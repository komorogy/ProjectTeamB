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

    //ボタンとかの宣言
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var Title: UITextField!
    @IBOutlet weak var TextEditer: UITextView!
    
    //ボタンアクション．
    @IBAction func PushSaveButton(sender: AnyObject) {
        
        //メモの保存処理をここに書く．
        MoveView("etsuran") ;
    }
    
    @IBAction func PushBackButton(sender: AnyObject) {
        //保存処理なしで，閲覧画面に戻る．
        MoveView("etsuran") ;
    }
    
    @IBAction func PushTitle(sender: AnyObject) {
    }
    
    
    //MoveView(ViewName:String) : 画面遷移する関数
    private func MoveView(ViewName:String){
        
        switch ViewName {
        case "etsuran"://編集画面へ飛ぶ
            var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_etsuran", bundle: NSBundle.mainBundle())
            var nextViewController: ViewController_etsuran = storyboard.instantiateInitialViewController() as ViewController_etsuran ;
        default ://エラー処理どうする？
            break ;
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




