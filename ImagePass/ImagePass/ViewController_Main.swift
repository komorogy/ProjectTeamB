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
    
    // メモ取得用
    let NSUD = NSUserDefaults();
    let KEY = "KEYForNSUD";
    var memo: NSMutableArray = NSMutableArray();
    
    // 別画面に渡すやつ
    var watasu :NSArray = NSArray();
    
    var logoImageView: UIImageView!
    
    // appdelegateやNSUDを取得するメソッド
    private func selectObj(){
        
        appdele.selectList()
        memo = appdele.getMemoList()
        
        tableView.reloadData()
        //        // セルの選択状態を解除する
        //        if let indexPath = tableView.indexPathForSelectedRow{
        //            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        //        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //imageView作成
        self.logoImageView = UIImageView(frame: CGRectMake(0, 0, 320, 320))
        //画面centerに
        self.logoImageView.center = self.view.center
        //logo設定
        self.logoImageView.image = UIImage(named: "logo")
        //viewに追加
        self.view.addSubview(self.logoImageView)
        
        // tableviewの紐付け
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //少し縮小するアニメーション
        UIView.animateWithDuration(0.3,
            delay: 1.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.logoImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: { (Bool) in
                
        })
        
        //拡大させて、消えるアニメーション
        UIView.animateWithDuration(0.2,
            delay: 2.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.logoImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.logoImageView.alpha = 0
            }, completion: { (Bool) in
                self.logoImageView.removeFromSuperview()
        })
    }

    override func viewWillAppear(animated: Bool) {
        selectObj()
        if (appdele.getTargeted()[5] as! String == "0") {
            performSegueWithIdentifier("showEtsuran",sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  
    // セルの行数を指定する
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appdele.getMemoList().count
    }
    
    // 各セルの内容を設定する
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell",forIndexPath: indexPath)
        
        // セルが選択されたときの背景色の設定
        let cellSelectedView = UIView()
        cellSelectedView.backgroundColor = UIColor.greenColor()//ださいから他の色探そう
        cell.selectedBackgroundView = cellSelectedView
        
        let hairetsu:NSArray = appdele.getMemoList()[indexPath.row] as! NSArray
        
        // tag番号1 : タイトル
        let memoTitle = tableView.viewWithTag(1) as! UILabel
        memoTitle.text = hairetsu[0] as? String
        
        
        // tag番号2 : サブタイトル(作成日時とか)
        let memoSub = tableView.viewWithTag(2) as! UILabel
        memoSub.text = hairetsu[4] as? String
        
        // 空白行のseparatorを消す
        let v = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = v
        tableView.tableHeaderView = v
        
        return cell
    }
    
    //スワイプしてdelete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            print("delete indexNumber:" + String(indexPath.row))
           
            // 削除
            appdele.deleteTargeted(indexPath.row)
            
            // テーブル再読込み
            selectObj()
        }
    }
    
    // Cell が選択された場合
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {        
        
        /*
        * 選択されたidを取得する(未実装)
        *  -> 鍵がかかっていればマッチング画面へ
        *  -> 鍵がかかっていなければ閲覧画面へ
        */
        
        // マッチングに渡す配列
        //watasu = memo[indexPath.row] as! NSArray
        appdele.setTargeted(indexPath.row)
        
        // 画面遷移
        jumpToNextView()
    }
    
    //画面遷移前の処理
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
//        // マッチング画面遷移時は、選択されたセルの情報をViewController_matchingにセットする
//        if(segue.identifier == "modalMatching"){
//            let navigationController = segue.destinationViewController as! UINavigationController
//            print("segue's name : modalMatching")
//            let viewController = navigationController.topViewController as! ViewController_matching
//        
//            viewController.memo =  watasu
//        }
//            
//        if(segue.identifier == "showEtsuran"){
//            print("segue's name : showEtsuran")
//            let viewController = segue.destinationViewController as! ViewController_etsuran
//            
//            viewController.memo =  watasu
//        }
        
    }
    
    // 画面遷移
    private func jumpToNextView(){
        
        // 閲覧画面へ遷移するために Segue を呼び出す
        if (appdele.getTargeted()[5] as! String == "0") {
            performSegueWithIdentifier("showEtsuran",sender: nil)
        }
        else if (appdele.getTargeted()[5] as! String == "1") {
            // matching画面へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("modalMatching",sender: nil)
        }
    }

}






