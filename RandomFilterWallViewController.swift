//
//  RandomFilterWallViewController.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 01/07/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import UIKit

class RandomFilterWallViewController: UIViewController{
    @IBOutlet weak var newButton: UIButton!
    
    //            filtro 0 (abandoned) -> range exposição
    //[        [    [0.96, 1.01]       ]             ] //divir por 10000
    
    
  //.mistery
    var misteryRange: [[[Int]]] = [[  [-15,5],[80,490], [1000,1300],[300,630],[1070,1220],[20,120],[5850000,6200000],[0,480],[400,2100],[20,50],[0,20],[0,77],[0,45],[880,1050]   ] ]
    
    
    @IBOutlet weak var highContrastButton: UIButton!
    @IBOutlet weak var blackAndWhiteButton: UIButton!
    
    @IBOutlet weak var dontKnowButton: UIButton!
    
    
    
    @IBOutlet weak var infoSkinButton: UIButton!
    
    @IBOutlet weak var infoSkinLabel: UILabel!
    
    
    var hasSkin = false
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    
    @IBOutlet weak var skinToneSwitch: UISwitch!
    
    
    
    
    
    @IBAction func newPreset(_ sender: Any) {
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func skinToneChanged(_ sender: Any) {
        if hasSkin == false {
            hasSkin = true
            skinToneSwitch.isOn = true
        }else{
            hasSkin = false
            skinToneSwitch.isOn = false
        }
        
    }
    
    
    var actualRangeToUse: [[[Int]]] = [[[]]]
      var colorfullRange: [[[Int]]] = [[  [25,160],[150,700], [700,1000],[1080,1600],[1070,1130],[20,120],[6100000,7000000],[80,340],[0,120],[20,50],[0,70],[0,70],[0,70],[990,1010]   ] ]
    
    var HSLRangesForKeyword: [[[Int]]] =   [[[0,51],[1000,1001],[900,1040]],             [[-90,13], [1000,1001], [1000,1060]],         [[0,140],[900,1100],[950,1050]],                 [[-120,120], [1000,2000], [950,1050]], [ [-50,15], [700, 1400], [950,1050]],           [ [0,1],[0,1],[1000,1001] ]    ]
    
    
    
    
    
    @IBOutlet weak var image1: UIImageView!
    
    
    @IBOutlet weak var image2: UIImageView!
    

    @IBOutlet weak var image4: UIImageView!
    
    
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var image6: UIImageView!
    
    @IBOutlet weak var image7: UIImageView!
    
    //Armazena os filtros gerados numa aplicação de keywords
    var newFiltersGenerated: [[Float]] = []
    
      var newHSLGenerated: [[[Float]]] = []
    
    
    @IBOutlet weak var scrollWall: UIScrollView!
    
    
    var resultImages: [UIImage] = []
     var HSLFilter2 = MultiBandHSV()
    
    @IBOutlet weak var imageTest: UIImageView!
    func makeItRandom(){
        //Limpa os filtros e imagens existentes
        newFiltersGenerated.removeAll()
        resultImages.removeAll()
        newHSLGenerated.removeAll()
        
        //Cria o novo filtro vazio para adicionar as variáveis random
         var newRandomFilter: [Float] = []
        var newHSLFilter2: [Float] = []
        //FASE 1 - GERANDO FILTROS
        //WHILE LOOP PARA IMPLEMENTAR
        
       
var n = 10
        var tentativas = 0.0
        
        
        
        
        
        
        while n != 0 {
            autoreleasepool {
        newRandomFilter.removeAll()
      // for i in 0...newFiltersGenerated.count-1
        for i in 0...actualRangeToUse[0].count-1 {
            //Faz o random entre o intervalo da keyword
        let number = Int.random(in: actualRangeToUse[0][i][0]...actualRangeToUse[0][i][1])
            //Adiciona o resultado
        newRandomFilter.append(Float(number)/1000)
        }
                var verificador:Float = 0.0
        outerLoop:  for i in 0...newRandomFilter.count-1{
            tentativas += 1
            if  newFiltersGenerated.count > 0 {
                
                var x = newFiltersGenerated[newFiltersGenerated.count-1][i]*1000
                var y = newRandomFilter[i]*1000
          var z = Float((min(Int(x), Int(y)))) / Float((max(Int(x), Int(y))))
            print(tentativas)
            if z > 0.85 {
                verificador += 1
                if verificador > 4 {
                    break outerLoop}}
            if (newRandomFilter.count-1) == i && verificador <= 4{
                    //Adiciona primeiro
                n -= 1
                    newFiltersGenerated.append(newRandomFilter)
                    break outerLoop
                }
            }else{
                //Adiciona o primeiro filtro
                n-=1
                newFiltersGenerated.append(newRandomFilter)
                break outerLoop}}}
}
       
        
        
        
        
        
        
        
        
        print("TOTAL DE TENTATIVAS: \(tentativas)")
        print("TEMOS UM TOTAL DE \(newFiltersGenerated.count) FILTROS")
             //Adiciona o novo filtro completo para os filtros gerados
        
        
        var x: [[Float]] = []
        for i in 0...10{
            x.removeAll()
            
            
          for i in 0...HSLRangesForKeyword.count-1 {
        
            newHSLFilter2.removeAll()
            for ii in 0...2 {
             let number = Int.random(in: HSLRangesForKeyword[i][ii][0]...HSLRangesForKeyword[i][ii][1])
                 newHSLFilter2.append(Float(number)/1000)
                
            }
            x.append(newHSLFilter2)
 
        }
           newHSLGenerated.append(x)
          
        }
       
       //Aplica os filtros
      applyAllTheFilters()
        
        //FASE 2 APLICANDO CADA FILTRO
        //OUTRA FUNC
        
    }
    
    
    func applyAllTheFilters(){
        
        
       for i in 0...newFiltersGenerated.count-1 {
        
        
    autoreleasepool {

       
        resultImages.append(editPhoto(toFilterIMG: globalImage!, filterTo: newFiltersGenerated[i], n: i))

        }
            
    }
        
        
        
        image1.image = resultImages[0]
        
       newButton.alpha = 1
         saveButton.alpha = 1
         editButton.alpha = 1
        
        
    }
    
    
    
    
    func removeFromScreen(){
 highContrastButton.alpha = 0
       blackAndWhiteButton.alpha = 0
        
      dontKnowButton.alpha = 0
       // applyButton.alpha = 0
        abandonedButton.alpha = 0
        coldButton.alpha = 0
        misteryButton.alpha = 0
        oldButton.alpha = 0
        hotButton.alpha = 0
        autumnButton.alpha = 0
        sadButton.alpha = 0
        loveButton.alpha = 0
        colorfullButton.alpha = 0
        chooseLabel.alpha = 0
        infoSkinButton.alpha = 0
        skinToneSwitch.alpha = 0
     infoSkinLabel.alpha = 0
    }
    
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var abandonedButton: UIButton!
    
    @IBOutlet weak var coldButton: UIButton!
    
    
   
    @IBOutlet weak var misteryButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var chooseLabel: UILabel!
    
    @IBOutlet weak var oldButton: UIButton!
    
    
    @IBOutlet weak var hotButton: UIButton!
    
    
    @IBOutlet weak var autumnButton: UIButton!
    
    
    
    @IBOutlet weak var sadButton: UIButton!
    
    
    @IBOutlet weak var loveButton: UIButton!
    
    
    @IBOutlet weak var colorfullButton: UIButton!
    
    
    
    @IBOutlet weak var workingOnImage: UIImageView!
    
    
    @IBAction func abandonedButtonClick(_ sender: Any) {
        if abandonedButton.alpha == 1 {
             abandonedButton.alpha = 0.4
        }else{
             abandonedButton.alpha = 1
        }
    
    }
    
    
    
    @IBAction func coldButtonClick(_ sender: Any) {
        if coldButton.alpha == 1 {
            coldButton.alpha = 0.4
        }else{
            coldButton.alpha = 1
        }

    }
    
    
    
    @IBAction func misteryButtonClick(_ sender: Any) {
        actualRangeToUse = misteryRange
        if misteryButton.alpha == 1 {
            misteryButton.alpha = 0.4
        }else{
            misteryButton.alpha = 1
        }


    }
    
    
    
    @IBAction func oldButtonClick(_ sender: Any) {
        if oldButton.alpha == 1 {
            oldButton.alpha = 0.4
        }else{
            oldButton.alpha = 1
        }

    }
    
    
    
    
    @IBAction func hotButtonClick(_ sender: Any) {
        if hotButton.alpha == 1 {
            hotButton.alpha = 0.4
        }else{
            hotButton.alpha = 1
        }
    }
    
    
    
    @IBAction func autumnButtonClick(_ sender: Any) {
        if autumnButton.alpha == 1 {
            autumnButton.alpha = 0.4
        }else{
            autumnButton.alpha = 1
        }

    }
    
    
    
    @IBAction func sadButtonClick(_ sender: Any) {
        if sadButton.alpha == 1 {
            sadButton.alpha = 0.4
        }else{
            sadButton.alpha = 1
        }
    }
    
    
    @IBAction func loveButtonClick(_ sender: Any) {
        if loveButton.alpha == 1 {
            loveButton.alpha = 0.4
        }else{
            loveButton.alpha = 1
        }
    }
    
    
    @IBAction func colorfullButtonClick(_ sender: Any) {
        actualRangeToUse = colorfullRange
        if colorfullButton.alpha == 1 {
            colorfullButton.alpha = 0.4
        }else{
            colorfullButton.alpha = 1
        }
    }
    
    
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        //Muda o viewController
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewControllerPrincipal") as? ViewController
        // self.navigationController?.pushViewController(vc!, animated: true)
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    
    
 
    
    
    
    
    @IBAction func applyButtonClick(_ sender: Any) {
        scrollWall.alpha = 1
  removeFromScreen()
      makeItRandom()
        
        
        /*
        
        workingOnImage.alpha = 0.4
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn, .autoreverse, .repeat], animations: {
              self.workingOnImage.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
           self.workingOnImage.alpha = 1
        }, completion: { (true) in
          
        })
        
        */
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
 
    
    
    
    override func viewDidLoad() {
         scrollWall.alpha = 0
       // scrollWall.contentSize = CGSize(width: scrollWall.frame.width, height: 1025)
        scrollWall.maximumZoomScale = 10
        scrollWall.minimumZoomScale = 1

          applyButton.layer.cornerRadius = applyButton.frame.height/2
        saveButton.layer.cornerRadius = saveButton.frame.height/2
         editButton.layer.cornerRadius = editButton.frame.height/2
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        
        
  
        
    func selectiveColorApply(image: CIImage, collection: [[Float]]) -> CIImage {
            
            HSLFilter2.inputImage = image
            
            
            
            HSLFilter2.inputRedShift = CIVector(x: CGFloat(collection[0][0]), y: CGFloat(  collection[0][1]), z: CGFloat(  collection[0][2]))
            
            HSLFilter2.inputOrangeShift = CIVector(x: CGFloat(  collection[1][0]), y: CGFloat(  collection[1][1]), z: CGFloat(  collection[1][2]))
            
            HSLFilter2.inputYellowShift = CIVector(x: CGFloat(  collection[2][0]), y: CGFloat(  collection[2][1]), z: CGFloat(  collection[2][2]))
            
            HSLFilter2.inputGreenShift = CIVector(x: CGFloat(  collection[3][0]), y: CGFloat(  collection[3][1]), z: CGFloat(  collection[3][2]))
            
            HSLFilter2.inputBlueShift = CIVector(x: CGFloat(  collection[4][0]), y: CGFloat(  collection[4][1]), z: CGFloat(  collection[4][2]))
            
            HSLFilter2.inputMagentaShift = CIVector(x: CGFloat(  collection[5][0]), y: CGFloat(  collection[5][1]), z: CGFloat(  collection[5][2]))
            
            
            
            return HSLFilter2.outputImage!
    }
    
        
        
        
        
        
        
    
        
        
        
        func makeWarmthVector(givenWarmth: CGFloat) -> [CIVector] {
            
            var vectors: [CIVector] = []
            
            vectors.append(CIVector(x:CGFloat(givenWarmth),y:CGFloat(givenWarmth/200)))
            
            vectors.append(CIVector(x:CGFloat(13000-givenWarmth),y:CGFloat(givenWarmth/200)))
            
            return vectors
        }
        
        
        
        
        
        
        
        
        
        
    func editPhoto(toFilterIMG: UIImage, filterTo: [Float], n:Int) -> UIImage{
            
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
            
            noiseReduction!.setValue(filterTo[9], forKey: "inputNoiseLevel")
            //APLICA OS FILTROS:
            
            let context = CIContext(options: [CIContextOption.workingColorSpace: CGColorSpaceCreateDeviceRGB(),
                                              
                                              
                                              CIContextOption.outputColorSpace: CGColorSpaceCreateDeviceRGB(),
                                              CIContextOption.useSoftwareRenderer: false])
            
            
            
            rgbMaskFilter!.setValue(imgToUse, forKey: "inputImage")
            var outputImage = rgbMaskFilter?.outputImage!
        
        if hasSkin == false {
        outputImage = selectiveColorApply(image: outputImage!, collection: newHSLGenerated[n])
        }
        print("FILTER: \(filterTo) ||||| HSL: \(newHSLGenerated[n]) |||||||||||||||||||FIM|||")
            
        
        
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
            
            
            
            
      
            
            var cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
            
            var newUIImage = UIImage(cgImage: cgimg!, scale: toFilterIMG.scale, orientation: toFilterIMG.imageOrientation)
            
            
            
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
            print("Execution time: \(executionTime)")
            
            
            
            
            
            return newUIImage

            
        }
        
        
        
        
        
        
        
    
    
    
    
    

    
    
    
    
    
}
    


