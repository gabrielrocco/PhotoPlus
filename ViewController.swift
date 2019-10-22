//
//  ViewController.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 25/05/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import UIKit
import Photos
var globalImage: UIImage? = nil
var essayNumber = 0







class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate{
    
    
    
    var actualCanvas: Canvas? = Canvas()
    
    
    @IBOutlet weak var drawTheMaskLabel: UILabel!
    var menuPresent = false
    var lastSliderValue:Float = 0.0
    var actualSliderValue:Float = 0.0
    //Slider para alterar os parametros dos filtros básicos de edição
    @IBOutlet weak var editSlider: UISlider!
    //Slider para mexer com certos parâmetros que podem ser necessários
    @IBOutlet weak var secondEditSlider: UISlider!
    @IBOutlet weak var secondEditLabel: UILabel!
    var i = 0
    @IBOutlet weak var thirdEditSlider: UISlider!
    
    
    
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
 
    
    @IBOutlet weak var cancelCanvasButton: UIButton!
    
    @IBOutlet weak var doneCanvasButton: UIButton!
    
    
    
    @IBOutlet weak var editToolsButtonChange: UIButton!
    
    //Nenhum filtro aplicado ainda, serve para quando voltar do resetPreview não ser aplicado nenhum filtro
    
    var novoFiltro: [Double] = []
    //Vai verificar se existe autorização para utilizar a câmera, caso sim, o usuario pode acessar
    var canGoToCamera = false
    
    @IBOutlet weak var exportView: UIView!
    
    @IBOutlet weak var exportingLabel: UILabel!
    
    
    @IBOutlet weak var buttonsView: UIView!
    
    
    @IBOutlet weak var undoFilterButton: UIButton!
    
    @IBOutlet weak var qualityOfVisualizationSettings: UISegmentedControl!
    
    @IBOutlet weak var proCameraBt: UIButton!
    
    @IBOutlet weak var learnView: UIView!
    
    @IBOutlet weak var sliderFilterView: UIView!
    
    var lastValueFilterPercentage: Float = 0
    
    @IBOutlet weak var imageZoomView: UIScrollView!
    
    //vai acompanhar o zoom na imagem para o botão tmb
    var initialImageButtonSize = CGSize()
    
    //Botão que permite editar as cores na imagem, fica na parte de edição
    @IBOutlet weak var colorsButton: UIButton!
    //Botão que permite adicionar um filtro em locais específicos
    @IBOutlet weak var brushButton: UIButton!
    @IBOutlet weak var learnCollection: UICollectionView!
    
    //ImageView que mostrará a imagem do histograma da imagem
    @IBOutlet weak var histogramView: UIImageView!
    
    
    
    //View das configurações, pode ser acessado na LearnView
    @IBOutlet weak var settings: UIView!
    //Botão que fecha as configurações
    @IBOutlet weak var settingsDoneButton: UIButton!
    //Botão localizado na LearnView que abre as configurações
    @IBOutlet weak var openSettingsButton: UIButton!
    
    //Segundo botão de reset, fica na parte dos filtros e e tem a mesma função
    @IBOutlet weak var resetFilters: UIButton!
    
    //Saber se a View Ativa é a dos filtros
    var isFiltersOn = false
    
    //Impede que outros filtros sejam aplicados enquanto um deles está sendo modificado, porcentagem:
    
    var imageViewSavedWidth: CGFloat = 0
    
    //Para a aplicação das edições:
    
    //UIImage da Imagem original importada:
    var UIImageImported: UIImage? = nil
    //UIImage resized muito pequena para os botões do filtro:
    var filterButtonMiniImg: UIImage? = nil
    var aCGImage: CGImage? = nil
    var aCIImage: CIImage? = nil
    //Após aplicação dos filtros:
    var newUIImage: UIImage? = nil
    //Muda os filtros aplicados pelo Slider
    var editOptionValue = 0
    
    var histogramBool = false
    
    
    
    var qualityOfVisualization:Float = 1300
    //Vai controlar o botão principal
    var isPhotoThere = false
    
    //Imagem importada
    var importedImage: UIImage? = nil
    var lastFilter = [0,0]
    
    
    //Coloca a imagem original na imageview enquanto o usuario segura
    @IBAction func start(_ sender: Any) {
        //preview reset
        if isPhotoThere == true  {
            //CODIGO COMENTADO PARA TESTES DO LOCAL FILTER
            //  imageViewIMG.image = resultImages[0]
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func resetPhoto(_ sender: Any) {
    //VORTAAAA
        for view in self.newImageBig.subviews {
            view.removeFromSuperview()
        }
        
        
         localAdjustmentsImage = []
         localAdjustmentsFilters = []
         localAdjustTemporaryImage = UIImageImported
        
        
        lastLineArraySize = 0
        actualLocalFilter = [0,1,1,1,0,6500,0,0,0.02,0,0,0]
        
       // var isLocalLastApplied = false
        canvasList = []
        pointsSaved = []
        tempIMG = UIImageImported
        localLocation = []
       
        
        
        
        selectiveColorsArray = [[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1]]
        sliderFilterView.alpha = 0
        appliedFilters.removeAll()
        appliedFilters.append([0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1])
        filtersSavedPercentage = [[20,20,20,20,20,20,20,20],[20,20,20,20],[20,20,20,20]]
        //Resetar a foto ao seu estado original de importação, caso existir:
        if isPhotoThere == true {
            savedEditValueSession = [0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1]
            changeEditLabel(option: editOptionValue)
            
            
            //Limpa a array de imagens editadas
            let x = resultImages[0]
            resultImages.removeAll()
            resultImages.append(x)
            imageViewIMG.image = resultImages[0]
            
            reloadFiltersData()
        }
    }
    
    
    
    
    
    
    
    
    
    //Lista com as imagens da seção Learn
    var learnPhotos: [UIImage] = [UIImage(named: "photographyBasics")!,UIImage(named: "isoSensitivity")!,UIImage(named: "shutterSpeed")!,UIImage(named: "aperture")!,UIImage(named: "photometry")!,UIImage(named: "focalDistance")!,UIImage(named: "hyperfocal")!,UIImage(named: "histogram")!,UIImage(named: "whiteBalance")!]
    
    //Lista com os labels da seção Learn
    var learnLabel: [String] = ["", "","","","","", "", "",""]
    
    @IBOutlet weak var percentageFilterSlider: UISlider!
    
    var filtersImagesA: [UIImage] = [UIImage(named: "bew")!,UIImage(named: "seasons")!,UIImage(named: "abandoned")!,UIImage(named: "effects")!,UIImage(named: "frames")!]
    
    var filtersImagesB: [UIImage] = [UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!]
    
    
    var editIcons: [UIImage] = [UIImage(named: "exposure")!,UIImage(named: "shadows")!,UIImage(named: "highlights")!,UIImage(named: "saturation")!,UIImage(named: "contrast")!,UIImage(named: "sharpen")!,UIImage(named: "temp")!,UIImage(named: "vibrance")!,UIImage(named: "vignette")!,UIImage(named: "noise")!,UIImage(named: "rgb")!]
    
    var editLabelsText: [String] = ["Exposure", "Shadows", "Highlights", "Saturation", "Contrast", "Sharpen","Warmth", "Vibrance", "Vignette", "Noise Reduction", "Color Filter"]
    
    var editLabelsTextLocal: [String] = ["Shadows", "Highlights", "Saturation", "Contrast", "Sharpen","Warmth", "Vibrance", "Vignette", "Noise Reduction", "Color Filter"]
    
    var editIconsLocal: [UIImage] = [UIImage(named: "shadows")!,UIImage(named: "highlights")!,UIImage(named: "saturation")!,UIImage(named: "contrast")!,UIImage(named: "sharpen")!,UIImage(named: "temp")!,UIImage(named: "vibrance")!,UIImage(named: "vignette")!,UIImage(named: "noise")!,UIImage(named: "rgb")!]
    
    var editLabelsTextToUse: [String] = []
    var editIconsToUse: [UIImage] = []
    
    //O espaço "identificador único" é reservado para filtros específicos que não podem ser alterados/que não alteram nenhuma característica de outros atributos
    
    var editLabels2Text: [String] = ["Radius"]
    
    
    
    
    
    //LOCAL FILTER ADJUSTS
    var localAdjustmentsImage: [UIImage] = []
    var localAdjustmentsFilters: [[Float]] = [[]]
    var isAdjustingLocal = false
    var localAdjustTemporaryImage: UIImage? = nil
    var lastLineArraySize = 0
    var actualLocalFilter: [Float] = [0,1,1,1,0,6500,0,0,0.02,0,0,0]
    var isLocalLastApplied = false
    var canvasList: [Canvas] = []
    var pointsSaved: [UIButton] = []
    var tempIMG: UIImage? = nil
    var localLocation: [Int] = []
    var isPaintingLocal = false
    
    /*
     filtersSavedPercentage: Salvar a porcentagem da aplicação dos filtros:
     O esquema aqui é mais ou menos esse:
     [[Espaço para filtros 0 (b&w)], [espaço para filtros season]]
     
     tipo:
     [[5,7,2,10,11,9],[3,13,20,0,10]]
     
     
     savedEditValueSession: Salva o valor dos filtros na sessão:
     
     [0:Exposição
     1:Shadows
     2:Highlights
     3:Saturation
     4:Contrast
     5:Sharpen
     6:Warmth
     7:Vibrance
     8:Vignette
     9:Noise Reduction]
     
     */
    
    var filtersSavedPercentage:[[Double]] = [[20,20,20,20,20,20,20,20],[20,20,20,20],[20,20,20,20]]
    var savedEditValueSession: [Float] = [0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1]
    
    
    
    var appFilters: [[[Float]]] = [[  [0.47, 0.2, 1.13, 0.0, 1.058, 0.85, 6500.0, 0.0, 2.2, 0.0,0,0,0,1], [0.44, 0.35, 1.1, 0.0, 1.043, 0.85, 6500.0, 0.0, 1.4, 0.0,0,0,0,1], [0.49, 0.46, 1.18, 0.0, 1.046, 0.85, 6500.0, 0.0, 0.8, 0.0,0,0,0,1], [0.22, 0.338, 1.7, 0.0, 0.977, 1.0, 2500.0, 0.0, 0.1, 0.0,0,0,0,1], [0.22, 0.338, 1.7, 0.0, 0.984, 0.2, 2500.0, 0.0, 0.1, 0.0,0,0,0,1], [0.22, 0.7, 0.915, 0.0, 1.03, 0.2, 10500.0, 0.0, 0.1, 0.0,0,0,0,1], [0.22, -0.2, 0.915, 0.0, 0.91, 0.2, 10500.0, 0.0, 0.1, 0.0,0,0,0,1], [0.3, 0.35, 0.98, 0.0, 0.95, 0.2, 8537.45, 0.0, 0.1, 0.0,0,0,0,1]    ], [ [0.2, 0.4, 1.25, 1.25, 1.01, 0.2, 7000, 0, 0, 0.01,0,0,0,1]   ],                         [[0.2, 0.43, 1.2, 0.67, 1.05, 0.2, 6290, 0.2, 2, 0.01,0,0,0,1],[0.2, 0.6, 1.2, 0.4, 1.07, 0.2, 6000, 0.3, 2.5, 0.01,0.09,0,0,1], [0,0.3,1.2,0.75,1.035,0,6500,0,1.7,0.02,0.034,0.09,0.048,1],[0.2, 0, 1.16, 1.08, 1.01, 0.2, 6290, 0.2, 2, 0.01,0,0,0,1]]]
    var resultImages: [UIImage] = []
    var fullResolutionImage: UIImage? = nil
    
    //Salva o minimo e máximo dos efeitos, utilizado para controlar o range do slider de aplicação
    var effectsAmountMinAndMax: [[Float]] = [[0.00001,0.01]]
    
    
    //Controla o amount dos efeitos
    var effectsSaveAmountForSession: [Float] = [0,0,0,0,0,0]
    
    var appliedFilters: [[Float]] = []
    //número de filtros disponíveis para um determinado tipo de filtro:
    //[numero de filtro b&w, numero de filtros season, etc]
    var numberOfFilters = [8,1,4]
    //tipo de filtro selecionado (black and white, etc)
    var filtersType = 0
    //Ajuda nas animações quando muda-se as opções do menu
    var optionNumber = 1
    
    
    
    @IBOutlet weak var filterCollectionViewA: UICollectionView!
    
    @IBOutlet weak var editCollection: UICollectionView!
    
    @IBOutlet weak var filtersCollectionViewB: UICollectionView!
    
    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var editOptionLabel: UILabel!
    
    @IBOutlet weak var editCollectionView: UIView!
    @IBOutlet weak var filtersCollectionView: UIView!
    
    @IBOutlet weak var imageViewIMG: UIImageView!
    @IBOutlet weak var redViewSelector: UIView!
    
    
    @IBOutlet weak var newImageBig: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    
    @IBOutlet weak var learnBt: UIButton!
    @IBOutlet weak var filterBt: UIButton!
    @IBOutlet weak var editBt: UIButton!
    @IBOutlet weak var filtersPrincipalView: UIView!
    
    
    var isCanvasThere = false
    
    
    @IBOutlet weak var importBt: UIButton!
    @IBOutlet weak var saveBt: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    
    var editToolIdentifier = 0
    
    @IBOutlet weak var colorsToolView: UIView!
    
    
    @IBOutlet weak var hueSlider: UISlider!
    
    
    @IBOutlet weak var saturationSlider: UISlider!
    
    
    @IBOutlet weak var luminanceSlider: UISlider!
    
    var HSLFilter = MultiBandHSV()
    var selectiveColorsIdentifier = 1
    var selectiveColorsArray: [[Float]] = [[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1],[0,1,1]]
    
    
    
    
    
    
    
    
    
    
    func organizeSlidersSelectiveColor(){
        hueSlider.value = selectiveColorsArray[editToolIdentifier][0]
        saturationSlider.value = selectiveColorsArray[editToolIdentifier][1]
        luminanceSlider.value = selectiveColorsArray[editToolIdentifier][2]
    }
    @IBAction func inputRedValues(_ sender: Any) {
        
        hueSlider.minimumTrackTintColor = UIColor.red
        saturationSlider.minimumTrackTintColor = UIColor.red
        luminanceSlider.minimumTrackTintColor = UIColor.red
        editToolIdentifier = 0
        organizeSlidersSelectiveColor()
        
    }
    
    @IBAction func inputOrangeValues(_ sender: Any) {
        hueSlider.minimumTrackTintColor = UIColor.orange
        saturationSlider.minimumTrackTintColor = UIColor.orange
        luminanceSlider.minimumTrackTintColor = UIColor.orange
        editToolIdentifier = 1
        organizeSlidersSelectiveColor()
    }
    
    
    @IBAction func inputYellowValues(_ sender: Any) {
        hueSlider.minimumTrackTintColor = UIColor.yellow
        saturationSlider.minimumTrackTintColor = UIColor.yellow
        luminanceSlider.minimumTrackTintColor = UIColor.yellow
        editToolIdentifier = 2
        organizeSlidersSelectiveColor()
    }
    
    
    @IBAction func inputGreenValues(_ sender: Any) {
        hueSlider.minimumTrackTintColor = UIColor.green
        saturationSlider.minimumTrackTintColor = UIColor.green
        luminanceSlider.minimumTrackTintColor = UIColor.green
        editToolIdentifier = 3
        organizeSlidersSelectiveColor()
    }
    
    @IBAction func inputBlueValues(_ sender: Any) {
        hueSlider.minimumTrackTintColor = UIColor(red:0.00, green:0.61, blue:0.89, alpha:1.0)
        saturationSlider.minimumTrackTintColor = UIColor(red:0.00, green:0.61, blue:0.89, alpha:1.0)
        luminanceSlider.minimumTrackTintColor = UIColor(red:0.00, green:0.61, blue:0.89, alpha:1.0)
        editToolIdentifier = 4
        organizeSlidersSelectiveColor()
    }
    
    
    @IBAction func inputMagentaValues(_ sender: Any) {
        hueSlider.minimumTrackTintColor = UIColor.magenta
        saturationSlider.minimumTrackTintColor = UIColor.magenta
        luminanceSlider.minimumTrackTintColor = UIColor.magenta
        editToolIdentifier = 5
        organizeSlidersSelectiveColor()
    }
    
    @IBAction func hueSliderChanged(_ sender: Any) {
        if  imageViewIMG.image != nil{
            selectiveColorsArray[editToolIdentifier][0] = hueSlider.value
            
            imageViewIMG.image =  editPhoto(toFilterIMG: tempIMG!, filterTo: savedEditValueSession)
        }
        
        print(hueSlider.value)
        
        
    }
    
    
    @IBAction func saturationSliderChanged(_ sender: Any) {
        if  imageViewIMG.image != nil{
            selectiveColorsArray[editToolIdentifier][1] = saturationSlider.value
            
            imageViewIMG.image =  editPhoto(toFilterIMG: tempIMG!, filterTo: savedEditValueSession)
        }
        
        print(saturationSlider.value)
        
    }
    
    
    
    @IBAction func luminanceSliderChanged(_ sender: Any) {
        
        print(luminanceSlider.value)
        if  imageViewIMG.image != nil{
            selectiveColorsArray[editToolIdentifier][2] = luminanceSlider.value
            
            imageViewIMG.image =  editPhoto(toFilterIMG: tempIMG!, filterTo: savedEditValueSession)
        }
        
        print(luminanceSlider.value)
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func editToolChange(_ sender: Any) {
        
        
        
        if isFiltersOn == true {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterWallViewController") as? RandomFilterWallViewController
            // self.navigationController?.pushViewController(vc!, animated: true)
            vc?.modalTransitionStyle = .coverVertical
            present(vc!, animated: true, completion: nil)
            
        }else{
            
            
            
            switch selectiveColorsIdentifier {
            case 0:
                //FILTRO TOTAL
                if imageViewIMG.image != nil {
                for view in self.newImageBig.subviews {
                    view.removeFromSuperview()
                    }}
                imageZoomView.minimumZoomScale = 1
                imageZoomView.maximumZoomScale = 10
                isAdjustingLocal = false
                cancelCanvasButton.alpha = 0
                doneCanvasButton.alpha = 0
                editIconsToUse = editIcons
                editLabelsTextToUse = editLabelsText
                editCollection.reloadData()
                changeEditLabel(option: editOptionValue)
                actualCanvas!.alpha = 0
                selectiveColorsIdentifier = 1
                colorsToolView.alpha = 0
                drawTheMaskLabel.alpha = 0
                editToolsButtonChange.setImage(UIImage(named: "picker"), for: .normal)
                break
            case 1:
                 if imageViewIMG.image != nil {
                for view in self.newImageBig.subviews {
                    view.removeFromSuperview()
                    }}
                //COR SELETIVA
                  drawTheMaskLabel.alpha = 0
                imageZoomView.minimumZoomScale = 1
                imageZoomView.maximumZoomScale = 10
                isAdjustingLocal = false
                cancelCanvasButton.alpha = 0
                doneCanvasButton.alpha = 0
                actualCanvas!.alpha = 0
                colorsToolView.alpha = 1
                selectiveColorsIdentifier = 2
                
                editToolsButtonChange.setImage(UIImage(named: "brush"), for: .normal)
                break
            case 2:
                if isCanvasThere == false && imageViewIMG.image != nil {
                    if pointsSaved.count > 0 {
                    for button in pointsSaved{
                        newImageBig.addSubview(button)
                    }
                    }}
                 drawTheMaskLabel.alpha = 1
                //AQUI EH O FILTRO LOCAL
                imageZoomView.setZoomScale(1, animated: true)
                imageZoomView.minimumZoomScale = 1
                imageZoomView.maximumZoomScale = 1
                isAdjustingLocal = true
                doneCanvasButton.alpha = 1
                editIconsToUse = editIconsLocal
                editLabelsTextToUse = editLabelsTextLocal
                editCollection.reloadData()
                changeEditLabel(option: editOptionValue)
                actualCanvas!.alpha = 1
                
                colorsToolView.alpha = 0
                selectiveColorsIdentifier = 0
                editToolsButtonChange.setImage(UIImage(named: "film"), for: .normal)
                break
            default: break
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func cropImageAction(_ sender: Any) {
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func brushAction(_ sender: Any) {
        createHistogram()
        
        if histogramBool == false{
            histogramBool = true
            histogramView.alpha = 1
        }else{
            histogramView.alpha = 0
            histogramBool = false
            
            //ocultar histograma
        }
    }
    
    
    
    @IBAction func doneButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            
            self.settings.center = CGPoint(x: self.settings.center.x, y: -self.settings.frame.height*2.5)
            self.menuPresent = false
            
            
        })
    }
    
    
    @IBAction func openSettings(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.menuPresent = true
            self.settings.center = CGPoint(x: self.settings.center.x, y: self.settings.frame.height*0.6 + self.topView.frame.height)
            
        })
    }
    
    
    
    @IBAction func sliderFilterChanged(_ sender: Any) {
        if filtersType != 3 {
            if abs(percentageFilterSlider.value-lastValueFilterPercentage) >= 1.0  {
                imageViewIMG.image = filtersPreviewApply(imgToUse: resultImages[resultImages.count-1], filterType: lastFilter[0], filterNumber: lastFilter[1], toImage: true, percentage: percentageFilterSlider.value)
                filtersSavedPercentage[lastFilter[0]][lastFilter[1]] = Double(percentageFilterSlider.value)
            }
        }else{
            //Efeitos
            if lastFilter == [3,0] {
                //Aplica o efeito de ruído, conforme o slider atualiza
                imageViewIMG.image = applyEffect(imgToUse:resultImages[resultImages.count-1], amount: CGFloat(percentageFilterSlider!.value), effectToApply: lastFilter[1])
                //  effectsSaveAmountForSession[lastFilter[1]] == percentageFilterSlider!.value
            }
            
            
        }
    }
    
    
    
    
    @IBAction func undoFilterButton(_ sender: Any) {
        //Botão que volta um estado na imagem apresentada, funciona até retornar à imagem original
        if resultImages.count > 1 {
            //Remove o ultimo filtro aplicado e a ultima imagem salva
            resultImages.removeLast()
            appliedFilters.removeLast()
            
            
            imageViewIMG.image = resultImages[resultImages.count-1]
            
        }
        
    }
    
    
    
    @IBAction func applyFilterPercentageButton(_ sender: Any) {
        //Apply Filter
        if filtersType != 3 {
            resultImages.append(filtersPreviewApply(imgToUse: resultImages[resultImages.count-1], filterType: lastFilter[0], filterNumber: lastFilter[1], toImage: true, percentage: percentageFilterSlider.value))
            
            
            
            
            sliderFilterView.alpha = 0
           // imageViewIMG.image = resultImages[resultImages.count-1]
            tempIMG = filtersPreviewApply(imgToUse: tempIMG!, filterType: lastFilter[0], filterNumber: lastFilter[1], toImage: true, percentage: percentageFilterSlider.value)
            imageViewIMG.image = tempIMG
            
            
            
            //Coloca na array dos filtros aplicados o filtro
            appliedFilters.append(appFilters[lastFilter[0]][lastFilter[1]])
            
            
            //Muda as configurações atuais
            //Esta mudança (comentar o codigo abaixo) impede que o usuario altere o filtro principal, mas resolve o problema de sopreposição de filtro. Pois a imagem editada ia para a variavel tempImage que realiza o funcionamento correto dos filtros locais. E ao alterar no EditPhoto Geral o filtro era reaplicado em cima desta.
           // for i in 0...savedEditValueSession.count-1{
           //     savedEditValueSession[i] = Float(novoFiltro[i])
          //  }
            
            //Volta aos valores originais de porcentagem de filtro! Eles só podem ser alterados na visualização de filtros, após aplicação todos voltam para o máximo
            filtersSavedPercentage = [[20,20,20,20,20,20,20,20],[20,20,20,20],[20,20,20,20]]
        }else{
            
            //Efeitos
            
            
            
            
            //Aplica o efeito de ruído, atualiza a array de imagens
            resultImages.append(applyEffect(imgToUse:resultImages[resultImages.count-1], amount: CGFloat(percentageFilterSlider!.value), effectToApply: lastFilter[1]))
            
            sliderFilterView.alpha = 0
            imageViewIMG.image = resultImages[resultImages.count-1]
            //Aqui está um filtro impossível de ocorrer, será feita uma comparação com os filtros aplicados, caso isso seja encontrado, será redirecionado para uma função que aplica o filtro especificado
            appliedFilters.append([-999,-1,-1,-1,-1,-1,-1,Float(lastFilter[0]),Float(lastFilter[1]),percentageFilterSlider!.value])
            
            
            
            
        }
        
    }
    
    
    @IBAction func cancelFilterApply(_ sender: Any) {
        if filtersType != 3 {
              imageViewIMG.image = tempIMG
           // imageViewIMG.image =   filtersPreviewApply(imgToUse: resultImages[resultImages.count-1], filterType: lastFilter[0], filterNumber: lastFilter[1], toImage: true, percentage: 0)
        }else{
            imageViewIMG.image = resultImages[resultImages.count-1]
        }
        sliderFilterView.alpha = 0
    }
    
    
    
    
    @IBAction func changeQualityOfVisualization(_ sender: Any) {
        //Muda a qualidade de visualização
        if qualityOfVisualizationSettings.selectedSegmentIndex == 0 {
            qualityOfVisualization = 500
        }else if qualityOfVisualizationSettings.selectedSegmentIndex == 1{
            qualityOfVisualization = 800
        }else if qualityOfVisualizationSettings.selectedSegmentIndex == 2{
            qualityOfVisualization = 1100
        }
    }
    
    
    
    
    
    
    func createHistogram(){
        /*
         histogramView.contentMode = .scaleToFill
         histogramView.frame.size = CGSize(width: view.frame.width, height: (newImageBig.center.y-newImageBig.frame.height/2)-(topView.center.y+topView.frame.height/2))
         
         histogramView.center = CGPoint(x:  newImageBig.center.x, y: topView.center.y+topView.frame.height/2+histogramView.frame.height/2)
         
         
         
         var aCGImageH = imageViewIMG.image?.cgImage!
         var aCIImageH = CIImage(cgImage: aCGImageH!)
         
         
         histogramFilter!.setValue(200, forKey: "inputHeight")
         histogramFilter!.setValue(1, forKey: "inputHighLimit")
         histogramFilter!.setValue(0, forKey: "inputLowLimit")
         
         let context = CIContext(options: nil)
         histogramFilter!.setValue(aCIImageH, forKey: "inputImage")
         let outputImage = histogramFilter?.outputImage!
         var cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
         
         cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
         
         let histogramImage = UIImage(cgImage: cgimg!)
         histogramView.image = histogramImage
         */
        
        
    }
    
    
    
    //Animate the transition of the views in menu
    func animateOptionMenu(option: Int){
        switch option {
        case 1:
            //LEARN VIEW
            UIView.animate(withDuration: 0.3, animations: {
                
                self.buttonsView.center = CGPoint(x: self.view.frame.width*1.5, y: self.buttonsView.center.y)
                self.learnView.center = CGPoint(x: self.learnView.frame.width/2, y: self.learnView.frame.height/2)
                
                self.filtersPrincipalView.center = CGPoint(x:self.filtersPrincipalView.center.x,y:self.filtersPrincipalView.center.y - self.filtersPrincipalView.frame.height*1.5)
                
                self.filtersCollectionView.center = CGPoint(x: self.filtersCollectionView.frame.width*1.5, y: 538+self.filtersCollectionView.frame.height/2)
                
                
                self.editCollectionView.center = CGPoint(x: self.editCollectionView.frame.width*1.5, y: 540+self.editCollectionView.frame.height/2)
                
            }) { (true) in
                self.filtersPrincipalView.center = CGPoint(x: -self.filtersPrincipalView.frame.width*1.5,y: self.filtersPrincipalView.frame.height/2)
            }
            
            
            
        case 2:
            if imageViewIMG.image != nil {
                for view in self.newImageBig.subviews {
                    view.removeFromSuperview()
                }
                editToolsButtonChange.alpha = 1
                editToolsButtonChange.isUserInteractionEnabled = true
                resetFilters.alpha = 1
                resetFilters.isUserInteractionEnabled = true
                undoFilterButton.alpha = 1
                undoFilterButton.isUserInteractionEnabled = true
                cropButton.alpha = 1
                cropButton.isUserInteractionEnabled = true
                redoButton.alpha = 1
                redoButton.isUserInteractionEnabled = true
              
            }else{
                cropButton.alpha = 0.5
                cropButton.isUserInteractionEnabled = false
                redoButton.alpha = 0.5
                redoButton.isUserInteractionEnabled = false
                resetFilters.alpha = 0.5
                resetFilters.isUserInteractionEnabled = false
                editToolsButtonChange.alpha = 0.5
                editToolsButtonChange.isUserInteractionEnabled = false
                undoFilterButton.alpha = 0.5
                undoFilterButton.isUserInteractionEnabled = false
            }
            
            
            
            
            
            
          
            editToolsButtonChange.imageEdgeInsets.bottom = 6
            editToolsButtonChange.imageEdgeInsets.left = 6
            editToolsButtonChange.imageEdgeInsets.right = 6
            editToolsButtonChange.imageEdgeInsets.top = 6
            
            
            editToolsButtonChange.setImage(UIImage(named: "gallery"), for: .normal)
            
          
            // editToolsButtonChange.setTitle("Filter Wall", for: .normal)
            isFiltersOn = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.buttonsView.center = CGPoint(x: self.imageZoomView.center.x, y: self.imageZoomView.center.y + self.imageZoomView.frame.height*0.5 + self.buttonsView.frame.height)
                
                
                self.learnView.center = CGPoint(x:self.learnView.center.x,y:self.learnView.center.y - self.learnView.frame.height*1.5)
                
                self.editCollectionView.center = CGPoint(x: self.editCollectionView.frame.width*1.5, y: 540+self.editCollectionView.frame.height/2)
                
                self.filtersPrincipalView.center = CGPoint(x: self.filtersPrincipalView.frame.width/2,y: self.filtersPrincipalView.frame.height/2)
                
                
                
                
                //Alterar
                self.filtersCollectionView.center = CGPoint(x: self.filtersCollectionView.frame.width/2, y: 538+self.filtersCollectionView.frame.height/2)
            }) { (true) in
                self.learnView.center = CGPoint(x: -self.learnView.frame.width*1.5,y: self.learnView.frame.height/2)
            }
            
            
            
        case 3:
            
            
            if isCanvasThere == false && imageViewIMG.image != nil && isAdjustingLocal == true {
                if pointsSaved.count > 0 {
                    for button in pointsSaved{
                        newImageBig.addSubview(button)
                    }
                }}
            
            editToolsButtonChange.alpha = 1
            editToolsButtonChange.isUserInteractionEnabled = true
            
            if imageViewIMG.image != nil {
                cropButton.alpha = 1
                cropButton.isUserInteractionEnabled = true
                redoButton.alpha = 1
                redoButton.isUserInteractionEnabled = true
                undoFilterButton.alpha = 1
                undoFilterButton.isUserInteractionEnabled = true
                resetFilters.alpha = 1
                resetFilters.isUserInteractionEnabled = true
                
            }else{
                resetFilters.alpha = 0.5
                resetFilters.isUserInteractionEnabled = false
                undoFilterButton.alpha = 0.5
                undoFilterButton.isUserInteractionEnabled = false
                cropButton.alpha = 0.5
                cropButton.isUserInteractionEnabled = false
                redoButton.alpha = 0.5
                redoButton.isUserInteractionEnabled = false
               
            }
            
            editToolsButtonChange.imageEdgeInsets.bottom = 8
            editToolsButtonChange.imageEdgeInsets.left = 8
            editToolsButtonChange.imageEdgeInsets.right = 8
            editToolsButtonChange.imageEdgeInsets.top = 8
            
          
            
            
            
            if colorsToolView.alpha == 0 {
                editToolsButtonChange.setImage(UIImage(named: "picker"), for: .normal)
            }else{
                editToolsButtonChange.setImage(UIImage(named: "brush"), for: .normal)
            }
            
            if isAdjustingLocal == true{
                  editToolsButtonChange.setImage(UIImage(named: "film"), for: .normal)
            }
            
            
            editToolsButtonChange.alpha = 1
            isFiltersOn = false
            //Arruma os labels e valores do slider
            
            changeEditLabel(option: editOptionValue)
            
            /*
             if imageViewIMG.image != nil{
             //Este código faz com que não exista integração de edição entre os filtros e a edição normal
             imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-1], filterTo: savedEditValueSession)
             }
             */
            //O view principal para edição será igual ao dos filtros, a diferença estará nos sliders abaixo da imagem, a animação ocorrerá nestes pontos.
            UIView.animate(withDuration: 0.3, animations: {
                
                self.buttonsView.center = CGPoint(x: self.imageZoomView.center.x, y: self.imageZoomView.center.y + self.imageZoomView.frame.height*0.5 + self.buttonsView.frame.height)
                
                
                self.learnView.center = CGPoint(x:self.learnView.center.x,y:self.learnView.center.y - self.learnView.frame.height*1.5)
                
                self.filtersPrincipalView.center = CGPoint(x: self.filtersPrincipalView.frame.width/2,y: self.filtersPrincipalView.frame.height/2)
                
                
                
                self.filtersCollectionView.center = CGPoint(x: self.filtersCollectionView.frame.width*1.5, y: 538+self.filtersCollectionView.frame.height/2)
                
                self.editCollectionView.center = CGPoint(x: self.editCollectionView.frame.width/2,y: 540+self.editCollectionView.frame.height/2)
                
                
            }) { (true) in
                self.learnView.center = CGPoint(x: -self.learnView.frame.width*1.5,y: self.learnView.frame.height/2)
            }
            
            
        default:
            print("default")
            
        }
        
    }
    
    
    
    
    
    @IBAction func stopEditing(_ sender: Any) {
        if actualCanvas != nil && imageViewIMG.image != nil && isAdjustingLocal == true {
            actualCanvas!.alpha = 1
        }
        
    }
    
    
    
    
    
    
    
    
    //Chamada quando um botão é tocado para reeditar um filtro local
      @objc func reEditLocal(_ sender: UIButton, event: UIEvent) {
        
        
        for view in self.newImageBig.subviews {
            view.removeFromSuperview()
        }
      
        
     
        isCanvasThere = true
        changeEditLabel(option: editOptionValue)
        
        
        
        //Isso aqui remove o filtro selecionado, porém antes coloca as variaveis existentes numa posição temporária
        //TEMPORARIA:
        actualCanvas = canvasList[sender.tag]
        actualLocalFilter = localAdjustmentsFilters[sender.tag]
        

     
        //Remove para permitir alteração, voltando a ser temporaria
        canvasList.remove(at: sender.tag)
        localAdjustmentsFilters.remove(at: sender.tag)
        pointsSaved.remove(at: sender.tag)
        localAdjustmentsImage.remove(at: sender.tag)
        
        if pointsSaved.count > 0{
        let x: [Int] = []
        for i in 0...pointsSaved.count-1{
            pointsSaved[i].tag = i
            }}

        
        
        
        //A ARRAY resultImages NAO VAI GUARDAR IMAGENS COM FILTROS LOCAIS APLICADOS
        //AGORA A IMAGEM TEMPORARIA VAI SER IGUALADA À ULTIMA SEM APLICAÇÃO DE FILTROS LOCAIS:
       tempIMG = resultImages[resultImages.count-1]
        
        
        //APLICAR FILTROS:
        //A IMPLEMENTAR
        
        
        //AGORA É APLICADO O FILTRO TOTAL ATUAL, QUE NÃO SE INCLUI APLICADO!
      //  tempIMG = self.editPhoto(toFilterIMG: tempIMG!, filterTo: self.savedEditValueSession)
        
        //AGORA ESTA IMAGEM TEMPORARIA VAI PASSAR POR TODA A NOVA APLICACAO DOS FILTROS EXISTENTES:
        if self.canvasList.count > 0 {
            for i in 0...self.canvasList.count-1{
                autoreleasepool {
              
                    tempIMG = self.editPhotoWithMask(background: tempIMG!, filterTo: self.localAdjustmentsFilters[i], maskImage: localAdjustmentsImage[i])
                }
            }
        }
        
        
        
        //AGORA A IMAGEM TEMPORÁRIA ESTÁ PRONTA PARA SER EXIBIDA!
        imageViewIMG.image = tempIMG
        
        
        //PRECISAMOS AINDA APLICAR O FILTRO LOCAL QUE ESTA SENDO REEDITADO! FAZEMOS ISSO CHAMANDO A FUNÇAO DO SLIDER!
         self.sliderChanged(sender)
        drawTheMaskLabel.alpha = 0.7
        
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.autoreverse,.curveEaseIn,.repeat], animations: {
            self.drawTheMaskLabel.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)
        }) { (false) in
            
        }
        
        
        
        
        doneCanvasButton.setImage(UIImage(named:"verified"), for: .normal)
        cancelCanvasButton.alpha = 1
        actualCanvas!.alpha = 1
        newImageBig.addSubview(actualCanvas!)
    
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func doneCanvasAction(_ sender: Any) {
        if imageViewIMG.image != nil {
            
          
            
            if isCanvasThere == true {
                if actualCanvas?.lines.count == 0 {
                    isCanvasThere = false
                    doneCanvasButton.setImage(UIImage(named:"add"), for: .normal)
                    cancelCanvasButton.alpha = 0
                    drawTheMaskLabel.alpha = 0
                     actualCanvas!.removeFromSuperview()
                    
                    print(pointsSaved.count)
                    
                    if pointsSaved.count > 0 {
                        for i in 0...pointsSaved.count-1{
                            pointsSaved[i].alpha = 1
                        }}
                    
                    
                    for button in pointsSaved{
                        newImageBig.addSubview(button)
                    }
                    
                    
                    return
                }
                tempIMG = resultImages[resultImages.count-1]
                
                
                isCanvasThere = false
                doneCanvasButton.setImage(UIImage(named:"add"), for: .normal)
                cancelCanvasButton.alpha = 0
                drawTheMaskLabel.alpha = 0
                
                
                // localAdjustmentsImage.append(newImageFromMask())
                //Depois é so fazer resize
                actualCanvas!.alpha = 1
                
                
                
                //Por fim adiciona na array
                
                if actualCanvas != nil {
                    canvasList.append(actualCanvas!)
                }
                //ADICIONA AS MODIFICACOES NA ARRAY DE MODIFICACAO DE FILTROS LOCAIS
                localAdjustmentsImage.append(newImageFromMask())
                localAdjustmentsFilters.append(actualLocalFilter)
                
                
                //CRIA O BOTAO QUE VAI PERMITIR VOLTAR A EDITAR ESSE FILTRO LOCAL
                 if pointsSaved.count > 0 {
                for i in 0...pointsSaved.count-1{
                    pointsSaved[i].alpha = 1
                    }}
                
                
                let buttonToSave = UIButton(frame: CGRect(x: (actualCanvas?.lines[Int((actualCanvas?.lines.count)!/2)].startX)!, y: (actualCanvas?.lines[Int((actualCanvas?.lines.count)!/2)].startY)!, width: 22, height: 22))
                buttonToSave.backgroundColor = UIColor(red:0.62, green:0.01, blue:0.00, alpha:1.0)
                buttonToSave.tag = canvasList.count-1
                 buttonToSave.addTarget(self, action: #selector(reEditLocal(_:event:)), for: UIControl.Event.touchUpInside)
                    buttonToSave.layer.cornerRadius = 11
                pointsSaved.append(buttonToSave)
                
              
                
                for button in pointsSaved{
                newImageBig.addSubview(button)
                }
                
          
                // tempIMG = editPhotoWithMask(background: tempIMG!, filterTo: actualLocalFilter, maskImage: localAdjustmentsImage[localAdjustmentsImage.count-1])
                
                if self.canvasList.count > 0 {
                    for i in 0...self.canvasList.count-1{
                        autoreleasepool {
                            
                     
                            tempIMG = self.editPhotoWithMask(background: tempIMG!, filterTo: self.localAdjustmentsFilters[i], maskImage: localAdjustmentsImage[i])
                        }
                    }
                }
   
                
                localLocation.append(resultImages.count-1)
              
                imageViewIMG.image = editPhoto(toFilterIMG: tempIMG!, filterTo: self.savedEditValueSession)
                
                
                changeEditLabel(option: editOptionValue)
                
                //REMOVE ESTA VERSAO DO CANVAS DA TELA
                self.actualCanvas!.backgroundColor = UIColor.clear
                //actualCanvas!.lines.removeAll()
                actualCanvas!.removeFromSuperview()
            }else{
                
                
                
                
                
                if pointsSaved.count > 0 {
                for i in 0...pointsSaved.count-1{
                    pointsSaved[i].alpha = 0
                    }}
                
                
                isCanvasThere = true
                actualLocalFilter =  [0,0.25,1,1,0,6500,0,0,0.02,0,0,0]
                changeEditLabel(option: editOptionValue)
                drawTheMaskLabel.alpha = 0.7
                UIView.animate(withDuration: 0.8, delay: 0, options: [.autoreverse,.curveEaseIn,.repeat], animations: {
                    self.drawTheMaskLabel.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)
                }) { (false) in
                    
                }
                
                
                
                doneCanvasButton.setImage(UIImage(named:"verified"), for: .normal)
                cancelCanvasButton.alpha = 1
                
                
                let canvas = Canvas()
                actualCanvas = canvas
                newImageBig.addSubview(actualCanvas!)
                actualCanvas!.backgroundColor = UIColor.clear
                actualCanvas!.frame = newImageBig.frame
                actualCanvas!.alpha = 1
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
    @IBAction func cancelCanvasAction(_ sender: Any) {
        if imageViewIMG.image != nil {
            drawTheMaskLabel.layer.removeAllAnimations()
            drawTheMaskLabel.alpha = 0
            isCanvasThere = false
            actualCanvas!.lines.removeAll()
            actualCanvas!.removeFromSuperview()
            doneCanvasButton.setImage(UIImage(named:"add"), for: .normal)
            cancelCanvasButton.alpha = 0
           tempIMG = resultImages[resultImages.count-1]
            
            
            tempIMG = self.editPhoto(toFilterIMG: tempIMG!, filterTo: self.savedEditValueSession)
            
            if self.canvasList.count > 0 {
                for i in 0...self.canvasList.count-1{
                    autoreleasepool {
                        
                        
                        tempIMG = self.editPhotoWithMask(background: tempIMG!, filterTo: self.localAdjustmentsFilters[i], maskImage: localAdjustmentsImage[i])
                    }
                }
            }
            
            imageViewIMG.image = tempIMG
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Status bar branca! Para contrastar com o aplicativo escuro. Caso contrário fica quase impossível de enxergar a barra de status
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func learnGoToView(_ sender: Any) {
        
        
        if menuPresent == false {
            let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: learnCollection)
            if let indexPath = learnCollection.indexPathForItem(at: hitPoint) {
                essayNumber = indexPath[1]
            }
            
            //Muda o viewController
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "essayViewController") as? essayViewController
            // self.navigationController?.pushViewController(vc!, animated: true)
            vc?.modalTransitionStyle = .coverVertical
            present(vc!, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    @IBAction func selectFiltersType(_ sender: Any) {
        //CollectionView A dos filtros...tipo de filtro
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: filterCollectionViewA)
        if let indexPath = filterCollectionViewA.indexPathForItem(at: hitPoint) {
            
            
            if filtersType == indexPath[1]  {
                //Impede que este código fique repetindo
            }else if filtersType != indexPath[1] && imageViewIMG.image != nil {
                filtersType = indexPath[1]
                reloadFiltersData()
                
                
            }
        }
        
        
        
        
    }
    
    
     //Selecionar filtro específico ou efeito para TESTAR, não aplica definitivamente. Aqui ainda permite editar porcentagem do filtro, etc
    @IBAction func selectFilter(_ sender: Any) {
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: filtersCollectionViewB)
        
        if imageViewIMG.image != nil{
            if let indexPath = filtersCollectionViewB.indexPathForItem(at: hitPoint) {
                
                
                
                if filtersType != 3 {
                    //FILTROS
              
                    lastFilter[0] = filtersType
                    lastFilter[1] = indexPath[1]
                    
                    print(lastFilter)
                    percentageFilterSlider.minimumValue = 0
                    percentageFilterSlider.maximumValue = 20
                    percentageFilterSlider.value = Float(filtersSavedPercentage[lastFilter[0]][lastFilter[1]])
                    
                    
                    imageViewIMG.image = filtersPreviewApply(imgToUse: tempIMG!, filterType: lastFilter[0], filterNumber: lastFilter[1], toImage: true, percentage:    percentageFilterSlider.value)
                    
                   
                    sliderFilterView.alpha = 1
                    
                
                    
                }else{
                    //EFEITOS ESPECIAIS
                    lastFilter[0] = filtersType
                    lastFilter[1] = indexPath[1]
                    
                    
                    sliderFilterView.alpha = 1
                    percentageFilterSlider.isUserInteractionEnabled = true
                    percentageFilterSlider.alpha = 1
                    
                    percentageFilterSlider.minimumValue = effectsAmountMinAndMax[indexPath[1]][0]
                    percentageFilterSlider.maximumValue = effectsAmountMinAndMax[indexPath[1]][1]
                    percentageFilterSlider.value = percentageFilterSlider.minimumValue
                    
                    imageViewIMG.image = applyEffect(imgToUse:resultImages[resultImages.count-1], amount: CGFloat(percentageFilterSlider!.value), effectToApply: lastFilter[1] )
                    
                    
                    
                }
                
                
                
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    //Possibilita importar imagem
    func importImage(){
        PHPhotoLibrary.requestAuthorization { (status) in
            // No crash
        }
        
        imagePicker.sourceType = .photoLibrary
        //Coloquei para falso o allowsEditing pois esta opção estava limitando a qualidade da imagem
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true,completion: nil)
    }
    
    
    
    
    //Botão para importar imagem
    @IBAction func importImgAction(_ sender: Any) {
        importImage()
    }
    
    
    
    @objc func multipleTap(_ sender: UIButton, event: UIEvent) {
        if imageViewIMG.image != nil && isAdjustingLocal == false {
            let touch: UITouch = event.allTouches!.first!
            if (touch.tapCount == 2) {
                if imageZoomView.zoomScale == 1 {
                    
                    //   imageZoomView.setZoomScale(4, animated: true)
                    imageZoomView.zoom(to: CGRect(x: touch.location(in: imageZoomView).x-50, y: touch.location(in: imageZoomView).y-50, width: 100, height: 100), animated: true)
                    
                }else{
                    imageZoomView.setZoomScale(1, animated: true)
                }
            }
        }
    }
    
    @objc func resetSliderDoubleTap(_ sender: UISlider, event: UIEvent) {
        
        var currentBaseFilter: [Float]
        
        if isAdjustingLocal == true {
            currentBaseFilter = [0,0.25,1,1,0,6500,0,0,0.02,0,0,0]
        }else{
            currentBaseFilter = [0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1]
        }
        
        sender.cancelTracking(with: nil)
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            sender.value = currentBaseFilter[editOptionValue]
            
        }
        if imageViewIMG.image != nil{
            self.sliderChanged(sender)
        }
        
    }
    
    
    //Importar imagem ou ver imagem importada sem edição (Este botão fica em cima da ImageView)
    @IBAction func newImageBig(_ sender: Any) {
        
        if imageViewIMG.image == nil {
            importImage()
        }else{
            
            
            
            
            //Preciso pensar quando um filtro foi aplicado, alterou o savedEditValueSession e depois o usuário faz o Undo
            //        imageViewIMG.image = resultImages[resultImages.count-1]
            
            
            //CODIGO COMENTADO PARA TESTES
            
            /*
             if resultImages.count-2 >= 0 {
             imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-2], filterTo: savedEditValueSession)
             }else{
             imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-1], filterTo: savedEditValueSession)
             }
             */
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //Exportar imagem
    @IBAction func exportImg(_ sender: Any) {
        
        if self.imageViewIMG.image != nil{
            
            UIView.animate(withDuration: 0.2, animations: {
                self.exportView.center = CGPoint(x: self.exportView.center.x, y: self.exportView.center.y+self.exportView.frame.height)
            }, completion: { (true) in
                
                
                var x: UIImage? = self.fullResolutionImage
                /*  let y = self.appliedFilters[self.appliedFilters.count-1]
                 
                 if y[0] != -999 {
                 self.appliedFilters.removeLast()
                 }
                 */
                if self.appliedFilters.count-1 >= 0{
                    
                    
                    for i in 0...self.appliedFilters.count-1{
                        autoreleasepool {
                            
                            if self.appliedFilters[i][0] == -999 {
                                
                                x = self.applyEffect(imgToUse:x!, amount: CGFloat(self.appliedFilters[i][9]), effectToApply: Int(self.appliedFilters[i][8]))
                            }else{
                                
                                x = self.editPhoto(toFilterIMG: x!, filterTo: self.appliedFilters[i])
                                
                            }
                        }
                        
                    }
                    
                }
                
                
                //FOTO PRONTA PÓS FILTROS:
                x = self.editPhoto(toFilterIMG: x!, filterTo: self.savedEditValueSession)
                
                /*
                 if y[0] != -999 {
                 self.appliedFilters.append(y)
                 }
                 
                 */
                
              
                
               
                
                //FOR PARA A APLICAÇÃO DE FILTROS LOCAIS
                if self.canvasList.count > 0 {
         for i in 0...self.canvasList.count-1{
              autoreleasepool {
          
                self.canvasList[i].backgroundColor = UIColor.black
                let renderer = UIGraphicsImageRenderer(size: self.imageViewIMG.bounds.size)
                let image = renderer.image { ctx in
                    self.canvasList[i].drawHierarchy(in: self.imageViewIMG.bounds, afterScreenUpdates: true)
                }
                
                self.canvasList[i].backgroundColor = UIColor.clear
                let test = image.cgImage
                
                let xxx  = self.resizeImage(image: UIImage(cgImage: test!), targetSize: self.importedImage!.size)
                let png = xxx.pngData()
                let finalImage = UIImage(data: png!)
                
                
                x = self.editPhotoWithMask(background: x!, filterTo: self.localAdjustmentsFilters[i], maskImage: finalImage!)
            }
         }
                }
                
                
                UIImageWriteToSavedPhotosAlbum(x!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
                
                
                self.exportingLabel.text = "DONE"
                
                UIView.animate(withDuration: 0.2, delay: 0.85, options: [], animations: {
                    self.exportView.center = CGPoint(x: self.exportView.center.x, y: self.exportView.center.y-self.exportView.frame.height)
                }, completion: { (true) in
                    self.exportingLabel.text = "EXPORTING..."
                })
                
                
                
            })
        }
        
    }
    
    
    
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    //AVISO IMAGEM EXPORTACAO
    func showAlertWith(title: String, message: String){
        //  let ac = UIAlertController(title: "YEAH", message: "The image was saved successfully", preferredStyle: .alert)
        
        //  ac.addAction(UIAlertAction(title: "OK", style: .default))
        //  present(ac, animated: true)
    }
    //Fim da parte que salva a imagem
    
    
    
    
    
    @IBAction func colorEditionPanel(_ sender: Any) {
        
        
        
    }
    
    @IBAction func proCameraBtAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {self.redViewSelector.center = CGPoint(x:self.proCameraBt.center.x,y:self.redViewSelector.center.y)})
        optionNumber = 4
        if canGoToCamera == true {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProCameraViewController") as? ProCameraViewController
            // self.navigationController?.pushViewController(vc!, animated: true)
            vc?.modalTransitionStyle = .coverVertical
            present(vc!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func LearnBtAction(_ sender: Any) {
        //Muda a posição do seletor vermelho para a opção do conteúdo de fotografia
        UIView.animate(withDuration: 0.2, animations: {self.redViewSelector.center = CGPoint(x:self.learnBt.center.x,y:self.redViewSelector.center.y)})
        
        optionNumber = 1
        animateOptionMenu(option: 1)
        
    }
    @IBAction func FilterBtAction(_ sender: Any) {
        //Muda a posição do seletor vermelho para a opção dos filtros disponíveis
        UIView.animate(withDuration: 0.2, animations: {self.redViewSelector.center = CGPoint(x:self.filterBt.center.x,y:self.redViewSelector.center.y)})
        optionNumber = 2
        animateOptionMenu(option: 2)
    }
    @IBAction func EditBtAction(_ sender: Any) {
        //Muda a posição do seletor vermelho para a opção de editar uma imagem
        UIView.animate(withDuration: 0.2, animations: {self.redViewSelector.center = CGPoint(x:self.editBt.center.x,y:self.redViewSelector.center.y)})
        
        optionNumber = 3
        animateOptionMenu(option: 3)
    }
    
    
    
    //Verifica a permissão de utilizar a câmera
    func verifyPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            //Se o acesso estiver permitido cria a sessão
            print("Camera Autorizada")
            canGoToCamera = true
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.canGoToCamera = true
                        print("Camera Autorizada")
                    }}}
        case .restricted:
            canGoToCamera = false
            print("r")
        case .denied:
            canGoToCamera = false
            print("n")
        }
        
    }
    
    func checkPermission() {
        //Essa função serve para conferir se o usuário permitiu o acesso às fotos, caso não, o acesso vai ser pedido
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({
            (newStatus) in print("o")
            
            if newStatus == PHAuthorizationStatus.authorized { print("success") }
        })
        case .restricted:  print("User do not have access to photo album.")
        case .denied:  print("User has denied the permission.")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func sliderChanged(_ sender: Any){
        
        if imageViewIMG.image != nil {
            
            
            
            if abs(max(lastSliderValue, actualSliderValue) - min(lastSliderValue, actualSliderValue)) > (editSlider.maximumValue - editSlider.minimumValue)/40  {
                
                if  isAdjustingLocal == false {
                    
                    
                    if editOptionValue == 10{
                        savedEditValueSession[10] = editSlider.value
                        savedEditValueSession[11] = secondEditSlider.value
                        savedEditValueSession[12] = thirdEditSlider.value
                       
                    }else if editOptionValue == 8{
                        savedEditValueSession[8] = editSlider.value
                        savedEditValueSession[13] = secondEditSlider.value
                        
                    }else{
                        savedEditValueSession[editOptionValue] = editSlider.value
                        //  lastSliderValue = editSlider.value
                    }
                    actualSliderValue = editSlider.value
                    
                 //   if resultImages.count-2 >= 0 {
                        
                    imageViewIMG.image = editPhoto(toFilterIMG: tempIMG!, filterTo: savedEditValueSession)
                 //   }else{
                  //      imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-1], filterTo: savedEditValueSession)
                        
                 //   }
                    
                    
                    print(editSlider.value)
                }else{
                    //
                    //FILTROS LOCAIS:
                    //
                    actualCanvas!.alpha = 1
                    
                    if  lastLineArraySize != actualCanvas!.lines.count {
                        localAdjustTemporaryImage = newImageFromMask()
                    }
                    if  localAdjustTemporaryImage == nil {
                        localAdjustTemporaryImage = newImageFromMask()
                    }
                    
                    actualCanvas!.alpha = 0
                    lastLineArraySize = actualCanvas!.lines.count
                    
                    
                    
                    actualLocalFilter[editOptionValue] = editSlider.value
                    lastSliderValue = editSlider.value
                    
                   
                 //   if resultImages.count-2 >= 0 {
                        imageViewIMG.image = editPhotoWithMask(background: editPhoto(toFilterIMG: tempIMG!, filterTo: self.savedEditValueSession), filterTo: actualLocalFilter, maskImage: localAdjustTemporaryImage!)
                        
                        // imageViewIMG.image = editPhotoWithMask(background: resultImages[resultImages.count-2], filterTo: actualLocalFilter, maskImage: localAdjustTemporaryImage!)
                //    }else{
                 //       imageViewIMG.image = editPhotoWithMask(background: resultImages[resultImages.count-1], filterTo: actualLocalFilter, maskImage: localAdjustTemporaryImage!)
                        
                //    }
                    
                    
                }
                
            }
            lastSliderValue = editSlider.value
            // actualSliderValue = editSlider.value
 
            
        }
        
    }
    
    
    func newImageFromMask() -> UIImage{
        self.actualCanvas!.backgroundColor = UIColor.black
        let renderer = UIGraphicsImageRenderer(size: self.imageViewIMG.bounds.size)
        var image = renderer.image { ctx in
            self.actualCanvas!.drawHierarchy(in: self.imageViewIMG.bounds, afterScreenUpdates: true)
        }
        
        self.actualCanvas!.backgroundColor = UIColor.clear
        let test = image.cgImage
        var xxx = UIImage(cgImage: test!, scale: imageViewIMG.image!.scale, orientation: imageViewIMG.image!.imageOrientation)
        xxx  = self.resizeImage(image: xxx, targetSize: imageViewIMG.image!.size)
        
        return xxx
        
        
    }
    
    
    @IBAction func editSlider2Changed(_ sender: Any) {
        if imageViewIMG.image != nil {
            if editOptionValue == 10{
                savedEditValueSession[10] = editSlider.value
                savedEditValueSession[11] = secondEditSlider.value
                savedEditValueSession[12] = thirdEditSlider.value
                print(savedEditValueSession)
            }else if editOptionValue == 8{
                savedEditValueSession[8] = editSlider.value
                savedEditValueSession[13] = secondEditSlider.value
            }
            
            imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-1], filterTo: savedEditValueSession)
            
            print(secondEditSlider.value)
        }
    }
    
    
    
    @IBAction func thirdSliderChanged(_ sender: Any) {
        if imageViewIMG.image != nil {
            if editOptionValue == 10{
                savedEditValueSession[10] = editSlider.value
                savedEditValueSession[11] = secondEditSlider.value
                savedEditValueSession[12] = thirdEditSlider.value
                print(savedEditValueSession)
            }
            
            imageViewIMG.image = editPhoto(toFilterIMG: resultImages[resultImages.count-1], filterTo: savedEditValueSession)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //O método .zoomScale envolve uma chamada para a função viewForZooming, ou seja, caso for chamado neste função inclui um loop de recursão infinito e resulta num crash
        var x = imageZoomView.zoomScale
        
        
        newImageBig.frame.size = CGSize(width:  initialImageButtonSize.width*x, height: initialImageButtonSize.height*x)
        actualCanvas!.frame.size = CGSize(width:  initialImageButtonSize.width*x, height: initialImageButtonSize.height*x)
        
    }
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        
        return imageViewIMG
        
        
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began: break
            // handle drag began
            case .moved: break
            // handle drag moved
            case .ended:
                if actualCanvas != nil && imageViewIMG.image != nil && isAdjustingLocal == true {
                    actualCanvas!.alpha = 1
                }
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        
        
        // self.editCollectionView.center = CGPoint(x: view.frame,y: 540+self.editCollectionView.frame.height/2)
        
        
        cancelCanvasButton.alpha = 0
        doneCanvasButton.alpha = 0
        
        
        editIconsToUse = editIcons
        editLabelsTextToUse = editLabelsText
        
        
        buttonsView.center = CGPoint(x: view.frame.width*1.5, y: buttonsView.center.y)
        
        
        hueSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        saturationSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        luminanceSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        
        
        colorsToolView.alpha = 0
        imageZoomView.minimumZoomScale = 1
        imageZoomView.maximumZoomScale = 1
        newImageBig.addTarget(self, action: #selector(multipleTap(_:event:)), for: UIControl.Event.touchDownRepeat)
        editSlider.addTarget(self, action: #selector(resetSliderDoubleTap(_:event:)), for: UIControl.Event.touchDownRepeat)
        editSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        
        initialImageButtonSize = newImageBig.frame.size
        
        //Delegates
        imagePicker.delegate = self
        
        imageZoomView.delegate = self
        
        filterCollectionViewA.dataSource = self
        filterCollectionViewA.delegate = self
        
        learnCollection.dataSource = self
        learnCollection.delegate = self
        
        
        editCollection.delegate = self
        editCollection.dataSource = self
        
        filtersCollectionViewB.delegate = self
        filtersCollectionViewB.dataSource = self
        
        //Coloca o histograma na posição correta já
        histogramView.alpha = 0
        
        
        secondEditSlider.alpha = 0
        secondEditLabel.alpha = 0
        editSlider.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/2.7)
        editOptionLabel.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/2.9-editOptionLabel.frame.height*1.5)
        
        
        //Inicia com o texto correto no label da parte de edição
        editOptionLabel.text = editLabelsText[0]
        
        
        //Confirma se existe permissão para utilizar a galeria de fotos, caso não, a permissão será pedida
        checkPermission()
        //Permissão para câmera
        verifyPermission()
        
        
        //Borda arredondada nos dois botões dos filtros (import e save)
        importBt.layer.cornerRadius = 8
        saveBt.layer.cornerRadius = 8
        brushButton.layer.cornerRadius = 8
        undoFilterButton.layer.cornerRadius = 8
        editToolsButtonChange.layer.cornerRadius = 8
        colorsButton.layer.cornerRadius = 8
        settings.layer.cornerRadius = 30
        resetFilters.layer.cornerRadius = 8
        settingsDoneButton.layer.cornerRadius = 8
        //Deixa o View com os filtros fora da tela principal
        self.filtersPrincipalView.center = CGPoint(x: -self.filtersPrincipalView.frame.width*1.5,y: self.filtersPrincipalView.frame.height/2)
        
        self.filtersCollectionView.center = CGPoint(x: self.filtersCollectionView.frame.width*1.5, y: 538+self.filtersCollectionView.frame.height/2)
        
        
        self.editCollectionView.center = CGPoint(x: self.editCollectionView.frame.width*1.5, y: 538+self.editCollectionView.frame.height/2)
        
        self.buttonsView.center = CGPoint(x: self.editCollectionView.frame.width*1.5, y: self.imageZoomView.center.y + self.imageZoomView.frame.height*0.5 + self.buttonsView.frame.height)
        
        self.learnView.center = CGPoint(x: self.learnView.frame.width/2, y: self.learnView.frame.height/2)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        if collectionView == filterCollectionViewA {
            // Return number of hashtags
            returnValue = filtersImagesA.count
        }
        
        if collectionView == editCollection {
            returnValue = editIconsToUse.count
        }
        
        if collectionView == filtersCollectionViewB {
            returnValue = filtersImagesB.count
        }
        
        if collectionView ==  learnCollection{
            
            return learnPhotos.count
        }
        
        return returnValue
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == filterCollectionViewA {
            // Place content into hashtag cells
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell1
            
            
            cell.filtersImage1.setBackgroundImage(filtersImagesA[indexPath.item], for: .normal)
            
            return cell
        } else if collectionView == editCollection {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! CollectionViewCell3
            
            cell.cell3icon.setBackgroundImage(editIconsToUse[indexPath.item], for: .normal)
            
            
            
            
            return cell
            
        } else if collectionView == filtersCollectionViewB {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! CollectionViewCell2
            
            //Creio que não vou deixar nenhuma imagem no segundo collection de filtros, apenas quando o usuario inserir uma imagem, por isso o IF abaixo:
            
            if imageViewIMG.image != nil{
                cell.filtersIconB.imageView!.contentMode = .scaleAspectFit
                cell.filtersIconB.setImage(filtersImagesB[indexPath.item], for: .normal)
                
                
            }
            
            
            
            
            return cell
            
        }else if collectionView == learnCollection {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "learnCell", for: indexPath) as! learnCollectionViewCell
            
            //cell.learnImage.image = learnPhotos[indexPath.item]
            
            //Aplica o efeito BLUR nas imagens da LearnCollectionView
           // let context = CIContext(options: nil)
           // blurFilter!.setValue(20, forKey: "inputRadius")
           // blurFilter!.setValue(CIImage(cgImage: learnPhotos[indexPath.item].cgImage!), forKey: "inputImage")
           // let outputImage2 = blurFilter?.outputImage!
            
           // let cgimg = context.createCGImage(outputImage2!, from: outputImage2!.extent)
            cell.learnImage.image = learnPhotos[indexPath.item]
            //Fim da aplicação do filtro blur.
            
            //Coloca o título do Essay
            cell.learnLabel1.text = learnLabel[indexPath.item]
            cell.learnLabel1.alpha = 0.9
            
            //BlackView que fica em cima das imagens para deixa-las mais escuras
           cell.learnBlackView.backgroundColor = UIColor.black
            cell.learnBlackView.alpha = 0.45
            
            //Borda arredondada
           cell.layer.cornerRadius = 20
           cell.layer.masksToBounds = true
            
            //Sombra vermelha
          //  cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
          //  cell.layer.shadowRadius = 1.5
          //  cell.layer.shadowOpacity = 0.5
         //   cell.layer.masksToBounds = false
            // cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 20).cgPath
         //   cell.layer.shadowColor = UIColor.red.cgColor
            
            
            
            return cell
            
        } else {
            preconditionFailure("Unknown collection view!")
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //Função complementar da função abaixo, serve para ajustar a posição dos sliders dependendo do número de sliders ativos....1 ou 2 por enquanto
    func adjustSliderPosition(value: Int){
        if value == 1 {
            if isAdjustingLocal == true {
                secondEditSlider.maximumTrackTintColor =  UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
                editSlider.maximumTrackTintColor = UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
                editSlider.transform = CGAffineTransform(scaleX: 1, y: 1)
                editOptionLabel.alpha = 1
                secondEditSlider.alpha = 0
                secondEditLabel.alpha = 0
                thirdEditSlider.alpha = 0
                editSlider.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/1.8)
                editOptionLabel.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/2-editOptionLabel.frame.height*1.5)
            }else{
                secondEditSlider.maximumTrackTintColor =  UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
                editSlider.maximumTrackTintColor = UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
                editSlider.transform = CGAffineTransform(scaleX: 1, y: 1)
                editOptionLabel.alpha = 1
                secondEditSlider.alpha = 0
                secondEditLabel.alpha = 0
                thirdEditSlider.alpha = 0
                editSlider.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/2.7)
                editOptionLabel.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/2.9-editOptionLabel.frame.height*1.5)
            }
        }else if value == 2{
            secondEditSlider.maximumTrackTintColor =  UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
            editSlider.maximumTrackTintColor = UIColor(red:0.24, green:0.00, blue:0.03, alpha:1.0)
            
            editSlider.transform = CGAffineTransform(scaleX: 1, y: 1)
            secondEditSlider.transform = CGAffineTransform(scaleX: 1, y: 1)
            editOptionLabel.alpha = 1
            secondEditSlider.alpha = 1
            secondEditLabel.alpha = 1
            thirdEditSlider.alpha = 0
            
            editSlider.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/1.8+editSlider.frame.height/4)
            editOptionLabel.center = CGPoint(x: editSlider.center.x, y: editCollectionView.frame.height/1.8+editSlider.frame.height/4-editOptionLabel.frame.height*1.7)
            secondEditSlider.center = CGPoint(x: secondEditSlider.center.x, y: editCollectionView.frame.height/3.75)
            secondEditLabel.center = CGPoint(x: secondEditSlider.center.x, y: editCollectionView.frame.height/3.75-secondEditSlider.frame.height+secondEditLabel.frame.height*0.35)
        }else if value == 3{
            secondEditSlider.alpha = 1
            secondEditLabel.alpha = 1
            thirdEditSlider.alpha = 1
            secondEditLabel.alpha = 0
            editOptionLabel.alpha = 0
            
            editSlider.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            secondEditSlider.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            thirdEditSlider.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            editSlider.center = CGPoint(x: secondEditSlider.center.x, y: editSlider.frame.height*1.3)
            
            
            secondEditSlider.center = CGPoint(x: editSlider.center.x, y: editSlider.frame.height*2.7)
            
            
            thirdEditSlider.center = CGPoint(x: secondEditSlider.center.x, y: editSlider.frame.height*4.2)
            
            
        }
    }
    
    
    
    
    
    //Essa função serve para preparar os sliders na seção edit toda vez que o usuário muda o parâmetro de edição (exposure, shadows, highlights)....
    func changeSliderValues(value: Int){
        if value == 0{
            
            if isAdjustingLocal == false {
                editSlider.minimumValue = -2.5
                editSlider.maximumValue = 2.5
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = -1
                editSlider.maximumValue = 1
                adjustSliderPosition(value: 1)
            }
            
            
        } else if value == 1{
            if isAdjustingLocal == false {
                editSlider.minimumValue = -1
                editSlider.maximumValue = 1
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = 0
                editSlider.maximumValue = 2
                adjustSliderPosition(value: 1)
            }
            
        }else if value == 2{
            
            if isAdjustingLocal == false {
                editSlider.minimumValue = 0
                editSlider.maximumValue = 2
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = 0
                editSlider.maximumValue = 2
                adjustSliderPosition(value: 1)
            }
            
        }else if value == 5{
            
            if isAdjustingLocal == false {
                editSlider.minimumValue = -0.8
                editSlider.maximumValue = 1.6
                adjustSliderPosition(value: 1)
            }else{
                //Temperatura
                editSlider.minimumValue = 2500
                editSlider.maximumValue = 10500
                adjustSliderPosition(value: 1)
            }
            
        }else if value == 3{
            if isAdjustingLocal == false {
                editSlider.minimumValue = 0
                editSlider.maximumValue = 2
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = 0.85
                editSlider.maximumValue = 1.2
                adjustSliderPosition(value: 1)
            }
            
        }else if value == 4{
            if isAdjustingLocal == false {
                editSlider.minimumValue = 0.85
                editSlider.maximumValue = 1.2
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = -0.8
                editSlider.maximumValue = 1.6
                adjustSliderPosition(value: 1)
            }
            
        }else if value == 6{
            if isAdjustingLocal == false {
                //Temperatura
                editSlider.minimumValue = 2500
                editSlider.maximumValue = 10500
                adjustSliderPosition(value: 1)
            }else{
                editSlider.minimumValue = 0
                editSlider.maximumValue = 1
                adjustSliderPosition(value: 1)
            }
            
            
        }else if value == 7{
            if isAdjustingLocal == false {
                editSlider.minimumValue = 0
                editSlider.maximumValue = 1
                adjustSliderPosition(value: 1)
            }else{
                adjustSliderPosition(value: 1)
                editSlider.minimumValue = 0
                editSlider.maximumValue = 7
            }
            
        }else if value == 8{
            if isAdjustingLocal == false {
                adjustSliderPosition(value: 2)
                secondEditLabel.text = editLabels2Text[0]
                secondEditSlider.value = savedEditValueSession[13]
                
                editSlider.minimumValue = 0
                editSlider.maximumValue = 7
                
                secondEditSlider.minimumValue = 0
                secondEditSlider.maximumValue = 2
            }else{
                adjustSliderPosition(value: 1)
                
                editSlider.minimumValue = 0.02
                editSlider.maximumValue = 0.1
            }
            
            
            
        }else if value == 9{
            if isAdjustingLocal == false {
                adjustSliderPosition(value: 1)
                
                editSlider.minimumValue = 0.02
                editSlider.maximumValue = 0.1
            }else{
                //10
            }
            
            
        }else if value == 10{
            adjustSliderPosition(value: 3)
            
            editSlider.minimumValue = 0
            editSlider.maximumValue = 1
            
            secondEditSlider.minimumValue = 0
            secondEditSlider.maximumValue = 1
            
            thirdEditSlider.minimumValue = 0
            thirdEditSlider.maximumValue = 1
            editSlider.maximumTrackTintColor = UIColor(red:0.65, green:0.17, blue:0.11, alpha:0.7)
            secondEditSlider.maximumTrackTintColor = UIColor(red:0.00, green:0.56, blue:0.05, alpha:0.7)
            thirdEditSlider.maximumTrackTintColor = UIColor(red:0.00, green:0.15, blue:0.73, alpha:0.7)
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func editSelector(_ sender: Any) {
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: editCollection)
        if let indexPath = editCollection.indexPathForItem(at: hitPoint) {
            changeEditLabel(option: indexPath[1])
        }
        
    }
    
    
    func changeEditLabel(option: Int){
        editOptionValue = option
        changeSliderValues(value: editOptionValue)
        
        if isAdjustingLocal == false {
            //nao esta sendo feito ajustes locais, por isso segue a ordem normal
            
            
            
            if editOptionValue == 10{
                editSlider.value =  savedEditValueSession[10]
                secondEditSlider.value = savedEditValueSession[11]
                thirdEditSlider.value =  savedEditValueSession[12]
                
            }else if editOptionValue == 8{
                editSlider.value = savedEditValueSession[8]
                secondEditSlider.value = savedEditValueSession[13]
                
            }else{
                editSlider.value = savedEditValueSession[editOptionValue]
            }
            
        }else{
            //esta sendo feito ajustes locais
            editSlider.value = actualLocalFilter[editOptionValue]
            
        }
        
        
        lastSliderValue = editSlider.value
        editOptionLabel.text = editLabelsTextToUse[editOptionValue]
        
    }
    
    
    
    
    
    
    
    
    
    
    
}




//Extensão que cuida da parte de abrir uma nova imagem
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let possibleImage = info[.editedImage] as? UIImage {
            importedImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            importedImage = possibleImage
            
        } else {
            return
        }
        
        //Limpa o histórico de filtros e imagens
        appliedFilters.removeAll()
        resultImages.removeAll()
        localAdjustmentsFilters.removeAll()
        canvasList.removeAll()
        pointsSaved.removeAll()
        //Limpa todas as subviews do imageBig
        for view in self.newImageBig.subviews {
            view.removeFromSuperview()
        }
        
        
        appliedFilters.append([0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1])
        
    
        
        let ratioMin = min(CGFloat(qualityOfVisualization)/importedImage!.size.width, CGFloat(qualityOfVisualization)/importedImage!.size.height)
        
        let ratioMinMini = min(220/importedImage!.size.width, 220/importedImage!.size.height)
        //Coloca a nova imagem selecionada na imageView principal
        imageViewIMG.contentMode = .scaleAspectFit
        
        imageViewIMG.image = resizeImage(image: importedImage!, targetSize: CGSize(width: importedImage!.size.width*ratioMin, height: importedImage!.size.height*ratioMin))
        
        
        
        
        filterButtonMiniImg = resizeImage(image: importedImage!, targetSize: CGSize(width: importedImage!.size.width*ratioMinMini, height: importedImage!.size.height*ratioMinMini))
        
        //Ativa o zoom na imageView
        imageZoomView.minimumZoomScale = 1
        imageZoomView.maximumZoomScale = 10
        
        
   
     
        
        //definido as principais variáveis do programa:
        //mais importante
        fullResolutionImage = importedImage!
        UIImageImported = imageViewIMG.image!
        resultImages.append(UIImageImported!)
        aCGImage = imageViewIMG.image!.cgImage!
        aCIImage = CIImage(cgImage: aCGImage!)
        globalImage = UIImageImported
        tempIMG = UIImageImported
        
        
        isPaintingLocal = false
        editToolsButtonChange.alpha = 1
        editToolsButtonChange.isUserInteractionEnabled = true
        resetFilters.alpha = 1
        resetFilters.isUserInteractionEnabled = true
        undoFilterButton.alpha = 1
        undoFilterButton.isUserInteractionEnabled = true
        undoFilterButton.isUserInteractionEnabled = true
        cropButton.alpha = 1
        cropButton.isUserInteractionEnabled = true
        redoButton.alpha = 1
        redoButton.isUserInteractionEnabled = true
        
        
        //Parte extremamente importante para o design do aplicativo! Vai centralizar o grupo imageView + ButtonView de acordo com o tamanho da imagem. A área livre é a área entre a view do topo (com o logo) e a view dos filtros.
        
        //INÍCIO:
        let ratio = UIImageImported!.size.width/UIImageImported!.size.height
        
        //r = w/h
        //w = r*h
        //h = w/r
        
        
        
        
        newImageBig.alpha = 1
        newImageBig.setTitle("", for: .normal)
        newImageBig.backgroundColor = UIColor.clear
        
        imageZoomView.frame.size = CGSize(width: view.frame.width, height: imageZoomView.frame.height)
        
        let aaa = filtersCollectionView.center.y-(filtersCollectionView.frame.height*0.5)
        let aab = topView.center.y + (topView.frame.height*0.5)
        let aac = buttonsView.frame.height*0.5
        
        //30 é espaçamento limite
        let maxHeigthPossible = abs(aaa-aab-2*aac-30)
        
        let actualHeight = imageZoomView.frame.width/ratio
        print(actualHeight)
        
        
        if actualHeight > maxHeigthPossible {
            imageZoomView.frame.size = CGSize(width: imageZoomView.frame.width, height: maxHeigthPossible)
            
            imageViewIMG.frame.size = CGSize(width: imageViewIMG.frame.width, height: maxHeigthPossible)
            
            newImageBig.frame.size = CGSize(width: newImageBig.frame.width, height: maxHeigthPossible)
            
        }else{
            
            imageZoomView.frame.size = CGSize(width: imageZoomView.frame.width, height: imageZoomView.frame.width/ratio)
            
            imageViewIMG.frame.size = CGSize(width: imageViewIMG.frame.width, height: imageViewIMG.frame.width/ratio)
            
            newImageBig.frame.size = CGSize(width: newImageBig.frame.width, height: newImageBig.frame.width/ratio)
            
        }
        
        
        
        imageZoomView.center = CGPoint(x: imageZoomView.center.x, y: (aaa+aab-aac)/2)
        
        buttonsView.center = CGPoint(x: imageZoomView.center.x, y: imageZoomView.center.y + imageZoomView.frame.height*0.5 + buttonsView.frame.height)
        
        //FIM
        
        
        //CANVAS IMPORTANTE
        //CANVAS DRAW
        /*
         let canvas = Canvas()
         actualCanvas = canvas
         newImageBig.addSubview(actualCanvas!)
         actualCanvas!.backgroundColor = UIColor.clear
         actualCanvas!.frame = newImageBig.frame
         actualCanvas!.alpha = 1
         */
        
        if actualCanvas != nil {
            actualCanvas?.removeFromSuperview()
        }
        
        sliderFilterView.alpha = 0
        
        filtersSavedPercentage = [[20,20,20,20,20,20,20,20],[20,20,20,20],[20,20,20,20]]
        
        
        
        
        
        
        
        
        
        
        
        //Botão vai servir agora para mostrar a imagem original
        //alpha precisa ser no mínimo 0.01 para o touch funcionar, caso contrario a interação será ignorada
        // newImageBig.alpha = 0.011
        newImageBig.isEnabled = true
        
        
        imageViewIMG.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.0)
        imageViewIMG.alpha = 1
        
        
        
        //retorna os valores iniciais para edição
        savedEditValueSession = [0,0,1,1,1,0,6500,0,0,0.02,0,0,0,1]
        
        changeEditLabel(option: 0)
        
        isPhotoThere = true
        
        reloadFiltersData()
        
        dismiss(animated: true)
        
        
        print("IMG 3 \(imageViewIMG.frame.size)")
        print("BUTTON  3\(newImageBig.frame.size)")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Controla a aplicação dos filtros nos botões do collectionView
    func reloadFiltersData(){
        
        
        if filtersType == 0 {
            //Easy Resize for number of filters in filtersType 0
            filtersImagesB = [UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!]
        }else if filtersType == 1{
            filtersImagesB = [UIImage(named: "bew")!]
            
        }else if filtersType == 2{
            filtersImagesB = [UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!,UIImage(named: "bew")!]
            
        }else if filtersType == 3{
            filtersImagesB = [UIImage(named: "bew")!]
            
        }
        
        
        
        
        
        if filtersType != 3 {
            for i in 0...(appFilters[filtersType].count-1) {
                //Aplica os filtros nos botões, deixar porcentagem sempre em 20 (porcentagem maxima)
                filtersPreviewApply(imgToUse: UIImageImported!, filterType: filtersType, filterNumber: i, toImage: false, percentage: 20)
            }}
        
        
        
        if filtersType == 3 {
            //EFEITOS ESPECIAIS
            filtersImagesB[0] = applyEffect(imgToUse: UIImageImported!, amount: 0.007, effectToApply: lastFilter[1])
        }
        
        
        
        
        
        
        
        
        filterCollectionViewA.reloadData()
        filtersCollectionViewB.reloadData()
    }
    
}



















//Resolve o problema do posicionamento da imagem após ser editada na importação.
//Esconde a barra de status durante este processo
extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }
    
    open override var prefersStatusBarHidden: Bool {
        return true
    }
}







extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
            
        else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}























