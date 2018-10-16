//
//  ViewController.swift
//  MaSlow
//
//  Created by Kate Roberts on 15/10/2018.
//  Copyright © 2018 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: Define my variables to work with the database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dayLog: [NSManagedObject] = []
    var dayLogArray: [Today]!
    let datafilepath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    //MARK: My local variables for my code
    var todayLog: Today!
    
    
    /// outlets to scroll view and the dirt/sky background
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        makeSureCurrentDayLog()
        
        /// my tutorial told me this would look better...
        scrollView.contentInsetAdjustmentBehavior = .never
        
        /// I ask it to check the size of screen that it is using
        let screenSize: CGRect = UIScreen.main.bounds
        
        /// I set my earth/sky image at just under double the screen size, so i still get a peek of earth on the top screen. Set the scroll view content to be the same as the image size
        backgroundImage.frame = CGRect(x: 0, y:0, width: screenSize.width, height: screenSize.height*1.85)
        scrollView.contentSize = (backgroundImage?.frame.size)!
        
        scrollView.setContentOffset(CGPoint(x:0, y:screenSize.height), animated: true)
        
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
    }
    
    func addButtonTier1() {
        buttonTier1 = UIButton()
        buttonTier1.tag = 1
        buttonTier1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: self.view.frame.height / 12)
        buttonTier1.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.75 - 3.5)
        buttonTier1.setTitle("click me!", for: UIControlState.normal)
        buttonTier1.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
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
        buttonLeftTier2.setTitle("click me!", for: UIControlState.normal)
        buttonLeftTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonLeftTier2, state: todayLog.buttonLeftTier2)

        buttonLeftTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier2)
    }
    
    func addButtonMidTier2() {
        buttonMidTier2 = UIButton()
        buttonMidTier2.tag = 3
        buttonMidTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonMidTier2.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.6353 - 3.5)
        buttonMidTier2.setTitle("click me!", for: UIControlState.normal)
        buttonMidTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonMidTier2, state: todayLog.buttonMidTier2)
        
        buttonMidTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonMidTier2)
    }
    
    func addButtonRightTier2() {
        buttonRightTier2 = UIButton()
        buttonRightTier2.tag = 4
        buttonRightTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonRightTier2.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.6353 - 3.5)
        buttonRightTier2.setTitle("click me!", for: UIControlState.normal)
        buttonRightTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonRightTier2, state: todayLog.buttonRightTier2)
        
        buttonRightTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier2)
    }
    
    func addButtonSecondLeftTier2() {
        buttonSecondLeftTier2 = UIButton()
        buttonSecondLeftTier2.tag = 5
        buttonSecondLeftTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondLeftTier2.center = CGPoint(x: view.bounds.width / 6, y: view.bounds.height * 1.52 - 3.5)
        buttonSecondLeftTier2.setTitle("click me!", for: UIControlState.normal)
        buttonSecondLeftTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
       
        buttonAppearance(button: buttonSecondLeftTier2, state: todayLog.buttonSecondLeftTier2)
        
        buttonSecondLeftTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondLeftTier2)
    }
    
    func addButtonSecondMidTier2() {
        buttonSecondMidTier2 = UIButton()
        buttonSecondMidTier2.tag = 6
        buttonSecondMidTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondMidTier2.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.52 - 3.5)
        buttonSecondMidTier2.setTitle("click me!", for: UIControlState.normal)
        buttonSecondMidTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonSecondMidTier2, state: todayLog.buttonSecondMidTier2)
        
        buttonSecondMidTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondMidTier2)
    }
    
    func addButtonSecondRightTier2() {
        buttonSecondRightTier2 = UIButton()
        buttonSecondRightTier2.tag = 7
        buttonSecondRightTier2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonSecondRightTier2.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.52 - 3.5)
        buttonSecondRightTier2.setTitle("click me!", for: UIControlState.normal)
        buttonSecondRightTier2.titleLabel?.font = UIFont(name: "Verdana", size: 15)
       
        buttonAppearance(button: buttonSecondRightTier2, state: todayLog.buttonSecondRightTier2)
        
        buttonSecondRightTier2.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondRightTier2)
    }
    
    func addButtonLeftTier3() {
        buttonLeftTier3 = UIButton()
        buttonLeftTier3.tag = 8
        buttonLeftTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonLeftTier3.center = CGPoint(x: view.bounds.width / 3.75, y: view.bounds.height * 1.406 - 3.5)
        buttonLeftTier3.setTitle("click me!", for: UIControlState.normal)
        buttonLeftTier3.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonLeftTier3, state: todayLog.buttonLeftTier3)
        
        buttonLeftTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier3)
    }
    
    func addButtonRightTier3() {
        buttonRightTier3 = UIButton()
        buttonRightTier3.tag = 9
        buttonRightTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonRightTier3.center = CGPoint(x: view.bounds.width - (view.bounds.width / 3.75), y: view.bounds.height * 1.406 - 3.5)
        buttonRightTier3.setTitle("click me!", for: UIControlState.normal)
        buttonRightTier3.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonRightTier3, state: todayLog.buttonRightTier3)
        
        buttonRightTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier3)
    }
    
    func addButtonSecondLeftTier3() {
        buttonSecondLeftTier3 = UIButton()
        buttonSecondLeftTier3.tag = 10
        buttonSecondLeftTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonSecondLeftTier3.center = CGPoint(x: view.bounds.width / 3.75, y: view.bounds.height * 1.291 - 3.5)
        buttonSecondLeftTier3.setTitle("click me!", for: UIControlState.normal)
        buttonSecondLeftTier3.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonSecondLeftTier3, state: todayLog.buttonSecondLeftTier3)
        
        buttonSecondLeftTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondLeftTier3)
    }
    
    func addButtonSecondRightTier3() {
        buttonSecondRightTier3 = UIButton()
        buttonSecondRightTier3.tag = 11
        buttonSecondRightTier3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.height / 12)
        buttonSecondRightTier3.center = CGPoint(x: view.bounds.width - (view.bounds.width / 3.75), y: view.bounds.height * 1.291 - 3.5)
        buttonSecondRightTier3.setTitle("click me!", for: UIControlState.normal)
        buttonSecondRightTier3.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonSecondRightTier3, state: todayLog.buttonSecondRightTier3)
    
        
        buttonSecondRightTier3.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonSecondRightTier3)
    }
    
    func addButtonLeftTier4() {
        buttonLeftTier4 = UIButton()
        buttonLeftTier4.tag = 12
        buttonLeftTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonLeftTier4.center = CGPoint(x: view.bounds.width / 6, y: view.bounds.height * 1.177 - 3.5)
        buttonLeftTier4.setTitle("click me!", for: UIControlState.normal)
        buttonLeftTier4.titleLabel?.font = UIFont(name: "Verdana", size: 15)
       
        buttonAppearance(button: buttonLeftTier4, state: todayLog.buttonLeftTier4)
        

        
        buttonLeftTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonLeftTier4)
    }
    
    func addButtonMidTier4() {
        buttonMidTier4 = UIButton()
        buttonMidTier4.tag = 13
        buttonMidTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonMidTier4.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 1.177 - 3.5)
        buttonMidTier4.setTitle("click me!", for: UIControlState.normal)
        buttonMidTier4.titleLabel?.font = UIFont(name: "Verdana", size: 15)
       
        buttonAppearance(button: buttonMidTier4, state: todayLog.buttonMidTier4)
        
        
        buttonMidTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonMidTier4)
    }
    
    func addButtonRightTier4() {
        buttonRightTier4 = UIButton()
        buttonRightTier4.tag = 14
        buttonRightTier4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3.5, height: self.view.frame.height / 12)
        buttonRightTier4.center = CGPoint(x: view.bounds.width - (view.bounds.width / 6), y: view.bounds.height * 1.177 - 3.5)
        buttonRightTier4.setTitle("click me!", for: UIControlState.normal)
        buttonRightTier4.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonRightTier4, state: todayLog.buttonRightTier4)
        
        
        buttonRightTier4.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonRightTier4)
    }
    
    func addButtonOutterLeftTier5() {
        buttonOutterLeftTier5 = UIButton()
        buttonOutterLeftTier5.tag = 15
        buttonOutterLeftTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonOutterLeftTier5.center = CGPoint(x: view.bounds.width / 7, y: view.bounds.height * 1.0625 - 3.5)
        buttonOutterLeftTier5.setTitle("click me!", for: UIControlState.normal)
        buttonOutterLeftTier5.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonOutterLeftTier5, state: todayLog.buttonOutterLeftTier5)
        
        
        buttonOutterLeftTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonOutterLeftTier5)
    }
    
    func addButtonInnerLeftTier5() {
        buttonInnerLeftTier5 = UIButton()
        buttonInnerLeftTier5.tag = 16
        buttonInnerLeftTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonInnerLeftTier5.center = CGPoint(x: ((view.bounds.width / 4.25) / 2) + (view.bounds.width / 2), y: view.bounds.height * 1.0625 - 3.5)
        buttonInnerLeftTier5.setTitle("click me!", for: UIControlState.normal)
        buttonInnerLeftTier5.titleLabel?.font = UIFont(name: "Verdana", size: 15)
       
        buttonAppearance(button: buttonInnerLeftTier5, state: todayLog.buttonInnerLeftTier5)
        
        
        buttonInnerLeftTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonInnerLeftTier5)
    }
    
    func addButtonInnerRightTier5() {
        buttonInnerRightTier5 = UIButton()
        buttonInnerRightTier5.tag = 17
        buttonInnerRightTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonInnerRightTier5.center = CGPoint(x:(view.bounds.width / 2) - ((view.bounds.width / 4.25) / 2), y: view.bounds.height * 1.0625 - 3.5)
        buttonInnerRightTier5.setTitle("click me!", for: UIControlState.normal)
        buttonInnerRightTier5.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonInnerRightTier5, state: todayLog.buttonInnerRightTier5)
        
      
        buttonInnerRightTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonInnerRightTier5)
    }
    
    func addButtonOutterRightTier5() {
        
        buttonOutterRightTier5 = UIButton()
        buttonOutterRightTier5.tag = 18
        buttonOutterRightTier5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 4.5, height: self.view.frame.height / 12)
        buttonOutterRightTier5.center = CGPoint(x: view.bounds.width - (view.bounds.width / 7), y: view.bounds.height * 1.0625 - 3.5)
        buttonOutterRightTier5.setTitle("click me!", for: UIControlState.normal)
        buttonOutterRightTier5.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        
        buttonAppearance(button: buttonOutterRightTier5, state: todayLog.buttonOutterRightTier5)
        
    
        buttonOutterRightTier5.addTarget(self, action: #selector(buttonInAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonOutterRightTier5)
    }
    
    
    
    
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
        state = todayLog.buttonTier1
        case 17: todayLog.buttonInnerRightTier5 = !todayLog.buttonInnerRightTier5
        state = todayLog.buttonInnerRightTier5
        case 18:  todayLog.buttonOutterRightTier5 = !todayLog.buttonOutterRightTier5
        state = todayLog.buttonOutterRightTier5
        default:print("none of the above")
    }
    
    // refresh the appearance of the button
    buttonAppearance(button: sender, state: state)
    self.view.setNeedsDisplay()
    
    // save the changed data to the database
    saveItems()

 }
    
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
    
    func makeSureCurrentDayLog(){
        
        //MARK: To do - add condition if date stamp is not the same as today
        let temp = dayLogArray[0]
        
        // If the data is empty or corrupted, i want to start afresh.
        if dayLogArray == nil || dayLogArray.count > 1
        {
            //Create Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Today")
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do
            {
                try context.execute(batchDeleteRequest)
            }
            catch
            {
                print("Batch delete error \(error)")
            }
            
           todayLog.buttonTier1 = false
           todayLog.message = "I've updated from batch delete loop"
           saveItems()
        }
        
        todayLog = temp
        saveItems()
        todayLog.message = "I've updated from reset"
        print(todayLog)

    }
    
    
    func saveItems(){
        do{
            try context.save() }
        catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// this is the function that determines what the button looks like in the 'on' and 'off' states.
    func buttonAppearance(button: UIButton, state: Bool)
    {
        print(state)
        if state == false
        {
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
            button.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
            button.layer.borderWidth = 5
            button.layer.cornerRadius = 20
        }
        else
        {
            button.setTitleColor(UIColor.yellow, for: UIControlState.normal)
            button.backgroundColor = UIColor.clear
        }
        button.reloadInputViews()
    }
    
    
}

