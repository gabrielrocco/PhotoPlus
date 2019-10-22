//
//  Effects.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 27/06/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{
    
    func applyEffect(imgToUse: UIImage, amount: CGFloat, effectToApply: Int) -> UIImage{
    
   
        //EFFECT GLOBAL VARIABLES
        var context = CIContext(options: nil)
        //Importação
        let aCGImageToFilter = imgToUse.cgImage
        let aCIImageToFilter = CIImage(cgImage: aCGImageToFilter!)
        var imgToUseFinal = aCIImageToFilter
      
        
        if effectToApply == 0 {
        //EFEITO GRANULADO

        //Parte 1
        let coloredNoise = CIFilter(name:"CIRandomGenerator")
        let noiseImage = coloredNoise?.outputImage
        //PARTE 2
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        //y: controla a quantidade! Slider afeta isso
        //0.0001 to 0.005
        let fineGrain = CIVector(x:0, y:amount, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        let whiteningFilter = CIFilter(name:"CIColorMatrix")
         whiteningFilter!.setValue(noiseImage, forKey: "inputImage")
         whiteningFilter!.setValue(whitenVector, forKey: "inputRVector")
         whiteningFilter!.setValue(whitenVector, forKey: "inputGVector")
         whiteningFilter!.setValue(whitenVector, forKey: "inputBVector")
         whiteningFilter!.setValue(fineGrain, forKey: "inputAVector")
         whiteningFilter!.setValue(zeroVector, forKey: "inputBiasVector")
        let whiteSpecks = whiteningFilter?.outputImage
            //PARTE 3
          let speckCompositor = CIFilter(name:"CISourceOverCompositing")
          speckCompositor!.setValue(whiteSpecks, forKey: "inputImage")
         speckCompositor!.setValue(imgToUseFinal, forKey: "inputBackgroundImage")
        let speckledImage = speckCompositor?.outputImage
            
        let finalImage = context.createCGImage(speckledImage!, from: imgToUseFinal.extent)
    let mynewUIImage = UIImage(cgImage: finalImage!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
     
        return mynewUIImage
       
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return imgToUse
    }
    
    
    
    
    
    
    
    
    
    
    
}
