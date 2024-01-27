//
//  InputView.swift
//  SwiftHttpChallenge
//
//  Created by Thomas Ditman on 26/01/2024.
//
//

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
                Text("The number of occurrences of the input in the wikipedia response is: " + String(resultCount))
            }
        }
        
    }
    
    //Wasn't able to test the query from online, but tested the resulting code.
    func sendQuery() {
        
        //Build query path
        let urlPath = "https://en.wikipedia.org/w/api.php?action=parse&section=0&prop=text&format=json&page=" + inputField
        
        let url = URL(string: urlPath)!
        
        
        //This builds a request for the raw data from the page. At this point we could either write code to get the data parsed as JSON, or use this solution.
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            //Converts response into a string
            htmlResponse = String(data: data, encoding: .utf8)!
            
            var searchInput: String = ""
            
            //This cuts off only the text field (And what comes after it, not perfect solution that works for any API). And counts occurrences of the input in it. Case sensitive.
            if let parsedForTextField = htmlResponse.range(of: "\"text\":") {
                searchInput = String(htmlResponse[parsedForTextField.upperBound...])
            }
            
            //Updates result
            resultCount = subStringCounter(fullString: searchInput, subString: inputField)
            
            /**
             Alternatively for just the Wikipedia API, instead of cutting off after the text field, you could also just baseline remove one more instance of the input, since it only happens once before the text field due to the title header.
             
             But this should really be done by parsing the JSON instead of using the raw data that comes in.
             */
        }
        
        //Send GET request
        task.resume()
    }
}

#Preview {
    InputView()
}
