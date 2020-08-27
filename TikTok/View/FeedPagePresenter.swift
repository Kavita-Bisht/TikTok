//
//  FeedPagePresenter.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import Foundation
import AVFoundation
import ProgressHUD
import Alamofire

protocol FeedPagePresenterProtocol: class {
    func viewDidLoad()
    func fetchNextFeed() -> IndexedFeed?
    func fetchPreviousFeed() -> IndexedFeed?
    func updateFeedIndex(fromIndex index: Int)
}

class FeedPagePresenter: FeedPagePresenterProtocol {
    fileprivate unowned var view: FeedPageView
    fileprivate var fetcher: FeedFetchProtocol
    fileprivate var feeds: [Feed] = []
    fileprivate var currentFeedIndex = 0
    fileprivate var currentDownloadFeedIndex = 0
    
    init(view: FeedPageView, fetcher: FeedFetchProtocol = FeedFetcher()) {
        self.view = view
        self.fetcher = fetcher
    }
    
    func viewDidLoad() {
        fetcher.delegate = self
        configureAudioSession()
        fetchFeeds()
    }
    
    func fetchNextFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex + 1)
    }
    
    func fetchPreviousFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex - 1)
    }
    
    func updateFeedIndex(fromIndex index: Int) {
        currentFeedIndex = index
    }
    
    
    fileprivate func configureAudioSession() {
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
    }
    
    fileprivate func fetchFeeds() {
        view.startLoading()
        fetcher.fetchFeeds()
    }
    
    fileprivate func getFeed(atIndex index: Int) -> IndexedFeed? {
        guard index >= 0 && index < feeds.count else {
            return nil
        }
       
        return (feed: feeds[index], index: index)
    }
    
    
}




extension FeedPagePresenter: FeedFetchDelegate {
    func feedFetchService(_ service: FeedFetchProtocol, didFetchFeeds feeds: [Feed], withError error: Error?) {
        view.stopLoading()
        if let error = error {
            view.showMessage(error.localizedDescription)
            return
        }
        self.feeds = feeds
        guard let initialFeed = self.feeds.first else {
            view.showMessage("No Availavle Video Feeds")
            return
        }
        
        // download videos
        
        downloadVideo(initialFeed)
        
        view.presentInitialFeed(initialFeed)
    }
    
    
    func downloadVideo(_ feed: Feed) {
        
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let fileName = String(feed.id) + ".mp4"
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        
        
        AF.download(feed.url, to: destination).response { response in
            
            debugPrint(response)
            
            switch response.result{
            case .success:
                let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                let fileName = String(feed.id) + ".mp4"
                let fileURL = documentsURL.appendingPathComponent(fileName)
                self.feeds[self.currentDownloadFeedIndex].url = fileURL
            case .failure:
                print("Error")
                self.downloadVideo(self.feeds[self.currentDownloadFeedIndex])
                
            }
            
            if self.currentDownloadFeedIndex < self.feeds.count - 2 {
                self.currentDownloadFeedIndex += 1
                self.downloadVideo(self.feeds[self.currentDownloadFeedIndex])
            }
            
        }
        
    }
}
