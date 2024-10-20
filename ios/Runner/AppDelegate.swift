import UIKit
import Flutter
import GoogleSignIn

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // GoogleSignIn 초기화
    let signInConfig = GIDConfiguration(clientID: "734591230931-ak13kid6g9t4bbb8he50ig2sgk3q18l3.apps.googleusercontent.com")
    GIDSignIn.sharedInstance.configuration = signInConfig
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // iOS 9 이상에서 Google 로그인 리다이렉션을 처리하는 부분 추가
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
