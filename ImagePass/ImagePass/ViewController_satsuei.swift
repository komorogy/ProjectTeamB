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
        
        //
        self.Closemodal(sender)
    }
    
    // モーダルを破棄する
    private func Closemodal(sender: AnyObject?){
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    
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
        
    }
    
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
        
        //ピンを立てる処理
        var myPin: MKPointAnnotation = MKPointAnnotation()
        
        // 座標を設定.
        myPin.coordinate = location

        /*
        
        // タイトルを設定.
        myPin.title = "タイトル"
        
        // サブタイトルを設定.
        myPin.subtitle = "サブタイトル"
        
        */

        // MapViewにピンを追加.
        map.addAnnotation(myPin)
        
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
