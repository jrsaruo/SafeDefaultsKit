//
//  ViewController.swift
//  Demo
//
//  Created by Yusaku Nishi on 2017/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    private let firstnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Firstname"
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    private let lastnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Lastname"
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Age"
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private let mainColorSelector: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.insertSegment(withTitle: "Red", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Blue", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Green", at: 0, animated: false)
        return segmentedControl
    }()
    private let useCloudSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        return button
    }()
    private let removeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("RemoveAll", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        return button
    }()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SafeDefaults Demo"
        
        // set delegates
        self.firstnameTextField.delegate = self
        self.lastnameTextField.delegate = self
        self.ageTextField.delegate = self
        
        loadDefaults(animated: false)
        setViews()
        addTargets()
    }
    
    private func loadDefaults(animated: Bool) {
        // test getter methods of SafeDefaults
        let profileDefaults = ProfileDefaults()
        self.firstnameTextField.text = profileDefaults.string(forKey: .firstname)
        self.lastnameTextField.text = profileDefaults.string(forKey: .lastname)
        self.ageTextField.text = profileDefaults.string(forKey: .age)
        
        let settingDefaults = SettingDefaults()
        self.mainColorSelector.selectedSegmentIndex = settingDefaults.integer(forKey: .mainColorIndex) ?? 0 // MARK: integer(forKey:) method returns Optional<Int> value
        self.useCloudSwitch.setOn(settingDefaults.bool(forKey: .syncWithCloud), animated: animated)
    }
    
    private func setViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.firstnameTextField)
        self.stackView.addArrangedSubview(self.lastnameTextField)
        self.stackView.addArrangedSubview(self.ageTextField)
        
        self.stackView.addArrangedSubview(self.mainColorSelector)
        self.stackView.addArrangedSubview(self.useCloudSwitch)
        
        self.view.addSubview(self.saveButton)
        self.view.addSubview(self.removeAllButton)
        
        // layout subviews
        self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 35).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -35).isActive = true
        self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.saveButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 50).isActive = true
        self.saveButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
        self.saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.removeAllButton.topAnchor.constraint(equalTo: self.saveButton.bottomAnchor, constant: 20).isActive = true
        self.removeAllButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        self.removeAllButton.widthAnchor.constraint(equalTo: self.saveButton.widthAnchor).isActive = true
        self.removeAllButton.heightAnchor.constraint(equalTo: self.saveButton.heightAnchor).isActive = true
        self.removeAllButton.centerXAnchor.constraint(equalTo: self.saveButton.centerXAnchor).isActive = true
    }
    
    private func addTargets() {
        self.saveButton.addTarget(self, action: #selector(self.saveButtonClicked), for: .touchUpInside)
        self.removeAllButton.addTarget(self, action: #selector(self.removeAllButtonClicked), for: .touchUpInside)
    }
    
    // MARK: -
    @objc private func saveButtonClicked(sender: UIButton) {
        // test setter methods of SafeDefaults
        let profileDefaults = ProfileDefaults()
        profileDefaults.set(self.firstnameTextField.text, forKey: .firstname)
        profileDefaults.set(self.lastnameTextField.text, forKey: .lastname)
        profileDefaults.set(self.ageTextField.text, forKey: .age)
        
        let settingDefaults = SettingDefaults()
        settingDefaults.set(self.mainColorSelector.selectedSegmentIndex, forKey: .mainColorIndex)
        settingDefaults.set(self.useCloudSwitch.isOn, forKey: .syncWithCloud)
        
        let alert = UIAlertController(title: "Saved",
                                      message: "Please try restarting application and make sure that values are saved.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func removeAllButtonClicked(sender: UIButton) {
        // test removeObject(forKey:) method of SafeDefaults
        let profileDefaults = ProfileDefaults()
        profileDefaults.removeObject(forKey: .firstname)
        profileDefaults.removeObject(forKey: .lastname)
        profileDefaults.removeObject(forKey: .age)
        
        let settingDefaults = SettingDefaults()
        settingDefaults.removeObject(forKey: .mainColorIndex)
        settingDefaults.removeObject(forKey: .syncWithCloud)
        
        loadDefaults(animated: true) // reload views
        
        let alert = UIAlertController(title: "Removed all values",
                                      message: "Please try restarting application and make sure that values are removed.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate -
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
