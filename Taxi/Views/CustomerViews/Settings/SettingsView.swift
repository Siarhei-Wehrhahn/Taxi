//
//  SettingsView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 07.03.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var profileImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
            } else {
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $profileImage)
                }
            }
            
            Text(viewModel.user?.nickName ?? "Unbekannter Name")
                .frame(width: 320, alignment: .leading)
            
            Text(viewModel.user?.email ?? "Unbekannte E-Mail")
                .frame(width: 320, alignment: .leading)
                .padding()
            
            Button {
                
            } label: {
                Text("Taxi anrufen")
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                
            } label: {
                Text("Support kontaktieren")
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Abmelden") {
                viewModel.logout()
            }
            .padding()
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    SettingsView()
}
