//
//  ProgressCircle.swift
//  TRACKENDO
//
//  Created by Matilda Dahlberg on 2018-04-10.
//  Copyright © 2018 Niklas Lindell. All rights reserved.
//

import UIKit

class ProgressCircle: UIViewController {
    @IBOutlet weak var circleView: UIView!
    
    //ritar upp cirkeln
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cirkeln visas i mitten av skärmen(center)
        let center = circleView.center
        
        //create my track layer(själva mallen bakom det gröna/röda)
        let trackLayer = CAShapeLayer()
        
        //gör en cirkel, startangle är att den börjar högst upp och endangle gör att den går runt (pi = 180grader)
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        
        //färgen på själva mallen
        trackLayer.strokeColor = UIColor.lightText.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        
        //ritar in det i min view
        view.layer.addSublayer(trackLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        
        //färgen på strecket som går runt
        shapeLayer.strokeColor = UIColor.green.cgColor
        
        //tjockleken på strecket
        shapeLayer.lineWidth = 5
        
        //färgen på cirkeln innanför strecket
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //gör så att linjen blir rundad i början och slutet
        //shapeLayer.lineCap = kCALineCapRound
        
        //strecket försvinner med den här
        shapeLayer.strokeEnd = 0
        
        //ritar upp den i min view
        view.layer.addSublayer(shapeLayer)
        
        //cirkeln startas när man trycker på skärmen, med vår handletap func
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap(){
        print("animate")
        
        //börjar animera och använder strokeEnd så att den börjar röras
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        //här går den från strokeEnd(0) till toValue(1)
        basicAnimation.toValue = 1
        
        //det här är hur snabbt cirkeln ska gå runt
        basicAnimation.duration = 5
        
        //dessa två gör att animationen stannar så när den är ifylld
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        //adderar animationen
        shapeLayer.add(basicAnimation, forKey: "basic")
        
    }
    
    
    
    
}

