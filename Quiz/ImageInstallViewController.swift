//
//  ImageInstallViewController.swift
//  Quiz
//
//  Created by nttr on 2017/07/26.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class ImageInstallViewController: UIViewController, URLSessionDownloadDelegate {

    var progressBar: UIProgressView!
    @IBOutlet var install: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "game", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
        /*        // ダウンロード開始ボタン
        let button = UIButton(type: .system)
        button.setTitle("ダウンロード開始", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 24)
        button.addTarget(self, action: #selector(self.startDownloadTask), for: .touchUpInside)
        button.sizeToFit()
        button.center = self.view.center
        self.view.addSubview(button)
        
        // プログレスバーの設定
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.layer.position = CGPoint(x: self.view.center.x, y: self.view.frame.height / 4)
        self.view.addSubview(progressBar)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func download(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "data", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
    // バックグラウンドで動作する非同期通信
    func startDownloadTask() {
        
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "myapp-background")
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        
        let url = URL(string: "https://i.ytimg.com/vi/1LFfkopJIVM/maxresdefault.jpg")!
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    
    // 現在時刻からユニークな文字列を得る
    func getIdFromDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return dateFormatter.string(from: Date())
    }
    
    // 保存するディレクトリのパス
    func getSaveDirectory() -> String {
        
        let fileManager = Foundation.FileManager.default
        
        // ライブラリディレクトリのルートパスを取得して、それにフォルダ名を追加
        let path = NSSearchPathForDirectoriesInDomains(Foundation.FileManager.SearchPathDirectory.libraryDirectory, Foundation.FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/DownloadFiles/"
        
        // ディレクトリがない場合は作る
        if !fileManager.fileExists(atPath: path) {
            createDir(path: path)
        }
        
        return path
    }
    
    // ディレクトリを作成
    func createDir(path: String) {
        do {
            let fileManager = Foundation.FileManager.default
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("createDir: \(error)")
        }
    }
    
    // MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // ダウンロード完了時の処理
        
        print("didFinishDownloading")
        
        do {
            if let data = NSData(contentsOf: location) {
                
                let fileExtension = location.pathExtension
                let filePath = getSaveDirectory() + getIdFromDateTime() + "." + fileExtension
                
                print(filePath)
                
                try data.write(toFile: filePath, options: .atomic)
            }
        } catch let error as NSError {
            print("download error: \(error)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // ダウンロード進行中の処理
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        // ダウンロードの進捗をログに表示
        print(String(format: "%.2f", progress * 100) + "%")
        
        // メインスレッドでプログレスバーの更新処理
        DispatchQueue.main.async(execute: {
            self.progressBar.setProgress(progress, animated: true)
        })
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // ダウンロードエラー発生時の処理
        if error != nil {
            print("download error: \(error)")
        }
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
