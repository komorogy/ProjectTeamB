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


class ViewController_satsuei: UIViewController,MKMapViewDelegate {

    //地図のview宣言
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        //位置情報を取得するときに呼ぶらしい。
        let userLocationManager = CLLocationManager() ;
        userLocationManager.startUpdatingLocation() ;
        
        let userLocation = MKUserLocation() ;
        print (userLocation.coordinate)
      
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        //地図の初期位置の設定
        map.setCenterCoordinate(location, animated: true) ;

        //地図の縮尺とかの設定
        var myRegion:MKCoordinateRegion = map.region ;
        myRegion.center = location ;
        myRegion.span.latitudeDelta = 0.02 ;
        myRegion.span.longitudeDelta = 0.02 ;
        map.setRegion(myRegion, animated: true) ;
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
