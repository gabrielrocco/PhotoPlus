//
//  essayViewController.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 06/06/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import UIKit

class essayViewController: UIViewController {
    @objc var increaseISObutton: UIButton = UIButton()
     @objc var decreaseISObutton: UIButton = UIButton()
    var isos: [Int] = [100,200,400,800,1600,3200,6400,12800,25600]
    var actualISO = 0
    
    var ISOimageArray: [UIImage] = [UIImage(named: "iso100")!, UIImage(named: "iso200")!,UIImage(named: "iso400")!,UIImage(named: "iso800")!,UIImage(named: "iso1600")!,UIImage(named: "iso3200")!,UIImage(named: "iso6400")!,UIImage(named: "iso12800")!,UIImage(named: "iso25600")!]
    var isoImage = UIImage(named: "isoPlaceholder")
    
    
    var aCGImage: CGImage? = nil
    var aCIImage: CIImage? = nil
    
    
    
    let imageChangeISO: UIImageView = UIImageView()
    let noiseImage: UIImageView = UIImageView()
    @IBOutlet weak var globalSlider: UISlider!
    
    
    @IBAction func globalSliderChanged(_ sender: Any) {
        noiseImage.image = isoImage
        aCGImage =  noiseImage.image?.cgImage!
        aCIImage = CIImage(cgImage: aCGImage!)
        noiseReduction!.setValue(globalSlider.value, forKey: "inputNoiseLevel")
        var context = CIContext(options: nil)
        noiseReduction!.setValue(aCIImage, forKey: "inputImage")
        var outputImage = noiseReduction?.outputImage!
        var cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
       
        
        var i = 0
        //Existe um pequeno impecilho no filtro de ruído...ele só funciona como eu gostaria caso for sobreposto. Posso até mesmo aplicar o filtro apenas uma vez com um valor exorbitante de 10000 mas nada demais acontece
        while i != abs(Int(globalSlider.value*0.65)){
            print(abs(Int(globalSlider.value*0.65)))
        noiseReduction!.setValue(outputImage, forKey: "inputImage")
        outputImage = noiseReduction?.outputImage!
        cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
            i+=1
        }

        
        var newUIImage = UIImage(cgImage: cgimg!)
        noiseImage.image = newUIImage
     

        
    }
    
    
    
    
    @objc func increaseISOaction(sender: UIButton) {
        if actualISO == isos.count-1 {
            actualISO = 0
        }else{
            actualISO += 1
        }
        
        isoLabel.text = "ISO: " + String(isos[actualISO])
        imageChangeISO.image = ISOimageArray[actualISO]
    }
    
    @objc func decreaseISOaction(sender: UIButton) {
        if actualISO == 0 {
            actualISO = isos.count-1
        }else{
            actualISO -= 1
        }
        
        isoLabel.text = "ISO: " + String(isos[actualISO])
        imageChangeISO.image = ISOimageArray[actualISO]
    }
    
    
    
    
    
    
    @IBOutlet weak var learnScrollView: UIScrollView!
    //Status bar branca! Para contrastar com o aplicativo escuro. Caso contrário fica quase impossível de enxergar a barra de status
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

     let isoLabel = UILabel()
    @IBOutlet weak var backButton: UIButton!
  
    
    
    @IBAction func goBack(_ sender: Any) {
        print("hello")
        
        //Muda o viewController
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewControllerPrincipal") as? ViewController
        // self.navigationController?.pushViewController(vc!, animated: true)
        vc?.modalTransitionStyle = .coverVertical
        present(vc!, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        isoLabel.text = "ISO: " + String(isos[actualISO])
        imageChangeISO.image = ISOimageArray[actualISO]
        increaseISObutton.addTarget(self, action: #selector(increaseISOaction), for: .touchUpInside)
        decreaseISObutton.addTarget(self, action: #selector(decreaseISOaction), for: .touchUpInside)
        if essayNumber == 0{
        makeBasicsEssay()
        }else if essayNumber == 1{
        makeISOessay()
        }
        
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

}
