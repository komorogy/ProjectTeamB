//
//  AppDelegate.swift
//  ImagePass
//
//  Created by 川述　優 on 2015/09/16.
//  Copyright (c) 2015年 川述　優. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // メモ取得用
    let NSUD = NSUserDefaults();
    let KEY = "KEYForNSUD";
    private var memo: NSMutableArray = NSMutableArray();
    
    // 選択対象のメモ
    private var targeted = ["","","","","",""];
    private var indexnum = 0
    
    
    // ゲッター
    func getTargeted()->NSArray{
        return targeted
    }
    
    func getMemoList()->NSMutableArray{
        return memo
    }
    
    func getTargetedIndexOfNumber()->Int{
        return indexnum
    }
    
    // セッター
    func setTargeted(index:Int){
        targeted = memo[index] as! [String]
        indexnum = index
    }
    
    // ターゲットクリア
    func clearTargeted(){
        for (index, _) in EnumerateSequence(targeted) {
            targeted[index] = ""
        }
        indexnum = 0
    }
    
    // メモ一覧取得
    func selectList(){
        if((NSUD.objectForKey(KEY)) != nil){
            memo = NSUD.objectForKey(KEY)?.mutableCopy() as! NSMutableArray;
            print("got NSUD")
        }
        
    }
    
    //メモ一覧に登録
    func addList(){
        NSUD.setObject(memo, forKey: KEY)
        NSUD.synchronize()
        print("add NSUD:" + String(memo))
    }
    
    // メモ一覧削除
    private func deleteList(){
        NSUD.removeObjectForKey(KEY)
        NSUD.synchronize()
        print("delete NSUD")
    }
    
    // メモの配列に追加
    func addMemo(){
        memo.addObject(targeted)
        print("add memo:" + String(targeted))
    }
    
    // 選択メモの値更新
    func updateTargeted(index :Int,update :String){
        targeted[index] = update
        print("update 'targeted':"+String(targeted))
    }
    
    // NSUDメモの内容を更新
    func updateNSUD(){
        // 更新対象のindexを削除
        memo.removeObjectAtIndex(indexnum)
        print("delete indexNumber:" + String(indexnum))
        // 元あったindex番号に、更新する値を追加
        memo.insertObject(targeted, atIndex: indexnum)
        print("add memo:" + String(memo[indexnum]))
        
        deleteList()
        addList()
    }
    
    // メモ削除
    func deleteTargeted(index :Int){
        memo.removeObjectAtIndex(index)
        print("delete indexNumber:" + String(index))
        
        deleteList()
        addList()
    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

