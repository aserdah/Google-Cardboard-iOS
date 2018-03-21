//
//  VacationViewControllerExtension.swift
//  Vacation 360
//
//  Created by Ahmed on 3/21/18.
//  Copyright © 2018 RayWenderlich. All rights reserved.
//

extension VacationViewController: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        if content is UIImage {
            imageVRView.isHidden = false
            imageLabel.isHidden = false
        } else if content is NSURL {
            videoVRView.isHidden = false
            videoLabel.isHidden = false
            refreshVideoPlayStatus()
        }
        
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
        print(errorMessage)
        
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        currentView = widgetView
        currentDisplayMode = displayMode
        refreshVideoPlayStatus()
        if currentView == imageVRView && currentDisplayMode != GVRWidgetDisplayMode.embedded {
            view.isHidden = true
        } else {
            view.isHidden = false
        }
    }
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
        // 1
        guard currentDisplayMode != GVRWidgetDisplayMode.embedded else {return}
        // 2
        if currentView == imageVRView {
            Media.photoArray.append(Media.photoArray.removeFirst())
            imageVRView?.load(UIImage(named: Media.photoArray.first!),
                              of: GVRPanoramaImageType.mono)
        }
        else {
            if isPaused {
                videoVRView?.play()
            } else {
                videoVRView?.pause()
            }
            isPaused = !isPaused
        }
    }
}

extension VacationViewController: GVRVideoViewDelegate {
    func videoView(_ videoView: GVRVideoView!, didUpdatePosition position: TimeInterval) {
        if position >= videoView.duration() {
            videoView.seek(to: 0)
            videoView.play()
        }
    }
}
