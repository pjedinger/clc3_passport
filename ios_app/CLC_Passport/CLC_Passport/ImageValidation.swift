//
//  ImageValidation.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 05.01.22.
//

import SwiftUI

struct ImageValidation: View {

    var image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable().scaledToFill().frame(minWidth: 0, maxWidth: .infinity).edgesIgnoringSafeArea(.all)
            .navigationTitle("Image Validation")
            .task {
                do {
                    let url = URL(string: "http://clc3-passphoto-balancer-758796881.eu-central-1.elb.amazonaws.com:8080/predict")!

                    let imageData = image.pngData()!
                    let base64String = imageData.base64EncodedString(options: .lineLength64Characters)

                    var json = [String:Any]()
                    json["Image"] = base64String

                    let data = try JSONSerialization.data(withJSONObject: json, options:[])

                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = data
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")

                    let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

                    })
                    task.resume()

                    //let (data, _) = try await URLSession.shared.data(from: url)
                    //messages = try JSONDecoder().decode([Message].self, from: data)
                } catch {
                }
            }
    }

    func sendForValidation(image: UIImage) async {
        
    }
}

struct ImageValidation_Previews: PreviewProvider {
    static var previews: some View {
        ImageValidation(image: UIImage())
    }
}
