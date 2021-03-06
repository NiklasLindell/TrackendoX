import UIKit
import Firebase
import AVFoundation

class IntervalTimerViewController: UIViewController {
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var roundsLable: UILabel!
    
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
    
    var audioPlayer : AVAudioPlayer?
    var timer = Timer()
    var runTime  = 0
    var restTime = 0
    var rounds = 1
    var pause = false
    var roundsNumber = 1
    var roundsTotal = 0
    
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
        
        runTime = Int((runSliderOutlet.maximumValue - runSliderOutlet.minimumValue) * 0.5)
        restTime = Int((restSliderOutlet.maximumValue - restSliderOutlet.minimumValue) * 0.5)
        rounds = Int((roundSliderOutlet.maximumValue - roundSliderOutlet.minimumValue) * 0.5)
        
        if let url = Bundle.main.url(forResource: "1beepAlarm", withExtension: "wav") {
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            let audioSession = AVAudioSession.sharedInstance()
            do{
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            }
            catch{
                
            }
        } else {
            print("file not found ERROR")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    //slidern som ändrar "run" sekundrarna
    @IBAction func runSlider(_ sender: UISlider) {
        runTime = Int(sender.value)
        runTextField.text = "Run: " + String(runTime) + " sec"
        totalTimeCalcSec()
        if (runTime + restTime) * rounds >= 60 {
            totalTimeCalcMin()
        }
    }
    
    //slidern som ändrar "rest" sekundrarna
    @IBAction func restSlider(_ sender: UISlider) {
        restTime = Int(sender.value)
        restTextField.text = "Rest: " + String(restTime) + " sec"
        totalTimeCalcSec()
        if (runTime + restTime) * rounds >= 60 {
            totalTimeCalcMin()
        }
    }
    
    //slidern som ändrar antal rundor
    @IBAction func roundSlider(_ sender: UISlider) {
        rounds = Int(sender.value)
        roundsTotal = Int(sender.value)
        roundsTextField.text = "Rounds: " + String(rounds)
        totalTimeCalcSec()
        if (runTime + restTime) * rounds >= 60 {
            totalTimeCalcMin()
        }
    }
    
    //start-knappen som startar klockan
    @IBAction func StartBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(IntervalTimerViewController.counter), userInfo: nil, repeats: true)
        startOutlet.isEnabled = false
        startOutlet.layer.backgroundColor = UIColor.darkGray.cgColor
        stopOutlet.layer.backgroundColor = UIColor.clear.cgColor
        pauseOutlet.layer.backgroundColor = UIColor.clear.cgColor
        runSliderOutlet.isEnabled = false
        restSliderOutlet.isEnabled = false
        roundSliderOutlet.isEnabled = false
        
    }
    
    //countdown timer
    @objc func counter() {
        if rounds > 0 {
            
            roundsLable.text = "\(roundsNumber)/\(roundsTotal)"
            
            if (runTime > 0) {
                runVSrestLbl.text = "RUN"
                runVSrestLbl.textColor = UIColor.green
                timeLbl.text = String(runTime)
                runTime -= 1
                if runTime == 0{
                    audioPlayer?.play()
                }
            }
                
            else if (restTime > 0 && runTime == 0){
                runVSrestLbl.text = "REST"
                runVSrestLbl.textColor = UIColor.red
                timeLbl.text = String(restTime)
                restTime -= 1
                if restTime == 0{
                    audioPlayer?.play()
                }
            }
            
            if (runTime <= 0 && restTime <= 0) {
                rounds -= 1
                runTime = Int(runSliderOutlet.value)
                restTime = Int(restSliderOutlet.value)
                roundsNumber += 1
            }
        }
            
        else {
            timer.invalidate()
            timeLbl.text = "00"
            runTextField.text = "Run"
            restTextField.text = "Rest"
            roundsTextField.text = "Rounds"
            roundsLable.text = "00/00"
            totalTime.text = "Total time"
            runVSrestLbl.text = "Activity"
            roundsNumber = 1
            runVSrestLbl.textColor = UIColor.white
            startOutlet.isEnabled = true
            startOutlet.layer.backgroundColor = UIColor.clear.cgColor
            stopOutlet.layer.backgroundColor = UIColor.clear.cgColor
            pauseOutlet.layer.backgroundColor = UIColor.clear.cgColor
            runSliderOutlet.isEnabled = true
            restSliderOutlet.isEnabled = true
            roundSliderOutlet.isEnabled = true
            runSliderOutlet.setValue(50, animated: true)
            restSliderOutlet.setValue(50, animated: true)
            roundSliderOutlet.setValue(16, animated: true)
        }
    }
    
    //stop-knappen som stoppar klockan
    @IBAction func StopBtn(_ sender: Any) {
        timer.invalidate()
        runTime = 0
        restTime = 0
        rounds = 1
        roundsNumber = 1
        runSliderOutlet.setValue(50, animated: true)
        restSliderOutlet.setValue(50, animated: true)
        roundSliderOutlet.setValue(16, animated: true)
        timeLbl.text = "00"
        totalTime.text = "Total time"
        runVSrestLbl.text = "Activity"
        runTextField.text = "Run"
        restTextField.text = "Rest"
        roundsTextField.text = "Rounds"
        roundsLable.text = "00/00"
        runVSrestLbl.textColor = UIColor.white
        runSliderOutlet.isEnabled = true
        restSliderOutlet.isEnabled = true
        roundSliderOutlet.isEnabled = true
        stopOutlet.layer.backgroundColor = UIColor.darkGray.cgColor
        startOutlet.isEnabled = true
        startOutlet.layer.backgroundColor = UIColor.clear.cgColor
        pauseOutlet.layer.backgroundColor = UIColor.clear.cgColor
        
        
    }
    
    //Pausar klockan
    @IBAction func PauseBtn(_ sender: Any) {
        timer.invalidate()
        pause = false
        startOutlet.isEnabled = true
        startOutlet.layer.backgroundColor = UIColor.clear.cgColor
        stopOutlet.layer.backgroundColor = UIColor.clear.cgColor
        pauseOutlet.layer.backgroundColor = UIColor.darkGray.cgColor
        runSliderOutlet.isEnabled = false
        restSliderOutlet.isEnabled = false
        roundSliderOutlet.isEnabled = false
    }
    
    func totalTimeCalcMin(){
        totalTime.text = "Total: " + String(((runTime + restTime) * rounds)/60) + " min"
    }
    func totalTimeCalcSec(){
        totalTime.text = "Total: " + String((runTime + restTime) * rounds) + " sec"
    }
    
}



