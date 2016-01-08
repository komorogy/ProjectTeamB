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
    
    // appdelegate取得
    let appdele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // 定数
    let PAGE_NAME: String = "unlock";// ページ名
    let CORRECT_RANGE = 100.0;// 解錠範囲 メートルで指定できる
    // 最終的な返却値
    //let SUCCESS: Bool = true;// 解錠成功時に返却する値
    //let FAILED:  Bool = false;// 解錠失敗時に返却する値
    
    
    // コンパスの値が取得できていたらtrue
    var compassCatched: Bool = false;
    
    // メモ取得用
    let NSUD = NSUserDefaults();
    let KEY  = "KEYForNSUD";
    var memo:  NSArray = NSArray();
    
    
    // 矢印の画像
    var directionImage: UIImage!;// = UIImage(named: "sample.jpeg")!
    let myRotateView  :UIImageView = UIImageView(frame: CGRect(x: 100, y: 250, width: 80, height: 80))
    
    var lm: CLLocationManager!
    
    // 目的地までの距離表示用ラベル
    @IBOutlet weak var textDistance: UILabel!
    
    
    // 現在地
    var currentLocation: CLLocation!;
    // 目標地点
    var goalLocation   : CLLocation!;
    
    // 端末の向き
    // コンパスの値が取れててないときは 0.0 （北）
    var computerHeading: Double = 0.0;
    // 目標の方向
    var dirN0: Double = 0.0
    // 表示する矢印の向き
    var goalDirection: Double!;// = dirN0 - computerHeading;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        debug("page loaded");
        
        // 目標地点をもらった情報で設定する
        let lati :Double  = atof(appdele.getTargeted()[2] as! String)
        let lon  :Double  = atof(appdele.getTargeted()[3] as! String)
        goalLocation = CLLocation(latitude: lati, longitude: lon);
        
        // 矢印の方向を0にする
        goalDirection = 0.0;
        
        
        // 画像
        // 最初は東西南北だけわかる画像
        // コンパスの値が取れたら矢印に変える
        directionImage = UIImage(named: "sample.png")!
        myRotateView.contentMode = UIViewContentMode.ScaleAspectFill
        
        // 矢印の表示
        // UIImageViewに画像を設定する.
        myRotateView.image = directionImage
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
        
        /**
        * GPSとコンパスを取得します。
        * GPSとコンパスは並列に動きます多分。
        * GPS側：    GPS取得->距離判定->GPS再取得or成功
        * コンパス側：コンパス取得->コンパス再取得
        * コンパス初回取得時に画像を矢印に変えます。
        */
        lm.startUpdatingLocation()
        lm.startUpdatingHeading()
    }
    
    // ナビゲーションバー上の戻るボタン
    @IBAction func BackButton(sender: AnyObject) {
        self.Closemodal(sender)
    }
    
    // 仮ボタン　解錠と仮定
    @IBAction func OpenButton(sender: AnyObject) {
        // フラグ書き換え
        appdele.updateTargeted(5, update: "0")
        appdele.updateNSUD()
        
        self.Closemodal(sender)
    }
    
    private func selectObj(){
        if((NSUD.objectForKey(KEY)) != nil){
            memo = NSUD.objectForKey(KEY)?.mutableCopy() as! NSMutableArray;
            print("got NSUD")
        }
    }
    
    // モーダルを破棄する
    private func Closemodal(sender: AnyObject?){
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        debug("get GPS");
        // 取得した緯度がnewLocation.coordinate.longitudeにDoubleで格納されている
        // コンパスに渡す用
        currentLocation = CLLocation(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude);
        
        debug(newLocation);
        
        // 目標のGPSと現在地との差
        let distanceToGoal = newLocation.distanceFromLocation(goalLocation);
        
        if( distanceToGoal < CORRECT_RANGE){
            debug("succeeded to unlock!!!!!!")
            
            //GPSの使用を停止する．
            lm.stopUpdatingLocation()
            lm.stopUpdatingHeading()
            
            // 画面遷移用のボタン表示
            let alertController = UIAlertController(title: "解錠成功", message: "目標地点に到達しました。", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
            // 解錠
            OpenButton(0);// 引数なにかわからない
            
        } else {
            debug("not yet succeeded to unlock");
            
            // 距離と方向を表示
            debug(distanceToGoal);
            if(distanceToGoal > 1000){
                textDistance.text = String( floor(distanceToGoal / 1000 )) + " km";
            } else {
                textDistance.text = String( floor(distanceToGoal        )) + " m";
            }
            
            // 画像を回転
            // コンパスの値が取得できている場合は、コンパス取得時に回転させるので、ここでは回転させない（画像も違う）。
            if(!compassCatched){
                // 現在地からみて目標地点はどちらの方向にあるか計算
                dirN0 = Double(computeDirectionFromGPS1ToGPS2(
                    /* startLati: */ currentLocation.coordinate.latitude, // よく分からないが、なんかエラーが出るのでここにはラベルつけない。
                    startLong:    currentLocation.coordinate.longitude,
                    goalLati :    goalLocation   .coordinate.latitude,
                    goalLong :    goalLocation   .coordinate.longitude)
                );
                
                // 画像を回転させる。
                let angle:CGFloat = CGFloat((-1 * dirN0 * M_PI) / 180.0) // 東西南北の画像を逆回転
                myRotateView.image = directionImage
                myRotateView.transform = CGAffineTransformMakeRotation(angle)
                self.view.addSubview(myRotateView)
            }
            
            debug("retrying...");
            
            // GPSを再取得。
            lm.startUpdatingLocation()
            
        }
    }
    
    // コンパスの値の取得成功時に実行される関数
    func locationManager(manager:CLLocationManager, didUpdateHeading newHeading:CLHeading) {
        // ipod touch はコンパスが使えないらしいので、ここには来ない
        debug("get heading");
        
        // コンパスの値が初めてとれたときは画像を矢印にする
        if(!compassCatched){
            directionImage = UIImage(named: "yajirushi.png")!
        }
        compassCatched = true;
        
        // 端末の向き更新
        //        computerHeading = newHeading.magneticHeading;
        computerHeading = newHeading.trueHeading;
        
        // 現在地からみて目標地点はどちらの方向にあるか計算
        dirN0 = Double(computeDirectionFromGPS1ToGPS2(
            /* startLati: */ currentLocation.coordinate.latitude, // よく分からないが、なんかエラーが出るのでここにはラベルつけない。
            startLong:    currentLocation.coordinate.longitude,
            goalLati :    goalLocation   .coordinate.latitude,
            goalLong :    goalLocation   .coordinate.longitude)
        );
        
        // 矢印の向き更新
        goalDirection = ( dirN0 - computerHeading + 360) % 360;
        
        // 画像を回転させる。
        let angle:CGFloat = CGFloat((goalDirection * M_PI) / 180.0)
        myRotateView.image = directionImage
        myRotateView.transform = CGAffineTransformMakeRotation(angle)
        self.view.addSubview(myRotateView)
        
        // コンパスを再取得。
        lm.startUpdatingHeading()
    }
    
    /*位置情報取得失敗時に実行される関数 　多分コンパスも*/
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        debug("failed to get GPS or heading");
        lm.startUpdatingLocation()
        lm.startUpdatingHeading()
    }
    
    // （緯度１、経度１）、（緯度２、経度２）を渡すと、
    // １から見た２の方向を返します。
    //
    // input : (startLat, startLong, goalLati, goalLong)　すべてDouble
    // output: 北を０度で右回りの角度０～３５９度
    //
    // 計算式は
    // http://hamasyou.com/blog/2010/09/07/post-2/
    // を参照。
    func computeDirectionFromGPS1ToGPS2(
        startLati: Double,
        startLong: Double,
        goalLati : Double,
        goalLong : Double
        ) -> Int{
            let Y = ( -1 ) * cos(goalLong  * M_PI / 180) * sin(goalLati * M_PI / 180  - startLati     * M_PI / 180);
            let X = cos(startLong * M_PI / 180) * sin(goalLong * M_PI / 180) - sin(startLong * M_PI / 180) * cos(goalLong * M_PI / 180) * cos(goalLati * M_PI / 180 - startLati * M_PI / 180);
            
            var directionFromGPS1ToGPS2_deg = Int ( 180 * atan2( Y, X) / M_PI + 360 )  % 360;// 東：0、北：90、西：180、南：270
            // 時計周りにする。
            directionFromGPS1ToGPS2_deg = 360 - directionFromGPS1ToGPS2_deg;
            // 北を0にする。
            directionFromGPS1ToGPS2_deg += 90;
            return  directionFromGPS1ToGPS2_deg % 360;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // コンソールログ出力
    func debug(message: NSObject){
        //print(PAGE_NAME + ": " + String(message));
    }
    // 特定の部分だけ見たいとき
    func debug2(message: NSObject){
        print(PAGE_NAME + ": " + String(message));
    }
    
}