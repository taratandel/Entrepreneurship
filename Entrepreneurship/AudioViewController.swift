//
//  AudioViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/23/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    var urls = String()
    var audioLabel = String()
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
  
    @IBOutlet weak var playButt: UIButton!
    @IBOutlet weak var nameOfTheJob: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfTheJob?.text = audioLabel
        let url = NSURL(string: urls)
        playerItem = AVPlayerItem(url: url! as URL)
        player=AVPlayer(playerItem: playerItem!)
        let playerLayer=AVPlayerLayer(player: player!)
        //playerLayer.frame=CGRectMake(0, 0, 300, 50)
        self.view.layer.addSublayer(playerLayer)
        playButt.addTarget(self, action: #selector (playButtonTapped(sender:)), for: .touchUpInside)
        playButtonTapped(sender: self)
        playButt.setImage(#imageLiteral(resourceName: "pause"), for: .normal)


        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector (finishedPlaying(myNotification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playButtonTapped(sender: AnyObject) {
        if player?.rate == 0
        {
            player!.play()
            playButt.setImage(#imageLiteral(resourceName: "pause"), for: .normal)

        } else {
            player!.pause()
            playButt.setImage(#imageLiteral(resourceName: "play"), for: .normal)

        }
    }
    func finishedPlaying(myNotification:NSNotification) {
         playButt.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        
        let stopedPlayerItem: AVPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
