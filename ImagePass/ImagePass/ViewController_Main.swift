//
//  ViewController_Main.swift
//  ImagePass
//
//  Created by Mina on 2015/09/28.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

class ViewController_Main: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // storyboardのtableviewを宣言
    @IBOutlet weak var tableView: UITableView!
    
    var addBtn :UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.  
        // tableviewの紐付け
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "List"
        // addBtnを設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn
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
        
        cell.textLabel?.text = texts[indexPath.row]
        
        return cell
    }
    
    // Cell が選択された場合
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        /*
         * 選択されたidを取得する(未実装)
         *  -> 鍵がかかっていればマッチング画面へ
         *  -> 鍵がかかっていなければ閲覧画面へ
         */
        
        var flg: Int = 1
        
        if (flg == 1){
        // 遷移先のstoryboardを取得.initialのViewControllerを取得
            var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_etsuran", bundle: NSBundle.mainBundle())
            var nextViewController: ViewController_Demo = storyboard.instantiateInitialViewController() as! ViewController_Demo
            
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }

        else{
            // 遷移先のstoryboardを取得.initialのViewControllerを取得
            var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_matching", bundle: NSBundle.mainBundle())
            var nextViewController: ViewController_Demo = storyboard.instantiateInitialViewController() as! ViewController_Demo
                
            // 画面遷移
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    
    // addBtnをタップしたときのアクション
    func onClick() {
        var storyboard: UIStoryboard = UIStoryboard(name: "Storyboard_edit", bundle: NSBundle.mainBundle())
        var nextViewController: ViewController_Edit = storyboard.instantiateInitialViewController() as! ViewController_Edit
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

}






