import UIKit
import Siren
import CoreLocation
import Flutter
import Firebase
import flutter_local_notifications

class YourLocationManagerClass: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.requestWhenInUseAuthorization()
//        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager?.distanceFilter = 500.0
//        locationManager?.allowsBackgroundLocationUpdates = true
//        locationManager?.pausesLocationUpdatesAutomatically = true
    }

    func startMonitoringSignificantLocationChanges() {
        locationManager?.startMonitoringSignificantLocationChanges()
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var locationManager: YourLocationManagerClass?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }

        GeneratedPluginRegistrant.register(with: self)
        hyperCriticalRulesExample()
        Siren.shared.wail() // line 2
        locationManager = YourLocationManagerClass()
        locationManager?.startMonitoringSignificantLocationChanges()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func hyperCriticalRulesExample() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .critical, showAlertAfterCurrentVersionHasBeenReleasedForDays: 3)
        siren.wail {results in
            switch results {
            case .success(let updateResults):
                print("AlerAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UPdateType ", updateResults.updateType)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
