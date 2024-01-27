//
//  InputView.swift
//  SwiftHttpChallenge
//
//  Created by Thomas Ditman on 26/01/2024.
//
//

import SwiftUI


struct MainView: View {
    
    @State private var inputField: String = ""
    
    @State private var textBodyFromRequest: String = ""
    
    @State private var occurrencesOfTopicInTextBody: Int = 0
    
    var body: some View {
        
        VStack {
            
            //Text input field, not made to look pretty, just to work
            TextField(
                "Please insert topic for searching",
                text: $inputField
            ).multilineTextAlignment(.center)
            
            Button(action: sendAndResolveGetRequest, label: {
                Text("Send Query")
            })
            
            if (occurrencesOfTopicInTextBody != 0) {
                Text(
                    "Your topic is mentioned in the text "
                    + String(occurrencesOfTopicInTextBody)
                    + " times")
            }
        }
        
    }
    
    func sendAndResolveGetRequest() {
        
        //Build query path
        let urlPath = "https://en.wikipedia.org/w/api.php?action=parse&section=0&prop=text&format=json&page=" + inputField
        
        let url = URL(string: urlPath)!
        
        //Will parse the code as JSON
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                //print(data)
                let res = try JSONDecoder().decode(EnclosingJSON.self, from: data)
                
                //debug print message
                print(
                    subStringCounter(
                        fullString: res.parse.text.text,
                        subString: inputField
                    )
                )
                occurrencesOfTopicInTextBody = subStringCounter(
                    fullString: res.parse.text.text,
                    subString: inputField
                )
            } catch {
                print(error)
            }
        }
        
        //Starts the request sending
        task.resume()
    }
}

#Preview {
    MainView()
}
