//
//  InputView.swift
//  SwiftHttpChallenge
//
//  Created by Thomas Ditman on 26/01/2024.
//
// I likely would not use Swift for this kind of task, it seems more like something that should be accomplished by a backend. This may just be due to personal inexperience with using swift for HTTP requests though. I think this might be a bit more comfortable to write in Golang.

import SwiftUI


struct InputView: View {
    
    @State private var inputField: String = ""
    
    @State private var htmlResponse: String = ""
    
    @State private var resultCount: Int = 0
    
    var body: some View {
        
        VStack {
            
            //Text input field, not made to look pretty, just to work
            TextField(
                "Please insert topic for searching",
                text: $inputField
            ).multilineTextAlignment(.center)
            
            Button(action: sendQuery, label: {
                Text("Send Query")
            })
            
            if (resultCount != 0) {
                Text("The number of occurrences of the input in the wikipedia response is" + String(resultCount))
            }
        }
        
    }
    
    //Wasn't able to test the query from online, but tested the resulting code.
    func sendQuery() {
        
        //Make sure input is valid, replace space with %20
        //let validInput = inputField.replacingOccurrences(of: " ", with: "%20")
        
        //Build query path
        let urlPath = "https://en.wikipedia.org/w/api.php?action=parse&section=0&prop=text&format=json&page=" + inputField
        
        let url = URL(string: urlPath)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                //client
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                //server error
                return
            }
            //TODO: TEST
            if let mimeType = httpResponse.mimeType, mimeType == "text/html",
               let data = data,
               let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    htmlResponse = string
                }
            }
            
        }
        
        //Send GET request
        task.resume()
        
        //Parse results
        resultCount = subStringCounter(fullString: htmlResponse, subString: inputField)
        
        
    }
    
        
    
}

#Preview {
    InputView()
}
