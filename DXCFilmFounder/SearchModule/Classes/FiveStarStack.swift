//
//  5StarStack.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 21/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class FiveStarStack: UIView {

    public var rating: Float?{
        didSet{
            configView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
    super.init(frame: frame)
        
    }
    
    private func configView(){
        
        guard let rating = rating else {return}
        let rateValue = rating/10
        
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 0
        var starArray = [UIImageView]()
        
        for _ in 1...5{
            let image = UIImage(named: "star")
            let star = UIImageView(image:image )
//            star.translatesAutoresizingMaskIntoConstraints = false
            
//            star.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.2).isActive = true
//            star.heightAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
            starArray.append(star)
        }
        
        stack.addArrangedSubview(starArray[0])
        stack.addArrangedSubview(starArray[1])
        stack.addArrangedSubview(starArray[2])
        stack.addArrangedSubview(starArray[3])
        stack.addArrangedSubview(starArray[4])
        
        
        
    
        
        let color = UIView()
        color.backgroundColor = .yellow
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        color.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(color)
        addSubview(stack)
        
        color.mask = stack
        
        NSLayoutConstraint.activate([
            
            //Stack size = FiveStarStack
            stack.heightAnchor.constraint(equalTo: heightAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor),
            
            //ColorBar width = Rating Value
            color.heightAnchor.constraint(equalTo: heightAnchor),
            color.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(rateValue)),
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            color.leadingAnchor.constraint(equalTo: leadingAnchor),
            color.topAnchor.constraint(equalTo: topAnchor),
            color.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
            ])
        
    }
    
}
