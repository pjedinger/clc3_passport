//
//  ImageValidation.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 05.01.22.
//

import SwiftUI

struct ImageValidation: View {

    var image: UIImage
    @State var result: String = ""
    @State var loadingState: Bool = true
    @State var triggerNavigationLink: Bool = false
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ResultView(image: image, result: result, shouldPopToRootView: self.$rootIsActive), isActive: $triggerNavigationLink) { EmptyView() }.isDetailLink(false)

        LoadingView(isShowing: $loadingState) {
            Image(uiImage: image)
                .resizable().scaledToFill().frame(minWidth: 0, maxWidth: .infinity).edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .task {
                    do {
                        //Save image to gallery
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

                        //Requesting to Model
                        let url = URL(string: "http://clc3-passphoto-balancer-758796881.eu-central-1.elb.amazonaws.com:8080/predict")!

                        let imageData = image.pngData()!
                        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)

                        var json = [String:Any]()
                        json["Image"] = base64String

                        let data = try JSONSerialization.data(withJSONObject: json, options:[])

                        let username = "clc3"
                        let password = "clc3"
                        let loginString = String(format: "%@:%@", username, password)
                        let loginData = loginString.data(using: String.Encoding.utf8)!
                        let base64LoginString = loginData.base64EncodedString()

                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.httpBody = data
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

                        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

                            do {
                                guard let data = data else {
                                    return
                                }

                                let js = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]

                                let prediction: String = js?["prediction"] as! String
                                print("Prediction: \(prediction)")
                                result = prediction
                                loadingState = false
                                triggerNavigationLink = true
                            } catch {

                            }
                        })
                        task.resume()
                        print("Request Sent.")
                    } catch {
                    }
                }
        }
    }
}
