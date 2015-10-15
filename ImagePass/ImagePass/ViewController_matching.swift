//
//  ViewController_matching.swift
//  ImagePass
//
//  解錠画面
//  Created by 杉本　耕 on 2015/10/04.
//  Copyright © 2015年 川述　優. All rights reserved.
//

import UIKit
/*
// ディレクトリをいじったりするクラス？みたいなの．defaultManager()でインスタンス化するみたい．
private let fileManager:NSFileManager = NSFileManager.defaultManager() ;
*/

class ViewController_matching: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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