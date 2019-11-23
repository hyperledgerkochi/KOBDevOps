$(function() {
    lucid.caja.init(function() {
        var user = window['chromeApp']['client']['user'];

        var id = window['chromeApp']['getDocumentId']() || "blank";

        client = lucid.Ng2ChromeChartAppFactory(user, id);

        //set, cache, or load plugins

        var availablePlugins = [{"name":"AWS Architecture","description":"Accurately diagram AWS architecture with the official AWS Simple Icons. You can chart with network shapes, database symbols, and a variety of other Amazon Web Services elements.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/aws-352x300.png","url":"/js/plugins/v2/aws2.js","keywords":"AWS,Simple Icons,Amazon,Web,Services,S3,EC2","group_name":"Networking"},{"name":"Android Mockups","description":"With custom-built Android shapes and elements, you can create mockups and wireframes with less pixelation. We offer the 4 most common Android devices and 60+ GUI elements.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/android-352x475.png","url":"/js/plugins/v2/android.js","keywords":"GUI,Android,Nexus,Galaxy,tablet,smartphone,mockup","group_name":"Software"},{"name":"Azure","description":"Diagram your network infrastructure using official Microsoft Azure icons. You can accurately depict your architecture setup with the wide range of shapes, including those for cloud, enterprise, VMs, and more.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/azure-352x192.PNG","url":"/js/plugins/v2/azure.js","keywords":"azure,microsoft,cloud","group_name":"Networking"},{"name":"BPMN 2.0","description":"BPMN 2.0 is the most up-to-date version of business process modeling notation. Model common business activities like tasks, transactions, and end events.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/bpmn-352x472.png","url":"/js/plugins/v2/bpmn2.js","keywords":"bpmn,business,process,model,notation","group_name":"Business"},{"name":"Circuit Diagrams","description":"Create circuit diagrams to help you model processes for electrical engineering tasks. Our library is outfitted with custom options that increase ease of use and diagramming speed.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/circuit-352x258.png","url":"/js/plugins/v2/ee.js","keywords":"circuit,electrical,amplifiers,multiplexers,capacitors,diodes,resistors,wires","group_name":"Other"},{"name":"Cisco Network Icons","description":"Cisco network icons are globally recognized symbols for diagramming network architecture. Use our standard shape set to model nodes and connections in a computer network.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/cisco-352x225.png","url":"/js/plugins/v2/cisco.js","keywords":"cisco,network","group_name":"Networking"},{"name":"Computation","description":"Perform dynamic displays and calculations.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/default-352x279.png","url":"/js/plugins/v2/computation.js","keywords":"computation","group_name":""},{"name":"Data Flow","description":"Data flow diagrams will help you document the logical flow of information through a step-by-step process. Model the path of data from home to destination.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/data-352x227.png","url":"/js/plugins/v2/dfd.js","keywords":"data,flow","group_name":"Business"},{"name":"Default","description":"Use these standard shapes to add more detail to your diagram. Text blocks with either a transparent background, solid background, or as note. Plus a hotspot shape for creating interactive diagrams.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/default-352x279.png","url":"/js/plugins/v2/default.js","keywords":"text,note,hotspot,action,interaction,detail","group_name":"Standard"},{"name":"Enterprise Integration","description":"Create diagrams for large-scale integration solutions across many implementation technologies. Designed by Gregor Hohpe and documented at www.eaipatterns.com.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/eip-352x197.png","url":"/js/plugins/v2/enterprise.js","keywords":"EIP,enterprise,integration,pattern,bus,message,channel,ESB,EAI,application","group_name":"Other"},{"name":"Entity Relationship","description":"Model databases in an easy-to-read format with entity relationship diagrams. You can get started with our shapes, which include contstraints, entities, relationships, and attributes.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/erd-352x364.png","url":"/js/plugins/v2/erd.js","keywords":"entity,relationship,ER,ERD,database model","group_name":"Software"},{"name":"Equations","description":"Create a mathematical expression using LaTeX markup language and insert it directly into your diagram. You can easily edit the expression by double-clicking it.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/equation-352x330.png","url":"/js/plugins/v2/equation.js","keywords":"math,latex,equation,symbol,expression","group_name":""},{"name":"Floor Plans","description":"Lay out floor plans for homes, offices, and buildings. Create and manage your space with standard shapes and specialized ones like office chairs and bathroom vanities.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/floorplan-352x681.png","url":"/js/plugins/v2/floorplan.js","keywords":"floor,office,plan,layout,home,building,floorplan,furniture,kitchen,bedroom,living,room,house,bathroom","group_name":"Other"},{"name":"Flowchart Shapes","description":"Build and optimize any process, whether simple or complex, with a variety of flowchart shapes and containers. Try demoing a path for surveys, software flow, and business activities.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/flowchart-352x304.png","url":"/js/plugins/v2/flowchart.js","keywords":"flow,chart,flowchart","group_name":"Standard"},{"name":"Freehand Drawing","description":" ","public":1,"thumbnail_url":"","url":"/js/plugins/v2/freehand.js","keywords":"","group_name":""},{"name":"Geometric Shapes","description":"Use clouds, hearts, plus signs, callouts, and other geometric shapes to give your diagram a lighthearted, hand-drawn feel.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/geometric-352x282.png","url":"/js/plugins/v2/shapes.js","keywords":"cloud,heart,plus,callout,pentagon,hexagon","group_name":"Standard"},{"name":"Google Cloud Platform","description":"Diagram Google Cloud Platform infrastructure with our official Google Cloud Platform shapes.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/gcp-352x259.png","url":"/js/plugins/v2/gcp.js","keywords":"GCP,Google,Cloud,Platform","group_name":"Networking"},{"name":"Mind Mapping","description":"Mind mapping is perfect for jotting down your thoughts. Navigate quickly with keyboard shortcuts to add new ideas and build on old ones.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/mindmap-352x406.png","url":"/js/plugins/v2/mindmap.js","keywords":"mind,map,node,child,idea,thought,train","group_name":"Other"},{"name":"Network Infrastructure","description":"Create fast, accurate network diagrams with this library. Unlike our Cisco and AWS shapes, these are vendor-neutral and allow for great flexibility.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/network-352x321.png","url":"/js/plugins/v2/network.js","keywords":"devices,networks,cisco,aws","group_name":"Networking"},{"name":"Org Charts","description":"Create org charts in minutes with .csv import and premade layouts. You can personalize your chart by uploading pictures and customizing role, name, and contact information.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/Vertical-Org-Chart.png","url":"/js/plugins/v2/orgchart2.js","keywords":"org,organizational,csv","group_name":"Business"},{"name":"Process Engineering","description":"Create efficient process flow diagrams for any factory or plant, with shapes like pumps, valves, heat exchangers, vessels, and more.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/process-352x309.png","url":"/js/plugins/v2/processing.js","keywords":"flowsheet,PFD,process,flow,P&ID","group_name":"Other"},{"name":"Sales","description":"","public":1,"thumbnail_url":"","url":"/js/plugins/v2/sales.js","keywords":"sales","group_name":"Business"},{"name":"Server Rack Diagrams","description":"Create rack diagrams to efficiently lay out servers, server racks, and power supply. Our shapes aren\"t vendor-specific, so you can use them in various scenarios.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/rack-500x656.png","url":"/js/plugins/v2/serverrack.js","keywords":"rack,server,computer,it,blank,slot,ethernet,switch,power,supply,bridge,patch,panel","group_name":"Networking"},{"name":"Site Maps","description":"Visualize your new or existing website with custom site map shapes. Add urls to each page and press \"Enter\" or \"Tab\" to quickly create more pages.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/sitemap-352x362.png","url":"/js/plugins/v2/sitemap.js","keywords":"site,map,site-map,website","group_name":"Software"},{"name":"Tables","description":"Organize your data with tables. Use advanced features to copy and paste data from Excel and Google Spreadsheets.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/tables-352x283.png","url":"/js/plugins/v2/table.js","keywords":"table,tables,spreadsheet,cell,row,column,data","group_name":"Business"},{"name":"Tech Clipart","description":"Our tech clipart library will enhance network diagrams with a host of electronics shapes, like servers, printers, and monitors. Tech clipart can be added to any diagram type, including floor plans and BPMN diagrams.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/tech-352x256.png","url":"/js/plugins/v2/techclipart.js","keywords":"printer,monitor,calculator,server,rack,copier,scanner,calculator,memory card reader,MP3 player,speaker,headset,LCD","group_name":"Networking"},{"name":"Timeline","description":"Create a timeline to illustrate previous events or to map out when specific tasks or events need to take place.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/timeline.png","url":"/js/plugins/v2/timeline.js","keywords":"timeline,time","group_name":"Other"},{"name":"UI Mockups","description":"Plan the ideal user interaction flow with UI mockups. Our tool gives you a variety of widgets, containers, and UI elements, to which you can easily add interactivity.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/uimockup-352x310.png","url":"/js/plugins/v2/ui2.js","keywords":"mockup,prototype,UI,UX","group_name":"Software"},{"name":"UML","description":"UML is a standard language for modeling object-based software. Use our Unified Modeling Language shapes and connectors to draw state diagrams, activity diagrams, use case diagrams, and more.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/uml-352x363.png","url":"/js/plugins/v2/uml.js","keywords":"UML,Unified,Modeling,Language,use case,class,activity,component,deployment,ERD","group_name":"Software"},{"name":"User Images","description":"Make your diagram professional or personalized with user images. You can quickly upload and organize your own PNG and JPEG image files to any document, then share images with your team.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/images-352x291.png","url":"/js/plugins/v2/userimage.js","keywords":"image,upload,png,jpeg,logo,picture,photo","group_name":"Visual Content"},{"name":"Value Stream","description":"Use our value stream maps to identify waste in any process--especially manufacturing--then quickly eliminate it. We offer shapes like materials, shipments, information, kanban, and more.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/value-352x238.png","url":"/js/plugins/v2/valuestream.js","keywords":"value,stream,mapping,Six,Sigma,lean,kaizen,kanban,just in time,JIT","group_name":"Business"},{"name":"Venn Diagrams","description":"Venn diagrams are perfect for students and teachers, especially when solving logic, probability, and comparison problems. We offer premade templates and easy design options.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/venn-352x318.png","url":"/js/plugins/v2/venn.js","keywords":"Venn,diagram,2-circle,3-circle","group_name":"Other"},{"name":"Video","description":"The video shape library allows you to upload any Youtube video to your diagram. If you publish the video, everyone--even non-Lucidchart users--can see it.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/video-352x218.png","url":"/js/plugins/v2/video.js","keywords":"Youtube,video,embed","group_name":"Visual Content"},{"name":"iOS 10 Mockups","description":"Create iPad and iPhone mockups with iOS shapes based on Apple's UIKit and Human Interface Guidelines.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/ios7-352x626.png","url":"/js/plugins/v2/ios.js","keywords":"ios,ipad,iphone,ipod,apple,mockup","group_name":"Software"},{"name":"iOS 7 Mockups","description":"Create iPad and iPhone mockups with iOS shapes based on Apple\"s Design Resources guide. Add interactivity to your mockups with hotspots and layers.","public":1,"thumbnail_url":"https://d2slcw3kip6qmk.cloudfront.net/app/chart/plugins/ios7-352x626.png","url":"/js/plugins/v2/ios7.js","keywords":"ios,ipad,iphone,ipod,ios7,mockup","group_name":"Software"}];
        client.setAvailablePlugins(availablePlugins);

        var urlToPlugin = {};
        availablePlugins.forEach(function(p) {
            urlToPlugin[p.url] = p;
        });
        for(var url in window.chromeApp.pluginFn) {
            var p = urlToPlugin[url] || {id:url, url:url, name:url, description:url};
            client.cachePlugin(url, {
                id: p.id,
                url: p.url,
                name: p.name,
                description: p.description,
                code: window.chromeApp.pluginFn[url]
            });
        };

        //load document
        function loadFromData(doc, changes) {
            doc.changeDom = [];
            client.load(doc, 0, doc['plugins'], function(recordLoadingTime) {
                if(id == "blank") {
                    client.generateOfflineId();
                    client.document.makeUnsaved();
                    client.allowSaving(false);
                    lucid.listen('document.postAction', function() {
                        client.allowSaving(true);
                    });
                }

                if(changes) {
                    var original = getValidateUndo(); //TODO: figure out why we need this
                    setValidateUndo(false);
                    try {
                        changes = JSON.parse(changes);
                        changes.forEach(function(a) {
                            client.document.runAction(a);
                        });
                    } catch(e) {
                        console.error(e);
                    }
                    setValidateUndo(original);
                }
                setTimeout(function() {
                    $(window).trigger('loadFadeInStart');
                    $('#load').fadeOut('fast', function() {
                        recordLoadingTime();
                        $(window).trigger('loadFadeInEnd');
                        $('#load').remove();
                    });
                }, 100);
            }, false);
        }

        var creator_id = "1";
        var db = lucid.db.get(client['user']['id']);
        db.getDocumentData(id, function(data) {
            db.getDocumentChanges(id, function(changes) {
                var doc = null;
                if(id == "blank") {
                    doc = {
                        "Document":{
                            "id":"blank",
                            "creator_id":creator_id,
                            "title":"Untitled Document",
                            "shared":null,
                            "published":"0",
                            "pdfdata":"{\"0_0\":{\"GridSpacing\":20,\"Width\":1360,\"Height\":1760,\"DPI\":160,\"Gradient\":0.5,\"FillColor\":{\"r\":255,\"g\":255,\"b\":255,\"a\":1},\"Blocks\":[],\"Lines\":[],\"Containers\":[]}}",
                            "state":"",
                            "action_history_length":20,
                            "pages":1
                        },
                        "Creator":client.user,
                        "plugins":[],
                        "Change":[{
                            "user_id":client.user['id'],
                            "created":"2012-12-10 12:03:58",
                            "action_history_length":20,
                            "change_count":20,
                            "changes":"[{\"Action\":\"SetProperty\",\"id\":null,\"Property\":\"Title\",\"Value\":\"New Document\",\"OldValue\":\"\"},{\"Action\":\"SetProperty\",\"id\":null,\"Property\":\"DefaultFont\",\"Value\":\"Helvetica\",\"OldValue\":\"times\"},{\"Action\":\"CreatePage\",\"Properties\":{\"Title\":\"New Page\"},\"id\":\"0_0\"},{\"Action\":\"SetProperty\",\"id\":null,\"Property\":\"DefaultLineShape\",\"Value\":\"curve\",\"OldValue\":\"elbow\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/flowchart.js\",\"Code\":\"\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/techclipart.js\",\"Code\":\"\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/userimage.js\",\"Code\":\"\"},{\"Action\":\"SetProperty\",\"id\":null,\"Property\":\"Title\",\"Value\":\"Untitled Document\",\"OldValue\":\"New Document\"},{\"Action\":\"UnloadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/techclipart.js\"},{\"Action\":\"UnloadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/userimage.js\"},{\"Action\":\"NoOp\"},{\"Action\":\"NoOp\"},{\"Action\":\"NoOp\"},{\"Action\":\"NoOp\"},{\"Action\":\"NoOp\"},{\"Action\":\"UnloadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/flowchart.js\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/flowchart.js\",\"Code\":\"\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/shapes.js\",\"Code\":\"\"},{\"Action\":\"LoadPlugin\",\"URL\":\"\\\/js\\\/plugins\\\/v2\\\/userimage.js\",\"Code\":\"\"},{\"Action\":\"SetProperty\",\"id\":null,\"Property\":\"Title\",\"Value\":\"Untitled Document\",\"OldValue\":\"\"}]",
                            "User":client.user
                        }],
                        "role":"owner"
                    };
                }
                else if(data) {
                    try {
                        // goog.json.serialize outputted bad JSON which broke JSON.parse; jsonParse is looser in its parsing, like eval()
                        // https://lucidsoftware.atlassian.net/browse/CHART-3888
                        doc = jsonParse(data);
                    } catch(e) {
                        console.error('load document error: ' + e.toString());
                    }
                }

                if(doc) {
                    loadFromData(doc, changes);
                }
                else {
                    //Getting the documentInfo without state
                    lucid.net.ajax({
                        'type':'GET',
                        'url':window['lucidConfigure']['documentServiceHost'] + '/documents',
                        'data':'id='+encodeURIComponent(id) + '&fields=role,state',
                        'headers':{'Accept': 'application/json'},
                        'xhrFields':{'withCredentials':true},
                        'dataType':'json',
                        'success':function(docs) {
                            try {
                                client.documentListStorage.putDocumentData(docs[0]['Document']['id'], JSON.stringify(docs[0]));
                                loadFromData(docs[0]);
                            }
                            catch(e) {
                                lucid.view.alert("The document cannot open until syncing is complete.", function() {
                                    setTimeout(chromeApp.replaceDoc, 5);
                                });
                                $('.dialog-overlay.modal').css('z-index',1000);
                                console.error(e.toString());
                            }
                        },
                        'error':function(e) {
                            lucid.view.alert("The document cannot open until syncing is complete. Please reconnect to the Internet to sync this document to your account.", function() {
                                setTimeout(chromeApp.replaceDoc, 5);
                            });
                            $('.dialog-overlay.modal').css('z-index',1000);
                            console.error(e);
                        }
                    });
                }

            });
        });
    });
});
