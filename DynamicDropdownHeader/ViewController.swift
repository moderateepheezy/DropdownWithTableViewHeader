//
//  ViewController.swift
//  DynamicDropdownHeader
//
//  Created by SimpuMind on 8/21/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dropDownButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        button.setTitle("Drow me down!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableView: UITableView = {
       let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let containerView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isClicked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dropDownButton)
        view.addSubview(containerView)
        containerView.addSubview(tableView)
    
        dropDownButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dropDownButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        dropDownButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        dropDownButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        containerView.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: dropDownButton.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.rowHeight = 80
        tableView.clipsToBounds = true
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        dropDownButton.addTarget(self, action: #selector(dropDown(button:)), for: .touchUpInside)
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! CustomTableViewHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(section == 0) {
            return 3
        } else if(section == 1) {
            return 5
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Soft Drinks"
        } else if(section == 1){
            return "Non Alcoholic"
        }else{
            return "Alcoholic"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        //cell.textLabel?.text = "Hello"
        
        if indexPath.section == 0 {
            cell.label.text = "Coca-Cola"
        }else if indexPath.section == 1 {
            cell.label.text = "Coca-Cola"
        }else if indexPath.section == 2 {
            cell.label.text = "Coca-Cola"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            tableView.reloadData()
            UIView.animate(withDuration: 0.5, animations: {
                self.isClicked = true
                self.containerView.isHidden = true
            })
        }
    }
    
    func dropDown(button: UIButton){
        
        if !isClicked{
            UIView.animate(withDuration: 0.5, animations: {
                self.isClicked = true
                self.containerView.isHidden = false
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.isClicked = false
                self.containerView.isHidden = true
            })
        }
    }
}


class CustomCell: UITableViewCell{
    
    let imgView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "coca-cola")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var label: UILabel = {
       let l = UILabel()
        l.text = "Coca-Cola"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let subLabel: UILabel = {
        let l = UILabel()
        l.text = "Soft Drink 330ml Bottle"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let priceLabel: UILabel = {
        let l = UILabel()
        l.text = "1,30 ⍷"
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(label)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(subLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    func setupViews(){
        
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.leftAnchor.constraint(equalTo: imgView.leftAnchor, constant: 50).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        subLabel.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 20).isActive = true
        subLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        subLabel.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
    }
}

//
// MARK :- HEADER
//
class CustomTableViewHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.89453125, green: 0.89453125, blue: 0.89453125, alpha: 1)
        textLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}

