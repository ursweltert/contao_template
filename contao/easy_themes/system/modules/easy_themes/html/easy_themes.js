var EasyThemes=new Class({Implements:[Options],options:{mode:"contextmenu",delay:500},container:null,layoutSection:null,themeHandle:null,intTimeoutId:0,shouldRun:true,isCollapsed:null,layoutSectionLoaded:false,initialize:function(b){var a=this;this.setOptions(b);this.layoutSection=document.id("tl_navigation").getElements(".easy_themes_toggle")[0];this.container=document.id("easy_themes");this.isCollapsed=(this.layoutSection.hasClass("easy_themes_collapsed"))?true:false;this.layoutSectionLoaded=Boolean($$("#tl_navigation a.themes").length);this.layoutSection.addEvent("click",function(){a.isCollapsed=!a.isCollapsed;a.init()});window.addEvent("ajax_change",function(){a.layoutSectionLoaded=true;a.init()});this.init()},init:function(){var a=this;if(!this.isCollapsed&&this.layoutSectionLoaded){this.themeHandle=$$("#tl_navigation a.themes")[0].getParent("li");this.container.inject(this.themeHandle);this.container.removeClass("easy_themes_doNotLaunch")}else{this.container.addClass("easy_themes_doNotLaunch");return}switch(this.options.mode){case"contextmenu":this.themeHandle.addEvent("contextmenu",function(b){b.preventDefault();a.container.fade("in")});$(document.body).addEvent("click",this.container.fade.pass("out",this.container));break;case"mouseover":this.themeHandle.addEvent("mouseenter",function(b){clearTimeout(a.intTimeoutId);a.container.fade("in")}).addEvent("mouseleave",function(b){a.intTimeoutId=a.container.fade.delay(a.options.delay,a.container,"out")})}}});