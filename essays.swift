//
//  essays.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 12/06/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import Foundation
import UIKit


//Aqui fica todo o conteudo dos artigos
extension essayViewController{
    

    
    
    
    
  
    //PHOTOGRAPHY BASICS ESSAY
    func makeBasicsEssay(){
        globalSlider.alpha = 0
        var sizeOfScrollView = 0
         var sizeOfScrollView2 = 0
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        
      
            //Photography Basics
            let labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            labelTitle.numberOfLines = 0
            labelTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            labelTitle.textAlignment = .center
            labelTitle.text = "Photography Basics"
            labelTitle.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 40)
         
            labelTitle.adjustsFontSizeToFitWidth=true
            
            
            
            
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            label.numberOfLines = 0
            label.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.textAlignment = .justified
            label.text = "Welcome to the first lesson of Photo+. We really hope that you enjoy it! This will be a very initial lesson and we will talk about the basics."
            
           
            let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            label2.numberOfLines = 0
            label2.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
            label2.lineBreakMode = NSLineBreakMode.byWordWrapping
            label2.textAlignment = .justified
            label2.text = "First of all, when we talk about photography we are essentially talking about drawing with light. It basically means that all that matters in that kind of art is the light. Obviously we can't control it in all the situations, for example, we can't control sunlight. BUT our camera let us control how that light is going to be captured. That means that we can change some parameters that will directly affect the final result."
            
            
            let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            label3.numberOfLines = 0
            label3.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
            label3.lineBreakMode = NSLineBreakMode.byWordWrapping
            label3.textAlignment = .justified
            label3.text = "Most of the cameras in the market allow us to have manual control of the 3 master variables which controls light entering (You can use your phone camera in manual mode with Photo+). ISO, Aperture and Shutter speed composes the EXPOSURE TRIANGLE. You have to master it to be able to capture photos professionally."
            
            let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            label4.numberOfLines = 0
            label4.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
            label4.lineBreakMode = NSLineBreakMode.byWordWrapping
            label4.textAlignment = .justified
            label4.text = "Furthermore you may think that all photos that you see on newspapers, magazines, or from professionals are not edited and that all the work is done on the camera, but that is a myth. A crucial part of the work is done on the camera but taking the photo is just half of the job!"

            let label5 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
            label5.numberOfLines = 0
            label5.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
            label5.lineBreakMode = NSLineBreakMode.byWordWrapping
            label5.textAlignment = .justified
            label5.text = "Write that: Your final result will be based first of all in one of the most difficult skills to learn and train....YOUR VISION, you have to train it. Then the camera skills enters into the field and for last but not less important, the post edition. Everything will be completely covered in all details on the lessons."
            
            
     
            
            
            
            var expectedLabelSize: CGSize = labelTitle.sizeThatFits(maximumLabelSize)
            var newFrame: CGRect = labelTitle.frame
            newFrame.size.height = expectedLabelSize.height
            labelTitle.frame = newFrame
            labelTitle.center = CGPoint(x: view.center.x, y: labelTitle.frame.height*0.45)
            
            
            expectedLabelSize = label.sizeThatFits(maximumLabelSize)
            newFrame = label.frame
            newFrame.size.height = expectedLabelSize.height
            label.frame = newFrame
            label.center = CGPoint(x: view.center.x, y: labelTitle.center.y + labelTitle.frame.height*0.35+label.frame.height/2)

            expectedLabelSize = label2.sizeThatFits(maximumLabelSize)
            newFrame = label2.frame
            newFrame.size.height = expectedLabelSize.height
            label2.frame = newFrame
            label2.center = CGPoint(x: view.center.x, y: label.center.y + label.frame.height*0.5 + label2.frame.height*0.5)
            
            expectedLabelSize = label3.sizeThatFits(maximumLabelSize)
            newFrame = label3.frame
            newFrame.size.height = expectedLabelSize.height
            label3.frame = newFrame
            label3.center = CGPoint(x: view.center.x, y: label2.center.y + label2.frame.height*0.5 + label3.frame.height*0.5)
            
            
   
            let triangleImage: UIImageView = UIImageView(image: UIImage(named: "triangle"))
            triangleImage.frame.size = CGSize(width: view.frame.width*0.8, height: view.frame.width*0.8)
                triangleImage.center = CGPoint(x: view.center.x, y: label3.center.y+label3.frame.height*0.5+triangleImage.frame.height*0.5)
            
            expectedLabelSize = label4.sizeThatFits(maximumLabelSize)
            newFrame = label4.frame
            newFrame.size.height = expectedLabelSize.height
            label4.frame = newFrame
            label4.center = CGPoint(x: view.center.x, y: triangleImage.center.y + triangleImage.frame.height*0.5 + label4.frame.height*0.5)
            
            expectedLabelSize = label5.sizeThatFits(maximumLabelSize)
            newFrame = label5.frame
            newFrame.size.height = expectedLabelSize.height
            label5.frame = newFrame
            label5.center = CGPoint(x: view.center.x, y: label4.center.y + label4.frame.height*0.5 + label5.frame.height*0.5)
            
            
  
            sizeOfScrollView = Int(label.frame.height + labelTitle.frame.height+triangleImage.frame.height+label2.frame.height+label3.frame.height+label4.frame.height+label5.frame.height)
            sizeOfScrollView2 = Int(view.frame.width)
            
            learnScrollView.contentSize = CGSize(width: sizeOfScrollView2, height: sizeOfScrollView)
            
             learnScrollView.addSubview(labelTitle)
            learnScrollView.addSubview(label)
             learnScrollView.addSubview(label2)
            learnScrollView.addSubview(label3)
             learnScrollView.addSubview(label4)
            learnScrollView.addSubview(label5)
             learnScrollView.addSubview(triangleImage)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //PHOTOGRAPHY BASICS ESSAY
    func makeISOessay(){
    
        var sizeOfScrollView = 0
        var sizeOfScrollView2 = 0
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        
        
        //Photography Basics
        let labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        labelTitle.textAlignment = .center
        labelTitle.text = "ISO SENSITIVITY"
        labelTitle.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 40)
        labelTitle.adjustsFontSizeToFitWidth=true
        

        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        label.text = "ISO sensitivity is the first of the three variables that we will talk about! It is basically the sensitivity of the camera sensor to light. The bigger that value is, much light will be processed by the sensor and more brighter the final image will be. (Normally ISO starts between 50 and 100 on most of the cameras )"
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label2.numberOfLines = 0
        label2.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.textAlignment = .justified
        label2.text = "As you might think, you normally use higher ISO values on darker situations. And that is practically the only situation that you will want to increase it. Notice that the quality on specifics ISO values will be different on from camera to camera, and the ISO range can also vary."
        
        
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label3.numberOfLines = 0
        label3.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label3.lineBreakMode = NSLineBreakMode.byWordWrapping
        label3.textAlignment = .justified
        label3.text = "See with your own eyes the difference between a low ISO (50-200) to a high ISO value (6400 and beyond)"
        
        let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label4.numberOfLines = 0
        label4.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label4.lineBreakMode = NSLineBreakMode.byWordWrapping
        label4.textAlignment = .justified
        label4.text = "As you can see the ISO can change drastically the final result and is surely an important tool to use in some cases (On the samples, ISO is the only variable that changed). But you have to use it moderately and by rule set it as low as possible. Know why?"
        
        let label5 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label5.numberOfLines = 0
        label5.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label5.lineBreakMode = NSLineBreakMode.byWordWrapping
        label5.textAlignment = .justified
        label5.text = "In this case, more light comes with a price: NOISE. Noise is the variation in pixel image that changes its color (chrominance noise) or brightness (luminance noise) resulting in loss of quality. Now you can change the slider and increase noise to the following image to understand in a practical way what happens when noise enters into the field and the way it changes the image quality."
       
        isoLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800)
        isoLabel.numberOfLines = 0
        isoLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        isoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        isoLabel.textAlignment = .center
        
        var expectedLabelSize: CGSize = labelTitle.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = labelTitle.frame
        newFrame.size.height = expectedLabelSize.height
        labelTitle.frame = newFrame
        labelTitle.center = CGPoint(x: view.center.x, y: labelTitle.frame.height*0.8)
        
        
        expectedLabelSize = label.sizeThatFits(maximumLabelSize)
        newFrame = label.frame
        newFrame.size.height = expectedLabelSize.height
        label.frame = newFrame
        label.center = CGPoint(x: view.center.x, y: labelTitle.center.y + labelTitle.frame.height*0.5+label.frame.height*0.5)
        
        expectedLabelSize = label2.sizeThatFits(maximumLabelSize)
        newFrame = label2.frame
        newFrame.size.height = expectedLabelSize.height
        label2.frame = newFrame
        label2.center = CGPoint(x: view.center.x, y: label.center.y + label.frame.height*0.5+label2.frame.height*0.5)
        
      
        expectedLabelSize = label3.sizeThatFits(maximumLabelSize)
        newFrame = label3.frame
        newFrame.size.height = expectedLabelSize.height
        label3.frame = newFrame
        label3.center = CGPoint(x: view.center.x, y: label2.center.y + label2.frame.height*0.5+label3.frame.height*0.5)
        
       
        imageChangeISO.frame.size = CGSize(width: view.frame.width*0.8, height: view.frame.width*0.8)
        imageChangeISO.center = CGPoint(x: view.center.x, y: label3.center.y+label3.frame.height*0.5+imageChangeISO.frame.height*0.5+25)
        imageChangeISO.layer.masksToBounds = true
         imageChangeISO.layer.cornerRadius = 10
        
        
        expectedLabelSize = isoLabel.sizeThatFits(maximumLabelSize)
        newFrame = isoLabel.frame
        newFrame.size.height = expectedLabelSize.height
        isoLabel.frame = newFrame
        isoLabel.center = CGPoint(x: view.center.x, y: imageChangeISO.center.y + imageChangeISO.frame.height*0.5+isoLabel.frame.height*0.7)
        
        increaseISObutton.setTitle("INCREASE ISO", for: .normal)
        increaseISObutton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        increaseISObutton.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
        increaseISObutton.titleLabel?.textAlignment = .center
        increaseISObutton.frame.size = CGSize(width: 100, height: 30)
        increaseISObutton.center = CGPoint(x: view.center.x+increaseISObutton.frame.width*0.6, y: imageChangeISO.center.y+imageChangeISO.frame.height*0.5+increaseISObutton.frame.height*2)
         increaseISObutton.layer.cornerRadius = 8

        
        decreaseISObutton.setTitle("DECREASE ISO", for: .normal)
        decreaseISObutton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        decreaseISObutton.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
        decreaseISObutton.titleLabel?.textAlignment = .center
        decreaseISObutton.frame.size = CGSize(width: 100, height: 30)
        decreaseISObutton.center = CGPoint(x: view.center.x-increaseISObutton.frame.width*0.6, y: imageChangeISO.center.y+imageChangeISO.frame.height*0.5+increaseISObutton.frame.height*2)
        decreaseISObutton.layer.cornerRadius = 8
        
        expectedLabelSize = label4.sizeThatFits(maximumLabelSize)
        newFrame = label4.frame
        newFrame.size.height = expectedLabelSize.height
        label4.frame = newFrame
        label4.center = CGPoint(x: view.center.x, y: decreaseISObutton.center.y + decreaseISObutton.frame.height*0.5+label4.frame.height*0.5+25)
        
        
        
        expectedLabelSize = label5.sizeThatFits(maximumLabelSize)
        newFrame = label5.frame
        newFrame.size.height = expectedLabelSize.height
        label5.frame = newFrame
        label5.center = CGPoint(x: view.center.x, y: label4.center.y + label4.frame.height*0.5+label5.frame.height*0.5)
        
        noiseImage.image = UIImage(named: "isoPlaceholder")
        noiseImage.frame.size = CGSize(width: view.frame.width*0.8, height: view.frame.width*0.8)
        noiseImage.center = CGPoint(x: view.center.x, y: label5.center.y+label5.frame.height*0.5+noiseImage.frame.height*0.5)
        noiseImage.layer.masksToBounds = true
        noiseImage.layer.cornerRadius = 10
        
        
        
         globalSlider.alpha = 1
           globalSlider.frame.size = CGSize(width: noiseImage.frame.width, height: globalSlider.frame.height)
         globalSlider.center = CGPoint(x: view.center.x, y: noiseImage.center.y + noiseImage.frame.height*0.5+globalSlider.frame.height)
        
        globalSlider.minimumValue = -17
        globalSlider.maximumValue = 0.02
        globalSlider.value = 0.02
       globalSlider.transform = CGAffineTransform(scaleX: -1, y: 1)
        globalSlider.maximumTrackTintColor = UIColor(red:0.53, green:0.03, blue:0.00, alpha:1.0)
        
        let label6 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.9, height: 800))
        label6.numberOfLines = 0
        label6.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 18)
        label6.lineBreakMode = NSLineBreakMode.byWordWrapping
        label6.textAlignment = .justified
        label6.text = "As you can see, noise isn't very attractive. So, always remeber that when you need to increase ISO sensitivity. But also remembers that it is an alternative to bring more light to the image, so don't be afraid of using it."
        
        expectedLabelSize = label6.sizeThatFits(maximumLabelSize)
        newFrame = label6.frame
        newFrame.size.height = expectedLabelSize.height
        label6.frame = newFrame
        label6.center = CGPoint(x: view.center.x, y: globalSlider.center.y + globalSlider.frame.height*0.5+label6.frame.height*0.5)
        
        
        
        
        
        

        learnScrollView.addSubview(labelTitle)
        learnScrollView.addSubview(label)
        learnScrollView.addSubview(label2)
         learnScrollView.addSubview(imageChangeISO)
         learnScrollView.addSubview(isoLabel)
         learnScrollView.addSubview(increaseISObutton)
          learnScrollView.addSubview(decreaseISObutton)
          learnScrollView.addSubview(label3)
         learnScrollView.addSubview(label4)
         learnScrollView.addSubview(label5)
        learnScrollView.addSubview(noiseImage)
        learnScrollView.addSubview(globalSlider)
         learnScrollView.addSubview(label6)

        
        
        
        sizeOfScrollView = Int(125+label.frame.height + labelTitle.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + imageChangeISO.frame.height + increaseISObutton.frame.height + label5.frame.height + label6.frame.height + noiseImage.frame.height + globalSlider.frame.height )
        sizeOfScrollView2 = Int(view.frame.width)
          learnScrollView.contentSize = CGSize(width: sizeOfScrollView2, height: sizeOfScrollView)
    }
    
    
    
    
    
    
    
    
    
}

