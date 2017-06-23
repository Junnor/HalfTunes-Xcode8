//
//  Download.swift
//  HalfTunes
//
//  Created by nyato喵特 on 2017/6/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  
  var track: Track
  
  init(track: Track) {
    self.track = track
  }
  
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  
  var progress: Float = 0
		
}
