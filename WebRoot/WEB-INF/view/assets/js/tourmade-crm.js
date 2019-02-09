//判断访问设备，如果是手机，跳转到m.tourmade.com

//  function browserRedirect() {
//     var sUserAgent = navigator.userAgent.toLowerCase();
//     var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
//     var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
//     var bIsMidp = sUserAgent.match(/midp/i) == "midp";
//     var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
//     var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
//     var bIsAndroid = sUserAgent.match(/android/i) == "android";
//     var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
//     var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
//     // document.writeln("您的浏览设备为：");
//     if (bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
//         //document.writeln("phone");
//        // window.location.href="http://m.tourmade.com"
//     } else {
//         $("body").addClass("leftpanel-collapsed");
//     }
// }

// browserRedirect();

function browserRedirect() {
	var screenW = $(window).width();
	if(screenW > 1023){
		$("body").addClass("leftpanel-collapsed");
	}
}
browserRedirect();

