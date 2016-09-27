//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Rohan Thomas on 2016-09-25.
//  Copyright © 2016 Rohan Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var images = [UIImageView]()
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        }
        
    override func viewDidAppear(_ animated: Bool) {
        
            var contentWidth :CGFloat = 0.0
            let ScrollWidth = ScrollView.frame.size.width //the width of the scroll view
            for x in 0...2 {
                let image = UIImage(named: "icon\(x).png") //each image is stored as a UIImage during each iteration
                let imageView = UIImageView(image: image) //the image of each iteration is stored as a UIImageView
                images.append(imageView) //images is an array of images we created that stores UIImageViews
                
                var newX: CGFloat = 0.0
                newX = ScrollWidth/2 + ScrollWidth * CGFloat(x) // the middle of the scrollView for the 0th iteration plus a ScrollWidth for each consecutive iteration
                
                contentWidth += newX //the full contentWidth is increasing by the newX each time
                
                ScrollView.addSubview(imageView) //adding the images as subviews in the ScrollView for each iteration
                
                imageView.frame = CGRect(x: newX-75, y: (ScrollView.frame.size.height/2)-75, width: 150, height: 150) // The position of each image that is contained in an imageView
        
        }

        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4) //this scales the first image. The animate code (below) only gets applied after the first swipe from the right
        
        ScrollView.clipsToBounds = false // don't clip the scrollview at its bounds
        
        ScrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height) //setting the contentsize of the ScrollView
    }
    
    @IBAction func detectSwipe(_ sender: AnyObject) {
        if (currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScrollView(direction: 1) //if the current position is less than the extreme right and its a left gesture, move right
            
        }
        
        if (currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)//vice-versa (extreme left, right gesture, move left)
        }
    
    
    }

    

    func moveScrollView(direction: Int){
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: ScrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        ScrollView.setContentOffset(point, animated: true)
        
        // Create a animation to increase the actual images on screen. This creates an animation to increase the present image's size
        UIView.animate(withDuration: 0.4){
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
 
            // Reverts the icon size of the other images
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
    


}

