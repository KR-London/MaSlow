//
//  ViewController.swift
//  MaSlow


import UIKit
import CoreData


class ViewController: UIViewController {
    
    //MARK: Define my variables to work with the database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dayLog: [NSManagedObject] = []
    var dayLogArray: [Today]!
    var usageLogArray: [UsageLog]!
    let datafilepath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var usage: [NSManagedObject] = []
    
    //MARK: My local data variables for my code
    var todayLog: Today!
    var usageLog: UsageLog!
    let task = Tasks()
    
    /// outlets to scroll view and the dirt/sky background
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tempFlowerFilenameDisplay: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    // declare buttons
    var buttonTier1: UIButton!
    var buttonLeftTier2: UIButton!
    var buttonMidTier2: UIButton!
    var buttonRightTier2: UIButton!
    var buttonSecondLeftTier2: UIButton!
    var buttonSecondMidTier2: UIButton!
    var buttonSecondRightTier2: UIButton!
    var buttonLeftTier3: UIButton!
    var buttonRightTier3: UIButton!
    var buttonSecondLeftTier3: UIButton!
    var buttonSecondRightTier3: UIButton!
    var buttonLeftTier4: UIButton!
    var buttonMidTier4: UIButton!
    var buttonRightTier4: UIButton!
    var buttonOutterLeftTier5: UIButton!
    var buttonInnerLeftTier5: UIButton!
    var buttonInnerRightTier5: UIButton!
    var buttonOutterRightTier5: UIButton!
    
    // declare tiers
    var Tier1: Bool = false
    var Tier2: Bool = false
    var Tier3: Bool = false
    var Tier4: Bool = false
    var Tier5: Bool = false
    
    // assigning sentences for each tier
    var quotesTier1:[String]=["1tier1","2tier1","3tier1","4tier1"]
    var quotesTier2:[String]=["1tier2","2tier2","3tier2","4tier2"]
    var quotesTier3:[String]=["1tier3","2tier3","3tier3","4tier3"]
    var quotesTier4:[String]=["1tier4","2tier4","3tier4","4tier4"]
    var quotesTier5:[String]=["1tier5","2tier5","3tier5","4tier5"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //     intialiseEmptyDayLog()
        
        /// This is a little debugging subroutine to let me simulate different values in teh data store. 
        let dummyDate = Date.init(timeIntervalSinceNow: 0)
        dummySimulateUsage(dummyData: ( dummyDate , "1001000"))
        
        
        /// my tutorial told me this would look better...
        scrollView.contentInsetAdjustmentBehavior = .never
        
        /// I ask it to check the size of screen that it is using
        let screenSize: CGRect = UIScreen.main.bounds
        
        /// I set my earth/sky image at just under double the screen size, so i still get a peek of earth on the top screen. Set the scroll view content to be the same as the image size
        backgroundImage.frame = CGRect(x: 0, y:0, width: screenSize.width, height: screenSize.height*1.85)
        scrollView.contentSize = (backgroundImage?.frame.size)!
        
        scrollView.setContentOffset(CGPoint(x:0, y:screenSize.height), animated: true)
        
        // I was a bit worried about app being slow laoding. moved these calls lower down to avoid impression of 'hang'
        loadItems()
        makeSureCurrentDayLog()
        print(datafilepath)
        
        
        
        // Add Buttons to view
        addButtonTier1()
        addButtonLeftTier2()
        addButtonMidTier2()
        addButtonRightTier2()
        addButtonSecondLeftTier2()
        addButtonSecondMidTier2()
        addButtonSecondRightTier2()
        addButtonLeftTier3()
        addButtonRightTier3()
        addButtonSecondLeftTier3()
        addButtonSecondRightTier3()
        addButtonLeftTier4()
        addButtonMidTier4()
        addButtonRightTier4()
        addButtonOutterLeftTier5()
        addButtonInnerLeftTier5()
        addButtonInnerRightTier5()
        addButtonOutterRightTier5()
        
        loadUsage()
        /// load the correct flower picture
        addFlower()
        
        // Create Hidden Label
        makeLabel(quote: "You are amazing!")
        
        //         usageTrackingSubroutine()
    }
    
    //MARK: Code for non-button UI elements
    // Label Creation
    func makeLabel(quote: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 1.5, height: view.bounds.height / 4.5))
        label.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 4.5)
        label.textAlignment = .center
        label.text = quote
        label.font = UIFont(name: "Verdana", size: 17)
        label.backgroundColor = UIColor(patternImage: UIImage(named: "Cloud")!)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.clipsToBounds = true
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.isHidden = false
        self.view.addSubview(label)
    }
    
    func addFlower(){
        
        guard let flowerFilenameString = usageLog.usageString
            else{
                tempFlowerFilenameDisplay.text = "No usage log data found"
                return
        }
        tempFlowerFilenameDisplay.text = "flower" + flowerFilenameString + "jpg"
        
        //      {tempFlowerFilenameDisplay.text = flowerFilename}
        //        //// As a placeholder for selecting the correct image from the stack, I'm displaying the filename on a label
        //        if let usageLog.usageString? != nil
        //        {
        //            let flowerFilename = "flower" + usageLog.usageString! + "jpg"
        //            tempFlowerFilenameDisplay.text = flowerFilename
        //        }
        //        else{
        //            self.tempFlowerFilenameDisplay.text = "Nothing in the usage log"
        //        }
        //
        let flowerFilename = "flower" + flowerFilenameString
        if let image = UIImage(named: flowerFilename)
        {
            flowerImageView.image = image
        }
        else{
            //flowerImageView.image = UIImage(named: "flowertest1")
            return
        }
        
        
        //flowerImageView.image = UIImage(named: "flower1000000")
    }
    
    
    
    
    //MARK: Button functions
    /// this is the function that determines what the button looks like in the 'on' and 'off' states.
    func buttonAppearance(button: UIButton, state: Bool)
    {
        // text appearance
        // let image = UIImage(named: "Stonev2") as UIImage?
        // button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        
        if state == false
        {
            button.setTitleColor(UIColor(red: 250/255, green: 192/255, blue: 114/255, alpha: 1.0), for: .normal)
            button.backgroundColor = UIColor.black                //UIColor(red: 138/255, green: 69/255, blue: 40/255, alpha: 1.0)
            //button.layer.borderWidth = 5
            button.layer.cornerRadius = 30
        }
        else
        {
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = UIColor.clear
        }
        button.reloadInputViews()
    }
    
    func addButtonTier1() {
        buttonTier1 = UIButton()
        buttonTier1.tag = 1
        buttonTier1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: self.view.frame.height / 12)
        buttonTier1.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.75 - 3.5)
        
        buttonTier1.setTitle( task.taskTier1, for: UIControlState.normal)
        
        
        /// I've moved appearance code into separate func so we can bulk update the appearance
        buttonAppearance(button: buttonTier1, state: todayLog.buttonTier1)
        buttonTier1.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(buttonTier1)
    }
    
    func addButtonLeftTier2() {
        buttonLeftTier2 = UIButton()
        buttonLeftTier2.tag = 2
        buttonLeftTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonLeftTier2.center = CGPoint(x: view.bounds.width / 6, y: view.bounds.height * 1.6353 - 3.5)
        buttonLeftTier2.setTitle(task.taskLeftTier2, for: UIControlState.normal)
        
        buttonAppearance(button: buttonLeftTier2, state: todayLog.buttonLeftTier2)
        
        buttonLeftTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier2)
    }
    
    func addButtonMidTier2() {
        buttonMidTier2 = UIButton()
        buttonMidTier2.tag = 3
        buttonMidTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonMidTier2.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.6353 - 3.5)
        buttonMidTier2.setTitle(task.taskMidTier2, for: UIControlState.normal)
        
        buttonAppearance(button: buttonMidTier2, state: todayLog.buttonMidTier2)
        
        buttonMidTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonMidTier2)
    }
    
    func addButtonRightTier2() {
        buttonRightTier2 = UIButton()
        buttonRightTier2.tag = 4
        buttonRightTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonRightTier2.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.6353 - 3.5)
        buttonRightTier2.setTitle(task.taskRightTier2, for: UIControlState.normal)
        
        buttonAppearance(button: buttonRightTier2, state: todayLog.buttonRightTier2)
        
        buttonRightTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier2)
    }
    
    func addButtonSecondLeftTier2() {
        buttonSecondLeftTier2 = UIButton()
        buttonSecondLeftTier2.tag = 5
        buttonSecondLeftTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondLeftTier2.center = CGPoint(x: view.bounds.width / 6, y: view.bounds.height * 1.52 - 3.5)
        buttonSecondLeftTier2.setTitle(task.taskSecondLeftTier2, for: UIControlState.normal)
        
        buttonAppearance(button: buttonSecondLeftTier2, state: todayLog.buttonSecondLeftTier2)
        
        buttonSecondLeftTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondLeftTier2)
    }
    
    func addButtonSecondMidTier2() {
        buttonSecondMidTier2 = UIButton()
        buttonSecondMidTier2.tag = 6
        buttonSecondMidTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondMidTier2.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.52 - 3.5)
        buttonSecondMidTier2.setTitle(task.taskSecondMidTier2, for: UIControlState.normal)
        
        buttonAppearance(button: buttonSecondMidTier2, state: todayLog.buttonSecondMidTier2)
        
        buttonSecondMidTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondMidTier2)
    }
    
    func addButtonSecondRightTier2() {
        buttonSecondRightTier2 = UIButton()
        buttonSecondRightTier2.tag = 7
        buttonSecondRightTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondRightTier2.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.52 - 3.5)
        buttonSecondRightTier2.setTitle(task.taskSecondRightTier2, for: UIControlState.normal)
        
        
        buttonAppearance(button: buttonSecondRightTier2, state: todayLog.buttonSecondRightTier2)
        
        buttonSecondRightTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondRightTier2)
    }
    
    func addButtonLeftTier3() {
        buttonLeftTier3 = UIButton()
        buttonLeftTier3.tag = 8
        buttonLeftTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonLeftTier3.center = CGPoint(x: view.bounds.width / 3.75, y: view.bounds.height * 1.406 - 3.5)
        buttonLeftTier3.setTitle(task.taskLeftTier3, for: UIControlState.normal)
        
        buttonAppearance(button: buttonLeftTier3, state: todayLog.buttonLeftTier3)
        
        buttonLeftTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier3)
    }
    
    func addButtonRightTier3() {
        buttonRightTier3 = UIButton()
        buttonRightTier3.tag = 9
        buttonRightTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonRightTier3.center = CGPoint(x: view.bounds.width - (view.bounds.width / 3.75), y: view.bounds.height * 1.406 - 3.5)
        buttonRightTier3.setTitle(task.taskRightTier3, for: UIControlState.normal)
        
        buttonAppearance(button: buttonRightTier3, state: todayLog.buttonRightTier3)
        
        buttonRightTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier3)
    }
    
    func addButtonSecondLeftTier3() {
        buttonSecondLeftTier3 = UIButton()
        buttonSecondLeftTier3.tag = 10
        buttonSecondLeftTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonSecondLeftTier3.center = CGPoint(x: view.bounds.width / 3.75, y: view.bounds.height * 1.291 - 3.5)
        buttonSecondLeftTier3.setTitle(task.taskSecondLeftTier3, for: UIControlState.normal)
        
        buttonAppearance(button: buttonSecondLeftTier3, state: todayLog.buttonSecondLeftTier3)
        
        buttonSecondLeftTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondLeftTier3)
    }
    
    func addButtonSecondRightTier3() {
        buttonSecondRightTier3 = UIButton()
        buttonSecondRightTier3.tag = 11
        buttonSecondRightTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonSecondRightTier3.center = CGPoint(x: view.bounds.width - (view.bounds.width / 3.75), y: view.bounds.height * 1.291 - 3.5)
        buttonSecondRightTier3.setTitle(task.taskSecondRightTier3, for: UIControlState.normal)
        
        buttonAppearance(button: buttonSecondRightTier3, state: todayLog.buttonSecondRightTier3)
        
        
        buttonSecondRightTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondRightTier3)
    }
    
    func addButtonLeftTier4() {
        buttonLeftTier4 = UIButton()
        buttonLeftTier4.tag = 12
        buttonLeftTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonLeftTier4.center = CGPoint(x: view.bounds.width / 6, y: view.bounds.height * 1.177 - 3.5)
        buttonLeftTier4.setTitle(task.taskLeftTier4, for: UIControlState.normal)
        
        buttonAppearance(button: buttonLeftTier4, state: todayLog.buttonLeftTier4)
        
        buttonLeftTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier4)
    }
    
    func addButtonMidTier4() {
        buttonMidTier4 = UIButton()
        buttonMidTier4.tag = 13
        buttonMidTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonMidTier4.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.177 - 3.5)
        buttonMidTier4.setTitle(task.taskMidTier4, for: UIControlState.normal)
        
        buttonAppearance(button: buttonMidTier4, state: todayLog.buttonMidTier4)
        buttonMidTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonMidTier4)
    }
    
    func addButtonRightTier4() {
        buttonRightTier4 = UIButton()
        buttonRightTier4.tag = 14
        buttonRightTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonRightTier4.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.177 - 3.5)
        buttonRightTier4.setTitle(task.taskRightTier4, for: UIControlState.normal)
        
        buttonAppearance(button: buttonRightTier4, state: todayLog.buttonRightTier4)
        buttonRightTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier4)
    }
    
    func addButtonOutterLeftTier5() {
        buttonOutterLeftTier5 = UIButton()
        buttonOutterLeftTier5.tag = 15
        buttonOutterLeftTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonOutterLeftTier5.center = CGPoint(x: view.bounds.width / 7, y: view.bounds.height * 1.0625 - 3.5)
        buttonOutterLeftTier5.setTitle(task.taskOutterLeftTier5, for: UIControlState.normal)
        
        buttonAppearance(button: buttonOutterLeftTier5, state: todayLog.buttonOutterLeftTier5)
        buttonOutterLeftTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonOutterLeftTier5)
    }
    
    func addButtonInnerLeftTier5() {
        buttonInnerLeftTier5 = UIButton()
        buttonInnerLeftTier5.tag = 16
        buttonInnerLeftTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonInnerLeftTier5.center = CGPoint(x: ((view.bounds.width / 4.25) / 2) + (view.bounds.width / 2), y: view.bounds.height * 1.0625 - 3.5)
        buttonInnerLeftTier5.setTitle(task.taskInnerLeftTier5, for: UIControlState.normal)
        
        buttonAppearance(button: buttonInnerLeftTier5, state: todayLog.buttonInnerLeftTier5)
        buttonInnerLeftTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonInnerLeftTier5)
    }
    
    func addButtonInnerRightTier5() {
        buttonInnerRightTier5 = UIButton()
        buttonInnerRightTier5.tag = 17
        buttonInnerRightTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonInnerRightTier5.center = CGPoint(x:(view.bounds.width / 2) - ((view.bounds.width / 4.25) / 2), y: view.bounds.height * 1.0625 - 3.5)
        buttonInnerRightTier5.setTitle(task.taskInnerRightTier5, for: UIControlState.normal)
        
        buttonAppearance(button: buttonInnerRightTier5, state: todayLog.buttonInnerRightTier5)
        buttonInnerRightTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonInnerRightTier5)
    }
    
    func addButtonOutterRightTier5() {
        
        buttonOutterRightTier5 = UIButton()
        buttonOutterRightTier5.tag = 18
        buttonOutterRightTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonOutterRightTier5.center = CGPoint(x: view.bounds.width - (view.bounds.width / 7), y: view.bounds.height * 1.0625 - 3.5)
        buttonOutterRightTier5.setTitle(task.taskOutterRightTier5, for: UIControlState.normal)
        
        
        buttonAppearance(button: buttonOutterRightTier5, state: todayLog.buttonOutterRightTier5)
        
        
        buttonOutterRightTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonOutterRightTier5)
    }
    
    ///MARK: Button action method
    @IBAction func buttonInAction(sender: UIButton!) {
        
        var state = false
        
        /// This is a brutal way of saying 'whatever the state of the button is, swap it'
        switch sender.tag
        {
        case 1: todayLog.buttonTier1 = !todayLog.buttonTier1
        state = todayLog.buttonTier1
        case 2: todayLog.buttonLeftTier2 = !todayLog.buttonLeftTier2
        state = todayLog.buttonLeftTier2
        case 3: todayLog.buttonMidTier2 = !todayLog.buttonMidTier2
        state = todayLog.buttonMidTier2
        case 4: todayLog.buttonRightTier2 = !todayLog.buttonRightTier2
        state = todayLog.buttonRightTier2
        case 5: todayLog.buttonSecondLeftTier2 = !todayLog.buttonSecondLeftTier2
        state = todayLog.buttonSecondLeftTier2
        case 6:  todayLog.buttonSecondMidTier2 = !todayLog.buttonSecondMidTier2
        state = todayLog.buttonSecondMidTier2
        case 7: todayLog.buttonSecondRightTier2 = !todayLog.buttonSecondRightTier2
        state = todayLog.buttonSecondRightTier2
        case 8:todayLog.buttonLeftTier3 = !todayLog.buttonLeftTier3
        state = todayLog.buttonLeftTier3
        case 9:todayLog.buttonRightTier3 = !todayLog.buttonRightTier3
        state = todayLog.buttonRightTier3
        case 10: todayLog.buttonSecondLeftTier3 =  !todayLog.buttonSecondLeftTier3
        state = todayLog.buttonSecondLeftTier3
        case 11: todayLog.buttonSecondRightTier3 = !todayLog.buttonSecondRightTier3
        state = todayLog.buttonSecondRightTier3
        case 12: todayLog.buttonLeftTier4 = !todayLog.buttonLeftTier4
        state = todayLog.buttonLeftTier4
        case 13:todayLog.buttonMidTier4 = !todayLog.buttonMidTier4
        state = todayLog.buttonMidTier4
        case 14: todayLog.buttonRightTier4 = !todayLog.buttonRightTier4
        state = todayLog.buttonRightTier4
        case 15:todayLog.buttonOutterLeftTier5 = !todayLog.buttonOutterLeftTier5
        state = todayLog.buttonOutterLeftTier5
        case 16:todayLog.buttonInnerLeftTier5 = !todayLog.buttonInnerLeftTier5
        state = todayLog.buttonInnerLeftTier5
        case 17: todayLog.buttonInnerRightTier5 = !todayLog.buttonInnerRightTier5
        state = todayLog.buttonInnerRightTier5
        case 18:  todayLog.buttonOutterRightTier5 = !todayLog.buttonOutterRightTier5
        state = todayLog.buttonOutterRightTier5
        default:print("none of the above")
        }
        
        // refresh the appearance of the button
        buttonAppearance(button: sender, state: state)
        if todayLog.buttonTier1 == true {
            makeLabel(quote: quotesTier1[Int(arc4random_uniform(UInt32(quotesTier1.count)))])
        } else if todayLog.buttonLeftTier2 && todayLog.buttonMidTier2 && todayLog.buttonRightTier2 == true && todayLog.buttonSecondLeftTier2 && todayLog.buttonSecondMidTier2 && todayLog.buttonSecondRightTier2 {
            makeLabel(quote: quotesTier2[Int(arc4random_uniform(UInt32(quotesTier2.count)))])
        } else if todayLog.buttonLeftTier3 && todayLog.buttonRightTier3 && todayLog.buttonSecondLeftTier3 && todayLog.buttonSecondRightTier3 {
            makeLabel(quote: quotesTier3[Int(arc4random_uniform(UInt32(quotesTier3.count)))])
        } else if todayLog.buttonLeftTier4 && todayLog.buttonMidTier4 && todayLog.buttonRightTier4 {
            makeLabel(quote: quotesTier4[Int(arc4random_uniform(UInt32(quotesTier4.count)))])
        } else if todayLog.buttonOutterLeftTier5 && todayLog.buttonInnerLeftTier5 && todayLog.buttonInnerRightTier5 && todayLog.buttonOutterRightTier5 {
            makeLabel(quote: quotesTier5[Int(arc4random_uniform(UInt32(quotesTier5.count)))])
        } else {
            makeLabel(quote: "You are amazing!")
        }
        self.view.setNeedsDisplay()
        // save the changed data to the database
        saveItems()
        
    }
    
    //MARK: Data loading subroutines
    func loadItems(){
        let request : NSFetchRequest<Today> = Today.fetchRequest()
        do{
            try
                dayLogArray = context.fetch(request)
            //print(dayLogArray[0].buttonTier1)
        }
        catch
        {
            print("Error fetching data \(error)")
        }
    }
    
    func loadUsage(){
        let request : NSFetchRequest<UsageLog> = UsageLog.fetchRequest()
        do{
            try
                usageLogArray = context.fetch(request)
            if usageLogArray.count > 0
            {
                self.usageLog = usageLogArray[0]
            }
        }
        catch
        {
            print("Error fetching data \(error)")
        }
    }
    
    /// This is a dummy subroutine for loading in possible scenarios of usage
    func dummySimulateUsage(dummyData: (Date, String)){
        var  usageLog = UsageLog.init(entity: NSEntityDescription.entity(forEntityName: "UsageLog", in:context)!, insertInto: context)
        usageLog.lastUsed = dummyData.0
        usageLog.usageString = dummyData.1
        
        
        saveItems()
        //        do{
        //            try context.save() }
        //        catch{
        //            let nserror = error as NSError
        //            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        //
        //        }
        //loadUsage()
        
        
    }
    
    
    func makeSureCurrentDayLog(){
        
        // defined a helper variable to tell me if I should throw away current tasks log
        var deleteIndicator = false
        
        // If the data is empty or corrupted, i want to start afresh.
        if dayLogArray == nil || dayLogArray.count != 1{
            deleteIndicator = true
        }
        else { /// put this in an else loop, so I don;t by mistake try to unwrap a nil object
            let temp = dayLogArray[0]
            let timestamp_of_now = Date.init(timeIntervalSinceNow: 0).description.split(separator: " ")[0]
            let timestamp_of_data = temp.date!.description.split(separator: " ")[0]
            
            if String(describing: timestamp_of_now) != String(describing: timestamp_of_data){
                deleteIndicator = true
                print("The stored data is out of date")
            }
        }
        
        // If the data is empty or corrupted, i want to start afresh.
        if deleteIndicator == true
        {
            //Create Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Today")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do{
                try context.execute(batchDeleteRequest)
            }
            catch{
                print("Batch delete error \(error)")
            }
            saveItems()
            intialiseEmptyDayLog()
        }
        else{
            todayLog = dayLogArray[0]
        }
    }
    
    
    func saveItems(){
        do{
            try context.save() }
        catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            
        }
    }
    
    /// this is the subroutine to reset the achievements
    func intialiseEmptyDayLog(){
        todayLog = Today(context:context)
        todayLog.buttonTier1 = false
        todayLog.buttonLeftTier2 = false
        todayLog.buttonMidTier2 = false
        todayLog.buttonRightTier2 = false
        todayLog.buttonSecondLeftTier2 = false
        todayLog.buttonSecondMidTier2 = false
        todayLog.buttonSecondRightTier2 = false
        todayLog.buttonLeftTier3 = false
        todayLog.buttonRightTier3 = false
        todayLog.buttonSecondLeftTier3 = false
        todayLog.buttonSecondRightTier3 = false
        todayLog.buttonLeftTier4 = false
        todayLog.buttonMidTier4 = false
        todayLog.buttonRightTier4 = false
        todayLog.buttonOutterLeftTier5 = false
        todayLog.buttonInnerLeftTier5 = false
        todayLog.buttonInnerRightTier5 = false
        todayLog.buttonOutterRightTier5 = false
        todayLog.message = "I've initialised a new day log"
        todayLog.date = Date.init(timeIntervalSinceNow: 0)
        saveItems()
    }
    
    func usageTrackingSubroutine(){
        /// flower subroutine
        
        /// I need to load the data item for the flower.
        loadUsage()
        
        // little safety subroutine in case I don't have data
        if usageLogArray == nil || usageLogArray.count == 1
        {
            return
        }
        else
        {
            usageLog = usageLogArray[0]
            
            /// I need to read the last element.
            let datestampOnData = usageLog.lastUsed?.description.split(separator: " ")[0]
            let datestampNow = Date.init(timeIntervalSinceNow: 0).description.split(separator: " ")[0]
            
            ///If the last element is not the same as today, i should append todays timestamp to the data
            if String(datestampNow) != String(describing: datestampOnData)
            {
                /// check that this is counting calendar dates, not 24hr periods >>> unit tests
                let daysSinceLastUse = Calendar.current.dateComponents([.day], from: usageLog.lastUsed!, to: Date.init(timeIntervalSinceNow: 0)).day
                
                switch daysSinceLastUse!
                {
                case 1:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(1))
                    usageLog.usageString?.append("1")
                case 2:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(2))
                    usageLog.usageString?.append("10")
                case 3:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(3))
                    usageLog.usageString?.append("100")
                case 4:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(4))
                    usageLog.usageString?.append("1000")
                case 5:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(5))
                    usageLog.usageString?.append("10000")
                case 6:
                    usageLog.usageString = String(describing: usageLog.usageString?.dropLast(6))
                    usageLog.usageString?.append("100000")
                default:
                    usageLog.usageString = "1000000"
                    print("none of the above")
                }
                
                ///sanity check
                if usageLog.usageString?.count != 7
                {
                    print("My usage string is \(String(describing: usageLog.usageString)). Does this look right to you?")
                }
            }
        }
        
    }
    
    //MARK: Miscellaneous
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

