/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

//  Vacation 360
//
//  Created by Ahmed on 3/21/18.
//  Copyright © 2018 RayWenderlich. All rights reserved.
//



import UIKit


class VacationViewController: UIViewController {
    
    @IBOutlet weak var imageVRView: GVRPanoramaView!
    
    @IBOutlet weak var videoVRView: GVRVideoView!
    
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var videoLabel: UILabel!
    
    enum Media {
        static var photoArray = ["sindhu_beach.jpg", "grand_canyon.jpg", "underwater.jpg"]
        static let videoURL = "https://s3.amazonaws.com/ray.wenderlich/elephant_safari.mp4"
    }
    
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    var isPaused = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageLabel.isHidden = true
        imageVRView.isHidden = true
        videoLabel.isHidden = true
        videoVRView.isHidden = true
        
        imageVRView.delegate = self
        videoVRView.delegate = self
        
        imageVRView.load(UIImage(named: Media.photoArray.first!),
                         of: GVRPanoramaImageType.mono)
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = true
        
        videoVRView.load(from: URL(string: Media.videoURL))
        videoVRView.enableCardboardButton = true
        videoVRView.enableFullscreenButton = true
        
        
        
    }
    
    func refreshVideoPlayStatus() {
        // 1
        if currentView == videoVRView && currentDisplayMode != GVRWidgetDisplayMode.embedded {
            videoVRView?.play()
            isPaused = false
        }
            // 2
        else {
            videoVRView?.pause()
            isPaused = true
        }
    }
}
