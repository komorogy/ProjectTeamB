//
//  ViewController_Main.swift
//  ImagePass
//
//  Created by Mina on 2015/09/28.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

class ViewController_Main: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    // storyboardのtableviewを宣言
    @IBOutlet weak var tableView: UITableView!
    
    // appdelegate取得
    let appdele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var flg: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.  
        // tableviewの紐付け
        tableView.delegate = self
        tableView.dataSource = self
        flg = appdele.flg == nil ? false : appdele.flg
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 他画面から戻ってきたとき
    override func viewWillAppear(animated: Bool) {
        // セルの選択状態を解除する
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
        
        // flg取得
        flg = appdele.flg == nil ? false : appdele.flg
    }
    
    // セルに表示するテキスト(実際はアプリに保存されているファイル)
    let texts = ["Sunday", "Monday", "Tuesday","たいとる"]
    
//    let memo1 = ["メモのタイトル", "本文","2015", 136.9, 35.8];
//    let memo2:NSArray = ["メモのタイトル", "本文", 136.9, 35.8];
//    let memo3:NSArray = ["メモのタイトル", "本文", 136.9, 35.8];
    
    // セルの行数を指定する
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count //（実際はアプリに保存されている件数を返す）
    }
    
    // 各セルの内容を設定する(現状は、配列textsの文字列をひとつずつ表示しているだけ)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell",forIndexPath: indexPath)
        
        // セルが選択されたときの背景色の設定
        let cellSelectedView = UIView()
        cellSelectedView.backgroundColor = UIColor.greenColor()//ださいから他の色探そう
        cell.selectedBackgroundView = cellSelectedView
        
        // tag番号1 : タイトル
        let memoTitle = tableView.viewWithTag(1) as! UILabel
        memoTitle.text = texts[indexPath.row]
        
        
        // tag番号2 : サブタイトル(作成日時とか)
        let memoSub = tableView.viewWithTag(2) as! UILabel
        memoSub.text = texts[indexPath.row]
        
        // 空白行のseparatorを消す
        let v = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = v
        tableView.tableHeaderView = v
        
        return cell
    }
    
    //スワイプしてdelete(実際の削除は未実装)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Cell が選択された場合
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {        
        
        /*
        * 選択されたidを取得する(未実装)
        *  -> 鍵がかかっていればマッチング画面へ
        *  -> 鍵がかかっていなければ閲覧画面へ
        */
    
        // 閲覧画面へ遷移するために Segue を呼び出す
        if (flg) {
            performSegueWithIdentifier("showEtsuran",sender: nil)
        }
        else if (!flg) {
        // matching画面へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("modalMatching",sender: nil)
        }
        
    }

}






