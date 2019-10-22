//
//  ProCameraViewController.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 15/06/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion


class ProCameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,AVCapturePhotoCaptureDelegate,UIPickerViewDelegate,UIPickerViewDataSource,AVCaptureVideoDataOutputSampleBufferDelegate{

    
     let videoOutput = AVCaptureVideoDataOutput()
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var orientation: AVCaptureVideoOrientation = .portrait
    let context = CIContext()
    
    
    
 
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBOutlet weak var whiteBalanceSegmented: UISegmentedControl!
    
    
    @IBOutlet weak var whiteBalanceSlider: UISlider!
    
    
    @IBOutlet weak var whiteBalanceLabel: UILabel!
    
   
    @IBOutlet weak var autoExposureSwitchLabel: UILabel!
    
    @IBOutlet weak var autoExposureSwitch: UISwitch!
    
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var configSelector: UIPickerView!
    @IBOutlet weak var aroImg: UIImageView!
    @IBOutlet weak var takePhotobutton: UIButton!
    var actualShutterSpeed: Double = 0
    var actualIso: Int = 0
    var updateTimer: Timer?
    var timerPhoto: Timer?
    @IBOutlet weak var lastPhoto: UIImageView!
  let stillImageOutput = AVCapturePhotoOutput()
    var session: AVCaptureSession?
   // var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var prevLayer: AVCaptureVideoPreviewLayer?
    

    
    @IBOutlet weak var infinityIMG: UIImageView!
    @IBOutlet weak var macroIMG: UIImageView!
    @IBOutlet weak var focusSlider: UISlider!
    @IBOutlet weak var touchToFocusLabel: UILabel!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var apertureLabel: UILabel!
    @IBOutlet weak var isoPicker: UIPickerView!
    @IBOutlet weak var shutterSpeedPicker: UIPickerView!
    @IBOutlet weak var whiteanimation: UIView!
    let layer = UIView()
    let layer2 = UIView()
    let layer3 = UIView()
   
    let motionManager = CMMotionManager()
    
    @IBOutlet weak var AutoFocusModeButton: UISegmentedControl!
    
    var isoSave: Int = 0
    var shutterSpeedSave: Double = 0
  
    @IBOutlet weak var flashLabel: UILabel!
    
    var configOptions: [String] = ["Exposure", "White Balance", "Focus", "Settings", "Warnings"]
    
     var isoArray: [Int] = []

    var shutterSpeedArray: [String] = []
    
    var shutterSpeedSeconds: [Double] = []
    
    @IBOutlet weak var cameraView: UIView!
    
    var isoCopy: Float = 0
    
  
    @IBOutlet weak var focusSelectorButton: UISegmentedControl!
    
    @IBOutlet weak var autoISOLabel: UILabel!
    
    @IBOutlet weak var autoExposureTimeLabel: UILabel!
    
    var flashEnabled = false

    @IBOutlet weak var shadowsWarningSwitch: UISwitch!
    
    @IBOutlet weak var highlightsWarningSwitch: UISwitch!
    
    @IBOutlet weak var shadowsWarningLabel: UILabel!
    
    @IBOutlet weak var highlightsWarningLabel: UILabel!
    
    
    @IBOutlet weak var gridSwitch: UISwitch!
    
    @IBOutlet weak var levelSwitch: UISwitch!
    
    @IBOutlet weak var histogramSwitch: UISwitch!
    
    @IBOutlet weak var gridLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var histogramLabel: UILabel!
    
    
    var timer = 0
   
    
    
    //Imagem da GRID, por enquanto apenas para o ipX
    var gridImage = UIImageView(image: UIImage(named:"iphoneXGrid"))

    
    
    
    @IBAction func shadowsWarningChangedValue(_ sender: Any) {
        //Aqui neste Switch será ativado e desativado o Warning das sombras
        
        
        
    }
    
    
    @IBAction func highlightsWarningChangedValue(_ sender: Any) {
         //Aqui neste Switch será ativado e desativado o Warning dos highlights
        
        
        
    }
    
    
    
    @IBAction func gridChanged(_ sender: Any) {
        //Ativa e desativa a grade

        if gridSwitch.isOn == true {
             gridImage.alpha = 0.7
        }else{
             gridImage.alpha = 0
        }
        
        
    }
    
    func prepareLevel(){
        //Ajusta todas as variáveis necessárias para o Level
        layer.alpha = 0
        layer2.alpha = 0
        layer3.alpha = 0
        layer.frame = CGRect(x: myImage.center.x-view.frame.width*0.2/2, y: 0+myImage.frame.height*0.4, width: view.frame.width*0.2, height: 5)
       UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)

        
        

        layer2.frame = CGRect(x: layer.center.x - layer.frame.width/2 - view.frame.width*0.1 , y: 0+myImage.frame.height*0.4, width: view.frame.width*0.1, height: 5)
        layer2.backgroundColor = UIColor.white
        
        

        layer3.frame = CGRect(x: layer.center.x + layer.frame.width/2, y: 0+myImage.frame.height*0.4, width: view.frame.width*0.1, height: 5)
        layer3.backgroundColor = UIColor.white

    }
    
    @IBAction func levelChanged(_ sender: Any) {
        //Ativa e desativa o Level
      
        if levelSwitch.isOn == true {

                layer.alpha = 0.85
                layer2.alpha = 0.85
                layer3.alpha = 0.85

            if motionManager.isDeviceMotionAvailable {
                motionManager.deviceMotionUpdateInterval = 0.01
                motionManager.startDeviceMotionUpdates(to: OperationQueue.main) {
                    (data, error) in
                    if let data = data {
                        let rotation = atan2(data.gravity.x, data.gravity.y) - .pi
                    
                      //rad to ø
                        let x = rotation * 57.29577
                        
                      self.layer.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
                    //  print(x)
                        
                        if x >= -1 || x <= -359 {
                            self.layer.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
                           self.layer2.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
                            self.layer3.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
                         
                        }else{
                            self.layer.backgroundColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
                     self.layer2.backgroundColor = UIColor.white
                    self.layer3.backgroundColor = UIColor.white
                        }
                        
                    }}}
           
            
        }else{
            motionManager.stopDeviceMotionUpdates()
            layer.alpha = 0
            layer2.alpha = 0
            layer3.alpha = 0
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func timerAction(_ sender: Any) {
        
        
        if timerButton.titleLabel?.text == "Off" {
            timer = 3
            self.timerButton.setTitle("3s", for: .normal)
        }else if timerButton.titleLabel?.text == "3s"{
            timer = 10
           self.timerButton.setTitle("10s", for: .normal)
        }else{
             self.timerButton.setTitle("Off", for: .normal)
            timer = 0
        }
        
        
        
        
        
        
        
    }
    
     @objc func timerPhotoAction(){
       takePhotoFunc()
        timerPhoto?.invalidate()
    }
    
    
    
    
    
    
    
    
    @IBAction func histogramChanged(_ sender: Any) {
        //Ativa e desativa o histograma
        
        
        
    }
    
    
    
    
    //Botão que ativa e desativa o flash: aqui é alterado somente a variável flashEnabled
    @IBAction func enableFlash(_ sender: Any) {
        if flashEnabled == false{
            flashEnabled = true
   flashButton.setImage(UIImage(named:"flashAc"), for: .normal)
            flashButton.backgroundColor =  UIColor.white
            flashLabel.text = "ON"
           
        }else{
            flashEnabled = false
             flashButton.setImage(UIImage(named:"flash"), for: .normal)
             flashButton.backgroundColor =  UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
             flashLabel.text = "OFF"
        }
        
    }
    
    
    

    
    
    
    
    
//Altera o modo de foco entre automático e manual
    func focusMode(){
        //FOCUS MODE -> AUTO OR MANUAL
        if focusSelectorButton.selectedSegmentIndex == 0{
            //Selecionou Manual Focus
            macroIMG.alpha = 1
            infinityIMG.alpha = 1
            focusSlider.alpha = 1
          //  touchToFocusLabel.alpha = 0
            AutoFocusModeButton.alpha = 0
            focusSlider.value = backCamera!.lensPosition
            if backCamera?.isFocusModeSupported(.locked) == true {

                backCamera?.setFocusModeLocked(lensPosition: focusSlider.value, completionHandler: { (CMTime) in
                    
                })
            }
        }else{
            focusSlider.alpha = 0
            macroIMG.alpha = 0
            infinityIMG.alpha = 0
            AutoFocusModeButton.alpha = 1
            autoFocusChangeFunc()
        
           // touchToFocusLabel.alpha = 1
        }
    }
    
    //Altera entre os modos de foco automáticos
    @IBAction func autoFocusModeChanged(_ sender: Any) {
        //FOCUS MODE -> TOUCH TO FOCUS OR CONTINOUS AUTO FOCUS
      autoFocusChangeFunc()
    }
    
    
    
    func autoFocusChangeFunc(){
        
        if AutoFocusModeButton.selectedSegmentIndex == 0{
            //Continous Auto Focus
            print("Aqui chegou")
            backCamera?.focusMode = .continuousAutoFocus
        }else{
            
            
            //touchtofocus
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    //Botão que altera o modo de foco
    @IBAction func changeFocusMode(_ sender: Any) {
        focusMode()
    }
    
    //Slider que altera o foco manual
    @IBAction func focusSliderChanged(_ sender: Any) {
        if backCamera?.isFocusModeSupported(.locked) == true {
        backCamera?.setFocusModeLocked(lensPosition: focusSlider.value, completionHandler: { (CMTime) in
        }) }
    }
    
    
    
    
    
    
    
    
    
    
    //Câmera com exposição automática
    func autoCam(){
 
        if (backCamera?.isExposureModeSupported(AVCaptureDevice.ExposureMode.continuousAutoExposure))!{
            //Precisamos ter acesso às configurações manuais de hardware para mexer na camera:
            try? backCamera?.lockForConfiguration()
        backCamera!.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            autoISOLabel.text = "ISO: " + String(Int(backCamera!.iso))
            
            let a = CMTimeGetSeconds(backCamera!.exposureDuration)
            let y = Int(Rational(approximating: a).denominator/Rational(approximating: a).numerator)
            autoExposureTimeLabel.text = "Shutter Speed: 1/"+String(y) + "s"
            
            apertureLabel.text = "Aperture: " + String(backCamera!.lensAperture) + "f"
          
        }
        

        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func configCameraView(isoConfig: Int, shutterSpeed: Double){
        

        if (backCamera?.isExposureModeSupported(AVCaptureDevice.ExposureMode.custom))!{
            //Precisamos ter acesso às configurações manuais de hardware para mexer na camera:
            try? backCamera?.lockForConfiguration()
            
            
            
            //Aqui podemos definir o ISO e a duração da exposição! A abertura do diafragma é fixa! Não pode ser alterada
            backCamera?.setExposureModeCustom(duration: CMTime(seconds: shutterSpeed, preferredTimescale: 1000000), iso: Float(isoConfig), completionHandler: nil)
            
        }
      //  print("ISO: ",device?.iso)
       // print("duration: ", device?.exposureDuration)
       // print("aperture: ",device?.lensAperture)
    }
   


    func takePhotoFunc(){
        //Settings may not be re-used' SO....
        let settings = AVCapturePhotoSettings()
        print("lens: ",backCamera?.lensPosition as Any)
        //  settings.isHighResolutionPhotoEnabled = true
        if flashEnabled == true {
            settings.flashMode = .on
        }else{
            settings.flashMode = .off
        }
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: UIScreen.main.bounds.size.width,
            kCVPixelBufferHeightKey as String: UIScreen.main.bounds.size.height
            ] as [String : Any]
        settings.previewPhotoFormat = previewFormat
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        
        
        UIView.animate(withDuration: 0.05, delay: 0, options: [.autoreverse], animations: {
            self.whiteanimation.alpha = 1
        }) { (true) in
            self.whiteanimation.alpha = 0
        }
    }
    
    //Função que tira a foto:
    @IBAction func tookPhoto(_ sender: Any) {
        
        if timer == 0{
            takePhotoFunc()
        }else{
            timerPhoto = Timer.scheduledTimer(timeInterval: TimeInterval(timer), target: self, selector: #selector(timerPhotoAction), userInfo: nil, repeats: false)
           
        }
    
 

        }
    
    
    
    
    
    
    
    
    
    
    
    func loadImage(data: Data) {
        //Aqui temos acesso à foto que foi tirada:
        let dataProvider = CGDataProvider(data: data as CFData)
        let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
        let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImage.Orientation.right)
        // do whatever you like with the generated image here...
       
        
        //Aqui fazemos o que quisermos com a imagem:
        lastPhoto.image = image
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil) //Salva no album
    }
    
    
    
    
    
    
    
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        guard error == nil else {
            print("Photo Error: \(String(describing: error))")
            return
        }

        guard let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let outputData =  AVCapturePhotoOutput
                .jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) else {
                    print("Oops, unable to create jpeg image")
                    return
        }
        
        print("captured photo...")
        loadImage(data: outputData)
    }
        

    
    
    
    
    
    
    
    
    func createSession() {
   /*
        session = AVCaptureSession()
        backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do{
            input = try AVCaptureDeviceInput(device: backCamera!)
        }
        catch{
            print(error)
        }
        
        if let input = input{
            session?.addInput(input)
        }
        
        prevLayer = AVCaptureVideoPreviewLayer(session: session!)
        prevLayer?.frame.size = cameraView.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
      //  prevLayer?.connection?.videoOrientation = transformOrientation(orientation: UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!)
        
        cameraView.layer.addSublayer(prevLayer!)
        //Este view vai animar quando a foto for tirada, para dar o efeito
        cameraView.addSubview(whiteanimation)
        cameraView.addSubview(gridImage)
        
     //   cameraView.addSubview(flashButton)
        
        prepareLevel()
        cameraView.addSubview(layer)
        cameraView.addSubview(layer2)
        cameraView.addSubview(layer3)
        

       
        
        
        takePhotobutton.alpha = 0.93
        aroImg.alpha = 0.93
        cameraView.addSubview(takePhotobutton)
        cameraView.addSubview(aroImg)
    photoOutput!.isHighResolutionCaptureEnabled = true
        
        
        
        session!.addOutput(photoOutput!)
        session?.startRunning()
        
  */
        
      
    }

    
    
    
    
    @IBAction func autoExposureChanged(_ sender: Any) {
        if autoExposureSwitch.isOn == true {
            autoCam()
            autoISOLabel.alpha = 1
            autoExposureTimeLabel.alpha = 1
            apertureLabel.alpha = 1
            isoPicker.alpha = 0.4
            shutterSpeedPicker.alpha = 0.4
            isoPicker.isUserInteractionEnabled = false
            shutterSpeedPicker.isUserInteractionEnabled = false
        }else{
            if isoArray[1] != nil{
                autoISOLabel.alpha = 0.4
                autoExposureTimeLabel.alpha = 0.4
                apertureLabel.alpha = 0.4
                isoPicker.alpha = 1
                shutterSpeedPicker.alpha = 1
                isoPicker.isUserInteractionEnabled = true
                shutterSpeedPicker.isUserInteractionEnabled = true
                // organizeRows()
                if isoSave == 0{
                    isoSave = actualIso
                }
                if shutterSpeedSave == 0{
                    shutterSpeedSave = actualShutterSpeed
                }
                
                configCameraView(isoConfig: isoSave,shutterSpeed: shutterSpeedSave)
                
            }}
        
    }
    
    
    
    
    func organizeWhiteBalanceButton(){
        if (backCamera?.isWhiteBalanceModeSupported(.autoWhiteBalance))! {
        }else{
            whiteBalanceSegmented.removeSegment(at: 1, animated: false)
        }
        
        if (backCamera?.isWhiteBalanceModeSupported(.continuousAutoWhiteBalance))! {
        }else{
            whiteBalanceSegmented.removeSegment(at: 0, animated: false)
        }
        
        if (backCamera?.isWhiteBalanceModeSupported(.locked))! {
        }else{
            whiteBalanceSegmented.removeSegment(at: 2, animated: false)
        }
    }
    
    
    
    @IBAction func changedWhiteBalance(_ sender: Any) {
        
          setCustomWhiteBalanceWithTemperature(temperature: whiteBalanceSlider.value)
          whiteBalanceLabel.text = String(roundf(whiteBalanceSlider.value)) + "K"
    }
    
    
    
    
    
    
    
    
    
    func setCustomWhiteBalanceWithTemperature(temperature:Float) {
        
      
        if backCamera!.isWhiteBalanceModeSupported(.locked) {
            let currentGains = backCamera!.deviceWhiteBalanceGains
            let currentTint = backCamera!.temperatureAndTintValues(for: currentGains).tint
                let temperatureAndTintValues = AVCaptureDevice.WhiteBalanceTemperatureAndTintValues(temperature: temperature, tint: currentTint)
                
                var deviceGains = backCamera!.deviceWhiteBalanceGains(for: temperatureAndTintValues)
            let maxWhiteBalanceGain = backCamera!.maxWhiteBalanceGain
                deviceGains.clampGainsToRange(minVal: 1, maxVal: maxWhiteBalanceGain)
            
          
            
 
                backCamera!.setWhiteBalanceModeLocked(with: deviceGains) {
                    (timestamp:CMTime) -> Void in
                    
                  //  let currentGains2 = self.backCamera!.
                  //  print(self.backCamera!.temperatureAndTintValues(for: currentGains2).temperature)
                }
            
            }
        
    }
    func whiteBalanceButtons(){
        if whiteBalanceSegmented.titleForSegment(at: whiteBalanceSegmented.selectedSegmentIndex) == "Continous" {
            backCamera?.whiteBalanceMode = .continuousAutoWhiteBalance
            whiteBalanceSlider.alpha = 0.4
            whiteBalanceLabel.alpha = 0.4
            whiteBalanceSlider.isUserInteractionEnabled = false
          
        }else if whiteBalanceSegmented.titleForSegment(at: whiteBalanceSegmented.selectedSegmentIndex) == "Auto" {
            
            whiteBalanceSlider.alpha = 0.4
            whiteBalanceLabel.alpha = 0.4
            whiteBalanceSlider.isUserInteractionEnabled = false
        }else if whiteBalanceSegmented.titleForSegment(at: whiteBalanceSegmented.selectedSegmentIndex) == "Manual" {
            
          setCustomWhiteBalanceWithTemperature(temperature: whiteBalanceSlider.value)
            let currentGains = backCamera!.deviceWhiteBalanceGains
            let currentTint = backCamera!.temperatureAndTintValues(for: currentGains).temperature
            whiteBalanceLabel.text = "\(roundf(currentTint))" + "K"
           //seisei
            whiteBalanceSlider.alpha = 1
            whiteBalanceLabel.alpha = 1
            whiteBalanceSlider.isUserInteractionEnabled = true
        
        }
        
    }
    
    
    
    
    @IBAction func whiteBalanceChanged(_ sender: Any) {
        whiteBalanceButtons()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var s = ""
        if pickerView   == configSelector {
            
            s = configOptions[row]
            
            
        }else if pickerView == isoPicker {
            
            s = String(isoArray[row])
            
            
        }else if pickerView == shutterSpeedPicker {
            
            s =  shutterSpeedArray[row]
            
        }
        
        return s
    }
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var x = 0
        if pickerView   == configSelector {
            
        x = configOptions.count
  
            
        }else if pickerView == isoPicker {
            
           x =  isoArray.count
      
            
        }else if pickerView == shutterSpeedPicker {
            
          x =  shutterSpeedArray.count
            
        }
        return x
    }
    

    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == isoPicker {
            actualIso = isoArray[row]
            configCameraView(isoConfig: actualIso,shutterSpeed: actualShutterSpeed)
             isoSave  = actualIso
             shutterSpeedSave  = actualShutterSpeed
        }else if pickerView == shutterSpeedPicker {
            actualShutterSpeed = shutterSpeedSeconds[row]
            configCameraView(isoConfig: actualIso,shutterSpeed: actualShutterSpeed)
            isoSave  = actualIso
            shutterSpeedSave  = actualShutterSpeed
        }else if pickerView == configSelector {
            if row == 0 {
                if autoExposureSwitch.isOn == true {
                    autoCam()
                    autoISOLabel.alpha = 1
                    autoExposureTimeLabel.alpha = 1
                    apertureLabel.alpha = 1
                    isoPicker.alpha = 0.4
                    shutterSpeedPicker.alpha = 0.4
                    isoPicker.isUserInteractionEnabled = false
                    shutterSpeedPicker.isUserInteractionEnabled = false
                }else{
                    if isoArray[1] != nil{
                        autoISOLabel.alpha = 0.4
                        autoExposureTimeLabel.alpha = 0.4
                        apertureLabel.alpha = 0.4
                        isoPicker.alpha = 1
                        shutterSpeedPicker.alpha = 1
                        isoPicker.isUserInteractionEnabled = true
                        shutterSpeedPicker.isUserInteractionEnabled = true
                        // organizeRows()
                        if isoSave == 0{
                            isoSave = actualIso
                        }
                        if shutterSpeedSave == 0{
                            shutterSpeedSave = actualShutterSpeed
                        }
                        
                        configCameraView(isoConfig: isoSave,shutterSpeed: shutterSpeedSave)
                        
                    }}
                autoExposureSwitchLabel.alpha = 1
               autoExposureSwitch.alpha = 1
                //MANUAL EXPOSURE
                focusSelectorButton.alpha = 0
                 // touchToFocusLabel.alpha = 0
               
               
               
                  focusSlider.alpha = 0
                macroIMG.alpha = 0
                infinityIMG.alpha = 0
                 AutoFocusModeButton.alpha = 0
                gridSwitch.alpha = 0
                levelSwitch.alpha = 0
              //  histogramSwitch.alpha = 0
                gridLabel.alpha = 0
                levelLabel.alpha = 0
              //  histogramLabel.alpha = 0
               shadowsWarningSwitch.alpha = 0
                highlightsWarningSwitch.alpha = 0
           shadowsWarningLabel.alpha = 0
         highlightsWarningLabel.alpha = 0
                whiteBalanceSegmented.alpha = 0
                whiteBalanceSlider.alpha = 0
                whiteBalanceLabel.alpha = 0
            }else if row == 1{
          //WHITE BALANCE
                 whiteBalanceButtons()
    whiteBalanceSegmented.alpha = 1
                
                if autoExposureSwitch.isOn == true {
                    isoPicker.isUserInteractionEnabled = false
                    shutterSpeedPicker.isUserInteractionEnabled = false
                }else{
                    isoPicker.isUserInteractionEnabled = true
                    shutterSpeedPicker.isUserInteractionEnabled = true
                }
                autoExposureSwitchLabel.alpha = 0
                autoExposureSwitch.alpha = 0
                gridSwitch.alpha = 0
                levelSwitch.alpha = 0
                //    histogramSwitch.alpha = 0
                gridLabel.alpha = 0
                levelLabel.alpha = 0
                //   histogramLabel.alpha = 0
                shadowsWarningSwitch.alpha = 0
                highlightsWarningSwitch.alpha = 0
                shadowsWarningLabel.alpha = 0
                highlightsWarningLabel.alpha = 0
                focusSlider.alpha = 0
                focusSelectorButton.alpha = 0
                //  touchToFocusLabel.alpha = 0
                AutoFocusModeButton.alpha = 0
                apertureLabel.alpha = 0
                isoPicker.alpha = 0.4
                shutterSpeedPicker.alpha = 0.4
                
                autoISOLabel.alpha = 0
                autoExposureTimeLabel.alpha = 0
                macroIMG.alpha = 0
                infinityIMG.alpha = 0
            }else if row == 2 {
               
                whiteBalanceSegmented.alpha = 0
                whiteBalanceLabel.alpha = 0
                whiteBalanceSlider.alpha = 0
                
                
                autoExposureSwitchLabel.alpha = 0
                autoExposureSwitch.alpha = 0
                shadowsWarningSwitch.alpha = 0
                highlightsWarningSwitch.alpha = 0
                gridSwitch.alpha = 0
                levelSwitch.alpha = 0
              //  histogramSwitch.alpha = 0
                gridLabel.alpha = 0
                levelLabel.alpha = 0
               // histogramLabel.alpha = 0
                shadowsWarningLabel.alpha = 0
                highlightsWarningLabel.alpha = 0
                 focusSelectorButton.alpha = 1
                 focusMode()
                apertureLabel.alpha = 0
                isoPicker.alpha = 0.4
                shutterSpeedPicker.alpha = 0.4
                autoISOLabel.alpha = 0
                autoExposureTimeLabel.alpha = 0
                 if autoExposureSwitch.isOn == true {
                isoPicker.isUserInteractionEnabled = false
                shutterSpeedPicker.isUserInteractionEnabled = false
                 }else{
                    isoPicker.isUserInteractionEnabled = true
                    shutterSpeedPicker.isUserInteractionEnabled = true
                }
                
            }else if row == 4 {
                whiteBalanceSegmented.alpha = 0
                whiteBalanceSlider.alpha = 0
                whiteBalanceLabel.alpha = 0
                if autoExposureSwitch.isOn == true {
                    isoPicker.isUserInteractionEnabled = false
                    shutterSpeedPicker.isUserInteractionEnabled = false
                }else{
                    isoPicker.isUserInteractionEnabled = true
                    shutterSpeedPicker.isUserInteractionEnabled = true
                }
                autoExposureSwitchLabel.alpha = 0
                autoExposureSwitch.alpha = 0
                //Warnings
                gridSwitch.alpha = 0
                levelSwitch.alpha = 0
             //   histogramSwitch.alpha = 0
                gridLabel.alpha = 0
                levelLabel.alpha = 0
              //  histogramLabel.alpha = 0
                shadowsWarningSwitch.alpha = 1
                highlightsWarningSwitch.alpha = 1
                shadowsWarningLabel.alpha = 1
                highlightsWarningLabel.alpha = 1
                focusSlider.alpha = 0
                focusSelectorButton.alpha = 0
                //  touchToFocusLabel.alpha = 0
                AutoFocusModeButton.alpha = 0
                apertureLabel.alpha = 0
                isoPicker.alpha = 0.4
                shutterSpeedPicker.alpha = 0.4
                autoISOLabel.alpha = 0
                autoExposureTimeLabel.alpha = 0
                macroIMG.alpha = 0
              
                infinityIMG.alpha = 0
                
            }else if row == 3{
                whiteBalanceSegmented.alpha = 0
                whiteBalanceSlider.alpha = 0
                whiteBalanceLabel.alpha = 0
                if autoExposureSwitch.isOn == true {
                    isoPicker.isUserInteractionEnabled = false
                    shutterSpeedPicker.isUserInteractionEnabled = false
                }else{
                    isoPicker.isUserInteractionEnabled = true
                    shutterSpeedPicker.isUserInteractionEnabled = true
                }
                autoExposureSwitchLabel.alpha = 0
                autoExposureSwitch.alpha = 0
                gridSwitch.alpha = 1
                levelSwitch.alpha = 1
              //  histogramSwitch.alpha = 1
                gridLabel.alpha = 1
                levelLabel.alpha = 1
              //  histogramLabel.alpha = 1
                shadowsWarningSwitch.alpha = 0
                highlightsWarningSwitch.alpha = 0
                shadowsWarningLabel.alpha = 0
                highlightsWarningLabel.alpha = 0
                focusSlider.alpha = 0
                focusSelectorButton.alpha = 0
                //  touchToFocusLabel.alpha = 0
                AutoFocusModeButton.alpha = 0
                apertureLabel.alpha = 0
                isoPicker.alpha = 0.4
                shutterSpeedPicker.alpha = 0.4
                autoISOLabel.alpha = 0
                autoExposureTimeLabel.alpha = 0
                macroIMG.alpha = 0
                infinityIMG.alpha = 0
              
                
                
            }else{
                whiteBalanceSegmented.alpha = 0
                whiteBalanceSlider.alpha = 0
                whiteBalanceLabel.alpha = 0
                if autoExposureSwitch.isOn == true {
                    isoPicker.isUserInteractionEnabled = false
                    shutterSpeedPicker.isUserInteractionEnabled = false
                }else{
                    isoPicker.isUserInteractionEnabled = true
                    shutterSpeedPicker.isUserInteractionEnabled = true
                }
                autoExposureSwitchLabel.alpha = 0
                autoExposureSwitch.alpha = 0
                gridSwitch.alpha = 0
                levelSwitch.alpha = 0
            //    histogramSwitch.alpha = 0
                gridLabel.alpha = 0
                levelLabel.alpha = 0
             //   histogramLabel.alpha = 0
                shadowsWarningSwitch.alpha = 0
                highlightsWarningSwitch.alpha = 0
                shadowsWarningLabel.alpha = 0
                highlightsWarningLabel.alpha = 0
                focusSlider.alpha = 0
                focusSelectorButton.alpha = 0
                //  touchToFocusLabel.alpha = 0
                AutoFocusModeButton.alpha = 0
                apertureLabel.alpha = 0
                isoPicker.alpha = 0.4
                shutterSpeedPicker.alpha = 0.4
        
                autoISOLabel.alpha = 0
                autoExposureTimeLabel.alpha = 0
                macroIMG.alpha = 0
                infinityIMG.alpha = 0
                
                
            }
            
        }
    }

    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 16)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView   == configSelector {
            
             pickerLabel?.text = configOptions[row]

            
        }else if pickerView == isoPicker {
            
             pickerLabel?.text = ("ISO " + String(isoArray[row]))
    
            
        }else if pickerView == shutterSpeedPicker {
            
            pickerLabel?.text =  (shutterSpeedArray[row] + "s")
   
        }
       
        pickerLabel?.textColor = UIColor.white
        
         return pickerLabel!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Realiza o necessário para voltar para a viewPrincipal e então faz atransição. Encerra a sessão, desbloqueia o controle de hardware e invalida o timer.
    @IBAction func goBack(_ sender: Any) {
        autoCam()
        
        backCamera?.unlockForConfiguration()
        captureSession.stopRunning()
        session?.stopRunning()
        //Muda o viewController
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewControllerPrincipal") as? ViewController
        // self.navigationController?.pushViewController(vc!, animated: true)
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    //Organiza inicialmente o RANGE dos ISOS
    func isoOrganize(){
        
       
 let xISO = Double((Int((backCamera?.activeFormat.maxISO)!) - Int((backCamera?.activeFormat.minISO)!)))
        
         isoArray.append(Int((backCamera?.activeFormat.minISO)!))
        var x = Int((backCamera?.activeFormat.minISO)!)
        while x <= Int((backCamera?.activeFormat.maxISO)!) {
            if isoArray[isoArray.count-1] > Int(xISO*0.12) {

                isoArray.append(Int(Double(isoArray[isoArray.count-1])*1.5))
            }else{

                isoArray.append(isoArray[isoArray.count-1]*2)
            }
             x = isoArray[isoArray.count-1]
        }
       
        for i in 0...isoArray.count-1 {
            if  isoArray[i] > 100 && isoArray[i] < 1000 {
                isoArray[i] = (Int(roundf(Float(isoArray[i]/10))))*10
            }else if isoArray[i] > 1000{
                isoArray[i] = (Int(roundf(Float(isoArray[i]/100))))*100
                
            }
           
        }

        if  (Int((backCamera?.activeFormat.maxISO)!)-isoArray[isoArray.count-1])>=30 {
            isoArray.append(Int((backCamera?.activeFormat.maxISO)!))
        }else{
            isoArray[isoArray.count-1] = Int((backCamera?.activeFormat.maxISO)!)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Organiza inicialmente o range do ShutterSpeed
    func shutterSpeedOrganize(){
        var min = CMTimeGetSeconds((backCamera?.activeFormat.minExposureDuration)!)
        let max = CMTimeGetSeconds((backCamera?.activeFormat.maxExposureDuration)!)
        if min < 1/25000 {
            min = 1/25000
        }
        shutterSpeedArray.append(String(Rational(approximating: max).numerator)+"/"+String(Rational(approximating: max).denominator))
        var lastDenominator = Rational(approximating: max).denominator
        let doubleStr = String(format: "%.4f", (1.0/(Double(lastDenominator))))
        shutterSpeedSeconds.append((Double(doubleStr))!)
        while (lastDenominator*2) <= (Rational(approximating: min).denominator){
            let x = lastDenominator
            if lastDenominator > 100 {
                lastDenominator = 100*Int(round(Float(lastDenominator)/100))
            }else if lastDenominator > 1000 {
                lastDenominator = 1000*Int(round(Float(lastDenominator)/1000))
            }else if lastDenominator > 10000 {
                lastDenominator = 10000*Int(round(Float(lastDenominator)/10000))
            }
            let doubleStr = String(format: "%.5f", (1.0/(Double(lastDenominator)*2.0)))
            shutterSpeedSeconds.append((Double(doubleStr))!)
            shutterSpeedArray.append("1"+"/"+String(lastDenominator*2))
            lastDenominator = x*2
        }
    }
    
   
    
    
    
    
    
    
    
    
    func updateRows(){
        
        var n = 0
        while isoArray[n] < Int(backCamera!.iso) {
            n+=1
        }
        isoPicker.selectRow(n, inComponent: 0, animated: true)
        actualIso = isoArray[n]
        n = 0
        
        //Evita um crash que o shutterSpeed pode estar mais alto (O range não abrange o valor máximo por ser algo absurdo...1/50.000)
        while shutterSpeedSeconds[n] > CMTimeGetSeconds(backCamera!.exposureDuration) {
            
            if n+1 == shutterSpeedSeconds.count - 1{
                break
            }else{
                n = n+1
            }
        }
        shutterSpeedPicker.selectRow(n, inComponent: 0, animated: true)
        actualShutterSpeed = shutterSpeedSeconds[n]
        
    }
    
    
    
    
    
    
    
    //Coloca os pickers do Manual Exposure no ISO e Shutter Speed mais próximos do inicial:
    func organizeRows(){
        autoCam()
        var n = 0
        while isoArray[n] < Int(backCamera!.iso) {
            n+=1
        }
        isoPicker.selectRow(n, inComponent: 0, animated: true)
        actualIso = isoArray[n]
        n = 0
        
        //Evita um crash que o shutterSpeed pode estar mais alto (O range não abrange o valor máximo por ser algo absurdo...1/50.000)
        while shutterSpeedSeconds[n] > CMTimeGetSeconds(backCamera!.exposureDuration) {
            
            if n+1 == shutterSpeedSeconds.count - 1{
                break
            }else{
                n = n+1
            }
        }
        shutterSpeedPicker.selectRow(n, inComponent: 0, animated: true)
        actualShutterSpeed = shutterSpeedSeconds[n]
        
        //Após colocar inicialmente as configurações automaticas a camera estará bloqueada em modo manual com tais configuracões, pois assim, caso o usuário mudar de ambiente ele verá a mudança real sem ter que alterar os valores. (Verá a mudança direto na câmera pois ela não mais estará em modo automático)
      configCameraView(isoConfig: actualIso, shutterSpeed: actualShutterSpeed)
    }
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        orientation = AVCaptureVideoOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!
    }
    
    
    

    
    
    func setupDevice() {
        
        myImage.addSubview(gridImage)
        myImage.addSubview(layer)
        myImage.addSubview(layer2)
        myImage.addSubview(layer3)
        prepareLevel()
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    
    
    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            
            
           
            
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            
            if captureSession.canAddOutput(stillImageOutput) {
  
                 captureSession.addOutput(stillImageOutput)
            }else{
                print("falhou")
            }
            
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            //see available types
            //print("\(vFormat) \n")
            
            var ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]
            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }
    
    
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        DispatchQueue.main.async {
        
        var highlightWarningFilter = highlightAmountFilter()
          var shadowsWarningFilter = shadowAmountFilter()
          let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)
        var outputImage: CIImage? = nil
            if self.shadowsWarningSwitch.isOn == true {
            shadowsWarningFilter.inputImage = cameraImage
        outputImage = shadowsWarningFilter.outputImage
        }
        
            if self.highlightsWarningSwitch.isOn == true{
            if outputImage != nil {
                highlightWarningFilter.inputImage = outputImage
            }else{
                 highlightWarningFilter.inputImage = cameraImage
            }
                
                outputImage = highlightWarningFilter.outputImage
        }
        
        if outputImage == nil {
            outputImage = cameraImage
        }
        

        
        
        let cgImage = self.context.createCGImage(outputImage!, from: cameraImage.extent)!
        
        
        
     
            let filteredImage = UIImage(cgImage: cgImage)
            self.myImage.image = filteredImage
        }
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
       
        
        
        
        
        
        self.configSelector.delegate = self
        self.configSelector.dataSource = self
        self.isoPicker.delegate = self
        self.isoPicker.dataSource = self
        self.shutterSpeedPicker.delegate = self
        self.shutterSpeedPicker.dataSource = self
        
      
      
       
        
        
         gridImage.alpha = 0
        
        
        flashButton.layer.cornerRadius = 14
        flashButton.backgroundColor =  UIColor(red:0.65, green:0.17, blue:0.11, alpha:1.0)
        
        
      timerButton.layer.cornerRadius = timerButton.frame.width/2
        
        
        
        self.setupDevice()
        self.setupInputOutput()
        
     //  createSession()

        //Organiza o range(picker) do ISO e do ShutterSpeed
        isoOrganize()
        shutterSpeedOrganize()
        organizeWhiteBalanceButton()
        
        
     //   //Verifica a permissão de utilizar a câmera
      //  verifyPermission()
        
        
        
  
        
       
        // createSession()
 updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateISOandShutter), userInfo: nil, repeats: true)
        super.viewDidLoad()

}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    //Função chamada a cada 0.5s pelo timer para atualizar os valores de ISO e velocidade do obturador. Porém chamada apenas quando a câmera está em modo automático.
    @objc func updateISOandShutter(){
         autoISOLabel.text = "ISO: " + String(Int(backCamera!.iso))
        
        let a = CMTimeGetSeconds(backCamera!.exposureDuration)
        let y = Int(Rational(approximating: a).denominator/Rational(approximating: a).numerator)
        autoExposureTimeLabel.text = "Shutter Speed: 1/"+String(y) + "s"
        
        apertureLabel.text = "Aperture: " + String(backCamera!.lensAperture) + "f"
        
        //vortaaaaa
        if whiteBalanceSegmented.titleForSegment(at: whiteBalanceSegmented.selectedSegmentIndex) != "Manual" && whiteBalanceSegmented.alpha > 0{
        let currentGains = backCamera!.deviceWhiteBalanceGains
        let currentTint = backCamera!.temperatureAndTintValues(for: currentGains).temperature
        whiteBalanceLabel.text = "\(roundf(currentTint))" + "K"
        whiteBalanceSlider.setValue(currentTint, animated: true)
            
        }
        
        if autoExposureSwitch.isOn == true{
         updateRows()
        }
      //  organizeRows()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    //Aqui serve para transformar um número como 2819.23789 numa aproximação em fração, útil para mostrar o tempo de exposição de forma correta.
    struct Rational {
        let numerator : Int
        let denominator: Int
        
        init(numerator: Int, denominator: Int) {
            self.numerator = numerator
            self.denominator = denominator
        }
        
        init(approximating x0: Double, withPrecision eps: Double = 1.0E-6) {
            
            var x = x0
            var a = x.rounded(.down)
            
            if x.isNaN  == true {
                x = 1
            }
            if a.isNaN == true {
                a = 1
            }
          var (h1, k1, h, k) = (1, 0, Int(a), 1)
            
            while x - a > eps * Double(k) * Double(k) {
                x = 1.0/(x - a)
                a = x.rounded(.down)
                (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
            }
            self.init(numerator: h, denominator: k)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //O tamanho da câmera será o mesmo do espaço alocado/pensado para ela:
 //  prevLayer?.frame.size = cameraView.frame.size
       gridImage.frame = myImage!.frame
     
        //Após carregar a view organiza o picker do iso e do shutterspeed de acordo com as configuracões que a camera entender no automatico, para que assim não ocorram muitas alterações na imagem quando o usuário começar a alterar as configurações:
        whiteanimation.frame.size = cameraView.frame.size
        
        //Coloca os pickers do Manual Exposure no ISO e Shutter Speed mais próximos do inicial:
   organizeRows()
    }
    
    
    
    
    //Status bar branca! Para contrastar com o aplicativo escuro. Caso contrário fica quase impossível de enxergar a barra de status
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
//FIM DO DOCUMENTO
}









extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}


extension AVCaptureDevice.WhiteBalanceGains {
    mutating func clampGainsToRange(minVal:Float, maxVal:Float) {
        blueGain = max(min(blueGain, maxVal), minVal)
        redGain = max(min(redGain, maxVal), minVal)
        greenGain = max(min(greenGain, maxVal), minVal)
    }
}

