//
//  Camera.swift
//  PillPal-2.0
//
//  Created by 47GOParticipant on 7/18/25.
//

import Foundation
import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?//bind to the parent view's state
    @Environment(\.presentationMode) var presentationMode//Dismiss the view when done
    
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let picker = UIImagePickerController()//create the camera picture
        picker.delegate = context.coordinator//set the coordinator as delegate
        picker.sourceType = .camera // set the source to the camera
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //no updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate,
        UIImagePickerControllerDelegate{
            let parent: CameraView
            
            init(_ parent: CameraView) {
                self.parent = parent
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[.originalImage] as? UIImage{
                    parent.image = image //pass the selected image to the parent
                }
                parent.presentationMode.wrappedValue.dismiss()//dismiss the picker
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()//dismiss on cancel
        }
            
            
            
        }
    }

    

