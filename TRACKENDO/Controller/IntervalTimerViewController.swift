import UIKit
import Firebase
import AVFoundation

class IntervalTimerViewController: UIViewController {
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var runVSrestLbl: UILabel!
    
    @IBOutlet weak var runTextField: UILabel!
    
    @IBOutlet weak var restTextField: UILabel!
    
    @IBOutlet weak var roundsTextField: UILabel!
    
    @IBOutlet weak var runSliderOutlet: UISlider!
    
    @IBOutlet weak var roundSliderOutlet: UISlider!
    @IBOutlet weak var restSliderOutlet: UISlider!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var runTime  = 0
    var restTime = 0
    var rounds = 0
    var pause = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOutlet.layer.cornerRadius = 0.5 * startOutlet.bounds.size.height
        stopOutlet.layer.cornerRadius = 0.5 * stopOutlet.bounds.size.height
        pauseOutlet.layer.cornerRadius = 0.5 * stopOutlet.bounds.size.height
        startOutlet.layer.borderColor = UIColor.white.cgColor
        stopOutlet.layer.borderColor = UIColor.white.cgColor
        pauseOutlet.layer.borderColor = UIColor.white.cgColor
        startOutlet.layer.borderWidth = 1
        stopOutlet.layer.borderWidth = 1
        pauseOutlet.layer.borderWidth = 1
        
        
//        runTime = Int((runSliderOutlet.maximumValue - runSliderOutlet.minimumValue) * 0.5)
//        restTime = Int((restSliderOutlet.maximumValue - restSliderOutlet.minimumValue) * 0.5)
//        rounds = Int((roundSliderOutlet.maximumValue - roundSliderOutlet.minimumValue) * 0.5)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "1beepAlarm", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch{
            print(error)
        }
    }

    //slidern som ändrar "run" sekundrarna
    @IBAction func runSlider(_ sender: UISlider) {
        runTime = Int(sender.value)
        runTextField.text = "Run: " + String(runTime) + " sec"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if (runTime + restTime) * rounds >= 60 {
            totalTime.text = String(((runTime + restTime) * rounds)/60) + " min"
        }
    }
    
    //slidern som ändrar "rest" sekundrarna
    @IBAction func restSlider(_ sender: UISlider) {
        restTime = Int(sender.value)
        restTextField.text = "Rest: " + String(restTime) + " sec"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if (runTime + restTime) * rounds >= 60 {
            totalTime.text = String(((runTime + restTime) * rounds)/60) + " min"
        }
    }
    
    //slidern som ändrar antal rundor
    @IBAction func roundSlider(_ sender: UISlider) {
        rounds = Int(sender.value)
        roundsTextField.text = String(rounds) + " rounds"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if (runTime + restTime) * rounds >= 60 {
            totalTime.text = String(((runTime + restTime) * rounds)/60) + " min"
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
            
            totalTime.text = String((runTime + restTime) * rounds) + " sec"
            if (runTime + restTime) * rounds >= 60 {
                totalTime.text = String(((runTime + restTime) * rounds)/60) + " min"
            }
            
            if (runTime > 0) {
                runVSrestLbl.text = "RUN"
                runVSrestLbl.textColor = UIColor.green
                timeLbl.text = String(runTime)
                runTime -= 1
                
            }
            else if (restTime > 0 && runTime == 0){
                runVSrestLbl.text = "REST"
                runVSrestLbl.textColor = UIColor.red
                timeLbl.text = String(restTime)
                restTime -= 1
                
            }
            else if (runTime <= 0 && restTime <= 0) {
                rounds -= 1
                runTime = Int(runSliderOutlet.value)
                restTime = Int(restSliderOutlet.value)
                
            }
//            else if (restTime <= 0 && rounds == 1){
//                audioPlayer.play()
//                timeLbl.text = "0"
//                runVSrestLbl.text = "Activity"
//                startOutlet.isEnabled = true
//                timer.invalidate()
//                audioPlayer.stop()
//            }
            else {
                print("hej")
                timer.invalidate()
            }
        }
    }
    //stop-knappen som stoppar klockan
    @IBAction func StopBtn(_ sender: Any) {
        timer.invalidate()
        runTime = 0
        restTime = 0
        rounds = 1
        runSliderOutlet.setValue(50, animated: true)
        restSliderOutlet.setValue(50, animated: true)
        restSliderOutlet.setValue(25, animated: true)
        totalTime.text = "0 sec"
        timeLbl.text = "0"
        runVSrestLbl.text = "Activity"
        runVSrestLbl.textColor = UIColor.white
        
        //audioPlayer.stop()
        
        startOutlet.isEnabled = true
    }
    
    //Pausar klockan
    @IBAction func PauseBtn(_ sender: Any) {
        timer.invalidate()
        pause = false
        startOutlet.isEnabled = true
    }
 
}



