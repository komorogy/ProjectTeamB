//
//  ViewController_matching.swift
//  ImagePass
//
//  解錠画面
//  Created by 杉本　耕 on 2015/10/04.
//  Copyright © 2015年 川述　優. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController_matching: UIViewController, CLLocationManagerDelegate  {
    
    var lm: CLLocationManager!
    // 取得した緯度、keidoを保持するインスタンス
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    // 目標地点
    var goalLatitude: CLLocationDegrees!;
    var goalLongtitude: CLLocationDegrees!;
    
    // GPS照合失敗回数
    var errCnt: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // var memo : objc_object!;// 指定されたメモのデータが入ってると想定
        // var memo = { title: "メモのタイトル", text: "メモ本文", latitude: 1369.9, longtitue: 35.8}
        var memo = ["メモのタイトル", "本文", "136.9", "35.8"];
        /**
         * memo = { title: メモのタイトル, text: メモ本文, latitude: 緯度, longtitue: 経度}
         * あるいはmemo = [メモのタイトル, 本文, 緯度, 経度];
         */
        
        
       
        // 目標地点
        //var goalLatitude = memo.latitude;
        //var goalLongtitude = memo.longtitude;
        goalLatitude = Double(memo[2]);
        goalLongtitude = Double(memo[3]);
        
        // フィールドの初期化
        lm = CLLocationManager()
        longitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        lm.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        lm.distanceFilter = 15;
        
        // GPSの使用を開始する
        lm.startUpdatingLocation()
        lm.startUpdatingHeading()
    }
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        latitude = newLocation.coordinate.latitude
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        longitude = newLocation.coordinate.longitude
        
        // 目標のGPSと現在地との差
        var difLong = goalLongtitude - longitude;
        var difLati = goalLatitude - latitude;
        
        if(difLong > -0.1 && difLong < 0.1 && difLati > -0.1 && difLati < 0.1){
            NSLog("ok")
            //GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
            lm.stopUpdatingLocation()
            // 画面遷移
            
        } else {
            NSLog("ng")
            errCnt++;
        }

    }

    /*位置情報取得失敗時に実行される関数 */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog(error.description);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    // 一覧画面に戻る。
    @IBAction func btnBackToList(sender: AnyObject) {
        MoveView("Main");
    }
    
    // 閲覧画面への遷移。
    // 実際には解錠条件を満たしたときで、ボタンをおしたときではない。
    //  ボタンも後で消す。
    @IBAction func btnToView(sender: AnyObject) {
        MoveView("eturan");
    }
*/
    //MoveView(ViewName:String) : 画面遷移する関数
    private func MoveView(ViewName:String){
        
        switch ViewName {
/*        case "etsuran"://閲覧画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_etsuran", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_etsuran = storyboard.instantiateInitialViewController() as! ViewController_etsuran ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
            break ;
            //case "etsuran"://一覧画面へ飛ぶ
        default://
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_Main", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_Main = storyboard.instantiateInitialViewController() as! ViewController_Main ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);

            break ;
*/          default ://エラー処理どうする？
                break ;
        }
        
        
    }

}