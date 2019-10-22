//
//  FiltersAplly.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 12/06/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import Foundation
import UIKit




//Extensão do ViewController que serve para aplicar filtros
extension ViewController{
    
    
    
    
    func selectiveColorApply(image: CIImage) -> CIImage {
        
        HSLFilter.inputImage = image
        
        

            HSLFilter.inputRedShift = CIVector(x: CGFloat(selectiveColorsArray[0][0]), y: CGFloat(selectiveColorsArray[0][1]), z: CGFloat(selectiveColorsArray[0][2]))

            HSLFilter.inputOrangeShift = CIVector(x: CGFloat(selectiveColorsArray[1][0]), y: CGFloat(selectiveColorsArray[1][1]), z: CGFloat(selectiveColorsArray[1][2]))
       
            HSLFilter.inputYellowShift = CIVector(x: CGFloat(selectiveColorsArray[2][0]), y: CGFloat(selectiveColorsArray[2][1]), z: CGFloat(selectiveColorsArray[2][2]))
      
            HSLFilter.inputGreenShift = CIVector(x: CGFloat(selectiveColorsArray[3][0]), y: CGFloat(selectiveColorsArray[3][1]), z: CGFloat(selectiveColorsArray[3][2]))

            HSLFilter.inputBlueShift = CIVector(x: CGFloat(selectiveColorsArray[4][0]), y: CGFloat(selectiveColorsArray[4][1]), z: CGFloat(selectiveColorsArray[4][2]))
     
            HSLFilter.inputMagentaShift = CIVector(x: CGFloat(selectiveColorsArray[5][0]), y: CGFloat(selectiveColorsArray[5][1]), z: CGFloat(selectiveColorsArray[5][2]))
        
    
        
        return HSLFilter.outputImage!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func filtersPreviewApply(imgToUse: UIImage, filterType: Int, filterNumber: Int, toImage: Bool, percentage: Float) -> UIImage {
        
        
        
        
        
        let aCGImageToFilter = imgToUse.cgImage
        let aCIImageToFilter = CIImage(cgImage: aCGImageToFilter!)
        var imgToUseFinal = aCIImageToFilter
        
        if toImage == false{
            
            let aCGImageMini = filterButtonMiniImg!.cgImage!
            let aCIImageMini = CIImage(cgImage: aCGImageMini)
            imgToUseFinal = aCIImageMini
        }
        
        
        //print(appFilters[filterType][filterNumber][0])
        //Mudar a ordem dos bw
        //Colocar os bw numa array de filtros
        //etc etc
        
    
       
        
        var base:[Float] =  [0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1]
        novoFiltro = []
        
        var warmthVectorFilter = CIVector(x:6500,y:0)
        var tintVectorFilter =  CIVector(x:6500,y:0)
     
        
        
        
        

        
        for i in 0...appFilters[filterType][filterNumber].count-1{
            novoFiltro.append((Double(((appFilters[filterType][filterNumber][i]-base[i])/20)*percentage+base[i])))
            
        }
        
        warmthVectorFilter =  (makeWarmthVector(givenWarmth: CGFloat(novoFiltro[6])))[0]
        
        tintVectorFilter = (makeWarmthVector(givenWarmth: CGFloat(novoFiltro[6])))[1]
        
        
        //ATUALIZA O VALOR DOS FILTROS
        brightnessFilter!.setValue(novoFiltro[0], forKey: "inputEV")
        
        shadowsFilter!.setValue(novoFiltro[1], forKey: "inputShadowAmount")
        shadowsFilter!.setValue(novoFiltro[2], forKey: "inputHighlightAmount")
        sharpenFilter!.setValue(novoFiltro[5], forKey: "inputSharpness")
        contrastSat!.setValue(novoFiltro[3], forKey: "inputSaturation")
        contrastSat!.setValue(novoFiltro[4], forKey: "inputContrast")
        vibranceFilter!.setValue(novoFiltro[7], forKey: "inputAmount")
        
        vignetteFilter!.setValue(novoFiltro[8], forKey: "inputIntensity")
        vignetteFilter!.setValue(novoFiltro[13], forKey: "inputRadius")
        
        temperatureFilter!.setValue(warmthVectorFilter, forKey: "inputNeutral")
        temperatureFilter!.setValue(tintVectorFilter, forKey: "inputTargetNeutral")
        
        noiseReduction!.setValue(novoFiltro[9], forKey: "inputNoiseLevel")
        
        rgbMaskFilter!.setValue(CIVector(string: "[1 \(novoFiltro[10]/2) \(novoFiltro[10]/3) \(novoFiltro[10]/7) \(novoFiltro[10]/8) \(novoFiltro[10]/9) \(novoFiltro[10]/10) \(novoFiltro[10]/11) \(novoFiltro[10]/12) \(novoFiltro[10]/13)]"), forKey: "inputRedCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(novoFiltro[11]/6) 1 \(novoFiltro[11]/7) \(novoFiltro[11]/7.5) \(novoFiltro[11]/13) \(novoFiltro[11]/14) \(novoFiltro[11]/16) \(novoFiltro[11]/17) \(novoFiltro[11]/18) \(novoFiltro[11]/19)]"), forKey: "inputGreenCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(novoFiltro[12]/2) \(novoFiltro[12]/3) 1 \(novoFiltro[12]/7) \(novoFiltro[12]/11) \(novoFiltro[12]/12) \(novoFiltro[12]/16) \(novoFiltro[12]/17) \(novoFiltro[12]/18) \(novoFiltro[12]/19)]"), forKey: "inputBlueCoefficients")
        
        //APLICA OS FILTROS:
        var context = CIContext(options: nil)
        brightnessFilter!.setValue(imgToUseFinal, forKey: "inputImage")
        var outputImage = brightnessFilter?.outputImage!
        var cgimg: CGImage? = nil
        
        
        temperatureFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = temperatureFilter?.outputImage!
        
        
        shadowsFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = shadowsFilter?.outputImage!
      
        
        
        sharpenFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = sharpenFilter?.outputImage!
      
        
        
        contrastSat!.setValue(outputImage, forKey: "inputImage")
        outputImage = contrastSat?.outputImage!
      
        
        vibranceFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = vibranceFilter?.outputImage!
      
        
        
        vignetteFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = vignetteFilter?.outputImage!
      
        
        noiseReduction!.setValue(outputImage, forKey: "inputImage")
        outputImage = noiseReduction?.outputImage!
        
        rgbMaskFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = rgbMaskFilter?.outputImage!
        
        
       cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
        
     
        
  
/*
        if appFilters[filterType][filterNumber][10] == -200 {
            
           
            abandonedBaseFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = abandonedBaseFilter?.outputImage!
            cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
            
            newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
            
        }
        */
        
        
        newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)

        
        //Esta parte é crucial em cada filtro! À partir de um loop no viewController os filtros podem ser aplicados diretamente à imagem ou nos botões do CollectionView...isso depende da variável toImage
        if toImage == true {
            return newUIImage!
        }else{
            filtersImagesB[filterNumber] = newUIImage!
            return newUIImage!
        }
        
        return UIImage()
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func makeWarmthVector(givenWarmth: CGFloat) -> [CIVector] {
        
        var vectors: [CIVector] = []
        
        vectors.append(CIVector(x:CGFloat(givenWarmth),y:CGFloat(givenWarmth/200)))
        
        vectors.append(CIVector(x:CGFloat(13000-givenWarmth),y:CGFloat(givenWarmth/200)))
        
        return vectors
    }
    
    
    
    
    
 
    
    
    
    
    func editPhoto(toFilterIMG: UIImage, filterTo: [Float]) -> UIImage{

      let methodStart = NSDate()
         var aCGImageToFilter = toFilterIMG.cgImage
         var aCIImageToFilter = CIImage(cgImage: aCGImageToFilter!)
         var imgToUse = aCIImageToFilter
        
        //Se existir uma imagem:
            //Aqui o valor recebido pela opção de edição vai permitir alterar o valor dos filtros, o IF vai apenas setar o valor pro filtro que estiver sendo alterado, enquanto estes serão aplicados após isso...
            
        
        
            //Transforma o valor da temperatura num vetor, pois é o tipo de inputValue que precisa ser utilizado neste filtro. Inicializa o vetor antes
            var warmthVector = CIVector(x:6500,y:0)
             var tintVector =  CIVector(x:6500,y:0)
        
                
                warmthVector =  (makeWarmthVector(givenWarmth: CGFloat(filterTo[6])))[0]
                
                tintVector = (makeWarmthVector(givenWarmth: CGFloat(filterTo[6])))[1]
                
            
            //ATUALIZA O VALOR DOS FILTROS
            brightnessFilter!.setValue(filterTo[0], forKey: "inputEV")
            
            shadowsFilter!.setValue(filterTo[1], forKey: "inputShadowAmount")
            shadowsFilter!.setValue(filterTo[2], forKey: "inputHighlightAmount")
            sharpenFilter!.setValue(filterTo[5], forKey: "inputSharpness")
            contrastSat!.setValue(filterTo[3], forKey: "inputSaturation")
            contrastSat!.setValue(filterTo[4], forKey: "inputContrast")
            vibranceFilter!.setValue(filterTo[7], forKey: "inputAmount")
            
            vignetteFilter!.setValue(filterTo[8], forKey: "inputIntensity")
            vignetteFilter!.setValue(filterTo[13], forKey: "inputRadius")
            
            temperatureFilter!.setValue(warmthVector, forKey: "inputNeutral")
            temperatureFilter!.setValue(tintVector, forKey: "inputTargetNeutral")
        
        rgbMaskFilter!.setValue(CIVector(string: "[1 \(filterTo[10]/2) \(filterTo[10]/3) \(filterTo[10]/7) \(filterTo[10]/8) \(filterTo[10]/9) \(filterTo[10]/10) \(filterTo[10]/11) \(filterTo[10]/12) \(filterTo[10]/13)]"), forKey: "inputRedCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(filterTo[11]/6) 1 \(filterTo[11]/7) \(filterTo[11]/7.5) \(filterTo[11]/13) \(filterTo[11]/14) \(filterTo[11]/16) \(filterTo[11]/17) \(filterTo[11]/18) \(filterTo[11]/19)]"), forKey: "inputGreenCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(filterTo[12]/2) \(filterTo[12]/3) 1 \(filterTo[12]/7) \(filterTo[12]/11) \(filterTo[12]/12) \(filterTo[12]/16) \(filterTo[12]/17) \(filterTo[12]/18) \(filterTo[12]/19)]"), forKey: "inputBlueCoefficients")
            
            noiseReduction!.setValue(savedEditValueSession[9], forKey: "inputNoiseLevel")
            //APLICA OS FILTROS:
            
        let context = CIContext(options: [CIContextOption.workingColorSpace: CGColorSpaceCreateDeviceRGB(),
                                        
                                          
                                          CIContextOption.outputColorSpace: CGColorSpaceCreateDeviceRGB(),
                                          CIContextOption.useSoftwareRenderer: false])
        
        rgbMaskFilter!.setValue(imgToUse, forKey: "inputImage")
       var outputImage = rgbMaskFilter?.outputImage!
        
        
            brightnessFilter!.setValue(outputImage, forKey: "inputImage")
             outputImage = brightnessFilter?.outputImage!
       
 
            
            temperatureFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = temperatureFilter?.outputImage!
        
            
            shadowsFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = shadowsFilter?.outputImage!
        
            
            
            
            sharpenFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = sharpenFilter?.outputImage!
        
            
            
            contrastSat!.setValue(outputImage, forKey: "inputImage")
            outputImage = contrastSat?.outputImage!
        
            
            
            
            vibranceFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = vibranceFilter?.outputImage!
        
            
            
            
            
            
            vignetteFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = vignetteFilter?.outputImage!
        
            
            noiseReduction!.setValue(outputImage, forKey: "inputImage")
            outputImage = noiseReduction?.outputImage!
        
        
       
        
        outputImage = selectiveColorApply(image: outputImage!)
        
           var cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        
                newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
        
      
        /*
        if filterTo[10] == -200 {
            
            
            abandonedBaseFilter!.setValue(outputImage, forKey: "inputImage")
            outputImage = abandonedBaseFilter?.outputImage!
            cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
            
            newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
            
        }
        
         */
        
        
       // print(i)
        let methodFinish = NSDate()
        let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
    // print("Execution time: \(executionTime)")
        
        
   
        
        
            return newUIImage!
            
            
        
        
        
        
       
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func editPhotoWithMask(background: UIImage, filterTo: [Float], maskImage: UIImage) -> UIImage{
        
        let methodStart = NSDate()
        
        let aCGImageToFilter = background.cgImage
        let aCIImageToFilter = CIImage(cgImage: aCGImageToFilter!)
        let imgToUse = aCIImageToFilter
        
        let maskToFilter = maskImage.cgImage
        let aCIMaskToFilter = CIImage(cgImage: maskToFilter!)
        let maskToUse = aCIMaskToFilter
        
        //Se existir uma imagem:
        //Aqui o valor recebido pela opção de edição vai permitir alterar o valor dos filtros, o IF vai apenas setar o valor pro filtro que estiver sendo alterado, enquanto estes serão aplicados após isso...
        
        
        
        //Transforma o valor da temperatura num vetor, pois é o tipo de inputValue que precisa ser utilizado neste filtro. Inicializa o vetor antes
        var warmthVector = CIVector(x:6500,y:0)
        var tintVector =  CIVector(x:6500,y:0)
        
        
        warmthVector =  (makeWarmthVector(givenWarmth: CGFloat(filterTo[5])))[0]
        
        tintVector = (makeWarmthVector(givenWarmth: CGFloat(filterTo[5])))[1]
        
        
        //ATUALIZA O VALOR DOS FILTROS
    //    brightnessFilter!.setValue(filterTo[0], forKey: "inputEV")
        
        shadowsFilter!.setValue(filterTo[0], forKey: "inputShadowAmount")
        shadowsFilter!.setValue(filterTo[1], forKey: "inputHighlightAmount")
        sharpenFilter!.setValue(filterTo[4], forKey: "inputSharpness")
        contrastSat!.setValue(filterTo[2], forKey: "inputSaturation")
        contrastSat!.setValue(filterTo[3], forKey: "inputContrast")
        vibranceFilter!.setValue(filterTo[6], forKey: "inputAmount")
        
        vignetteFilter!.setValue(filterTo[7], forKey: "inputIntensity")
    //    vignetteFilter!.setValue(filterTo[13], forKey: "inputRadius")
        
        temperatureFilter!.setValue(warmthVector, forKey: "inputNeutral")
        temperatureFilter!.setValue(tintVector, forKey: "inputTargetNeutral")
        
        rgbMaskFilter!.setValue(CIVector(string: "[1 \(filterTo[9]/2) \(filterTo[9]/3) \(filterTo[9]/7) \(filterTo[9]/8) \(filterTo[9]/9) \(filterTo[9]/10) \(filterTo[9]/11) \(filterTo[9]/12) \(filterTo[9]/13)]"), forKey: "inputRedCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(filterTo[10]/6) 1 \(filterTo[10]/7) \(filterTo[10]/7.5) \(filterTo[10]/13) \(filterTo[10]/14) \(filterTo[10]/16) \(filterTo[10]/17) \(filterTo[10]/18) \(filterTo[10]/19)]"), forKey: "inputGreenCoefficients")
        rgbMaskFilter!.setValue(CIVector(string: "[\(filterTo[11]/2) \(filterTo[11]/3) 1 \(filterTo[11]/7) \(filterTo[11]/11) \(filterTo[11]/12) \(filterTo[11]/16) \(filterTo[11]/17) \(filterTo[11]/18) \(filterTo[11]/19)]"), forKey: "inputBlueCoefficients")
        
        noiseReduction!.setValue(filterTo[8], forKey: "inputNoiseLevel")
        //APLICA OS FILTROS:
        
        let context = CIContext(options: [CIContextOption.workingColorSpace: CGColorSpaceCreateDeviceRGB(),
                                          
                                          
                                          CIContextOption.outputColorSpace: CGColorSpaceCreateDeviceRGB(),
                                          CIContextOption.useSoftwareRenderer: false])
        
        rgbMaskFilter!.setValue(imgToUse, forKey: "inputImage")
        var outputImage = rgbMaskFilter?.outputImage!
        
        
        brightnessFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = brightnessFilter?.outputImage!
        
        
        
        temperatureFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = temperatureFilter?.outputImage!
        
        
        shadowsFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = shadowsFilter?.outputImage!
        
        
        
        
        sharpenFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = sharpenFilter?.outputImage!
        
        
        
        contrastSat!.setValue(outputImage, forKey: "inputImage")
        outputImage = contrastSat?.outputImage!
        
        
        
        
        vibranceFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = vibranceFilter?.outputImage!
        
        
        
        
        
        
        vignetteFilter!.setValue(outputImage, forKey: "inputImage")
        outputImage = vignetteFilter?.outputImage!
        
        
        noiseReduction!.setValue(outputImage, forKey: "inputImage")
        outputImage = noiseReduction?.outputImage!
        

        outputImage = selectiveColorApply(image: outputImage!)
        
        
        
        
        
        maskFilter!.setValue(imgToUse, forKey: "inputBackgroundImage")
        maskFilter!.setValue(outputImage, forKey: "inputImage")
        maskFilter!.setValue(maskToUse, forKey: "inputMaskImage")
        outputImage = maskFilter?.outputImage!
        
        
        
        var cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        
        newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
        
        
        /*
         if filterTo[10] == -200 {
         
         
         abandonedBaseFilter!.setValue(outputImage, forKey: "inputImage")
         outputImage = abandonedBaseFilter?.outputImage!
         cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
         
         newUIImage = UIImage(cgImage: cgimg!, scale: UIImageImported!.scale, orientation: UIImageImported!.imageOrientation)
         
         }
         
         */
        
        
        // print(i)
        let methodFinish = NSDate()
        let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
        // print("Execution time: \(executionTime)")
        
        
        
        
        
        return newUIImage!
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
}



