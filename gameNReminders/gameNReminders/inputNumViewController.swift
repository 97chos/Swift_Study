//
//  inputNumViewController.swift
//  gameNReminders
//
//  Created by sangho Cho on 2020/11/15.
//

import Foundation
import UIKit
import SnapKit

protocol inputNumDelegate: class {
    func didInputed(number: Int)
}

class inputNumViewController: UIViewController {
    var currentTitle = UILabel()
    var currentValue = UILabel()
    var correctTitle = UILabel()
    var correctRange = UILabel()


    var zero = UIButton(type: .system)
    var one = UIButton(type: .system)
    var two = UIButton(type: .system)
    var thr = UIButton(type: .system)
    var four = UIButton(type: .system)
    var five = UIButton(type: .system)
    var six = UIButton(type: .system)
    var sev = UIButton(type: .system)
    var eig = UIButton(type: .system)
    var nine = UIButton(type: .system)
    var delete = UIButton(type: .system)
    var done = UIButton(type: .system)

    let ad = UIApplication.shared.delegate as? AppDelegate
    var delegate: inputNumDelegate?
    var result = ""
    lazy var margin = self.view.layoutMarginsGuide

    override func viewDidLoad() {

        let buttonList = [zero,one,two,thr,four,five,six,sev,eig,nine,delete,done]
        let buttonTitles = ["0","1","2","3","4","5","6","7","8","9","delete","Done"]

        for n in 0..<buttonList.count {
            self.buttonLayout(button: buttonList[n], title: buttonTitles[n])
        }

        self.view.backgroundColor = .white

        self.view.addSubview(currentTitle)
        self.view.addSubview(currentValue)
        self.view.addSubview(correctTitle)
        self.view.addSubview(correctRange)

        //MARK:-- Keypad StackView 구문

        let containerRow = stackViewFactory(type: .vertical)
        containerRow.axis = .vertical
        let row1 = stackViewFactory(type: .horizontal)
        let row2 = stackViewFactory(type: .horizontal)
        let row3 = stackViewFactory(type: .horizontal)
        let row4 = stackViewFactory(type: .horizontal)

        self.view.addSubview(containerRow)
        containerRow.widthAnchor.constraint(equalTo: margin.widthAnchor).isActive = true
        containerRow.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.55).isActive = true
        containerRow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerRow.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -10).isActive = true

        row1.addArrangedSubview(one)
        row1.addArrangedSubview(two)
        row1.addArrangedSubview(thr)

        row2.addArrangedSubview(four)
        row2.addArrangedSubview(five)
        row2.addArrangedSubview(six)

        row3.addArrangedSubview(sev)
        row3.addArrangedSubview(eig)
        row3.addArrangedSubview(nine)

        row4.addArrangedSubview(delete)
        row4.addArrangedSubview(zero)
        row4.addArrangedSubview(done)

        containerRow.addArrangedSubview(row1)
        containerRow.addArrangedSubview(row2)
        containerRow.addArrangedSubview(row3)
        containerRow.addArrangedSubview(row4)

        currentTitleLayout()
        currentValueLayout()
        correctTitleLayout()
        correctRangeLayout()

        one.addTarget(self, action: #selector(oneAction), for: .touchUpInside)
        two.addTarget(self, action: #selector(twoAction), for: .touchUpInside)
        thr.addTarget(self, action: #selector(thrAction), for: .touchUpInside)
        four.addTarget(self, action: #selector(fourAction), for: .touchUpInside)
        five.addTarget(self, action: #selector(fiveAction), for: .touchUpInside)
        six.addTarget(self, action: #selector(sixAction), for: .touchUpInside)
        sev.addTarget(self, action: #selector(sevAction), for: .touchUpInside)
        eig.addTarget(self, action: #selector(eigAction), for: .touchUpInside)
        nine.addTarget(self, action: #selector(nineAction), for: .touchUpInside)
        zero.addTarget(self, action: #selector(zeroAction), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        done.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {

        if result == "Up" && (ad?.paramMin)! < (ad?.paramValue)! {
            ad?.paramMin = (ad?.paramValue)!
        } else if result == "Down" && (ad?.paramMax)! > (ad?.paramValue)! {
            ad?.paramMax = (ad?.paramValue)!
        }
        correctRange.text = "\((ad?.paramMin)!) ~ \((ad?.paramMax)!)"
    }

    func currentTitleLayout() {
        currentTitle.text = "현재 입력 값"
        currentTitle.textColor = .black
        currentTitle.textAlignment = .center
        currentTitle.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
    }

    func currentValueLayout() {
        currentValue.text = ""
        currentValue.font = UIFont.boldSystemFont(ofSize: 30)
        currentValue.textColor = .black
        currentValue.textAlignment = .center
        currentValue.snp.makeConstraints() {
            $0.top.equalTo(currentTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
    }

    func correctTitleLayout() {
        correctTitle.text = "정답 범위"
        correctTitle.textColor = .black
        correctTitle.textAlignment = .center
        correctTitle.snp.makeConstraints() {
            $0.top.equalTo(currentValue.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
    }

    func correctRangeLayout() {
        correctRange.text = "0 ~ 100"
        correctRange.font = UIFont.boldSystemFont(ofSize: 30)
        correctRange.textColor = .black
        correctRange.textAlignment = .center
        correctRange.snp.makeConstraints() {
            $0.top.equalTo(correctTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    //MARK:-- Keypad Layout
    func stackViewFactory(type: NSLayoutConstraint.Axis) -> UIStackView {
        let row = UIStackView()
        row.axis = type
        row.alignment = .fill
        row.distribution = .fillEqually
        row.spacing = 10
        row.translatesAutoresizingMaskIntoConstraints = false

        return row
    }

    func buttonLayout(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
    }

    @objc func oneAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "1"
        }
    }
    @objc func twoAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "2"
        }
    }
    @objc func thrAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "3"
        }
    }
    @objc func fourAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "4"
        }
    }
    @objc func fiveAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "5"
        }
    }
    @objc func sixAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "6"
        }
    }
    @objc func sevAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "7"
        }
    }
    @objc func eigAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "8"
        }
    }
    @objc func nineAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "9"
        }
    }
    @objc func zeroAction() {
        if currentValue.text!.count > 1 {
            currentValue.text? += ""
        } else {
            currentValue.text? += "0"
        }
    }
    @objc func deleteAction() {
        self.currentValue.text = String(self.currentValue.text?.dropLast() ?? "")
    }
    @objc func doneAction() {
        guard let number = Int(self.currentValue.text ?? "") else {
            self.dismiss(animated: true)
            return
        }

        self.delegate?.didInputed(number: number)
        self.ad?.paramValue = number

        self.dismiss(animated: true)

    }

}
