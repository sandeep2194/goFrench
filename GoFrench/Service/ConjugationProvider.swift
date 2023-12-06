//
//  ConjugationService.swift
//  GoFrench
//
//  Created by Sandeep Singh on 2023-11-22.
//

import Foundation


class ConjugationProvider {
    
    static let baseUrl = "https://french-verbs-fall-2023-app-ramym.ondigitalocean.app";
    static let token:String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbmRlZXBjbjk5OEBnbWFpbC5jb20iLCJ1aWQiOiI2NTcwZDYyZDAyYzI4MDgzNDUzYzkwYTIiLCJleHAiOjE3MDQ0ODU3MDV9.rI9Qg_c1kf4_J5KyeD67VcIeHi-l1Ef16NP30RX4d_k"
    // Function to fetch conjugation data from the API

    static func fetchConjugationData(for word: String, completion: @escaping (Data?) -> Void) {
        guard let verbsURL = URL(string: "\(baseUrl)/v0/verbs") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: verbsURL)
        request.httpMethod = "POST"
        
        // Set Content-Type to application/json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Add token to the request header
        request.setValue(token, forHTTPHeaderField: "x-access-token")

        // Prepare the body data
        let body: [String: String] = ["verb": word]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
            print("Request URL: \(verbsURL)")
            print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
            print("Request Body: \(String(data: jsonData, encoding: .utf8) ?? "nil")")
        } catch {
            print("Error creating the request body: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response: \(response.debugDescription)")

            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(jsonResponse)")
                    let conjugationData = self.parseConjugationResponse(from: jsonResponse)
                    completion(conjugationData)
                } else {
                    print("Invalid JSON format")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    // Function to parse the given JSON and return Data
   static func parseConjugationResponse(from jsonResponse: [String: Any]) -> Data? {
        guard let data = jsonResponse["verb"] as? [String: Any],
              let word = data["word"] as? String,
              let fullDescription = data["fullDescription"] as? String,
              let verbGroup = data["wordVerbGroup"] as? String,
              let verbType = data["wordVerbType"] as? String,
              let conjugateWith = data["wordConjugateWithWhichVerb"] as? String,
              let conjugateRule = data["wordConjugateRule"] as? String else {
            return nil
        }

        var conjugations = [Conjugation]()

        // Handle "infinitive" and "participe"
        if let infinitive = data["infinitive"] as? [String: String] {
            for (tense, verbForm) in infinitive {
                let conjugation = Conjugation(
                    type: "Infinitive",
                    tense: tense,
                    conjugatedForm: verbForm,
                    subject: ""
                )
                conjugations.append(conjugation)
            }
        }
        if let participe = data["participe"] as? [String: String] {
            for (tense, verbForm) in participe {
                let conjugation = Conjugation(
                    type: "Participe",
                    tense: tense,
                    conjugatedForm: verbForm,
                    subject: ""
                )
                conjugations.append(conjugation)
            }
        }

        // Handle other conjugation types
        let conjugationTypes = ["indicatif", "subjonctif", "conditionnel", "imperatif"]
        
        for type in conjugationTypes {
            if let tenseDict = data[type] as? [String: Any] {
                for (tenseKey, tenseValue) in tenseDict {
                    if let conjugationsForTense = tenseValue as? [String: String] {
                        for (fullSubjectKey, conjugatedForm) in conjugationsForTense {
                            let subject = extractSubject(from: fullSubjectKey)
                            let conjugation = Conjugation(
                                type: type.capitalized,
                                tense: tenseKey,
                                conjugatedForm: conjugatedForm,
                                subject: subject
                            )
                            conjugations.append(conjugation)
                        }
                    }
                }
            }
        }

        return Data(
            word: word,
            fullDescription: fullDescription,
            verbGroup: verbGroup,
            verbType: verbType,
            conjugateWith: conjugateWith,
            conjugateRule: conjugateRule,
            conjugations: conjugations
        )
    }

    static private func extractSubject(from key: String) -> String {
        let subjects = key.split(whereSeparator: { $0.isUppercase }).map(String.init)
        return subjects.last ?? key
    }
}

