//
//  CameraView Controller.swift
//  PillPal-2.0
//
//  Created by 47GOParticipant on 7/18/25.
//

import SwiftUI
import PhotosUI
import CoreML
import Vision

struct CameraConetntView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: UIImage?
    @State private var showCamera = false
    @State private var predictionLabel = "No image selected"

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(20)
            }


            Text(predictionLabel)
                .padding()

            HStack(spacing: 20) {
                Button(action: {
                    showCamera = true
                }) {
                    Text("Take Photo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundStyle(.black)
                        .cornerRadius(25)
                }

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    Text("Select Photo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundStyle(.black)
                        .cornerRadius(25)
                }
            }
            .padding(.top)

        }
        .padding()
        .sheet(isPresented: $showCamera) {
            CameraView(image: $image)
                .onDisappear {
                    if image != nil {
                        classifyImage()
                    }
                }
        }
        .onChange(of: selectedItem) { oldItem, newItem in
            if let newItem = newItem {
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let selectedImage = UIImage(data: data) {
                        image = selectedImage
                        classifyImage()
                    }
                }
            }
        }
    }

    func classifyImage() {
        guard let uiImage = image,
              let cgImage = uiImage.cgImage else {
            predictionLabel = "Invalid image"
            return
        }

        do {
            //let model = try VNCoreMLModel(for: PillPalImageClassifier_1(configuration: MLModelConfiguration()).model)
            
            let model = try VNCoreMLModel(for: Pillpal(configuration: MLModelConfiguration()).model)

            let request = VNCoreMLRequest(model: model) { request, error in
                if let results = request.results as? [VNClassificationObservation],
                   let topResult = results.first {
                    DispatchQueue.main.async {
                        predictionLabel = "Prediction: \(topResult.identifier) (\(Int(topResult.confidence * 100))%)"
                    }
                } else {
                    DispatchQueue.main.async {
                        predictionLabel = "Could not classify"
                    }
                }
            }

            let handler = VNImageRequestHandler(cgImage: cgImage)
            try handler.perform([request])

        } catch {
            predictionLabel = "Failed: \(error.localizedDescription)"
        }
    }
}






//struct CameraConetntView: View {
//    @State private var selectedItem: PhotosPickerItem?
//    //holds the selected photo item
//    @State private var selectedImage: UIImage?
//    //holds the loaded image
//    @State private var showingCamera = false
//    //control camera sheet visiablity
//    var body: some View {
//        VStack{
//            //display the selected image or place holder
//            if let selectedImage = selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//                    .cornerRadius(25)
//                
//            }
//            else{
//                Text("No Image Selected")
//                    .foregroundStyle(.black)
//                    .padding()
//            }
//            Button(action:{
//                showingCamera = true //show the camera
//            }){
//                Text("Take Photo")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white)
//                    .foregroundStyle(.black)
//                    .cornerRadius(25)
//            }
//            .sheet(isPresented: $showingCamera){
//                CameraView(image: $selectedImage)
//            }
//            //photo picker button
//            PhotosPicker( selection:
//                    $selectedItem,
//                //bind to the selected
//                matching: .images, //show only images
//                photoLibrary: .shared()
//            )
//            {
//               Text("Select Photo")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white)
//                    .foregroundStyle(.black)
//                    .cornerRadius(25)
//            }
//            .onChange(of: selectedItem) { oldItem, newItem in
//                if let newItem = newItem {
//                    Task {
//                        if let data = try? await newItem.loadTransferable(type: Data.self),
//                           let image = UIImage(data: data) {
//                            selectedImage = image // updated the selected image
//                        }
//                    }
//                }
//            }
//
//
//            
//        }
//        .padding()
//    }
//}


