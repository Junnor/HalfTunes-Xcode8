//
//  SearchVC+URLSessionDelegate.swift
//  HalfTunes
//
//  Created by nyato喵特 on 2017/6/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

import Foundation

extension SearchViewController: URLSessionDownloadDelegate {
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    print("Finished downloading to: \(location)")
    
    guard let sourceUrl = downloadTask.originalRequest?.url else {
      return
    }
    let download = downloadService.activeDownloads[sourceUrl]
    downloadService.activeDownloads[sourceUrl] = nil
    
    let destinationUrl = localFilePath(for: sourceUrl)
    print("destination url: \(destinationUrl)")
    
    let fileManager = FileManager.default
    
    try? fileManager.removeItem(at: destinationUrl)
    
    do {
      try fileManager.copyItem(at: location, to: destinationUrl)
      download?.track.downloaded = true
    } catch let error {
      print("counld not copy file to disk: \(error.localizedDescription)")
    }
    
    if let index = download?.track.index {
      DispatchQueue.main.async {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
    
  }
}
