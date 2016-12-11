//
//  emmitParticles.swift
//  Liveyktest1
//
//  Created by yons on 16/9/21.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

func emmitParticles(emitter: CAEmitterLayer , in rootView:UIView) {
    let originPoint = CGPoint(x: rootView.bounds.maxX, y: rootView.bounds.maxY)
    let pos = CGPoint(x: originPoint.x / 2, y: originPoint.y)
    let image = #imageLiteral(resourceName: "tspark")
    
    // 配置emitter
    emitter.emitterPosition = pos //发射源位置
    emitter.renderMode = kCAEmitterLayerBackToFront  //渲染模式
    
    // CAEmitterCell用来表示一个个的粒子, 它有一系列的参数用于设置效果.
    let rocket = CAEmitterCell()
    rocket.emissionLongitude = CGFloat(M_PI_2)
    rocket.emissionLatitude = 0
    rocket.lifetime = 1.6               //生命周期，必需大于1.0
    rocket.birthRate = 1                //每秒生成粒子个数，默认1.0
    rocket.velocity = 40                //粒子运动的速度均值
    rocket.velocityRange = 100          //速度范围
    rocket.yAcceleration = -250         //粒子y方向的 加速度分量
    rocket.emissionRange = CGFloat(M_PI_4)  //周围发射角度
    rocket.color = UIColor(colorLiteralRed: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).cgColor   //粒子的颜色
    rocket.redRange = 1.0   //一个粒子的颜色green 能改变的范围
    rocket.greenRange = 1.0
    rocket.blueRange = 1.0
    rocket.name = "rocket"  //Name the cell so that it can be animated later using keypath
    
    
    let flare = CAEmitterCell()
    flare.contents = image.cgImage
    flare.emissionLongitude = 4 * CGFloat(M_PI_2)
    flare.scale = 0.4
    flare.velocity = 100;
    flare.birthRate = 45;
    flare.lifetime = 1.5;
    flare.yAcceleration = -350;
    flare.emissionRange = CGFloat(M_PI / 7)
    flare.alphaSpeed = -0.7;     //粒子消逝的速度
    flare.scaleSpeed = -0.1;
    flare.scaleRange = 0.1;
    flare.beginTime = 0.01;
    flare.duration = 0.7;
    
    //The particles that make up the explosion
    let firework = CAEmitterCell()
    firework.contents = image.cgImage;
    firework.birthRate = 9999;
    firework.scale = 0.6;
    firework.velocity = 130;
    firework.lifetime = 2;
    firework.alphaSpeed = -0.2;
    firework.yAcceleration = -80;
    firework.beginTime = 1.5;
    firework.duration = 0.1;
    firework.emissionRange = CGFloat(M_PI * 2)
    firework.scaleSpeed = -0.1
    firework.spin = 2;
    firework.name = "firework"
    
    //preSpark is an invisible particle used to later emit the spark
    let preSpark = CAEmitterCell()
    preSpark.birthRate = 80
    preSpark.velocity = firework.velocity * 0.70
    preSpark.lifetime = 1.7
    preSpark.yAcceleration = firework.yAcceleration * 0.85
    preSpark.beginTime = firework.beginTime - 0.2
    preSpark.emissionRange = firework.emissionRange
    preSpark.greenSpeed = 100
    preSpark.blueSpeed = 100
    preSpark.redSpeed = 100
    preSpark.name = "preSpark"
    
    //The 'sparkle' at the end of a firework
    let spark = CAEmitterCell()
    spark.contents = image.cgImage
    spark.lifetime = 0.05;
    spark.yAcceleration = -250;
    spark.beginTime = 0.8;
    spark.scale = 0.4;
    spark.birthRate = 10;
    
    preSpark.emitterCells = [spark]
    rocket.emitterCells = [flare, firework, preSpark]
    emitter.emitterCells = [rocket]
    
    rootView.setNeedsDisplay()
}

