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
//MakeNewDirectory(ID:String)->Bool : データを保存するディレクトリを作成する．メモの新規作成のときに使う．
//MoveView(ViewName:String) : 画面遷移する関数．
////////////////////////////////////////////////////////////////////


class ViewController_etsuran: UIViewController {

    // AppDelegateのインスタンス化
    let appdele :AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    
    // メモ一覧で選択されたメモを保持する
    var memo: NSArray = NSArray();
    
    //アプリケーションが自由にできるDocumentディレクトリのパス
    let rootDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
    
    // ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
    let fileManager:NSFileManager = NSFileManager.defaultManager() ;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(appdele.getTargeted().count > 0){
            myTitle.text = appdele.getTargeted()[0] as? String
            myTextView.text = appdele.getTargeted()[1] as? String
        }

        // Do any additional setup after loading the view, typically from a nib.
    
        /*
        ///////////////////////////////////////////////////////////////////
        //閲覧画面の初期化処理．AppDelegate.swiftに定義されているIdを見て，新規作成・既存ファイル閲覧を判断
        //Id=""のとき，新規作成
        //Id="hogehoge"のとき，既存のファイルを開く．
        ////////////////////////////////////////////////////////////////////
/*        BackButton.setTitle("Back", forState: UIControlState.Normal) ;
        CameraButton.setTitle("Camera", forState: UIControlState.Normal) ;
        TextViewer.text="test" ;
*/
        
//        let ID:String = appDelegate.Id ;
        let ID:String = "";
        
        var dataDirectory = rootDirectory ;

        
        if (ID==""){
            dataDirectory += dataDirectory + "/" + MakeNewID();
            if(!MakeNewDirectory(dataDirectory)){
                //ディレクトリ作成に失敗したら，とりあえず一覧画面に戻しとく．
                MoveView("Main") ;
            }
            MoveView("edit") ;
        }*/

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {

        // 戻るボタンが押された処理
        print("back!")
        appdele.clearTargeted()
    }
    

    // もう一回カギをかける デバッグ用につけといた
    @IBAction func reLock(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)    }

/*
    
    //IsExistDirectory(ID:String)->Bool : "rootDirectory/ID"というディレクトリが存在するか確認する．
    private func IsExistDirectory(dataDirectory:String)->Bool{
        var result:Bool=false;
        
        if(fileManager.fileExistsAtPath(dataDirectory)){
            result = true ;
        }
        
        return result ;
    }
    
    //MakeNewID()->String : IDの新規発番．メモの新規作成のときに使う
    private func MakeNewID()->String{
        var result:String="" ;
        
        //日付を文字列に直すときに便利なクラスらしい．
        let dateFormatter = NSDateFormatter() ;
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") ;//日本の時刻を基準に
        dateFormatter.dateFormat = "yyyyMMddHHmmss" ;//時刻形式はyyyymmddhhmmss
        
        result = dateFormatter.stringFromDate(NSDate()) ;//resultにyyyymmddhhmmssを保存．
        
        //この関数のPIDが欲しいけど，どうやって取るんだ・・・
        
        return result;
    }
    
    //MakeNewDirectory(ID:String)->Int : データを保存するディレクトリを作成する．メモの新規作成のときに使う．
    private func MakeNewDirectory(dataDirectory:String)->Bool{
        var result:Bool=true ;
        let errorPointer : NSErrorPointer = nil ;
        
        do {
            try fileManager.createDirectoryAtPath(dataDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            errorPointer.memory = error
        } ;
        
        if ( errorPointer != nil ){
            result = false ;
        }
        
        return result;
    }
    
    
    //MoveView(ViewName:String) : 画面遷移する関数
    private func MoveView(ViewName:String){
        
        switch ViewName {
/*        case "Main"://一覧画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_Main", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_Main = storyboard.instantiateInitialViewController() as! ViewController_Main ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
        case "edit"://編集画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_edit", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_edit = storyboard.instantiateInitialViewController() as! ViewController_edit ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
        case "satsuei"://撮影画面へ飛ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_satsuei", bundle: NSBundle.mainBundle())
            let nextViewController: ViewController_satsuei = storyboard.instantiateInitialViewController() as! ViewController_satsuei ;
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true);
 */       default ://エラー処理どうする？
            break ;
        }
        
    }
    */

 

    
}







