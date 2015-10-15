//
//  ViewController_Main.swift
//  ImagePass
//
//  Created by Mina on 2015/09/28.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

class ViewController_Main: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //ひとまず画面遷移用だけ形になるようにフラグを作成　マッチング画面を通ればtrueになる
    private var flg: Bool = false
    
    // storyboardのtableviewを宣言
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.  
        // tableviewの紐付け
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルに表示するテキスト(実際はアプリに保存されているファイル)
    let texts = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    // セルの行数を指定する
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count //（実際はアプリに保存されている件数を返す）
    }
    
    // 各セルの内容を設定する(現状は、配列textsの文字列をひとつずつ表示しているだけ)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel!.text = texts[indexPath.row]
        
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
            performSegueWithIdentifier("showMemo",sender: nil)
        }
        else if (!flg) {
        // matching画面へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("modalMatching",sender: nil)
        }
        
    }
    
    
    
    //unWind
    @IBAction func exitToMain(segue: UIStoryboardSegue)
    {
        /* -----------------------------------------------------------------------
            画面遷移を成功させるために、
            ここでflgの書き換えをして、セルを選択した時にflgを見て遷移先を選ぶようにしています
            実際はここでの処理は必要なく、セル選択時にディレクトリを見に行って遷移先を判断する
           ----------------------------------------------------------------------- */
        
        //画面遷移を分けるために、マッチング画面のOpenボタンで帰ってきた場合、鍵解除ということにしている
        if(segue.identifier == "openMemo"){
            self.flg = true
        }
        //画面遷移を分けるために、鍵設定画面のボタンで帰ってきた場合、施錠ということにしている
        else if(segue.identifier == "setGPS"){
            self.flg = false
        }
    }

}






