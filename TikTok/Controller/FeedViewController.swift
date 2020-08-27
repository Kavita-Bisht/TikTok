//
//  FeedViewController.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class FeedViewController: UIViewController,  StoryboardScene {
    
    static var sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var index: Int!
    fileprivate var feed: Feed!
    fileprivate var isPlaying: Bool!
    
    // Player
    private let videoContainer =  UIView()
    
    var player:AVPlayer!
    
    // Labels
    private let userLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let audioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // Buttons
    private let profileButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let likeButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let commentButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let shareButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    
    
    static func instantiate(feed: Feed, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = FeedViewController.instantiate()
        viewController.feed = feed
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFeed()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    
    func play() {
     
      
        player?.play()
    }
    
    func pause() {
  
       // player?.seek(to: CMTime.zero)
        player?.pause()
    }
    
    
    fileprivate func initializeFeed() {
        let url = feed.url
        
        // check for existing feed
        
        videoContainer.frame = view.bounds
        player = AVPlayer(url: url)
        let playerView = AVPlayerLayer()
        playerView.frame = view.bounds
        playerView.player =  player
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

       
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        isPlaying ? play() : nil
        
        // add subview
        view.addSubview(videoContainer)
        view.addSubview(userLabel)
        userLabel.text = "Hello Text"
        view.addSubview(captionLabel)
        view.addSubview(audioLabel)
        
        view.addSubview(profileButton)
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)
        
        
        let size = view.frame.size.width / 10
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        // frame
        profileButton.frame = CGRect(x:width - size - 20, y: height - 450, width: size, height: size)
        profileButton.setImage(#imageLiteral(resourceName: "profile_main"), for: .normal)
        likeButton.frame = CGRect(x: width - size - 20, y: height - 350, width: size, height: size)
        likeButton.setImage(#imageLiteral(resourceName: "love_main"), for: .normal)
        commentButton.frame = CGRect(x: width - size - 20, y: height - 250, width: size, height: size)
        commentButton.setImage(#imageLiteral(resourceName: "comment_main"), for: .normal)
        shareButton.frame = CGRect(x: width - size - 20, y: height - 150, width: size, height: size)
        shareButton.setImage(#imageLiteral(resourceName: "share_main"), for: .normal)
        
        
        // send videocontainer to back
        videoContainer.clipsToBounds = true
        view.sendSubviewToBack(videoContainer)
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
               //Called when player finished playing
        player?.seek(to: CMTime.zero)
        //player?.pause()
        player?.play()
           }
         
}


