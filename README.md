# FPSViewDemo
实时查看应用的当前帧率

![demo](http://upload-images.jianshu.io/upload_images/458529-6da2941eadede2c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

###usage

````
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //显示帧率视图
    [JBFPSView showFPSView];
    return YES;
}
````
