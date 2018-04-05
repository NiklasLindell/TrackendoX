import UIKit
import Firebase
import AVFoundation

class IntervalTimerViewController: UIViewController {
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var runVSrestLbl: UILabel!
    

    @IBOutlet weak var runLabel: UILabel!
    
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var roundsLable: UILabel!
    
    @IBOutlet weak var runSliderOutlet: UISlider!
    
    @IBOutlet weak var roundSliderOutlet: UISlider!
    @IBOutlet weak var restSliderOutlet: UISlider!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var RunTime = 0
    var RestTime = 0
    //var TotalSeconds = RunTime + RestTime
    
    var rounds = 0
    var isRunning = false
    var active = true
    
    
    //slidern som ändrar "run" sekundrarna
    @IBAction func runSlider(_ sender: UISlider) {
        RunTime = Int(sender.value)
        runTextField.text = String(RunTime)
    }
    
    //slidern som ändrar "rest" sekundrarna
    @IBAction func restSlider(_ sender: UISlider) {
        RestTime = Int(sender.value)
        restTextField.text = String(RestTime)
        
    }
    
    //slidern som ändrar antal rundor
    @IBAction func roundSlider(_ sender: UISlider) {
        rounds = Int(sender.value)
        roundsTextField.text = String(rounds)
    }
    
    //start-knappen som startar klockan
    @IBAction func StartBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(IntervalTimerViewController.counter), userInfo: nil, repeats: true)
        timeSliderOutlet.isHidden = true
        runTextField.isHidden = true
        startOutlet.isHidden = false
    }
    
    //countdown timer
    @objc func counter() {
        RunTime -= 1
        RestTime -= 1
        //        var TotalSeconds = RunTime + RestTime
        //            TotalSeconds -= 1
        timeLbl.text = String(RunTime)
        if (RunTime == 0){
            timer.invalidate()
            StartBtn((Any).self)
            RestTime -= 1
            timeSliderOutlet.isHidden = false
            startOutlet.isHidden = false
            
            audioPlayer.play()
        }
    }
    //stop-knappen som stoppar klockan
    @IBAction func StopBtn(_ sender: Any) {
        timer.invalidate()
        RunTime = 0
        RestTime = 0
        timeSliderOutlet.setValue(0, animated: true)
        timeLbl.text = "0"
        
        audioPlayer.stop()
        
        runTextField.isHidden = false
        timeSliderOutlet.isHidden = false
        startOutlet.isHidden = false
    }
    //Pausar klockan
    @IBAction func PauseBtn(_ sender: Any) {
        timer.invalidate()
        isRunning = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let audioPath = Bundle.main.path(forResource: "alarm", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch{
            //ERROR
        }
        
    }
    
}

