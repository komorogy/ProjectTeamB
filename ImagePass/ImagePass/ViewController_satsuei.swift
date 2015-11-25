//
//  ViewController.swift
//  ImagePass
//
//  Created by 川述　優 on 2015/09/16.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit
import MapKit
////////////////////////////////////////////////////////////////////////////////
// ViewController_satsuei.swift で定義している関数．
// MoveView(ViewName:String) : 画面遷移する関数
//
///////////////////////////////////////////////////////////////////////////////////


// ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
private let fileManager:NSFileManager = NSFileManager.defaultManager() ;




class ViewController_satsuei: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    let NSUD = NSUserDefaults() ;
    
    let KEY = "KEYForNSUD" ;
    
    var data  = ["","","","",""] ;
    
    var dataArray : NSMutableArray = NSMutableArray();
    
    var myPin: MKPointAnnotation = MKPointAnnotation()
    
    
    @IBOutlet weak var navigation: UILabel!
    
    
    //地図のview宣言
    @IBOutlet weak var map: MKMapView!
    //位置情報を取得するときに呼ぶらしい。
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self ;
        
        //位置情報取得が許可されていない場合．
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization() ;
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
        locationManager.distanceFilter = 300 ;
        locationManager.startUpdatingLocation() ;
  
        
        //長押し検知のため，UI設定．ストーリーボードで出来る気がする．
        var longPressDetector : UILongPressGestureRecognizer = UILongPressGestureRecognizer() ;
        longPressDetector.addTarget(self, action: "recognizeLongPress:") ;
        
        map.addGestureRecognizer(longPressDetector) ;
        
        /*let location = CLLocationCoordinate2DMake(33.564, 139.930531) ;
        let span = MKCoordinateSpanMake(1.0, 1.0) ;
        let region = MKCoordinateRegionMake(location, span) ;
        map.setRegion(region, animated: true) ;*/
    }

    // ナビゲーションバー上の戻るボタン
    @IBAction func BackButton(sender: AnyObject) {
        self.Closemodal(sender)
    }
    
    // ナビゲーションバーにある仮ボタン GPSが設定されたと仮定
    @IBAction func SetGPSButton(sender: AnyObject) {
        
        //アラートで確認後、データの保存処理
        if((NSUD.objectForKey(KEY)) != nil){
            dataArray = NSUD.objectForKey(KEY)?.mutableCopy() as! NSMutableArray; //NSUD.objectForKey(KEY) as! NSMutableArray;
        }
        
        let dateFormatter = NSDateFormatter() ;
        
        data[2] = myPin.coordinate.latitude.description ;
        data[3] = myPin.coordinate.longitude.description ;
        
        //日付取得．フォーマットは？
        
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") ;//日本の時刻を基準に
        dateFormatter.dateFormat = "yyyyMMddHHmmss" ;//時刻形式はyyyymmddhhmmss
        
        let result = dateFormatter.stringFromDate(NSDate()) ;//resultにyyyymmddhhmmssを保存．
        
        data[4] = result ;
        
        print(dataArray) ;
        print(data) ;
        
        
        //NSMutableArray にaddできない．ググる
        dataArray.addObject(data)
        print(dataArray) ;
      
        //
        NSUD.setObject(dataArray, forKey: KEY) ;
        NSUD.synchronize()
        
//        for i in dataArray {
//            print(i[0] as! String) ;
//        }
        
        /*
        var test = NSUD.objectForKey(KEY) as! NSMutableArray;
        var test2 = test[0];
        
        print(test2[0]) ;
        print(test2[1]) ;
        print(test2[2]) ;
        print(test2[3]) ;
        print(test2[4]) ;
        
        
        var test2 = test[1];
        
        print(test2[0]) ;
        print(test2[1]) ;
        print(test2[2]) ;
        print(test2[3]) ;
        print(test2[4]) ;
        */
        
        self.Closemodal(sender)
    }
    
    // モーダルを破棄する
    private func Closemodal(sender: AnyObject?){
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
   /*
    //MoveView(ViewName:String) : 画面遷移する関数
    private func MoveView(ViewName:String){
        
        switch ViewName {
        case "Main"://一覧画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_Main", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_Main = storyboard.instantiateInitialViewController() as! ViewController_Main ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
        case "edit"://閲覧画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_etsuran", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_etsuran = storyboard.instantiateInitialViewController() as! ViewController_etsuran ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
        default ://エラー処理どうする？
            break ;
        }
        
    }*/
    
    //位置情報取得成功時に呼ばれる関数
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        //newLocationに現在地の情報が格納されている
        let longtitude = newLocation.coordinate.longitude ;
        let latitude = newLocation.coordinate.latitude ;
        let location = CLLocationCoordinate2DMake(latitude, longtitude) ;

        print("called!!") ;
        print(longtitude) ;
        print(latitude) ;
        
        //表示する地図の中心を現在地に設定
        map.setCenterCoordinate(location, animated: true) ;
        
        //ピンを立てる処理///////////////////////

        // 座標を設定.
        myPin.coordinate = location

        let title : String = String(location.latitude) + "," + String(location.longitude);
        
        myPin.title = title;
        
        // MapViewにピンを追加.
        map.addAnnotation(myPin)
        //////////////////////////////////////
        
        var region = map.region ;
        region.center = location ;
        region.span.latitudeDelta = 0.01 ;
        region.span.longitudeDelta = 0.01 ;
        
        map.mapType = MKMapType.Standard ;
      
        map.setRegion(region, animated: true) ;
        
        locationManager.stopUpdatingLocation() ;
    }
    
    //位置情報取得失敗時に呼ばれる関数
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertView() ;
        alert.title = "get no location" ;
        alert.message = "locationManager.startUpdatingLocation failed" ;
        alert.addButtonWithTitle("OK") ;
        alert.show() ;
    }
    
    //長押しされた時のアクション
    func recognizeLongPress(sender:UILongPressGestureRecognizer){
        if (sender.state != UIGestureRecognizerState.Began){
            return ;
        }
        
        //長押しされた場所を取得
        let point = sender.locationInView(map) ;
        
        
        let location : CLLocationCoordinate2D = map.convertPoint(point, toCoordinateFromView: map) ;
        
        ///////////////////////////////////
        //let myPin : MKPointAnnotation = MKPointAnnotation() ;
        
        myPin.coordinate = location ;
        
        let title = String(location.latitude) + "," + String(location.longitude) ;
        
        myPin.title = title ;
        
        map.addAnnotation(myPin) ;
        ////////////////////////////////////
        print(location.latitude) ;
        print(location.longitude) ;
        
    }
    
    //addAnotationした時に呼ばれる
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var myPinView : MKPinAnnotationView! ;
        
        myPinView.annotation = annotation ;
        
        return myPinView ;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
