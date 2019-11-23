pluginFn['/js/plugins/v2/venn.js'] = function(lucid, window) {
	var b;
function d(m,n,p){lucid.plugin.initBlockClass({className:m,name:i18n.get("plugin-venndiagram-shape-circle"),searchKeywords:[],defaultSize:{w:500,h:500},unthemed:!0,disabledPropertyControls:["FillType","LineColor"],defaultProperties:function(){return{FillColor:n,LineWidth:2}},onInit:function(){},getLinkPoints:function(){return[{x:.5,y:0},{x:.5,y:1},{x:0,y:.5},{x:1,y:.5}]},getRenderData:function(g){var c=g.BoundingBox,a=g.FillColor;a&&a.charAt&&"#"!=!a.charAt(0)||(a="#ffffff");7<a.length&&(a=a.substr(0,
7));var e=a;e=p?{t:"r",dx1:0,dy1:0,dx2:.341666,dy2:.383333,x1:.5,y1:.5,x2:.5,y2:.5,cs:[{t:0,c:lucid.color.lighten(e+"66",.3125)},{t:.6,c:lucid.color.lighten(e+"99",0)},{t:1,c:lucid.color.darken(e+"ff",.125)}]}:e+"66";return[{FillColor:e,StrokeColor:a+"ff",LineWidth:g.LineWidth,Actions:[{Action:"move",x:c.x+c.w,y:c.y+c.h/2},{Action:"curve",Control:lucid.math.ellipseArcControlPoints(c.x,c.y,c.w,c.h,0,2*Math.PI)},{Action:"close"}]}]}})}
for(var f="#49c1a1ff #7769e0ff #efd95dff #e24adbff #e55050ff #f49769ff #7ae266ff #47b0e5ff".split(" "),h=[],k=0;k<f.length;k++)b="VennGradientColor"+(k+1),d(b,f[k],!0),h.push(b);var l=[];for(k=0;k<f.length;k++)b="VennPlainColor"+(k+1),d(b,f[k]),l.push(b);var q={"Venn Gradient":{displayName:i18n.get("plugin-venndiagram-group-gradient"),items:h},"Venn Plain":{displayName:i18n.get("plugin-venndiagram-group-plain"),items:l}};lucid.plugin.createToolGroups(q);
//# sourceMappingURL=/js/plugins/v2/source-maps/venn.js.map

};
