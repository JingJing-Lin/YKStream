//
//  MJMainViewController.swift
//  YKStream_Swift
//
//  Created by MinJing_Lin on 16/12/1.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

import UIKit
import Just
import Kingfisher

class MJMainViewController: UITableViewController {

    let liveListUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
    var list : [YKCell]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadList()
        
       //下拉刷新
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)
        
    }
    
    func loadList() {
        
        Just.post(liveListUrl) { (r) in
            
            //guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
            //as操作符用来把某个实例转型为另外的类型，由于实例转型可能失败，故选项形式as?
            
            guard let json = r.json as? NSDictionary else{
                return
            }
            let lives = MJStreamModel(fromDictionary: json).lives!
            
            //map函数会遍历整个数组，并对数组中每一个元素执行闭包中定义的操作。 相当于对数组中的所有元素做了一个映射。
            self.list = lives.map({ (live) -> YKCell in
                return YKCell(portrait: live.creator.portrait, cover: live.creator.nick, location: live.city, viewers: live.onlineUsers, url: live.streamAddr)
            })
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCellId", for: indexPath) as! LiveTableViewCell

        let live = list[indexPath.row]
        
        cell.name.text = live.cover
        cell.city.text = live.location
        cell.viewers.text = "\(live.viewers)"
        
        //图片前缀 http://img.meelive.cn/
        var imgUrl = URL(string: "http://img.meelive.cn/" + live.portrait)
        if live.portrait.hasPrefix("http")  {
            imgUrl = URL(string: live.portrait)
        }
        dump(imgUrl)

        cell.headerImg.kf.setImage(with: imgUrl)
        cell.bigImg.kf.setImage(with: imgUrl)
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let dest = segue.destination as! ViewController
        
        dest.live = list[(tableView.indexPathForSelectedRow?.row)!]
    }
 

}
