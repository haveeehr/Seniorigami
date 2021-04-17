//
//  StepCell.swift
//  Seniorigami
//
//  Created by Ghirlandaio on 13/04/21.
//
import AVFoundation
import UIKit

class StepCell: UICollectionViewCell  {

    @IBOutlet weak var origamiStepImg: UIImageView!
    @IBOutlet weak var origamiStepCount:PaddingLabel!
    @IBOutlet weak var origamiStepDesc: UILabel!
    var speechText = String()
    @IBOutlet weak var turnOnAudioButton: UIButton!
    let speechSynthesizer = AVSpeechSynthesizer()
    @IBAction func turnOnAudio(_ sender: Any) {

        // Line 1. Create an instance of AVSpeechSynthesizer.
      
        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
        let speechUtterance = AVSpeechUtterance(string: speechText)
        //Line 3. Specify the speech utterance rate. 1 = speaking extremely the higher the values the slower speech patterns. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        // Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
//            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // Line 5. Pass in the urrerance to the synthesizer to actually speak.
            speechSynthesizer.speak(speechUtterance)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        origamiStepCount.sizeToFit()
        origamiStepCount.layer.cornerRadius = 10
        
        
    }
    
    func setupCard(selected: Origami, indexPath: Int){
        let color = UIColor.init(named: (selected.mode?.color)!)
        var imgs: [UIImage] = []
        for index in 0...(selected.instructions![indexPath].images.count)-1{
            imgs.append(UIImage(named: (selected.instructions![indexPath].images[index]!))!)
            
        }
        
        speechText = selected.instructions![indexPath].desc!
      
        origamiStepImg.image = UIImage.animatedImage(with: imgs, duration: 3)
        origamiStepCount.text = "\(indexPath+1) of \((selected.steps)!)"
        origamiStepCount.sizeToFit()
        origamiStepDesc.text = selected.instructions![indexPath].desc
        origamiStepCount.layer.backgroundColor = color?.cgColor
        
        
    }
    
}
