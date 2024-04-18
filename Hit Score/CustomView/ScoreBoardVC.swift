//
//  ScoreBoardVC.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit
import SnapKit

class ScoreBoardVC: UIView
{
    var homeTeams : [Team] = []
    var awayTeams : [Team] = []
    
    var scoreBackground = UIView()
    var homeTeamTextField = CustomTextField(fontSize: 30,haveUnderline: true)
    var awayTeamTextField = CustomTextField(fontSize: 30,haveUnderline: true)
    
    var currentTextField = UITextField()
    
    var vsLabel = CustomLabel(fontSize: 30, weight: .bold, text: "V")
    var stadiumName = CustomLabel(fontSize: 30, weight: .bold, text: "")
    
    var homeTeamScoreTextField = CustomTextField(fontSize: 45,haveUnderline: false)
    var awayTeamScoreTextField = CustomTextField(fontSize: 45,haveUnderline: false)
    
    var homeLabel = CustomLabel(fontSize: 20, weight: .semibold, text: "Home")
    var awayLabel = CustomLabel(fontSize: 20, weight: .semibold, text: "Away")
    
    
    var scoreSeperator = CustomLabel(fontSize: 30, weight: .bold, text: "-")
    let teamPicker = UIPickerView()
    let scorePicker = UIPickerView()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupUI()
        configureUI()
        
        teamPicker.delegate = self
        teamPicker.dataSource = self
        
        scorePicker.delegate = self
        scorePicker.dataSource = self
        
        homeTeamTextField.delegate = self
        awayTeamTextField.delegate = self
        
        homeTeamScoreTextField.delegate = self
        awayTeamScoreTextField.delegate = self
        
        scoreBackground.backgroundColor = .systemBackground
        
        homeTeamTextField.inputView = teamPicker
        awayTeamTextField.inputView = teamPicker
        
        homeTeamScoreTextField.inputView = scorePicker
        awayTeamScoreTextField.inputView = scorePicker
        
        
        
        setTeams(homeLeague: .Turkey_SuperLig, awayLeague: .Turkey_SuperLig)
        
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTeams(homeLeague : LeagueNames , awayLeague : LeagueNames)
    {
        if homeTeams != LeagueService.getLeagueTeams(with: String(describing: homeLeague))
        {
            homeTeams.removeAll()
            for item in LeagueService.getLeagueTeams(with: String(describing: homeLeague))
            {
                homeTeams.append(item)
                
            }
            homeTeamTextField.text = homeTeams.first?.team_name
            stadiumName.text =  homeTeams.first?.team_stadium

        }
           
        if awayTeams != LeagueService.getLeagueTeams(with: String(describing: awayLeague))
        {
            awayTeams.removeAll()
            for item in LeagueService.getLeagueTeams(with: String(describing: awayLeague))
            {
                awayTeams.append(item)
                
            }
            awayTeamTextField.text = awayTeams.first?.team_name

        }
       
     

    }
    
    
    func configureUI()
    {
        homeTeamScoreTextField.text = "0"
        awayTeamScoreTextField.text = "0"
        homeTeamTextField.text = "Trabzonspor"
        awayTeamTextField.text = "Trabzonspor"
        
        homeLabel.textColor = .systemRed
        awayLabel.textColor = .systemBlue
        
        
    }
    
    func setupUI()
    {
        self.addSubViews(scoreBackground,homeTeamScoreTextField,awayTeamScoreTextField,scoreSeperator,stadiumName,homeLabel,awayLabel)
        scoreBackground.addSubViews(homeTeamTextField,awayTeamTextField,vsLabel)
        
        scoreBackground.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(50)
            make.top.equalTo(self)
        }
        
        homeTeamTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(scoreBackground.snp.width).dividedBy(2).offset(-40)
            make.top.bottom.equalToSuperview()
        }
        
        awayTeamTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(scoreBackground.snp.width).dividedBy(2).offset(-40)
            make.top.bottom.equalToSuperview()
        }
        
        homeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(homeTeamTextField.snp.top)
            make.centerX.equalTo(homeTeamTextField)
            
        }
        
        awayLabel.snp.makeConstraints { make in
            make.bottom.equalTo(awayTeamTextField.snp.top)
            make.centerX.equalTo(awayTeamTextField)
            
        }
        
        vsLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamTextField.snp.trailing)
            make.trailing.equalTo(awayTeamTextField.snp.leading)
            make.bottom.top.equalTo(awayTeamTextField)
            
        }
        
        homeTeamScoreTextField.snp.makeConstraints { make in
            make.trailing.equalTo(homeTeamTextField)
            make.top.equalTo(scoreBackground.snp.bottom).offset(30)
            make.width.equalTo(homeTeamTextField).dividedBy(2)
            make.height.equalTo(100)
        }
        
        awayTeamScoreTextField.snp.makeConstraints { make in
            make.leading.equalTo(awayTeamTextField)
            make.top.equalTo(scoreBackground.snp.bottom).offset(30)
            make.width.equalTo(awayTeamTextField).dividedBy(2)
            make.height.equalTo(100)
        }
        
        scoreSeperator.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamScoreTextField.snp.trailing)
            make.trailing.equalTo(awayTeamScoreTextField.snp.leading)
            make.centerY.equalTo(homeTeamScoreTextField)
            make.height.equalTo(30)
        }
        
        stadiumName.snp.makeConstraints { make in
            make.top.equalTo(awayTeamScoreTextField.snp.bottom)
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
    }
    
    
}


extension ScoreBoardVC : UITextFieldDelegate
{
    // MARK: Text Field Protocols
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        var tf = self.currentTextField as! CustomTextField
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            tf.underlineLayer.backgroundColor = UIColor.red.cgColor

        }, completion: nil)
    }
    
}


extension ScoreBoardVC : UIPickerViewDelegate,UIPickerViewDataSource
{
    // MARK: Picker Protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == teamPicker
        {
            if currentTextField == homeTeamTextField
            {
                return homeTeams.count
                
            }
            else
            {
                return awayTeams.count
                
            }
        }
        else
        {
            return 10
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == teamPicker
        {
            if currentTextField == homeTeamTextField
            {
                return homeTeams[row].team_name
                
            }
            else
            {
                return awayTeams[row].team_name
                
            }
        }
        else
        {
            return String(row)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == teamPicker
        {
            if currentTextField == homeTeamTextField
            {
                currentTextField.text = homeTeams[row].team_name
                stadiumName.text =  homeTeams[row].team_stadium
            }
            else
            {
                currentTextField.text = awayTeams[row].team_name
                
            }
        }
        else
        {
            if currentTextField == homeTeamScoreTextField
            {
                
                currentTextField.text = String(row)
                
            }
            else
            {
                currentTextField.text = String(row)
                
            }
        }
        
        
    }
    
    
    
}
