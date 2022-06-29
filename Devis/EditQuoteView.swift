//
//  EditQuoteView.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import SwiftUI

struct EditQuoteView: View {
    @Binding var data: Quote.QuoteData
    @Binding var inputImage: UIImage?
    
    @State private var isPresentingImagePicker: Bool = false
    private var hasImage: Bool { data.quoteStyle.image == nil && inputImage == nil }
    
    var body: some View {
        Form{

            Section(header: HStack { Image(systemName: "paintpalette");Text("Style") }) {
                Toggle("Gradient", isOn: $data.quoteStyle.isGradient)
                Toggle("White Font", isOn: $data.quoteStyle.whiteFont)

                Picker("Theme", selection: $data.quoteStyle.theme) {
                    ForEach(Theme.allCases) { theme in
                        ThemeView(theme: theme, isGradient: $data.quoteStyle.isGradient, whiteFont: $data.quoteStyle.whiteFont)
                            .tag(theme)
                    }
                }
                HStack{
                    Text("Opacity")
                    Slider(
                        value: $data.quoteStyle.colorOpacity,
                        in: 0...1,
                        step: 0.1
                    )
                    .accentColor(data.quoteStyle.theme.mainColor)
                }
            }
            
            Section(header: HStack { Image(systemName: Constants.camera);Text("Image") }){
                HStack {
                    Text("Background Image")
                    Spacer()
                    
                    Menu(content: {
                        Button(action: { isPresentingImagePicker = true }) {
                            HStack { Text("Add Image");Image(systemName:  Constants.camera) }
                        }
                        Button(role:.destructive,action: { deleteImage() }) {
                            HStack { Text("Delete Image");Image(systemName: "trash") }
                        }
                    }) {
                        Image(systemName:  Constants.camera)
                    }
                    
                }
                HStack {
                    Text("Opacity")
                        .opacity(hasImage ? 0.4 : 1)
                    Slider(
                        value: $data.quoteStyle.imageOpacity,
                        in: 0...1,
                        step: 0.1
                    )
                    .disabled(hasImage)
                }
            }
            .sheet(isPresented: $isPresentingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            
            Section(header: HStack { Image(systemName: "questionmark");Text("Type")}) {
//                TextField("Type",text: $data.type)
                Picker("Type", selection: $data.type) {
                    ForEach(Constants.types.allCases) { type in
                        Text(type.id).tag(type)
                    }
                }
            }
            
            Section(header: HStack { Image(systemName: "person");Text("Author") }){
                TextField("Author", text: $data.author)
            }
            
            Section(header: HStack { Image(systemName: "quote.opening");Text("Quote") }) {
                TextField("Text",text: $data.text)
            }
        }
    }
   
    func deleteImage() { inputImage = nil }
}

struct EditQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditQuoteView(data: .constant(Constants.sampleQuotes[3].data), inputImage: .constant(nil))
    }
}
