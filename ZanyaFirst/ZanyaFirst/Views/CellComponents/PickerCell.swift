//////
//////  PickerCell.swift
//////  ZanyaFirst
//////
//////  Created by Kimjaekyeong on 2023/07/25.
//////
////
//import SwiftUI
//
//struct examplePicker {
//    let picker = UIDatePicker()
//    let toolbar = UIToolbar()
//    
//    func creatDatePicker() {
//        //toolbar
//        toolbar.barTintColor = UIColor(named: "F8F8F8")
//        toolbar.clipsToBounds = true
//        toolbar.sizeToFit()
//        
//        //done button for toolbar
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
//        let g = UIImage(named: "timePicker_check")
//        let done = UIBarButtonItem(image:g,style: .plain, target: nil, action: #selector(donePressed))
//        done.tintColor = UIColor(named: "25808E")
//        toolbar.setItems([flexibleSpace,done], animated: false)
//        
//        picker.datePickerMode = .time
//        picker.backgroundColor = UIColor(named: "F8F8F8")
//    }
//    
//    @objc func donePressed() {
//        let pickDateType = picker.date
//        
//        userDefaults.set(pickerDateType, forKey:"AlarmTime")
//        userDefaults.synchronize()
//        
//        
//    }
//}
//
//
//
//struct PickerCell: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct PickerCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerCell()
//    }
//}
