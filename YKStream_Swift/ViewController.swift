//
//  ViewController.swift
//  YKStream_Swift
//
//  Created by MinJing_Lin on 16/12/1.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnGift: UIButton!
    @IBOutlet weak var btnLove: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    var playerView: UIView!
    var ijkPlayer: IJKMediaPlayback!

    @IBAction func tapBack(_ sender: UIButton) {
        
        ijkPlayer.shutdown()
        
        //warning
        _ =  navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func tapGift(_ sender: UIButton) {
        
        let duration = 2.0
        let carImg = UIImageView(image: #imageLiteral(resourceName: "porsche"))
        carImg.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(carImg)
        
        UIView.animate(withDuration: duration ){
            carImg.bounds = CGRect(x: 0, y: 0, width: 250, height: 127)
            carImg.center = self.view.center
        }
        
        //延迟两秒消失
        DispatchQueue.main.asyncAfter(deadline: .now()+duration){
            UIView.animate(withDuration: duration, animations: { 
                carImg.alpha = 0;
            }, completion: { (completed) in
                carImg.removeFromSuperview()
            })
        }
        
        let layerParticle = CAEmitterLayer()
        view.layer.addSublayer(layerParticle)
        emmitParticles(emitter: layerParticle, in: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2){
            layerParticle.removeFromSuperlayer()
        }
        
    }
 
    
    @IBAction func tapLove(_ sender: UIButton) {
        let heartView = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        heartView.center = CGPoint(x: btnLove.frame.origin.x+20, y: btnLove.frame.origin.y)
        view.addSubview(heartView)
        heartView.animate(in: view)
        
        //按钮关键帧动画
        let btnAnima = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnima.values = [1.0,0.7,0.5,0.3,0.5,0.7,1.0,1.2,1.4,1.2,1.0]   /**设置关键路径*/
        btnAnima.keyTimes = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]  /**设置关键路径的时间点 范围【0~1】*/
        btnAnima.duration = 0.2
        sender.layer.add(btnAnima, forKey: "anima")
        
    }
    
    var live:YKCell!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.ijkPlayer.isPlaying() {
            ijkPlayer.prepareToPlay()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBg()
        setPlayView()
        
        bringBtnToFront()
    }
    
    func setPlayView() {
        self.playerView = UIView(frame: view.bounds)
        view.addSubview(self.playerView)
        
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil)
        ijkPlayer.scalingMode = .aspectFill
        let pv = ijkPlayer.view!
        pv.frame = playerView.bounds
        pv.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        playerView.insertSubview(pv, at: 1)
    }
    
    func setBg(){
        var imgUrl = URL(string: "http://img.meelive.cn/" + live.portrait)
        if live.portrait.hasPrefix("http")  {
            imgUrl = URL(string: live.portrait)
        }
        imgBack.kf.setImage(with: imgUrl)
        
        //  创建需要的毛玻璃特效类型   iOS8.0之后
        let blurEffect = UIBlurEffect(style: .light)
        //  毛玻璃view 视图
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imgBack.frame
        imgBack.addSubview(effectView)
        
    }
    
    func bringBtnToFront() {
        view.bringSubview(toFront: btnBack)
        view.bringSubview(toFront: btnGift)
        view.bringSubview(toFront: btnLove)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

