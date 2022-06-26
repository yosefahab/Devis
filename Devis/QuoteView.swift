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
        ZStack{
            BackgroundView(style: quote.quoteStyle)
            VStack(alignment:.center){
                    VStack{
                        Text(quote.type)
                            .padding()
                            .font(.custom("Courier New", size: 23))
                            .accessibilityLabel("\(quote.type) quote")
                        Spacer()
                        Text(quote.text)
                            .padding()
                            .font(.custom("Arima Madurai", size: 32).bold())
                            .multilineTextAlignment(.center)
                            .lineSpacing(10)
                            .minimumScaleFactor(0.3)
                            .accessibilityLabel(quote.text)
                        Spacer()
                        Text(quote.author)
                            .padding()
                            .font(.custom("Copperplate", size: 23))
                            .accessibilityLabel("By \(quote.author)")
                    }
                    .foregroundColor(quote.quoteStyle.whiteFont ? .white : .black)
                    .accessibilityElement(children: .combine)
                
                VStack{
                    Button(action: {
                        quote.isFavourite = !quote.isFavourite
                    }) {
                        Image(systemName: quote.isFavourite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding()
                            .font(.system(size: CGFloat(Constants.SFSize)).bold())
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
                            .font(.system(size: CGFloat(Constants.SFSize)).bold())
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
                    .blur(radius: 2.0)
                    .blendMode(.screen)
                    .edgesIgnoringSafeArea(.all)
            )
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                EditQuoteView(data: $data, inputImage: $inputImage)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){ isPresentingEditView = false }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done"){
                                isPresentingEditView = false
                                quote.update(from: data, image: inputImage)
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Edit Quote")
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
