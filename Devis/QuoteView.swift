//
//  ContentView.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import SwiftUI

struct QuoteView: View {
    @Binding var quote: Quote

    @State private var isPresentingEditView: Bool = false
    @State private var inputImage: UIImage?
    @State private var data = Quote.QuoteData()
    
    var body: some View {
        ZStack {
            if quote.quoteStyle.colorOpacity < 1 && quote.quoteStyle.imageOpacity < 1 {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.black)
                    .ignoresSafeArea()
            }
            BackgroundView(style: quote.quoteStyle)
            VStack(alignment:.center) {
                    VStack {
                        Text(quote.type)
                            .padding()
                            .font(.custom(Constants.typeFont, size: Constants.quoteViewFontSize))
                            .accessibilityLabel("\(quote.type) quote")
                        Spacer()
                        Text(quote.text)
                            .padding()
                            .font(.custom(Constants.textFont, size: Constants.quoteViewTextFontSize).bold())
                            .multilineTextAlignment(.center)
                            .lineSpacing(Constants.quoteViewLineSpacing)
                            .minimumScaleFactor(Constants.quoteViewMinScaleFactor)
                            .accessibilityLabel(quote.text)
                        Spacer()
                        Text(quote.author)
                            .padding()
                            .font(.custom(Constants.authorFont, size: Constants.quoteViewFontSize))
                            .accessibilityLabel("By \(quote.author)")
                    }
                    .foregroundColor(quote.quoteStyle.whiteFont ? .white : .black)
                    .accessibilityElement(children: .combine)
                
                VStack{
                    Button(action: {
                        quote.isFavourite = !quote.isFavourite
                    }) {
                        Image(systemName: quote.isFavourite ? Constants.heartFill : Constants.heart)
                            .foregroundColor(.red)
                            .padding()
                            .font(.system(size: Constants.quoteViewSFSize).bold())
                            .accessibilityLabel("Add or remove from favourites")
                    }
                    
                    Button(action: {
                        isPresentingEditView = true
                        data = quote.data
                        inputImage = quote.quoteStyle.image == nil ? nil : UIImage(data: quote.quoteStyle.image!)
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(Color.white)
                            .padding()
                            .font(.system(size: Constants.quoteViewSFSize).bold())
                            .accessibilityLabel("Edit Quote")
                    }
                }
                Spacer()
            }
            .background(
                Image(data: quote.quoteStyle.image)?
                    .resizable()
                    .opacity(Double(quote.quoteStyle.imageOpacity))
                    .scaledToFill()
                    .blur(radius: Constants.quoteViewImgBlur)
                    .blendMode(.screen)
                    .edgesIgnoringSafeArea(.all)
            )
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                EditQuoteView(data: $data, inputImage: $inputImage)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { isPresentingEditView = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                quote.update(from: data, image: inputImage)
                            }
                        }
                    }
                    .navigationBarTitle("Edit Quote", displayMode: .inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quote:
                .constant(Constants.sampleQuotes[1]))
    }
}
