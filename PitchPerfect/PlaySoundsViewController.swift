//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Niklas Rammerstorfer on 24/07/2017.
//  Copyright © 2017 rammerstorfer. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
