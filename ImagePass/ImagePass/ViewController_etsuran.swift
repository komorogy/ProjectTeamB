//
//  ViewController.swift
//  ImagePass
//
//  Created by 川述　優 on 2015/09/16.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

///////////////////////////////////////////////////////////////////
//ViewController_etsuran.swiftで定義している関数．
//IsExistDirectory(ID:String)->Bool : IDという名前のディレクトリが存在するか確認する．
//MakeNewID()->String : IDの新規発番．メモの新規作成のときに使う．
//MakeNewDirectory(ID:String)->Int : データを保存するディレクトリを作成する．メモの新規作成のときに使う．
//MoveView(ViewName:String) : 画面遷移する関数．
////////////////////////////////////////////////////////////////////


// ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
private let fileManager:NSFileManager = NSFileManager.defaultManager() ;

// AppDelegateのインスタンス化
private let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate ;

class ViewController_etsuran: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ////////////////////////////////////////////////////////////////////
        //閲覧画面の初期化処理．AppDelegate.swiftに定義されているIdを見て，新規作成・既存ファイル閲覧を判断
        //Id=""のとき，新規作成
        //Id="hogehoge"のとき，既存のファイルを開く．
        ////////////////////////////////////////////////////////////////////
        var ID:String = appDelegate.Id ;
    
        if (ID==""){
            ID = MakeNewID();
            MakeNewDirectory(ID) ;
            MoveView("edit") ;
        }
        
        //画面の表示処理をここに書く．
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//IsExistDirectory(ID:String)->Bool : IDという名前のディレクトリが存在するか確認する．
private func IsExistDirectory(ID:String)->Bool{
    var result:Bool=true;
    
    return result ;
}

//MakeNewID()->String : IDの新規発番．メモの新規作成のときに使う
private func MakeNewID()->String{
    var result:String="" ;
    
    return result;
}

//MakeNewDirectory(ID:String)->Int : データを保存するディレクトリを作成する．メモの新規作成のときに使う．
private func MakeNewDirectory(ID:String)->Int{
    var result:Int=0 ;
    
    return result;
}


//MoveView(ViewName:String) : 画面遷移する関数
private func MoveView(ViewName:String){
    
    switch ViewName {
        case "Main"://一覧画面へ飛ぶ
            break ;
        case "edit"://編集画面へ飛ぶ
            break ;
        case "satsuei"://撮影画面へ飛ぶ
            break ;
        default ://エラー処理どうする？
        break ;
    }
    
}


