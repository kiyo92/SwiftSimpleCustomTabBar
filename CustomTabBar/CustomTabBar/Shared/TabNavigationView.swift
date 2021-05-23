//
//  TabNavigationView.swift
//  CustomTabBar
//
//  Created by administrador on 22/05/21.
//

import Foundation
import UIKit
class TabNavigationView: UIView {
    var itemTapped: ((_ tab: Int) -> Void) = {_ in}
    var activeItem: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView: UIView = self.createTabItem(item: menuItems[i])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            self.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: itemWidth * CGFloat((i + 1))),
                itemView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            ])
            
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0) // activate the first tab
    }
    
    func createTabItem(item: TabItem) -> UIView {
        
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        
        //Set title properties
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont(name: "Helvetica", size: 13)
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        //Set icon properties
        itemIconView.image = item.icon
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarItem.layer.backgroundColor = UIColor.white.cgColor //Change item color
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            //Creating icon constraints
            itemIconView.heightAnchor.constraint(equalToConstant: 25),
            itemIconView.widthAnchor.constraint(equalToConstant: 25),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8),
            
            //Creating label constraints
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 5),
        ])
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap))) // Creating gesture for user interaction
        
        return tabBarItem
        
    }
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
        itemTapped(to)
    }
    
    //Changes color back
    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
                tabToActivate.backgroundColor = UIColor.lightGray
            })
        }
        
        self.activeItem = tab
    }
    //Changes color back
    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
                inactiveTab.backgroundColor = UIColor.white
            })
        }
    }
}
