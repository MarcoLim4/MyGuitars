/*
 
    Solution from Paul Hudson.
    Using to make a bridge to UIImagePickerViewController until SwiftUI doesn't give us a way
 
 */

import SwiftUI

enum PhotoSource {
    case camera
    case library
}

class ImageSaver: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)        
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished!")
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    
    let source: PhotoSource
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.delegate = context.coordinator

        if source == .camera {
            picker.sourceType = .camera
        }

        return picker

    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

}
