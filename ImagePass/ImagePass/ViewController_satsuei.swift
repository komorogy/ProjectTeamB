//
//  ViewController.swift
//  ImagePass
//
//  Created by 川述　優 on 2015/09/16.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////////////////////
// ViewController_satsuei.swift で定義している関数．
// MoveView(ViewName:String) : 画面遷移する関数
//
///////////////////////////////////////////////////////////////////////////////////


// ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
private let fileManager:NSFileManager = NSFileManager.defaultManager() ;


class ViewController_satsuei: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MoveView(ViewName:String) : 画面遷移する関数
    private func MoveView(ViewName:String){
        
        switch ViewName {
        case "Main"://一覧画面へ飛ぶ
            var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_Main", bundle: NSBundle.mainBundle())
            var nextViewController: ViewController_Main = storyboard.instantiateInitialViewController() as ViewController_Main ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
        case "edit"://閲覧画面へ飛ぶ
            var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_etsuran", bundle: NSBundle.mainBundle())
            var nextViewController: ViewController_etsuran = storyboard.instantiateInitialViewController() as ViewController_etsuran ;
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

//ボタンアクションはここに書く
