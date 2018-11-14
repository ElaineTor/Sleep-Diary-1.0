//
//  StaticEntryTableViewController.swift
//  Sleep Diary 1.0
//
//  Created by VIS Swimming on 25/5/18.
//  Copyright © 2018 TOR. All rights reserved.
//

import UIKit

class StaticEntryTableViewController: UITableViewController {

    @IBOutlet weak var savebutton: UIBarButtonItem!
    
    //Sleep entry date - Picker
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
   
    
//Sleep Location - Textfield
    @IBOutlet weak var sleepLocationTextField: UITextField!
    
//Caffiene intake - yes/no buttons/textfield/ picker
    @IBOutlet weak var caffieneIntakeTextField: UITextField!
    @IBOutlet weak var caffieneYesButton: UIButton!
    @IBOutlet weak var caffieneIntakeLabel: UILabel!
    @IBOutlet weak var caffieneNoButton: UIButton!
    @IBOutlet weak var caffieneTimePicker: UIDatePicker!
    @IBOutlet weak var timeOfCaffieneLabel: UILabel!
    
//Phone Use - yes/no buttons/textfield/ picker
    @IBOutlet weak var phoneUseYesButton: UIButton!
    @IBOutlet weak var phoneUseNoButton: UIButton!
    @IBOutlet weak var phoneUseLabel: UILabel!
    @IBOutlet weak var phoneUseTextField: UITextField!
    @IBOutlet weak var phoneUseTimeLabel: UILabel!
    
//Sleep Arousal - UIPicker
    @IBOutlet weak var sleepArousalLabel: UITextField!
    
//BedTime - DatePicker
    @IBOutlet weak var bedTimeLabel: UILabel!
    @IBOutlet weak var bedTimePicker: UIDatePicker!
   
//Wake-up Time - DatePicker
    @IBOutlet weak var wakeUpLabel: UILabel!
    @IBOutlet weak var wakeUpPicker: UIDatePicker!
    
//Total Sleep Time - Label
    @IBOutlet weak var totalSleepTime: UILabel!
    
//Sleep Quality - UIPicker
    @IBOutlet weak var sleepQualityLabel: UITextField!
    
//Alertness upon waking - UIPicker
    @IBOutlet weak var alertnessLabel: UITextField!
    
//Additional Comments - Text View
    @IBOutlet weak var additionalCommentsTextView: UITextView!
    
//List of Variables
    var newSleepEntry: SleepEntry?
    var isDatePickerHidden = false
    var isBedTimePickerHidden = false
    var isWakeUpPickerHidden = false
    var isCaffienePickerHidden = false
    var isPhonePickerHidden = false

override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
        createPicker()
        hideOptionalFields()
    let midnightToday = Calendar.current.startOfDay(for: Date())
    dateDatePicker.date = midnightToday
    let toolBar = UIToolbar()
 
//add done buttons to text fields
    toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
    
    toolBar.setItems([doneButton], animated: false)
    
    sleepLocationTextField.inputAccessoryView = toolBar
    additionalCommentsTextView.inputAccessoryView = toolBar
    sleepArousalLabel.inputAccessoryView = toolBar
    sleepQualityLabel.inputAccessoryView = toolBar
    alertnessLabel.inputAccessoryView = toolBar
    caffieneIntakeTextField.inputAccessoryView = toolBar
    phoneUseTextField.inputAccessoryView = toolBar
    
    
// add a new sleep entry
    if let newSleepItem = newSleepEntry {
        dateLabel.text = newSleepItem.date
        sleepLocationTextField.text = newSleepItem.location
        caffieneIntakeLabel.text = newSleepItem.caffiene
        caffieneIntakeTextField.text = newSleepItem.caffieneAmount ?? ""
        timeOfCaffieneLabel.text  = newSleepItem.timeCaffieneIntake ?? ""
        phoneUseLabel.text = newSleepItem.phoneUse
        phoneUseTextField.text = newSleepItem.phoneUseTime ?? ""
        sleepArousalLabel.text = newSleepItem.arousal
        bedTimeLabel.text = newSleepItem.bedtime
        wakeUpLabel.text = newSleepItem.wakeupTime
        totalSleepTime.text = newSleepItem.totalSleepTime
        sleepQualityLabel.text = newSleepItem.sleepQuality
        alertnessLabel.text = newSleepItem.alertness
        additionalCommentsTextView.text = newSleepItem.additionalComments
    }
}
    
//IB Actions
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = SleepEntry.dateFormatter.string(from:dateDatePicker.date)
    }
    
    @IBAction func caffieneYesButtonPressed(_ sender: UIButton) {
        caffieneYesButton.backgroundColor = .green
        caffieneIntakeLabel.text = "YES"
        caffieneNoButton.alpha = 0.5
        caffieneYesButton.alpha = 1.0
        isCaffienePickerHidden = false
        tableView.beginUpdates()
        tableView.endUpdates()
        caffieneIntakeTextField.isHidden = false
        caffieneIntakeLabel.isHidden = false
    }
    
    @IBAction func caffieneNoButtonPressed(_ sender: UIButton) {
        caffieneNoButton.backgroundColor = .red
        caffieneIntakeLabel.text = "NO"
        caffieneYesButton.alpha = 0.5
        caffieneNoButton.alpha = 1.0
        isCaffienePickerHidden = true
        tableView.beginUpdates()
        tableView.endUpdates()
        caffieneIntakeTextField.isHidden = true
        caffieneIntakeLabel.isHidden = false
    }
    
    @IBAction func caffienePickerChanged(_ sender: UIDatePicker) {
        timeOfCaffieneLabel.text = SleepEntry.timeFormatter.string(from:caffieneTimePicker.date)
    }
    
    @IBAction func phoneUseYesButtonPressed(_ sender: UIButton) {
        phoneUseLabel.text = "YES"
        phoneUseYesButton.backgroundColor = .green
        isPhonePickerHidden = false
        phoneUseYesButton.alpha = 1.0
        phoneUseNoButton.alpha = 0.5
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func phoneUseNoButtonPressed(_ sender: UIButton) {
        phoneUseLabel.text = "NO"
        phoneUseNoButton.backgroundColor = .red
        isPhonePickerHidden = true
        phoneUseNoButton.alpha = 1.0
        phoneUseYesButton.alpha = 0.5
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    

    @IBAction func wakeUpPickerChanged(_ sender: UIDatePicker) {
        wakeUpLabel.text = SleepEntry.timeFormatter.string(from:wakeUpPicker.date)
        updateSaveButton()
        totalSleepTime.text = totalSleepDuration()
    }
    
    @IBAction func bedTimePickerChanged(_ sender: UIDatePicker) {
        bedTimeLabel.text = SleepEntry.timeFormatter.string(from:bedTimePicker.date)
        updateSaveButton()
        totalSleepTime.text = totalSleepDuration()
    }
    
func hideOptionalFields() {
        isCaffienePickerHidden = true
        isPhonePickerHidden = true
        isDatePickerHidden = true
        isWakeUpPickerHidden = true
        isBedTimePickerHidden = true
    }
    
    //CALCULATE TOTAL SLEEP
    func totalSleepDuration() -> String {
        let bedtime = bedTimePicker.date
        let waketime = wakeUpPicker.date.addingTimeInterval(60*60*24)
        let totalSleep = waketime.timeIntervalSince(bedtime)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .hour]
        
        let formattedDuration = formatter.string(from: totalSleep)
    
        return String(formattedDuration!)
        
    }
    
    
//save sleep entry
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard segue.identifier == "saveUnwind" else { return }
    
    let date = dateLabel.text
    let location = sleepLocationTextField.text
    let caffiene = caffieneIntakeLabel.text
    let timeCaffieneIntake = timeOfCaffieneLabel.text
    let caffieneAmount = caffieneIntakeTextField.text
    let phoneUse = phoneUseLabel.text
    let phoneUseTime = phoneUseTextField.text
    let arousal = sleepArousalLabel.text
    let bedtime = bedTimeLabel.text
    let wakeupTime = wakeUpLabel.text
    let sleepQuality = sleepQualityLabel.text
    let alertness = alertnessLabel.text
    let additionalComments = additionalCommentsTextView.text
    let totalSleepTime = self.totalSleepTime.text
    
    newSleepEntry = SleepEntry(date: date!, location: location!, caffiene: caffiene, timeCaffieneIntake: timeCaffieneIntake, caffieneAmount: caffieneAmount, phoneUse: phoneUse, phoneUseTime: phoneUseTime, arousal: arousal!, bedtime: bedtime!, wakeupTime: wakeupTime!, totalSleepTime: totalSleepTime!, sleepQuality: sleepQuality!, alertness: alertness!, additionalComments: additionalComments)
    
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
//table properties
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let pickerHeight = CGFloat(150)
    let hiddenHeight = CGFloat(0)
    let normalHeight = CGFloat(44)
    
    switch (indexPath) {
        
    case [0,1]:
        return !isDatePickerHidden ? pickerHeight: hiddenHeight
    case [5,1]:
        return !isBedTimePickerHidden ? pickerHeight: hiddenHeight
    case [2,4]:
        return !isCaffienePickerHidden ? pickerHeight: hiddenHeight
//    case [2,3]:
//        return !isCaffienePickerHidden ? normalHeight: hiddenHeight
//    case [2,4]:
//        return !isCaffienePickerHidden ? pickerHeight: hiddenHeight
//    case [3,2]:
//        return !isPhonePickerHidden ? pickerHeight: hiddenHeight
    case [6,1]:
        return !isWakeUpPickerHidden ? pickerHeight: hiddenHeight
    case [10,0]:
        return pickerHeight
        
    default:
        return normalHeight
        }
    }

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    switch (indexPath) {
    case [0,0]: isDatePickerHidden = !isDatePickerHidden
    
    tableView.beginUpdates()
    tableView.endUpdates()
        
    case [5,0]: isBedTimePickerHidden = !isBedTimePickerHidden
        
    tableView.beginUpdates()
    tableView.endUpdates()
    
    case [2,3]: isCaffienePickerHidden = !isCaffienePickerHidden
    
    tableView.beginUpdates()
    tableView.endUpdates()
        
    case [6,0]: isWakeUpPickerHidden = !isWakeUpPickerHidden
    
    tableView.beginUpdates()
    tableView.endUpdates()
        
    default:
        break
        }
    }
    
//UIPickerView Data
    let arousalData = ["Very High", "High", "Moderate", "Low", "None"]
    var arousalSelected: String?
    
    let sleepQualityData = ["Very Good", "Good", "Average", "Poor", "Very Poor"]
    var sleepQualitySelected: String?
    
    let alertnessData = ["Very Alert", "Alert", "Moderately Alert", "Low Alertness", "Tired"]
    var alertnessSelected: String?
    
    func createPicker() {
        let arousalUpdate = UIPickerView()
        arousalUpdate.delegate = self
        sleepArousalLabel.inputView = arousalUpdate
      
        
        let sleepQualityUpdate = UIPickerView()
        sleepQualityUpdate.delegate = self
        sleepQualityLabel.inputView = sleepQualityUpdate
        
        let alertnessUpdate = UIPickerView()
        alertnessUpdate.delegate = self
        alertnessLabel.inputView = alertnessUpdate
    }
    
//keyboard disappears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //DISABLE SAVE BUTTON
    func updateSaveButton() {
        let EntryDate = dateLabel.text ?? ""
        let EntryQuality = sleepQualityLabel.text ?? ""
        let wakeUpTime = wakeUpLabel.text ?? ""
        let bedTime = bedTimeLabel.text ?? ""
        
        savebutton.isEnabled = !EntryDate.isEmpty && !EntryQuality.isEmpty && !wakeUpTime.isEmpty && !bedTime.isEmpty
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sleepLocationTextField.resignFirstResponder()
        caffieneIntakeTextField.resignFirstResponder()
        additionalCommentsTextView.resignFirstResponder()
        return (true)
        
        }
}

//func createTimeString(seconds: Int)->String
//{
//    var h:Int = seconds / 3600
//    var m:Int = (seconds/60) % 60
//    var s:Int = seconds % 60
//    let a = String(format: "%u:%02u:%02u", h,m,s)
//    return a
//
//}


extension StaticEntryTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//add the other pickers
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sleepArousalLabel.inputView {
        return arousalData.count
        } else if pickerView == sleepQualityLabel.inputView {
            return sleepQualityData.count
        } else {
            return alertnessData.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sleepArousalLabel.inputView {
            return arousalData[row]
        } else if pickerView == sleepQualityLabel.inputView {
            return sleepQualityData[row]
        } else {
            return alertnessData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        arousalSelected = arousalData[row]
        if pickerView == sleepArousalLabel.inputView {
            sleepArousalLabel.text = arousalSelected
        } else if pickerView == sleepQualityLabel.inputView {
            sleepQualitySelected = sleepQualityData [row]
            sleepQualityLabel.text = sleepQualitySelected
            updateSaveButton()
        } else {
            alertnessSelected = alertnessData [row]
            alertnessLabel.text = alertnessSelected
            }
        }
    }

