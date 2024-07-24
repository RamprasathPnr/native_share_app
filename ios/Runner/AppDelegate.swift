import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

private let channel = "com.example.native_share/share"


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { (call, result) in
          if call.method == "shareText" {
            if let args = call.arguments as? [String: Any], let text = args["text"] as? String {
              self.shareText(text: text)
              result(nil)
            } else {
              result(FlutterError(code: "UNAVAILABLE", message: "Text not available", details: nil))
            }
          } else {
            result(FlutterMethodNotImplemented)
          }
        }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func shareText(text: String) {
      let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
      if let rootViewController = window?.rootViewController {
        rootViewController.present(activityViewController, animated: true, completion: nil)
      }
    }


}
