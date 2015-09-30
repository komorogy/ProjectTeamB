//
//  ViewController.swift
//  ImagePass
//
//  Created by 川述　優 on 2015/09/16.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

/////////////////////////////////////////////////////////////////////////
// ViewController_edit.swift にて定義している関数．
// MoveView(ViewName:String) : 画面遷移する関数
/////////////////////////////////////////////////////////////////////////


// ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
private let fileManager:NSFileManager = NSFileManager.defaultManager() ;

class ViewController_edit: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MoveView(ViewName:String) : 画面遷移する関数
private func MoveView(ViewName:String){
    
    switch ViewName {
    case "edit"://編集画面へ飛ぶ
        break ;
    default ://エラー処理どうする？
        break ;
    }
    
}