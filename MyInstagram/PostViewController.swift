//
//  PostViewController.swift
//  MyInstagram
//
//  Created by クロス尚美 on 2018/11/03.
//  Copyright © 2018年 NC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD




class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var image: UIImage!
    
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextField!
    

        
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handlePostButton(sender: UIButton) {
        
        //ImageViewから画像を取得する
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        
        // postDataに必要な情報を取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        
        
        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath)
        let postDic = ["caption": textView.text!, "image": imageString, "time": String(time), "name": name!]
        postRef.childByAutoId().setValue(postDic)
        
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        
        
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    
        // 受け取った画像をImageViewに設定する
        imageView.image = image
    }
    

    @IBAction func goToISV(_ sender: Any) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("呼ばれている")
        if info[.originalImage] != nil {
            print("if文の中が呼ばれている")
            // 撮影/選択された画像を取得する
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
    
            imageView.image = image
            
            picker.dismiss(animated: true, completion: nil)
            // あとでCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            // CLImageEditorにimageを渡して、加工画面を起動する。
            
            //以下でAdobeのCLImageEditorを使わない設定とする
            //            let editor = CLImageEditor(image: image)!
            //            editor.delegate = self as! CLImageEditorDelegate
            //            picker.pushViewController(editor, animated: true)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
