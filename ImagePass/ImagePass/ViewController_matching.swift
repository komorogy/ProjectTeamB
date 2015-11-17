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
import Darwin

class ViewController_matching: UIViewController, CLLocationManagerDelegate  {
    
    // 定数
    let PAGE_NAME: String = "unlock";// ページ名
    //let ERR_LIMIT: Int = 100;// GPS照合失敗回数上限
    let INTERVAL = 3.0;// GPS取得間隔
    let CORRECT_RANGE = 100.0;// 解錠範囲 メートルで指定できる
    let PI = 3.141592653589;// 円周率
    // 最終的な返却値
    let SUCCESS: Bool = true;// 解錠成功時に返却する値
    let FAILED: Bool = false;// 解錠失敗時に返却する値
    
    
    // コンパスの値が取得できていない間true
    var noCompass: Bool = true;
    
    // 矢印の画像
    var directionImage: UIImage!;// = UIImage(named: "sample.jpeg")!
    
    
    var lm: CLLocationManager!
    
    // 現在地
    var currentLocation: CLLocation!;
    // 目標地点
    var goalLocation: CLLocation!;
    
    // 端末の向き
    // コンパスの値が取れててないときは 0.0 （北）
    var computerHeading: Double = 0.0;
    // 目標の方向
    var dirN0: Double = 0.0
    // 表示する矢印の向き
    var goalDirection: Double!;// = dirN0 - computerHeading;
    
    
    // ▼廃止だけど一応
    /*　
    // タイムアウト
    // GPS照合失敗回数
    var errCnt: Int = 0;
    */
    // ▲廃止だけど一応

    override func viewDidLoad() {
        super.viewDidLoad();
        debug("page loaded");
        // var memo : objc_object!;// 指定されたメモのデータが入ってると想定
        // var memo = { title: "メモのタイトル", text: "メモ本文", latitude: 1369.9, longtitue: 35.8}
        var memo = ["メモのタイトル", "本文", "136.9", "35.8"];
  
        /**
         * memo = { title: メモのタイトル, text: メモ本文, latitude: 緯度, longtitue: 経度}
         * あるいはmemo = [メモのタイトル, 本文, 緯度, 経度];
         */
        
        
       
        // 目標地点をもらった情報で設定する
        goalLocation = CLLocation(latitude: Double(memo[3])!, longitude: Double(memo[2])!);
        
        // 矢印の方向を0にする
        goalDirection = 0.0;
        
        
        // 画像
        // 最初は東西南北だけわかる画像。
        // コンパスの値が取れたら矢印に帰る
        directionImage = UIImage(named: "sample.jpeg")!
        
        // 距離の初期表示
        // 計算中みたいなテキスト
        
        // 矢印の表示
        // 画像を回転する.
        let myRotateView:UIImageView = UIImageView(frame: CGRect(x: 100, y: 250, width: 80, height: 80))
        // UIImageViewに画像を設定する.
        myRotateView.image = directionImage
        // radianで回転角度を指定(30度)する.
        let angle:CGFloat = CGFloat((goalDirection * M_PI) / 180.0)
        // 回転用のアフィン行列を生成する.
        myRotateView.transform = CGAffineTransformMakeRotation(angle)
        // Viewに張りつけ.
        self.view.addSubview(myRotateView)
        
        
        
        // フィールドの初期化
        lm = CLLocationManager()
        currentLocation = CLLocation();
        
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        lm.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        lm.distanceFilter = CLLocationDistance(INTERVAL);// 時間にする
        
        // GPSの使用を開始する
        lm.startUpdatingLocation()
        lm.startUpdatingHeading()// コンパス
    }
    
    // ナビゲーションバー上の戻るボタン
    @IBAction func BackButton(sender: AnyObject) {
        self.Closemodal(sender)
    }
    
    // 仮ボタン　解錠と仮定
    @IBAction func OpenButton(sender: AnyObject) {
        let appdele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdele.flg = true
        self.Closemodal(sender)
    }
    
    // モーダルを破棄する
    private func Closemodal(sender: AnyObject?){
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        debug("get GPS");
        // 取得した緯度がnewLocation.coordinate.longitudeにDoubleで格納されている
        currentLocation = CLLocation(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude);
        
        debug(currentLocation);
        
        // 目標のGPSと現在地との差
        var distanceToGoal = currentLocation.distanceFromLocation(goalLocation);
        
        if( distanceToGoal < CORRECT_RANGE){
            debug("succeeded to unlock!!!!!!")
            
            
            //GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
            lm.stopUpdatingLocation()
            lm.stopUpdatingHeading()
            // 画面遷移用のボタン表示
            
            // SUCCESS を渡す
            
            
        } else {
            debug("not yet succeeded to unlock");

            // ▼廃止だけど一応
            /*
            // タイムアウト
            if(errCnt++ > ERR_LIMIT){
                ;// アラート
                ;// 一覧に戻る
            }
            */
            // ▲廃止だけど一応
            
            // 距離と方向を表示
            debug(distanceToGoal);
            // textDistance.text = String(format:"%f m", distanceToGoal);
            
            
            
            debug("retrying...");
        }
    }
    
    // コンパスの値の取得成功時に実行される関数
    func locationManager(manager:CLLocationManager, didUpdateHeading newHeading:CLHeading) {
        // ipod touch はコンパスが使えないらしいので、ここには来ない
        debug("get heading");
        debug(newHeading.trueHeading);
        debug(newHeading.magneticHeading);
        
        // コンパスの値が初めてとれたときは画像を矢印にする
        if(noCompass){
            directionImage = UIImage(named: "yajirusi.jpeg")!
        }
        noCompass = false;
        
        // 端末の向き更新
        computerHeading = newHeading.magneticHeading;
        
        // 現在地からみて目標地点はどちらの方向にあるか計算
        // http://hamasyou.com/blog/2010/09/07/post-2/
        // 緯度経度 lat1, lng1 の点を出発として、緯度経度 lat2, lng2 への方位
        // 北を０度で右回りの角度０～３６０度
        let lng1 = currentLocation.coordinate.longitude;
        let lat1 = currentLocation.coordinate.latitude;
        let lng2 = goalLocation.coordinate.longitude;
        let lat2 = goalLocation.coordinate.latitude;
        
        let Y = cos(lng2 * PI / 180) * sin(lat2 * PI / 180 - lat1 * PI / 180);
        let X = cos(lng1 * PI / 180) * sin(lng2 * PI / 180) - sin(lng1 * PI / 180) * cos(lng2 * PI / 180) * cos(lat2 * PI / 180 - lat1 * PI / 180);
        var dirE0 = 180 * atan2(Y, X) / PI; // 東向きが０度の方向
        if (dirE0 < 0) {
            dirE0 = dirE0 + 360; //0～360 にする。
        }
        dirN0 = (dirE0 + 90) % 360; //(dirE0+90)÷360の余りを出力 北向きが０度の方向
        
        // 矢印の向き更新
        goalDirection = dirN0 - computerHeading;
        if(goalDirection < 0) {
            // 負だったら正の表現値にする
            goalDirection = goalDirection + 360.0;//
        }
    }

    /*位置情報取得失敗時に実行される関数 　多分コンパスも*/
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        debug("failed to get GPS or heading");
        //debug(error.description);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // コンソールログ出力
    func debug(message: NSObject){
        NSLog(PAGE_NAME + ": " + String(message));
    }
}