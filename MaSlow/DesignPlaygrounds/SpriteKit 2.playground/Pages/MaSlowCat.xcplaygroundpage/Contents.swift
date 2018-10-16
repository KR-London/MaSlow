/* Flower design framework for Sonja from Kate */



import SpriteKit
import XCPlayground

//Make sure that you are showing the assistant editor (Command-Alt-Enter) otherwise you won't see your live view

/// this frame corresponds to the small white box placeholder in the main canvas. Size (last two parameters) is provisional, subject to confirmation in Karen's background canvas design. First two params are where the frame is - ignore these.

//Midpoint defined for later convenience

let frame = CGRect(x: 0, y: 0, width: 320, height: 256)
let midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
let point2 = CGPoint(x: frame.size.width / 2.0 + 20 , y: frame.size.height / 2.0 + 20)


var scene = SKScene(size: frame.size)

/// please replace NyanCat with a flower picture
let nyanCat = SKSpriteNode(imageNamed: "tempStalk")
nyanCat.position = midPoint
nyanCat.setScale(8.0)

let secondCat = SKSpriteNode(imageNamed: "Nyancat")
secondCat.position = point2
secondCat.setScale(2.0)
//scene.addChild(secondCat)

/// housekeeping code to present the sprite on screen
scene.addChild(nyanCat)
let view = SKView(frame: frame)
view.presentScene(scene)
/// Your animation options are
/// 1) to have multiple versions of the flower sprite with different numbers of coloured petals and present the right one depending on which days user logged on
/* 2)Have a 'stalk and leaf' sprite and a 'petal' sprite. Present 'stalk and leaf' sprite always. Then
    for i in 0 ... 6 <<< days of the week. Swift starts count from 0 always
    {
        if days_used_tracker[i] == true
        {
            let secondCat = SKSpriteNode(imageNamed: "Nyancat")
            secondCat.position = midPoint
            secondCat.setScale(2.0)
            scene.addChild(secondCat)
 
        }
 
    }
 
 3) define a compound sprite
 
 */


XCPlaygroundPage.currentPage.liveView = view

//: That's it... you could now go and be very creative building a scene of your own... Or... [Make Nyan Cat Happy](@next)
