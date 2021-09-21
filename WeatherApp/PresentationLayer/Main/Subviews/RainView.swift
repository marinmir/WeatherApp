//
//  RainView.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 21.09.2021.
//

import UIKit

class RainView: UIView {
    var particleImage: UIImage?

    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    func makeEmitterCell(color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 40
        cell.lifetime = 10.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 2
        cell.emissionLongitude = .pi
        cell.emissionRange = 0
        cell.scale = scale
        cell.scaleRange = scale / 2

        cell.contents = particleImage?.cgImage
        return cell
    }
    
    
    override func layoutSubviews() {
        let emitter = self.layer as! CAEmitterLayer

        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterSize = CGSize(width: bounds.size.width.advanced(by: 250), height: 1)
        
        let near = makeEmitterCell(color: UIColor(white: 1, alpha: 0.9), velocity: 600, scale: 0.27)
        let middle = makeEmitterCell(color: UIColor(white: 1, alpha: 0.66), velocity: 480, scale: 0.25)
        let far = makeEmitterCell(color: UIColor(white: 1, alpha: 0.33), velocity: 360, scale: 0.2)

        emitter.emitterCells = [near, middle, far]
        transform = CGAffineTransform(rotationAngle: .pi / 6)
    }
}
