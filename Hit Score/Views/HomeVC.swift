//
//  ViewController.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit
import SnapKit
import LinkPresentation
import AppTrackingTransparency

class HomeVC: UIViewController {
    
    let containerView = UIView()
    let shareButton : UIButton = {
        var btn = UIButton()
        btn.setTitle("Share", for: .normal)
        //btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        return btn
    }()
    
    let picker = UIPickerView()
    var scoreBoard = ScoreBoardVC()
    var appName = CustomLabel(fontSize: 50, weight: .bold, text: "Hit Score")
    var screenShot = UIImage()
    var leagues : [LeagueNames] {
        var ar : [LeagueNames] = []
        LeagueNames.allCases.forEach { item in
            ar.append(item)
        }
        return ar
    }
    
    var HomeLeagueTextField = CustomTextField(fontSize: 20,haveUnderline: false)
    var AwayLeagueTextField = CustomTextField(fontSize: 20,haveUnderline: false)
    
    var firstYPos = CGFloat()
    
   

    var homeLeague = LeagueNames.Turkey_SuperLig
    var awayLeague = LeagueNames.Spain_LaLiga
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14, *) {
          ATTrackingManager.requestTrackingAuthorization { (status) in
            
            //print("IDFA STATUS: \(status.rawValue)")
          }
        }
        view.backgroundColor = .systemBackground
        setUI()
        configureUI()
        
        picker.delegate = self
        picker.dataSource = self
        
        HomeLeagueTextField.delegate = self
        AwayLeagueTextField.delegate = self

        HomeLeagueTextField.inputView = picker
        AwayLeagueTextField.inputView = picker
        
        HomeLeagueTextField.text = homeLeague.rawValue
        AwayLeagueTextField.text = awayLeague.rawValue

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        shareButton.addTarget(self, action: #selector(shareTap), for: .touchUpInside)
        
        view.bringSubviewToFront(shareButton)

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    @objc func shareTap() {
        self.screenShot = containerView.screenshot()
        

        let share = UIActivityViewController(activityItems: [self.screenShot, self], applicationActivities: nil)
        share.excludedActivityTypes = [.saveToCameraRoll]
        share.popoverPresentationController?.sourceView = self.view
        share.modalPresentationStyle = .formSheet
        share.popoverPresentationController?.sourceRect = CGRectMake(0, view.frame.height, view.frame.width, 100) // change the rect to the frame you want the view to appear
        Task{
            present(share, animated: true, completion: nil)
            
        }
        
    }
    
    func keyboardWillShow()
    {
        firstYPos = self.HomeLeagueTextField.frame.origin.y
        
        
        UIView.animate(withDuration: 0.5) {
            self.HomeLeagueTextField.frame.origin.y = (UIScreen.main.bounds.size.height - self.picker.frame.height) - self.HomeLeagueTextField.bounds.height
            self.AwayLeagueTextField.frame.origin.y = (UIScreen.main.bounds.size.height - self.picker.frame.height) - self.AwayLeagueTextField.bounds.height
        }
    }
    
    func keyboardWillHide()
    {
        UIView.animate(withDuration: 0.5) {
            self.HomeLeagueTextField.frame.origin.y = self.firstYPos
            self.AwayLeagueTextField.frame.origin.y = self.firstYPos
        }
    }
  
    
    func setUI()
    {
        view.addSubViews(containerView,shareButton)
        containerView.addSubViews(appName,scoreBoard,AwayLeagueTextField,HomeLeagueTextField)

        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.8)
            
        }
        appName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        scoreBoard.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(appName.snp.bottom).offset(20)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
        shareButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            make.height.equalTo(75)
        }

        
        HomeLeagueTextField.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom)
            make.leading.equalTo(scoreBoard).inset(10)
            make.height.equalTo(50)
            make.width.equalTo(scoreBoard.snp.width).dividedBy(2.5)
        }
        AwayLeagueTextField.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom)
            make.trailing.equalTo(scoreBoard).inset(10)
            make.height.equalTo(50)
            make.width.equalTo(scoreBoard.snp.width).dividedBy(2.5)
        }
      
    }
    
    func configureUI()
    {
        appName.textColor = .red
        HomeLeagueTextField.layer.borderWidth = 1
        HomeLeagueTextField.layer.borderColor = UIColor.label.cgColor

        AwayLeagueTextField.layer.borderWidth = 1
        AwayLeagueTextField.layer.borderColor = UIColor.label.cgColor

        shareButton.backgroundColor = .systemGreen
    }
    
}
extension HomeVC : UIActivityItemSource
{
    // MARK: Activity Item protocols
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
        
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        
        let imageProvider = NSItemProvider(object: screenShot)
        
        let metadata = LPLinkMetadata()
        metadata.title = "Description of image to share" // Preview Title
        
        
        metadata.imageProvider = imageProvider
        return metadata
    }
}
extension HomeVC : UITextFieldDelegate
{
    // MARK: TextField protocols
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardWillShow()
        textField.layer.cornerRadius = 15
        print("313?")

        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {

            textField.layer.borderColor = UIColor.systemGreen.cgColor

        }, completion: nil)
        
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardWillHide()
        print("alaka?")
        UIView.animate(withDuration: 1) {
            textField.layer.borderColor = UIColor.black.cgColor
        }

    }
}


extension HomeVC : UIPickerViewDelegate,UIPickerViewDataSource
{
    // MARK: Picker protocols
   
    
 

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0
        {
            return leagues.count
        }
        else
        {
            return leagues.count
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            HomeLeagueTextField.text = leagues[row].rawValue
            homeLeague = leagues[row]
            scoreBoard.setTeams(homeLeague: homeLeague, awayLeague: awayLeague)
            
           

        }
        else
        {
            AwayLeagueTextField.text = leagues[row].rawValue
            awayLeague = leagues[row]
            scoreBoard.setTeams(homeLeague: homeLeague, awayLeague: awayLeague)
            
            
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0
        {
            return leagues[row].rawValue
        }
        else
        {
            return leagues[row].rawValue
            
        }
    }
    
}
