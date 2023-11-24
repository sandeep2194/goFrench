//
//  ConjugationService.swift
//  GoFrench
//
//  Created by Sandeep Singh on 2023-11-22.
//

import Foundation




class ConjugationProvider {
    
   static let baseUrl = URL(string: "https://mocki.io/v1/2e7196ac-1909-4883-bb17-ed996ea1c487")!
    
    // Function to fetch conjugation data from the API
    static func fetchConjugationData(for word: String, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let conjugationData = self.parseConjugationResponse(from: jsonResponse)
                    completion(conjugationData)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    // Function to parse the given JSON and return ConjugationData
   static func parseConjugationResponse(from jsonResponse: [String: Any]) -> Data? {
        guard let data = jsonResponse["data"] as? [String: Any],
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

