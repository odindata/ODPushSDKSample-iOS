# ODPsuhSDKSample-iOS
奥丁pushSDk示例demo
# OdinPush集成
![Build Status](https://img.shields.io/badge/pod-0.2.1-blue.svg)
![Build Status](https://img.shields.io/badge/platform-iOS-dark.svg)

### OdinPush是一个iOS的远程推送库，集成简单且功能丰富。  

---

#### OdinPush使用步骤
 1. [安装](#install)
 2. [申请AppKey和AppSecret](#appkey)
 3. [配置AppKey和AppSecret](#appkeyconfig)
 4. [开启远程推送权限](#openremote)
 5. [配置推送证书](#certconfig)
 6. [代码权限申请及配置](#codeconfig)
 7. [具体功能使用](#wayofuse)  
  7.1 [App前台通知权限配置](#fontpushset)  
  7.2 [跳转指定链接](#targetlink)  
  7.3 [跳转指定界面](#targetpage)  
  7.4 [富媒体通知](#richpush)  
  7.5 [差异化推送](#differpush)  
  
---

<h1 id="install">1.安装</h1>  

OdinPush提供2种方式集成到工程中。
### 1.1 手动集成
在[奥丁数据开发者服务中心](http://www.stfukeyy.com/)或者[GitHub的Odin账号](https://github.com/odindata/OdinPush/releases)下载OdinPush.framework的最新版本，并添加到项目中。  

必须添加的依赖库**libc++.tbd**和**libz.1.2.5.tbd**，选中对应的**target -> Build Phases -> Link Binary with Libraries**，点击加号，添加上述的两个依赖库：
> libc++.tbd  
> libz.1.2.5.tbd  

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushlibdepend.png?raw=true)

然后通过**Build Settings** > **Other Linker Flags**，添加
> -ObjC  

如下图所示：  
![image](https://github.com/BaconTimes/files/blob/master/images/odinpushbuildsetting.png?raw=true)

### 1.2 pod集成
#### 1.2.1 启动命令行工具，切换到工程目录下，如果项目之前没有使用pod集成，那么执行

```shell
$ pod init
```
该命令会在当前目录下生产对应的Podfile文件。

#### 1.2.2 在Podfile中添加
> pod 'OdinPush'

#### 1.2.3 执行pod的集成命令

```shell
$ pod install
```
pod install成功后，可能报以下警告：

```
[!] The `OdinPushDemo [Debug]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-OdinPushDemo/Pods-OdinPushDemo.debug.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.

[!] The `OdinPushDemo [Release]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-OdinPushDemo/Pods-OdinPushDemo.release.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.
```

因为在Cocoapod里面会设置Other Linker Flags，而开发者之前也设置过，那么就会冲突，需要根据Cocoapod的提示，额外配置Other Linker Flags，添加  

> $(inherited)

如下图所示：

![image](https://github.com/BaconTimes/files/blob/master/images/oindpushpodwarn.png?raw=true)

#### 1.2.4 如果安装失败，提示原因是没有找到OdinPush，那么执行以下命令更新本地库，然后再执行pod install

```shell
$ pod repo update
```
<h1 id="appkey">2.申请AppKey和AppSecret</h1>  

在[奥丁数据开发者服务中心](http://www.stfukeyy.com)申请并获得OdinPush的**AppKey**和**AppSecret**。

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushappinfo.png?raw=true)






<h1 id="appkeyconfig">3.配置AppKey和AppSecret</h1>  

在工程的**info.plist**进行配置，AppKey对应plist的key是**OdinKey**，AppSecret对应plist的key是**OdinSecret**，二者都是string类型。

```
<key>OdinKey</key>  
<string>填写你自己申请的AppKey</string>  
<key>OdinSecret</key>  
<string>填写你自己申请的AppSecret</string>  
```

<p align="center">
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushprojinfo.png?raw=true" alt="OdinPush_info.plist" title="info.plist">
</p>

#### 网络请求权限配置  

由于OdinPush的请求是http，需要运行app设置请求权限。源代码如下：

```
<key>NSAppTransportSecurity</key>  
<dict>  
<key>NSAllowsArbitraryLoads</key>  
<true/>  
</dict>  
```
开发者可以将上面代码直接加入到**info.plist**中。
或者自行添加，在info.plist最外层点击加号，添加新的键值对，key为**App Transport Security Settings**，类型为**Dictionary**，在刚添加的Dictionary下面添加键值对，key为**Allow Arbitrary Loads**，类型为**Boolean**，值为**YES**，如下图所示：  

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushnetauth.png?raw=true)



<h1 id="openremote">4.开启远程推送权限</h1>  

选择项目的project文件，**project -> targets -> Capabilities**，分别打开**Push Notifications和Background Modes**，**Background Modes**中选中**Remote notifications**  

参照下图所示，打开远程推送配置开关。

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushprojsetting1.jpg?raw=true" alt="project setting" title="project -> targets -> Capabilities">
</p>

打开后台推送权限设置

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushprojsetting2.jpg?raw=true" alt="project setting" title="project -> targets -> Capabilities">
</p>






<h1 id="certconfig">5.配置推送证书</h1>  

推送证书的配置分2种，在服务中心 > PushSDK > 推送设置。  

##### 其一是APNs证书，这种配置分别有开发和生产环境；在苹果开发网站获得开发和生产环境的p12证书及密码后，在奥丁数据开发者即可；

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushcertp12.jpg?raw=true" alt="certificate p12" title="p12证书配置">
</p>

##### 其二就是授权验证，这种配置方式不区分正式和测试，需要p8证书（该证书只能在生成后下载一次）、KeyId，TeamId以及BundleId，在奥丁数据开发者服务中心配置即可。

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushcertp8.jpg?raw=true" alt="certificate p8" title="p8证书配置">
</p>

###### KeyId是在创建p8证书之后，自动生成该证书对应的KeyId。

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushcertp8keyid.jpg?raw=true" alt="certificate p8 KeyId" title="p8 KeyId">
</p>

###### TeamId可以通过登录苹果开发者网站获得，Account ->MemberShip。  

<p align="center" >
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushcertp8teamid.png?raw=true" alt="certificate p8 TeamId" title="p8 TeamId">
</p>

###### BundleId就是工程的**bundle Identifier**。  

<h1 id="codeconfig">6.代码权限申请及配置</h1>    

在代码中添加环境配置，申请通知权限的代码和接受消息通知的代码。  
下面的代码是配置SDK的使用环境：  

```objective-c
#ifdef DEBUG
    [OdinPush setAPNsForProduction:NO];
#else
    [OdinPush setAPNsForProduction:YES];
#endif
```  
下面的代码是配置远程通知的通知形式：  

```objective-c
OPushNotificationConfiguration *config = [[OPushNotificationConfiguration alloc] init];
config.types = (OPushAuthorizationOptionsSound|OPushAuthorizationOptionsAlert|OPushAuthorizationOptionsBadge);
[OdinPush setupNotification:config];
```

<h1 id="wayofuse">7.具体功能使用</h1>  

###### 下面介绍OdinPush的具体的功能使用。在远程推送，app集成Push的功能后，只是对消息的接受和处理，自身并不发送消息，而是后台根据业务逻辑发送消息。


<h2 id="fontpushset">7.1 App前台通知权限配置</h2>  

在iOS10之前，app在前台的环境下，是无法展示通知的，但是在iOS之后，可以通过UNUserNotification框架来设置前台展示的权限。 开发者需要一个类遵守UNUserNotificationCenterDelegate协议，然后初始化的时候设置代理，并实现对应的协议方法即可，下面的代码是以**PushDelegation类**为例，开发者在 
**userNotificationCenter: willPresentNotification: withCompletionHandler:**
方法中调用**completionHandler**，针对不同的情况来判断是否展示和怎么展示前台通知； 由于OdinPush内部实现了该方法，如果开发者没有实现该方法，那么OdinPush的回调就是  

```objective-c
completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound)。
```

PushDelegation.m代码

```objective-c
@interface PushDelegation () <UNUserNotificationCenterDelegate>
@end

@implementation PushDelegation
- (instancetype)init {
    self = [super init];
    if (self) {
       UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
       center.delegate = self;
    }
    return self;
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程通知
        completionHandler(UNNotificationPresentationOptionNone);
    } else {
        //本地通知
        completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound);
    }
}
@end
```

在Appdelegate.m中，导入头文件，添加字段，并在application: didFinishLaunchingWithOptions: 初始化即可。

```objective-c
@property (nonatomic, strong) PushDelegation *pushDelegation;

_pushDelegation = [[PushDelegation alloc] init];
```

<h2 id="targetlink">7.2 跳转指定链接</h2>  

该功能的实现，需要在奥丁数据开发者服务中心配置和客户端代码的添加。  
客户端代码如下：  

```objective-c
[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(pushMessage:) name:OdinPushDidReceiveMessageNotification object:nil];

- (void)pushMessage:(NSNotification *)noti {
    OPushMessage *message = noti.object;
    switch (message.messageType) {
        case OPushMessageTypeClicked:{
        NSString *link = message.msgInfo[@"url"];
            if (link) {
                //开发者拿到链接后自行处理
            }
        }
            break;
    }
}
```

而在奥丁数据开发者服务中心的设置：PushSDK -> 创建推送 -> 通知推送 -> 后续动作，选择打开链接，然后填写链接地址即可。

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushlinkset.png?raw=true)


<h2 id="targetpage">7.3 跳转指定界面</h2>  

该功能的实现，需要在奥丁数据开发者服务中心配置和客户端代码的配置。
在需要跳转的UIViewController里面导入  

```objective-c
#import <OdinPushSDK/UIViewController+OdinPush.h>
```

在implementation里面重写刚导入的分类的2个方法，如下所示

```objective-c
+ (NSString *)OdinPushPath {
    return @"page1";
}

-(instancetype)initWithOdinPushScene:(NSDictionary *)params {
    self = [super init];
    if (self) {
        if (params[@"title"]) {
            self.title = params[@"title"];
        }
        if (params[@"subtitle"]) {
            NSLog(@"%@", params[@"subtitle"]);
        }
    }
    return self;
}
```

在奥丁数据开发者服务中心的配置：**PushSDK -> 创建推送 -> 通知推送 -> 后续动作**，选择“**应用内跳转**”，
在scheme地址中填写的参数，添加上面代码中OdinPushPath返回的参数，而下面的参数的键值对，则对应上面初始化方法的params，客户端在接受到该通知之后，点击该通知即可跳转对应的界面，对应的参数也会传递进去。

#### 注意！！！  
开发者需要在代码中提前设置，比如开发者根据需求，配置了5个界面，那么每个界面的+(NSString *)OdinPushPath返回值都必须不一样，并记录下来，在后台创建推送时，跳转哪个界面，就填写那个界面对应的+(NSString *)OdinPushPath返回值。

上面的代码与下面的示例图是相对应的： 

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushpagetransfer.png?raw=true)

<h2 id="richpush">7.4 富媒体通知</h2>

在iOS10之后，通过**UserNotifications**框架和**Notification Service Extension**实现富媒体通知，示例图如下：

![image](https://github.com/BaconTimes/files/blob/master/notiExt/mediaPic.png?raw=true)

无论是本地通知和远程通知，都需要构造**UNNotificationAttachment**的实例，进而需要资源的NSURL，**该NSURL对应的资源必须是本地资源，不能使网络资源**。
##### 本地通知实现富媒体通知  
示例代码如下：

```objective-c
UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
NSString *path = [NSBundle.mainBundle pathForResource:@"youth" ofType:@"jpeg"];
UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"ident" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
content.attachments = @[attachment];
content.title = @"This is a title.";
UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:trigger];
[UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
}];
```
上面代码中的富媒体资源是图片，开发者也可替换成视频和音频，执行上面的代码就可以接收到本地富媒体通知。

##### 远程通知实现富媒体通知  

要实现远程富媒体通知，那么就需要添加**Notification Service Extension**，示例图如下：

![image](https://github.com/BaconTimes/files/blob/master/notiExt/addNotiService.png?raw=true)

新添加的Extension是以target形式添加到工程中的，因为是新的target，所以bundle Identifier不能与项目的工程的bundle Identifier一致，且需要给其配置对应的provision file。

添加成功后，系统会自动生成NotificationService对应的.h和.m文件。

使用OdinPush下载媒体文件，分2种情况：  
1. 手动集成  
**选中OdinPush.framework**，查看Xcode右侧的文件信息的**Target Membership**，可以看到2个target，一个是app的项目，还有一个就是刚才添加的Notification Service Extension对应的target，然后点击选中该target，至此就已经将OdinPush.framework添加到新的target中，然后可以导入头文件使用，示例图如下所示： 

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushselfextintegrate.png?raw=true)

2. CocoaPod集成
添加新的target之后，需要在Podfile里面添加对应的target，并将pod 'OdinPush'加到对应的target中，下面是示例配置，请将target改成开发者自己设置的target name：

```
target 'OdinPushDemo' do
  pod 'OdinPush'
end

target 'PushService' do
  pod 'OdinPush'
end
```

添加完成后，再执行pod install即可。

示例代码如下:  
导入头文件  

```objective-c
#import <OdinPushSDK/OdinPushSDK.h>
```

使用OdinPush下载媒体文件示例代码如下：

```objective-c
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    NSString * url = request.content.userInfo[@"attachment"];
    if (url) {
        [OdinPushServiceExtension handelNotificationServiceRequestUrl:url withAttachmentsComplete:^(NSArray *attachments, NSError *error) {
            self.bestAttemptContent.attachments = attachments;
            self.contentHandler(self.bestAttemptContent);
        }];
    } else {
        self.contentHandler(self.bestAttemptContent);
    }
    self.contentHandler(self.bestAttemptContent);
}
```

根据上面的代码，之所以取url对应key为**attachment**，是因为在奥丁数据开发者服务中心推送过来的富媒体通知的地址对应的key就是attachment。  

在创建推送中，配置媒体文件有2种形式，本地文件和网络文件。这二者最终给到客户端的都是媒体文件的链接，对应的key值是**attachment**，并且需要将**mutable-content**选中。
配置的示例图如下：

![image](https://github.com/BaconTimes/files/blob/master/notiExt/addNotiMedia.png?raw=true)


<h2 id="differpush">7.5 差异化推送</h2>

在OdinPush的**OdinPush.h**里面可以看到**设置标签**的四个API和**设置别名**的三个API，开发者可以通过这几个API，根据用户不同的属性添加不同的标签和别名；开发者在SDK初始化成功后，就能获取**RegistrationID**。
###### 标签API

```objective-c
+ (void)getTagsWithResult:(void (^) (NSArray *tags, NSError *error))handler;
+ (void)addTags:(NSArray<NSString *> *)tags result:(void (^) (NSError *error))handler;
+ (void)deleteTags:(NSArray<NSString *> *)tags result:(void (^) (NSError *error))handler;
+ (void)cleanAllTags:(void (^) (NSError *error))handler;
```

###### 别名API

```objective-c
+ (void)getAliasWithResult:(void (^) (NSString *alias, NSError *error))handler;
+ (void)setAlias:(NSString *)alias result:(void (^) (NSError *error))handler;
+ (void)deleteAlias:(void (^) (NSError *error))handler;
```
###### 获取RegistrationID API

```objective-c
+ (void)getRegistrationID:(void(^)(NSString *registrationID, NSError *error))handler;
```
而在奥丁数据开发者服务中心对应的是**创建推送**里面的**目标人群**，示例图如下：

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushsetTarget.png?raw=true)
