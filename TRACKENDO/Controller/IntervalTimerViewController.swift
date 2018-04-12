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
        runTextField.text = "Run: " + String(runTime) + " sec"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //slidern som ändrar "rest" sekundrarna
    @IBAction func restSlider(_ sender: UISlider) {
        restTime = Int(sender.value)
        restTextField.text = "Rest: " + String(restTime) + " sec"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //slidern som ändrar antal rundor
    @IBAction func roundSlider(_ sender: UISlider) {
        rounds = Int(sender.value)
        roundsTextField.text = String(rounds) + " rounds"
        totalTime.text = String((runTime + restTime) * rounds) + " sec"
        if runTime + restTime * rounds >= 60 {
            totalTime.text = String((runTime + restTime) * rounds) + " min"
        }
    }
    
    //start-knappen som startar klockan
    @IBAction func StartBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(IntervalTimerViewController.counter), userInfo: nil, repeats: true)
        startOutlet.isEnabled = false
        if runTime > 0{
        handleTapRun()
        } else {
            handleTapRest()
        }
    }
    
    //countdown timer
    @objc func counter() {
        if rounds > 0 {
            
            totalTime.text = String((runTime + restTime) * rounds)
            if runTime >= 0 {
                runVSrestLbl.text = "RUN"
                shapeLayer.strokeColor = UIColor.green.cgColor
                timeLbl.text = String(runTime)
                runTime -= 1
                
            }
            else if (runTime <= 0 && restTime > 0){
                runVSrestLbl.text = "REST"
                shapeLayer.strokeColor = UIColor.red.cgColor
                timeLbl.text = String(restTime)
                restTime -= 1
                
            }
            else if (runTime <= 0 && restTime <= 0) {
                rounds -= 1
                runTime = Int(runSliderOutlet.value)
                restTime = Int(restSliderOutlet.value)
                
            }
            else if (runTime == 0 || restTime == 0){
                audioPlayer.play()
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
        
        //audioPlayer.stop()
        
        startOutlet.isEnabled = true
    }
    
    //Pausar klockan
    @IBAction func PauseBtn(_ sender: Any) {
        timer.invalidate()
        pause = false
        startOutlet.isEnabled = true
    }
    
    @IBOutlet weak var circleView: UIView!
    
    //ritar upp cirkeln
    let shapeLayer = CAShapeLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cirkeln visas i mitten av skärmen(center)
        let center = circleView.center
        
        //create my track layer(själva mallen bakom det gröna/röda)
        let trackLayer = CAShapeLayer()
        
        //gör en cirkel, startangle är att den börjar högst upp och endangle gör att den går runt (pi = 180grader)
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        
        //färgen på själva mallen
        trackLayer.strokeColor = UIColor.lightText.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        
        //ritar in det i min view
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        //tjockleken på strecket
        shapeLayer.lineWidth = 5
        
        //färgen på cirkeln innanför strecket
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //strecket försvinner med den här
        shapeLayer.strokeEnd = 0
        
        //ritar upp den i min view
        view.layer.addSublayer(shapeLayer)
        
        //cirkeln startas när man trycker på skärmen, med vår handletap func
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        runTime = Int((runSliderOutlet.maximumValue - runSliderOutlet.minimumValue) * 0.5)
        restTime = Int((restSliderOutlet.maximumValue - restSliderOutlet.minimumValue) * 0.5)
        rounds = Int((roundSliderOutlet.maximumValue - roundSliderOutlet.minimumValue) * 0.5)
        
        do {
            let audioPath = Bundle.main.path(forResource: "1beepAlarm", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch{
            //ERROR
        }
        
    }
    func handleTapRun(){
        print("animate")
        
        //börjar animera och använder strokeEnd så att den börjar röras
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        //här går den från strokeEnd(0) till toValue(1)
        basicAnimation.toValue = 1
        
        //det här är hur snabbt cirkeln ska gå runt
        basicAnimation.duration = CFTimeInterval(runTime)
        
        //dessa två gör att animationen stannar så när den är ifylld
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = true
        
        //adderar animationen
        shapeLayer.add(basicAnimation, forKey: "basic")
        
    }
    
    func handleTapRest(){
        print("animate")
        
        //börjar animera och använder strokeEnd så att den börjar röras
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        //här går den från strokeEnd(0) till toValue(1)
        basicAnimation.toValue = 1
        
        //det här är hur snabbt cirkeln ska gå runt
        basicAnimation.duration = CFTimeInterval(restTime)
        
        
        
        //dessa två gör att animationen stannar så när den är ifylld
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = true
        
        //adderar animationen
        shapeLayer.add(basicAnimation, forKey: "basic")
        
    }
    
    
    
    
    
    
    
    
}



