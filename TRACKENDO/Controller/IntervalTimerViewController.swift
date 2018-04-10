import UIKit
import Firebase
import AVFoundation

class IntervalTimerViewController: UIViewController {
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var runVSrestLbl: UILabel!
    
    @IBOutlet weak var runTextField: UITextField!
    
    @IBOutlet weak var restTextField: UITextField!
    
    @IBOutlet weak var roundsTextField: UITextField!
    
    @IBOutlet weak var runSliderOutlet: UISlider!
    
    @IBOutlet weak var roundSliderOutlet: UISlider!
    @IBOutlet weak var restSliderOutlet: UISlider!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var runTime = 0
    var restTime = 0
    var rounds = 1
    var pause = false
    var active = true
    
    
    //slidern som ändrar "run" sekundrarna
    @IBAction func runSlider(_ sender: UISlider) {
        runTime = Int(sender.value)
        runTextField.text = String(runTime)
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //slidern som ändrar "rest" sekundrarna
    @IBAction func restSlider(_ sender: UISlider) {
        restTime = Int(sender.value)
        restTextField.text = String(restTime)
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //slidern som ändrar antal rundor
    @IBAction func roundSlider(_ sender: UISlider) {
        rounds = Int(sender.value)
        roundsTextField.text = String(rounds)
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //start-knappen som startar klockan
    @IBAction func StartBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(IntervalTimerViewController.counter), userInfo: nil, repeats: true)
        startOutlet.isEnabled = false
    }
    
    //countdown timer
    @objc func counter() {
        if rounds > 0 {
            
            totalTime.text = String((runTime + restTime) * rounds)
            if runTime > 0 {
                runVSrestLbl.text = "RUN"
                //runVSrestLbl.text = (UIColor.green.cgColor as! String)
                timeLbl.text = String(runTime)
                runTime -= 1
                //audioPlayer.play()
                
            }
            else if (runTime == 0 && restTime > 0){
                runVSrestLbl.text = "REST"
                //runVSrestLbl.text = (UIColor.red.cgColor as! String)
                timeLbl.text = String(restTime)
                restTime -= 1
                //audioPlayer.play()
                
            }
            else if (runTime == 0 && restTime == 0) {
                rounds -= 1
                runTime = Int(runSliderOutlet.value)
                restTime = Int(restSliderOutlet.value)
                
            }
            else if (runTime == 0 && restTime == 0 && rounds == 0){
                audioPlayer.play()
                timeLbl.text = "0"
                runVSrestLbl.text = "Activity"
                startOutlet.isEnabled = true
                timer.invalidate()
            }
            else {
                timer.invalidate()
            }
            
        }
    }
    //stop-knappen som stoppar klockan
    @IBAction func StopBtn(_ sender: Any) {
        timer.invalidate()
        runTime = 0
        restTime = 0
        rounds = 0
        runSliderOutlet.setValue(90, animated: true)
        restSliderOutlet.setValue(90, animated: true)
        restSliderOutlet.setValue(25, animated: true)
        timeLbl.text = "0"
        runVSrestLbl.text = "Activity"
        
        audioPlayer.stop()
        
        startOutlet.isEnabled = true
    }
    
    //Pausar klockan
    @IBAction func PauseBtn(_ sender: Any) {
        timer.invalidate()
        pause = false
        startOutlet.isEnabled = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runTime = Int((runSliderOutlet.maximumValue - runSliderOutlet.minimumValue) * 0.5)
        restTime = Int((restSliderOutlet.maximumValue - restSliderOutlet.minimumValue) * 0.5)
        rounds = Int((roundSliderOutlet.maximumValue - roundSliderOutlet.minimumValue) * 0.5)
        
        
        do {
            let audioPath = Bundle.main.path(forResource: "alarm", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch{
            //ERROR
        }
        
    }
    
}

