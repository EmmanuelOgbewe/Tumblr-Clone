//
//  ViewController.swift
//  Life_VideoApp
//
//  Created by Emmanuel  Ogbewe on 10/11/18.
//  Copyright © 2018 Emmanuel Ogbewe. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseFirestore


class ViewController: UIViewController, UIGestureRecognizerDelegate {

//    //Mark: IBOutlets
//    @IBOutlet weak var tableView: UITableView!
//    
//    @IBOutlet weak var playView: UIView!
//    
//    @IBOutlet weak var thumbImage: UIImageView!
//    
//    @IBOutlet weak var slider: UISlider!
//    
//    @IBOutlet weak var minTime: UILabel!
//    
//    @IBOutlet weak var maxTime: UILabel!
//
//    @IBOutlet weak var topShadow: UIImageView!
//    
//    @IBOutlet weak var upload: UIButton!
//    
//    @IBOutlet weak var play: UIButton!
//    
//    @IBOutlet private var newPostView: UIView!
//    
//    @IBOutlet private var dimView: UIView!
//    
//    @IBOutlet private var postThumb: UIImageView!
//    
//    
//    @IBOutlet private var postDetails: UITextField!
//    
//    @IBOutlet private var viewTopConstraint: NSLayoutConstraint!
//    
//    var player: AVPlayer!
//    var playerLayer: AVPlayerLayer!
//    var selectedImage: UIImage?
//    var videoUrl: URL?
//    var username = ""
//    var detailsText = ""
//    var isVideoPlaying = false
//
    lazy var db = Firestore.firestore()
    private var databaseRef : CollectionReference {
        return db.collection("posts")
    }
    private var posts : [Post] = []
    private var postListener: ListenerRegistration?
    deinit {
        postListener?.remove()
    }
    let pickerController = UIImagePickerController()

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.s
//        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
//         grabPosts()
//
//        thumbImage.isHidden = true
//        play.setImage(nil, for: .normal)
//        tableView.delegate = self
//        tableView.dataSource = self
//        pickerController.delegate = self
//        tableView.tableFooterView = UIView()
//        dimView.isHidden = true
//
//
//        postDetails.delegate = self
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        UIApplication.shared.statusBarStyle = .lightContent
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.openPicker))
//        tapGesture.delegate = self
//        thumbImage.isUserInteractionEnabled = true
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }
//
//    func addTimeObserver() {
//        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
//        let mainQueue = DispatchQueue.main
//        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
//            guard let currentItem = self?.player.currentItem else {return}
//            self?.slider.maximumValue = Float(currentItem.duration.seconds)
//            self?.slider.minimumValue = 0
//            self?.slider.value = Float(currentItem.currentTime().seconds)
//            self?.minTime.text = self?.getTimeString(from: currentItem.currentTime())
//        })
//    }
//    func cleanUp(){
//        postDetails.text = ""
//    }
//
//
//    @IBAction func uploadVideo(_ sender: Any) {
////       uploadNewPost()
//
//        if upload.titleLabel?.text == "U P L O A D" {
//            upload.setTitle("C A N C E L", for: .normal)
//            viewTopConstraint.constant = 130
//             self.dimView.isHidden = false
//             self.dimView.alpha = 0
//            self.thumbImage.alpha = 0
//            cleanUp()
//            UIView.animate(withDuration: 0.6) {
//                 self.dimView.alpha = 0.3
//                self.thumbImage.alpha = 1
//                self.newPostView.layoutIfNeeded()
//            }
//        }else{
//            upload.setTitle("U P L O A D", for: .normal)
//            viewTopConstraint.constant = 349
//                dimView.alpha = 0.3
//                thumbImage.alpha = 1
//            UIView.animate(withDuration: 0.4) {
//                self.dimView.alpha = 0
//                self.thumbImage.alpha = 0
//                self.newPostView.layoutIfNeeded()
//            }
//        }
//
//    }
//
//    @IBAction func sendPost(_ sender: UIButton) {
//        detailsText = postDetails.text!
//        username = "EOgbewe"
//
//
//        guard let data = selectedImage?.jpegData(compressionQuality: 0.8) else {
//                    return
//            }
//        print(data)
//        HelperService.uploadDataToServer(data: data, videoUrl: self.videoUrl, username: username, senderId: "", postText: detailsText, onSuccess: {
//                self.upload.setTitle("U P L O A D", for: .normal)
//                self.viewTopConstraint.constant = 349
//                self.dimView.alpha = 0.3
//                self.thumbImage.alpha = 1
//                self.cleanUp()
//                UIView.animate(withDuration: 0.4) {
//                    self.dimView.alpha = 0
//                    self.thumbImage.alpha = 0
//                    self.newPostView.layoutIfNeeded()
//                }
//            })
//
//    }
//
//    @IBAction func chooseVideos(_ sender: Any) {
//        openPicker()
//    }
//
//
//
//    @IBAction func playPressed(_ sender: UIButton) {
//        if isVideoPlaying {
//            player.pause()
//            play.setImage(UIImage(named:"icons8-Play-26"), for: .normal)
//
//        }else {
//            player.play()
//            play.setImage(nil, for: .normal)
////
//        }
//
//        isVideoPlaying = !isVideoPlaying
//    }
//    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        player.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
//    }
//
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
//            self.maxTime.text = getTimeString(from: player.currentItem!.duration)
//        }
//    }
//
//    func getTimeString(from time: CMTime) -> String {
//        let totalSeconds = CMTimeGetSeconds(time)
//        let hours = Int(totalSeconds/3600)
//        let minutes = Int(totalSeconds/60) % 60
//        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
//        if hours > 0 {
//            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
//        }else {
//            return String(format: "%02i:%02i", arguments: [minutes,seconds])
//        }
//    }
//    func uploadNewPost(){
//        let alert = UIAlertController(title: "New Post", message: nil, preferredStyle: .alert)
//        var usernameText = ""
//        var detailsText = ""
//
//        alert.addTextField(configurationHandler: { (username) in
//             username.placeholder = "username"
//                usernameText = username.text!
//        })
//        alert.addTextField(configurationHandler: { (details) in
//             details.placeholder = "Write about the vid..."
//                detailsText = details.text!
//        })
//        let action = UIAlertAction(title: "Upload Video", style: .default, handler: { (text) in
//
//                self.username = usernameText
//                self.detailsText = detailsText
//                self.openPicker()
//
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addAction(action)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
//    }
//    @objc func openPicker(){
//     print("tapped")
//    isVideoPlaying = false
//    player.pause()
//    pickerController.mediaTypes =  ["public.movie"]
//    present(pickerController, animated: true, completion: nil)
//    }
//    //Manage data functions
//    private func grabPosts(){
//        postListener = databaseRef.addSnapshotListener { querySnapshot, error in
//            guard let snapshot = querySnapshot else {
//                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
//                return
//            }
//            print(snapshot.count)
//            snapshot.documentChanges.forEach { change in
//                self.handleDocumentChange(change)
//            }
//            let postUrl = self.posts[0].videoUrl
//            let url = URL(string: postUrl)!
//            self.player = AVPlayer(url: url)
//            self.playerLayer = AVPlayerLayer(player: self.player)
//            self.playerLayer.videoGravity = .resizeAspectFill
//            self.playView.layer.addSublayer(self.playerLayer)
//            self.playerLayer.frame = self.playView.bounds
//            self.player.play()
//            self.player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
//        }
//    }
//    private func addPostToTable(_ post: Post) {
//        guard !posts.contains(post) else {
//            return
//        }
//
//        posts.append(post)
//
//        posts.sort()
//
//        guard let index = posts.index(of: post) else {
//            return
//        }
//        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//    }
//
//    private func updatePostInTable(_ post: Post) {
//        guard let index = posts.index(of: post) else {
//            return
//        }
//
//        posts[index] = post
//        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//    }
//
//    private func removePostFromTable(_ post: Post) {
//        guard let index = posts.index(of: post) else {
//            return
//        }
//
//        posts.remove(at: index)
//        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//    }
//
//    private func handleDocumentChange(_ change: DocumentChange) {
//        print(change.document)
//        guard let post = Post(document: change.document) else {
//            return
//        }
//        switch change.type {
//        case .added:
//            addPostToTable(post)
//
//        case .modified:
//            updatePostInTable(post)
//
//        case .removed:
//            removePostFromTable(post)
//        }
//    }
//}
//extension ViewController: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.postDetails.endEditing(true)
//        return true
//    }
//}
//extension ViewController: UITableViewDelegate, UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostCell
//        cell.post = posts[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let postUrl = self.posts[indexPath.row].videoUrl
//        print(postUrl)
//        let url = URL(string: postUrl)!
//        self.player = AVPlayer(url: url)
//    }
//}
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
//            print(videoUrl)
//            if let thumbnailImage = self.thumbnailImageForFileUrl(videoUrl) {
//                selectedImage = thumbnailImage
//                postThumb.image = thumbnailImage
//                //                photo.image = thumnailImage
//                self.videoUrl = videoUrl
//                print(selectedImage)
//            }
//            dismiss(animated: true, completion: nil)
//
//
//
//            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//                selectedImage = image
//                //            photo.image = image
//                dismiss(animated: true, completion: {
//
//                })
//            }
//        }
//    }
//
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let videoUrl = info["UIImagePickerControllerMediaURL"] as? URL {
//            print(videoUrl)
//            if let thumbnailImage = self.thumbnailImageForFileUrl(videoUrl) {
//                selectedImage = thumbnailImage
//                postThumb.image = thumbnailImage
////                photo.image = thumnailImage
//                self.videoUrl = videoUrl
//                print(selectedImage)
//            }
//            dismiss(animated: true, completion: nil)
//
//
//
//        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//            selectedImage = image
////            photo.image = image
//            dismiss(animated: true, completion: {
//
//              })
//            }
//        }
//    }
//
//    func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
//        let asset = AVAsset(url: fileUrl)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        do {
//            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 7, timescale: 1), actualTime: nil)
//            return UIImage(cgImage: thumbnailCGImage)
//        } catch let err {
//            print(err)
//        }
//
//        return nil
//        }
}

