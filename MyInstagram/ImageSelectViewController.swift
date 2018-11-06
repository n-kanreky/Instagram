//
//  ImageSelectViewController.swift
//  MyInstagram
//
//  Created by クロス尚美 on 2018/11/02.
//  Copyright © 2018年 NC. All rights reserved.
//

import UIKit


class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func handleLibraryButton(_ sender: Any) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    //以下のoverride func二つは、TA通りの位置************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //************************************************************************
    
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("呼ばれている")
        if info[.originalImage] != nil {
            print("if文の中が呼ばれている")
            // 撮影/選択された画像を取得する
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
            postViewController.image = image
            let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
            dispatchQueue.async {
                self.present(postViewController, animated: true, completion: nil)
            }
            
            
            _ = info[.originalImage] as! UIImage
            
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
    
    
    //    // CLImageEditorで加工が終わったときに呼ばれるメソッド
    //    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
    //        // 投稿の画面を開く
    //        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
    //        postViewController.image = image!
    //        editor.present(postViewController, animated: true, completion: nil)
    //    }
}
