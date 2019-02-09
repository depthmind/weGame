(function() {
    // 配置
    var envir = 'online';
    var configMap = {
        test: {
            appkey: '4df6dade715dd34af9432741032a1f0b',
            url:'https://apptest.netease.im'
        },
        
        pre:{
    		appkey: '4df6dade715dd34af9432741032a1f0b',
    		url:'http://preapp.netease.im:8184'
        },
        online: {
           appkey: '4df6dade715dd34af9432741032a1f0b',
           url:'https://app.netease.im'
        }
    };
    window.CONFIG = configMap[envir];
    // 是否开启订阅服务
    window.CONFIG.openSubscription = true
}())