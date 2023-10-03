//
//  SettingsViewController.swift
//  ColorApp
//
//  Created by Андрей Платунов on 02.10.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    
    
    // MARK: - Public Properties
    var delegate: SettingsViewControllerDelegate!
    var viewColor: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 22
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
        
        colorView.backgroundColor = viewColor
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        
    }
    
    
    
    // MARK: - IBAction
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender {
            case redSlider:
                setValue(for: redLabel)
            case greenSlider:
                setValue(for: greenLabel)
            default:
                setValue(for: blueLabel)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .clear)
        dismiss(animated: true)
    }
    
    
    
    // MARK: - private method
    private func setColor() {
        colorView.backgroundColor = UIColor (
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func fontSlider() {
        redSlider.minimumTrackTintColor = .red
        redSlider.thumbTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        greenSlider.thumbTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        blueSlider.thumbTintColor = .blue
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
                case redLabel: label.text = string(from: redSlider)
                case greenLabel: label.text = string(from: greenSlider)
                default: label.text = string(from: blueSlider)
            }
        }
    }
    
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { slider in
            switch slider {
                case redSlider: redSlider.value = Float(ciColor.red)
                case greenSlider: greenSlider.value = Float(ciColor.green)
                default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}
