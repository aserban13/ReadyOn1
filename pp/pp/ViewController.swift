//
//  ViewController.swift
//  pp
//
//  Created by Andreea Serban on 1/5/19.
//  Copyright © 2019 Andreea Serban. All rights reserved.
//
//What to do:
//if the power is off, only engine will work
//for the seats have it rotate between two phases: hot, cold, off
import UIKit
import FirebaseDatabase

//#import <Cocoa/Cocoa.h>


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
  
    
    
    //current temperature that it is set to
    var curr_temp = 75
    
//Activate Time
//This will set the time to what the user wants
    
    
    
    func activate_power_button(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        active_pwer = true
        
        powerbutton.setImage(UIImage(named: "poweron.png"), for: .normal)
        //change data to true
        ref.child("Climate Control").setValue(1)
    }
    //will update all the values on the table to be 0 when the power button is turned off
    func power_off_disable(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Climate Control").setValue(0)
        ref.child("Time").setValue(0)
        ref.child("Auto").setValue(0)
        ref.child("Defrost").setValue(0)
        ref.child("AC").setValue(0)
        ref.child("Heated Steering Wheel").setValue(0)
        ref.child("Heated Driver Seat").setValue(0)
        ref.child("Cooled Driver Seat").setValue(0)
        ref.child("Heated Pass Seat").setValue(0)
        ref.child("Cooled Pass Seat").setValue(0)
        ref.child("Heated Rear Seat (Driver Side)").setValue(0)
        ref.child("Cooled Rear Seat (Driver Side)").setValue(0)
        ref.child("Heated Rear Seat (Pass Side)").setValue(0)
        ref.child("Cooled Rear Seat (Pass Side)").setValue(0)
    }
//POWER BUTTON
//    Will turn on the car settings to the default setting
    @IBOutlet weak var powerbutton: UIButton!
    var active_pwer = false
    @IBAction func poweraction(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if !active_pwer {
            active_pwer = true
            powerbutton.setImage(UIImage(named: "poweron.png"), for: .normal)
            //change data to true
           ref.child("Climate Control").setValue(1)
            
        }
        else{
            power_off_disable()
            //when the power button is turned off, then all the other buttons must be turned off
            active_pwer = false
            powerbutton.setImage(UIImage(named: "poweroff.png"), for: .normal)
            //turn all the active buttons off
            if active_auto{
                active_auto = false
                autobutton.setTitleColor(UIColor.white, for:.normal)
                active_auto = false
            }
            if active_am{
                active_am = false
                AM_Button.setTitleColor(UIColor.white, for:.normal)
                AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            }
            if active_pm{
                active_pm = false
                PMbutton.setTitleColor(UIColor.white, for:.normal)
                PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            }
            if active_defrost {
                active_defrost = false
                defrostbutton.setTitleColor(UIColor.white, for:.normal)
            }
            if active_ac{
                active_ac = false
                acbutton.setTitleColor(UIColor.white, for:.normal)
                active_ac = false
            }
            if active_wheel {
                active_wheel = false
                wheelbutton.layer.borderWidth = 0.0
            }
            if active_driver {
                active_driver = false
                driverseat.layer.borderWidth = 0.0
            }
            if active_shotgun{
                active_shotgun = false
                shotgunbutton.layer.borderWidth = 0.0
            }
            if active_leftback{
                active_leftback = false
                leftbackbutton.layer.borderWidth = 0.0
            }
            if active_rightback{
                active_rightback = false
                rightbackbutton.layer.borderWidth = 0.0
            }
           
        }
    }
    
    
    
    
    
    /*
     The following function allows user to adjust the time using the up and down arrrows. Lets user selest AM or PM
     */
    
    //Time that it will be set to
    
    @IBOutlet weak var hour_label: UILabel!

    var h = 12
    var m = 00
    //Hour Manipulation
//    Increase the hour
    @IBOutlet weak var hour_up_button: UIButton!
    @IBAction func hour_increase_action(_ sender: Any) {
            if h == 12 {
                h = 1
                hour_label.text = String(h)
            }
            else{
                h += 1
                hour_label.text = String(h)
            }
    }
    @IBOutlet weak var hour_down_button: UIButton!
    @IBAction func hour_decrease_action(_ sender: Any) {
            if h == 1 {
                h = 12
                hour_label.text = String(h)
            }
            else{
                h -= 1
                hour_label.text = String(h)
            }
    }
    
    
    //Minute Manipulation
    //Will go up and down by 10
    
    @IBOutlet weak var min_label: UILabel!
    @IBOutlet weak var min_up_button: UIButton!
    @IBAction func min_increase_action(_ sender: Any) {
            if m == 50 {
                m = 0
                let lab = ": 00"
                min_label.text = lab
            }
            else{
                m += 10
                let l = ": \(m)"
                min_label.text = l
            }
    }
    
    
    @IBOutlet weak var min_down_button: UIButton!
    @IBAction func min_decrease_action(_ sender: Any) {
        if m == 0 {
            m = 50
            let lab = ": 50"
            min_label.text = lab
        }
        else if m == 10{
            m = 0
            min_label.text = ": 00"
        }
        else{
            m -= 10
            let l = ": \(m)"
            min_label.text = l
        }
    }
    // AM/PM
    //AM Default Function
    func am_default(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if !active_am {
            activate_power_button()
            active_am = true
            AM_Button.setTitleColor(UIColor.red, for:.normal)
            
            AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
             ref.child("Time").setValue(1)
        }
        else{
            active_am = false
            AM_Button.setTitleColor(UIColor.white, for:.normal)
            AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
    }
    //AM Action button function
    //Will activate AM button and adjusts based on pms status
//    if pm is active when am is going to be active, deactivate pm
    @IBOutlet weak var AM_Button: UIButton!
    var active_am = false
    @IBAction func AM_Action(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //if auto was active, turn it off
        if active_auto{
            active_auto = false
            autobutton.setTitleColor(UIColor.white, for:.normal)
            autobutton.setTitleColor(UIColor.lightGray, for:.highlighted)
            ref.child("Auto").setValue(0)
            
        }
        //when PM is not active
        if !active_pm{
          am_default()
        }
        //when PM is already active
        else{
                active_pm = false
                PMbutton.setTitleColor(UIColor.white, for:.normal)
                PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
               am_default()
        }
    }
    //PM Default Function
    func pm_default(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if !active_pm{
            activate_power_button()
            active_pm = true
            PMbutton.setTitleColor(UIColor.red, for:.normal)
            PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            ref.child("Time").setValue(1)
        }
        else{
            active_pm = false
            PMbutton.setTitleColor(UIColor.white, for:.normal)
            PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
    }
    //When the user clicks on the PM button, it will activate the PM status and deactivate the AM button if it was active
    @IBOutlet weak var PMbutton: UIButton!
    var active_pm = false
    @IBAction func PM_Action(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //if auto was active, turn it off
        if active_auto{
            active_auto = false
            autobutton.setTitleColor(UIColor.white, for:.normal)
            autobutton.setTitleColor(UIColor.lightGray, for:.highlighted)
            ref.child("Auto").setValue(0)
            
        }
        //when am is not active
            if !active_am {
               pm_default()
            }
                //when am is active
            else{
                //turn off am
                active_am = false
                AM_Button.setTitleColor(UIColor.white, for:.normal)
                AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                pm_default()
        }
        
    }
    
    
    
    
    
    
    @IBOutlet weak var temp: UILabel!
    func disable_ampm(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Time").setValue(0)
        //if AM is active, turn off
        if active_am{
            active_am = false
            AM_Button.setTitleColor(UIColor.white, for:.normal)
            AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        //if PM is active, turn off
        else if active_pm{
            active_pm = false
            PMbutton.setTitleColor(UIColor.white, for:.normal)
            PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
    }
//    AUTO button activation
//    Will allow the user to set a defualt setting of how they like their car to be prepared
    @IBOutlet weak var autobutton: UIButton!
    var active_auto = false
    @IBAction func autoAction(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if !active_auto {
            //deactivate any am or pm
            disable_ampm()
            
            active_auto = true
            activate_power_button()
            autobutton.setTitleColor(UIColor.cyan, for:.normal)
            autobutton.setTitleColor(UIColor.lightGray, for:.highlighted)
            //update the database
            ref.child("Auto").setValue(1)
            
        }
        else{
            active_auto = false
            autobutton.setTitleColor(UIColor.white, for:.normal)
            autobutton.setTitleColor(UIColor.lightGray, for:.highlighted)
            //update the database
            ref.child("Auto").setValue(0)
        }
    }
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    /*
     Adjusts the temperature in the car and buttons for defrost and A/C
     */
    
    //Temperature increases in the car (hotter)
    //    Makes the temperature go up and increase the number displayed
    
    func update_temp_data(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Temp").setValue(curr_temp)
    }
    @IBAction func hotter(_ sender: Any) {
        activate_power_button()
        curr_temp += 1
        temp.text = String(curr_temp)
        update_temp_data()
    }
    //    Temperature decreases in the car (cooler)
    //    Makes the temperature go down and decreases the temperature
    @IBAction func colder(_ sender: Any) {
        activate_power_button()
        curr_temp -= 1
        temp.text = String(curr_temp)
        update_temp_data()
    }
    
    //Defrost Defualt Function
    //Return: changes the color of the font when active and defaults to white font if not active
    func defrost_default(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //if the active defrost is false, enable settings
        if !active_defrost {
            //turn on power button
            activate_power_button()
            active_defrost = true
            defrostbutton.setTitleColor(UIColor.red, for:.normal)
            ref.child("Defrost").setValue(1)
            
            
        }
            //if the defrsot was active, but user wants to deactivate it
        else{
            active_defrost = false
            defrostbutton.setTitleColor(UIColor.white, for:.normal)
            ref.child("Defrost").setValue(0)
        }
    }
//    Activate Defrost when the power button is active
//    When defrost is active, will light up blue
//    Uses the defrost_default() function to change the color of the font
    @IBOutlet weak var defrostbutton: UIButton!
    var active_defrost = false
    @IBAction func Defaction(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
            if !active_ac{
                defrost_default()
            }
            //when ac is active
            else{
                //turn off ac
                active_ac = false
                ref.child("AC").setValue(0)
                acbutton.setTitleColor(UIColor.white, for:.normal)
                acbutton.setTitleColor(UIColor.darkGray, for:.highlighted)
                //activates or de activates defrost
                defrost_default()
            }
    }

    
    
//AC Default function
//Activates or Deactivates  the AC button
    func ac_default(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if !active_ac {
            activate_power_button()
            active_ac = true
            acbutton.setTitleColor(UIColor.cyan, for:.normal)
            acbutton.setTitleColor(UIColor.darkGray, for:.highlighted)
            
             ref.child("AC").setValue(1)
        }
        else{
            active_ac = false
            acbutton.setTitleColor(UIColor.white, for:.normal)
            acbutton.setTitleColor(UIColor.darkGray, for:.highlighted)
        
             ref.child("AC").setValue(0)
        }
    }
    
    
//    A/C starter button
//    When selected, the title text will change the color from white to cyan
    @IBOutlet weak var acbutton: UIButton!
    var active_ac = false
    @IBAction func a_ction(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
            if !active_defrost{
                ac_default()
            }
            else{
                //turn off defrost
                ref.child("Defrost").setValue(0)
                active_defrost = false
                defrostbutton.setTitleColor(UIColor.white, for:.normal)
                ac_default()
            }
    }
    
    
    
    
    
    
   /*
     Wheel Warming and Engine Warming function are listed below
     */
    //Wheel warming button
    //When selected, the border will be higlighted with a cyan colored border
    @IBOutlet weak var wheelbutton: UIButton!
    var active_wheel = false
    @IBAction func actionwheel(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
            //if it is not active, make it active
        if !active_wheel {
            active_wheel = true
            activate_power_button()
            wheelbutton.layer.borderColor = UIColor.red.cgColor
            wheelbutton.layer.borderWidth = 1.0
            ref.child("Heated Steering Wheel").setValue(1)
        }
        else{
            active_wheel = false
            wheelbutton.layer.borderWidth = 0
            ref.child("Heated Steering Wheel").setValue(0)
        }
    }
    
    
    
    
    
    
    func data_update_el_diablo(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Climate Control").setValue(1)
        ref.child("Time").setValue(0)
        ref.child("Auto").setValue(0)
        ref.child("Defrost").setValue(1)
        ref.child("AC").setValue(0)
        ref.child("Heated Steering Wheel").setValue(1)
        ref.child("Heated Driver Seat").setValue(1)
        ref.child("Cooled Driver Seat").setValue(0)
        ref.child("Heated Pass Seat").setValue(1)
        ref.child("Cooled Pass Seat").setValue(0)
        ref.child("Heated Rear Seat (Driver Side)").setValue(1)
        ref.child("Cooled Rear Seat (Driver Side)").setValue(0)
        ref.child("Heated Rear Seat (Pass Side)").setValue(1)
        ref.child("Cooled Rear Seat (Pass Side)").setValue(0)
        
    }
    func data_after_el_diablo(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Climate Control").setValue(0)
        ref.child("Time").setValue(0)
        ref.child("Auto").setValue(0)
        ref.child("Defrost").setValue(0)
        ref.child("AC").setValue(0)
        ref.child("Heated Steering Wheel").setValue(0)
        ref.child("Heated Driver Seat").setValue(0)
        ref.child("Cooled Driver Seat").setValue(0)
        ref.child("Heated Pass Seat").setValue(0)
        ref.child("Cooled Pass Seat").setValue(0)
        ref.child("Heated Rear Seat (Driver Side)").setValue(0)
        ref.child("Cooled Rear Seat (Driver Side)").setValue(0)
        ref.child("Heated Rear Seat (Pass Side)").setValue(0)
        ref.child("Cooled Rear Seat (Pass Side)").setValue(0)
    }
//    turn off AC button, auto, am, pm
    func deactivate_during_el_diablo(){
        active_ac = false
        acbutton.setTitleColor(UIColor.white, for:.normal)
        acbutton.setTitleColor(UIColor.darkGray, for:.highlighted)
        //turn off am
        active_am = false;
        AM_Button.setTitleColor(UIColor.white, for:.normal)
        AM_Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //turn off pm
        active_pm = false;
        PMbutton.setTitleColor(UIColor.white, for:.normal)
        PMbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //turn off auto
        active_auto = false;
        autobutton.setTitleColor(UIColor.white, for:.normal)
        autobutton.setTitleColor(UIColor.lightGray, for:.highlighted)
    }
    //TO DO: Do three modes: red, green, none
    //Engine warming button
    //When selected, the border will be highlighted with a cyan colored border
    //active all heat engine
    func activate_el_diablo(){
      
        enginebutton.layer.borderColor = UIColor.red.cgColor
        enginebutton.layer.borderWidth = 1.0
        enginebutton.setImage(UIImage(named: "HOT engine Lightening2.png"), for: .normal)
        activate_power_button()
        deactivate_during_el_diablo()
        data_update_el_diablo()
        //defrost on
//        if !active_defrost{
        active_defrost = true
        defrostbutton.setTitle("MAX Defrost", for: .normal)
        defrostbutton.setTitleColor(UIColor.red, for:.normal)
//        }
//        if !active_wheel{
        active_wheel = true
        wheelbutton.layer.borderColor = UIColor.red.cgColor
        wheelbutton.layer.borderWidth = 1.0
//        }
    
//        if !active_driver{
        active_driver = true
        heat_driver = true
        cool_driver = false
        driverseat.layer.borderColor = UIColor.red.cgColor
        driverseat.layer.borderWidth = 1.0
//        }
//        if !active_shotgun{
        active_shotgun = true
        heat_shotgun = true
        cool_driver = false
        shotgunbutton.layer.borderColor = UIColor.red.cgColor
        shotgunbutton.layer.borderWidth = 1.0
//        }
//        if !active_leftback{
        active_leftback = true
        heat_leftback = true
        cool_leftback = false
        leftbackbutton.layer.borderColor = UIColor.red.cgColor
        leftbackbutton.layer.borderWidth = 1.0
//        }
//        if !active_rightback{
        active_rightback = true
        heat_rightback = true
        cool_rightback = false
        rightbackbutton.layer.borderColor = UIColor.red.cgColor
        rightbackbutton.layer.borderWidth = 1.0
//        }
        
    }
    
    //deactives the functions that were enables when all heat was activated
    func after_el_diablo(){
        data_after_el_diablo()
        enginebutton.layer.borderWidth = 0.0
        enginebutton.setImage(UIImage(named: "engine.png"), for: .normal)
        
        active_defrost = false
        defrostbutton.setTitleColor(UIColor.white, for:.normal)
        defrostbutton.setTitle("Defrost", for: .normal)
        
        active_wheel = false
        wheelbutton.layer.borderWidth = 0.0
        
        active_driver = false
        heat_driver = false
        cool_driver = false
        driverseat.layer.borderWidth = 0.0
        
        active_shotgun = false
        heat_shotgun = false
        cool_shotgun = false
        shotgunbutton.layer.borderWidth = 0.0
        
        active_leftback = false
        heat_leftback = false
        cool_leftback = false
        leftbackbutton.layer.borderWidth = 0.0
        
        active_rightback = false
        heat_rightback = false
        cool_rightback = false
        rightbackbutton.layer.borderWidth = 0.0
        
        active_pwer = false
        powerbutton.setImage(UIImage(named: "poweroff.png"), for: .normal)
    }
    @IBOutlet weak var enginebutton: UIButton!
    var active_hot = false
    var active_plug = false
    var active_eco = false
    var active_ecoplug = false
    var active_remote = false
    @IBAction func actionengine(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //regular engine
        //turn off hot
        if active_hot{
            ref.child("Engine HOT").setValue(0)
            active_hot = false
            after_el_diablo()
            
            ref.child("Engine Remote").setValue(0)
            ref.child("Engine Plug").setValue(0)
            ref.child("Engine Eco").setValue(0)
            ref.child("Engine EcoPlug").setValue(0)
            ref.child("Engine HOT").setValue(0)
            
        }
        else if active_remote{
            active_remote = false
            active_plug = true
            enginebutton.layer.borderColor = UIColor.red.cgColor
            enginebutton.layer.borderWidth = 1.0
            enginebutton.setImage(UIImage(named: "engine with plug.png"), for: .normal)
            ref.child("Engine Remote").setValue(0)
            ref.child("Engine Plug").setValue(1)
            ref.child("Engine Eco").setValue(0)
            ref.child("Engine EcoPlug").setValue(0)
            ref.child("Engine HOT").setValue(0)
            

        }
        else if active_plug{
            active_plug = false
            active_eco = true;
            enginebutton.layer.borderColor = UIColor.green.cgColor
            enginebutton.layer.borderWidth = 1.0
            enginebutton.setImage(UIImage(named: "engine ECO.png"), for: .normal)
            ref.child("Engine Remote").setValue(0)
            ref.child("Engine Plug").setValue(0)
            ref.child("Engine Eco").setValue(1)
            ref.child("Engine EcoPlug").setValue(0)
            ref.child("Engine HOT").setValue(0)

        }
        else if active_eco{
            active_eco = false
            active_ecoplug = true;
            enginebutton.layer.borderColor = UIColor.green.cgColor
            enginebutton.layer.borderWidth = 1.0
            enginebutton.setImage(UIImage(named: "engine ECO plug green.png"), for: .normal)

            ref.child("Engine Remote").setValue(0)
            ref.child("Engine Plug").setValue(0)
            ref.child("Engine Eco").setValue(0)
            ref.child("Engine EcoPlug").setValue(1)
            ref.child("Engine HOT").setValue(0)
        }
            //turn on hot
        else if active_ecoplug{
            active_ecoplug = false
            active_hot = true
            
            ref.child("Engine Remote").setValue(0)
            ref.child("Engine Plug").setValue(0)
            ref.child("Engine Eco").setValue(0)
            ref.child("Engine EcoPlug").setValue(0)
            ref.child("Engine HOT").setValue(1)
            activate_el_diablo()
        }
        else{
            active_remote = true
            enginebutton.layer.borderColor = UIColor.red.cgColor
            enginebutton.layer.borderWidth = 1.0
            enginebutton.setImage(UIImage(named: "Remote Engine Start.png"), for: .normal)
            ref.child("Engine Remote").setValue(1)
            ref.child("Engine Plug").setValue(0)
            ref.child("Engine Eco").setValue(0)
            ref.child("Engine EcoPlug").setValue(0)
            ref.child("Engine HOT").setValue(0)
        }
    }
    
    
    /*
     This section is for the heated/cooled seats
     Below is the code for: the drivers set, shotgun seat, left back, and right back seats
     Each of these seats take into account which setting is enabled
     
     */
   
//    Driver seat heated/cooled seats
    @IBOutlet weak var driverseat: UIButton!
    var active_driver = false
    var heat_driver = false
    var cool_driver = false
    @IBAction func driver_heat_action(_ sender: Any) {
        //the order is heat, cool, nothing
        var ref: DatabaseReference!
        ref = Database.database().reference()
        activate_power_button()
        if !active_driver{
            active_driver = true
            heat_driver = true
            cool_driver = false
            driverseat.layer.borderColor = UIColor.red.cgColor
            driverseat.layer.borderWidth = 1.0
            ref.child("Heated Driver Seat").setValue(1)
            ref.child("Cooled Driver Seat").setValue(0)
            
        }
        else if heat_driver {
            active_driver = true
            heat_driver = false
            cool_driver = true
            driverseat.layer.borderColor = UIColor.cyan.cgColor
            driverseat.layer.borderWidth = 1.0
            ref.child("Heated Driver Seat").setValue(0)
            ref.child("Cooled Driver Seat").setValue(1)
        }
        else if cool_driver{
            active_driver = false
            heat_driver = false
            cool_driver = false
            driverseat.layer.borderWidth = 0.0
            ref.child("Heated Driver Seat").setValue(0)
            ref.child("Cooled Driver Seat").setValue(0)
        }
    }
    
// Pass(Shotgun) heated/cooled seats
    @IBOutlet weak var shotgunbutton: UIButton!
    var active_shotgun = false
    var heat_shotgun = false
    var cool_shotgun = false
    @IBAction func shotgun_action(_ sender: Any) {
        //the order is heat, cool, nothing
        var ref: DatabaseReference!
        ref = Database.database().reference()
        activate_power_button()
        if !active_shotgun{
            active_shotgun = true
            heat_shotgun = true
            cool_shotgun = false
            shotgunbutton.layer.borderColor = UIColor.red.cgColor
            shotgunbutton.layer.borderWidth = 1.0
            ref.child("Heated Pass Seat").setValue(1)
            ref.child("Cooled Pass Seat").setValue(0)
        }
        else if heat_shotgun {
            active_shotgun = true
            heat_shotgun = false
            cool_shotgun = true
            shotgunbutton.layer.borderColor = UIColor.cyan.cgColor
            shotgunbutton.layer.borderWidth = 1.0
            ref.child("Heated Pass Seat").setValue(0)
            ref.child("Cooled Pass Seat").setValue(1)
        }
        else if cool_shotgun{
            active_shotgun = false
            heat_shotgun = false
            cool_shotgun = false
            shotgunbutton.layer.borderWidth = 0.0
            ref.child("Heated Pass Seat").setValue(0)
            ref.child("Cooled Pass Seat").setValue(0)
        }
    }
    
    
    @IBOutlet weak var leftbackbutton: UIButton!
    var active_leftback = false
    var heat_leftback = false
    var cool_leftback = false
    @IBAction func leftback_action(_ sender: Any) {
            //the order is heat, cool, nothing
        var ref: DatabaseReference!
        ref = Database.database().reference()
        activate_power_button()
        if !active_leftback{
            active_leftback = true
            heat_leftback = true
            cool_leftback = false
            leftbackbutton.layer.borderColor = UIColor.red.cgColor
            leftbackbutton.layer.borderWidth = 1.0
            ref.child("Heated Rear Seat (Driver Side)").setValue(1)
            ref.child("Cooled Rear Seat (Driver Side)").setValue(0)

        }
        else if heat_leftback {
            active_leftback = true
            heat_leftback = false
            cool_leftback = true
            leftbackbutton.layer.borderColor = UIColor.cyan.cgColor
            leftbackbutton.layer.borderWidth = 1.0
            ref.child("Heated Rear Seat (Driver Side)").setValue(0)
            ref.child("Cooled Rear Seat (Driver Side)").setValue(1)
        }
        else if cool_leftback{
            active_leftback = false
            heat_leftback = false
            cool_leftback = false
            leftbackbutton.layer.borderWidth = 0.0
            ref.child("Heated Rear Seat (Driver Side)").setValue(0)
            ref.child("Cooled Rear Seat (Driver Side)").setValue(0)
        }
    }
    
    
    @IBOutlet weak var rightbackbutton: UIButton!
    var active_rightback = false
    var heat_rightback = false
    var cool_rightback = false
    @IBAction func rightback_action(_ sender: Any) {
            //the order is heat, cool, nothing
        var ref: DatabaseReference!
        ref = Database.database().reference()
            if !active_rightback{
                active_rightback = true
                heat_rightback = true
                cool_rightback = false
                rightbackbutton.layer.borderColor = UIColor.red.cgColor
                rightbackbutton.layer.borderWidth = 1.0
                ref.child("Heated Rear Seat (Pass Side)").setValue(1)
                ref.child("Cooled Rear Seat (Pass Side)").setValue(0)
            }
            else if heat_rightback {
                active_rightback = true
                heat_rightback = false
                cool_rightback = true
                rightbackbutton.layer.borderColor = UIColor.cyan.cgColor
                rightbackbutton.layer.borderWidth = 1.0
                ref.child("Heated Rear Seat (Pass Side)").setValue(0)
                ref.child("Cooled Rear Seat (Pass Side)").setValue(1)
            }
            else if cool_rightback{
                active_rightback = false
                heat_rightback = false
                cool_rightback = false
                rightbackbutton.layer.borderWidth = 0.0
                ref.child("Heated Rear Seat (Pass Side)").setValue(0)
                ref.child("Cooled Rear Seat (Pass Side)").setValue(0)
            }
    }
}

