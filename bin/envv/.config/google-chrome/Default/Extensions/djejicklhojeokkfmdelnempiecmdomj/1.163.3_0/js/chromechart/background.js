document.cookie = 'client=chromeApp;domain=.lucidchart.com;path=/';

(function() {
    var authToken = null,
        randomToken = null,
        user = null,
        storage = lucid.db.getExported(0);
   
    window.client = null;

    var authTimeout;
    var xhr = new XMLHttpRequest;
    xhr.timeout = 10*1000;
    /**
     * Make request to lucidchart.com with authorization token.
     * If successful, create the client and call the success callback.
     * If unauthorized, call the unauthorized callback and prompt login.
     * If timed out or offline, call the failure callback once, and wait and try again later.
     */
    function authenticate(token, success, unauthorized, failure) {
        if(token != null) {
            authToken = token;
        }

        authTimeout != null && clearTimeout(authTimeout);
   
        lucid.net.Checker.whenOnline(function() {
            xhr.open('PUT', lucidConfigure.lucid_host+'/users/chromeAppToken?token='+encodeURIComponent(authToken)); //implicit xhr.abort()
            xhr.ontimeout = function() {
                failure && failure();
                failure = null;
                authTimeout = setTimeout(function() {
                    authenticate(null, success, unauthorized);
                }, 10*1000);
            };
            xhr.onerror = function() {
                failure && failure();
                failure = null;
            };
            xhr.onreadystatechange = function() {
                if(this.readyState == 4) {
                    if(this.status == 200) {
                        //okay
                        var data = JSON.parse(this.responseText);
                        randomToken = data.random_token;
                        user = data.user.User;

                        storage.setStorage({user:user});

                        success && success();
                    } else if(this.status == 401) {
                        //unauthorized
                        authToken = null;
                        storage.setStorage({token:null});
                       
                        unauthorized && unauthorized();
                        promptLogin();
                    } else {
                        //offline
                        this.ontimeout();
                    }
                }
            };
            xhr.send();
        });
    };

    var inLogin;
    /**
     * Shows a window that prompts the user for login. The callback is guaranteed to be called on
     * eventual login regardless of how many times a login window might be shown.
     */
    function promptLogin(complete) {
        complete && lucid.listen.one('chromeApp.login', complete);
       
        if(!inLogin) {
            inLogin = true;
            lucid.view.chromechart.AppWindow.hideAll();
            lucid.view.chromechart.AuthWindow.open(function(token) {
                var me = this;
                inLogin = false;

                //We wait until authentication returns, since
                // (1) there is a chance that this is the first login and no data has been stored offline yet
                // (2) there is a change that windows were already open before, but then they logged in as a different user
                authenticate(
                    token,
                    function() {
                        //token worked
                        lucid.view.chromechart.AppWindow.showAll();
                        me.close();

                        lucid.listen.set('chromeApp.login');
                    },
                    function() {
                        //token didn't work; close this one (another auth window opens)
                        me.close();
                    }
                );

                storage.setStorage({token:token});
            });
        }
    }

    //used in jQuery setup; if we ever get unauthorized, we call this
    window.refreshToken = function() {
        authenticate();
    };
    //auth methods to be exported to editor windows
    window.chromeAppAuth = {
        navigateUrl: function(url, addRandomToken) {
            return window.lucidConfigure.lucid_host
                + '/users/setToken'
                + '?token=' + encodeURIComponent(authToken)
                + '&next=' + encodeURIComponent(url)
                + (addRandomToken ? '&addRandomToken' : '');
        },
        refreshToken: refreshToken,
        promptLogin: promptLogin,   //can be called as many times as necessary
        getRandomToken: function() {
            return randomToken;
        }
    };

    Promise.all([
        new Promise((resolve, reject) => {
            storage.getStorage(['token', 'user'], function(obj) {
                user = user || obj.user;

                var completed = false;
                function complete() {
                    if(!completed) {
                        completed = true;
                        resolve();
                    }
                }
                
                obj.token && authenticate(obj.token, complete, complete, complete);

                // wait for user to be fetched and updated, if possible
                // this can slow down launch time, but we will have more correct user info (e.g. user level)
                if(navigator.onLine) {
                    setTimeout(function() {
                        if(!completed) {
                            console.warn('Fetching user timed out');
                        }
                        complete();
                    }, 2000);
                } else {
                    complete();
                }
            });
        }),
        new Promise((resolve, reject) => {
            chrome.app.runtime.onLaunched.addListener(function(launchData) {
                resolve();
            });
        }),
        lucid.localStorage.ready,
    ]).then(() => {
        /**
         * Creates the background client
         */
        function createClient() {
            if(!client) {
                //create new client
                lucid.setAjaxSettled();
                client = new lucid.ChromeChartBackgroundApp(user);
            } else if(client.user.id != user.id) {
                //replace client
                client.destroy();
                lucid.view.chromechart.EditorWindow.closeAll();
                client = new lucid.ChromeChartBackgroundApp(user);
            }
           
            lucid.view.chromechart.EditorWindow.openDoc();
        }
        if(user && authToken) {
            //we may have not finished authenticating yet, but we launch the window anyway
            createClient();
        } else {
            promptLogin(createClient);
        }
    });

})();
