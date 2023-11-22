//
//  ConjugationService.swift
//  GoFrench
//
//  Created by sandeep singh on 2023-11-22.
//

import Foundation


//
//  ConjugationService.swift
//  GoFrench
//
//  Created by Sandeep Singh on 2023-11-22.
//

import Foundation

// Define a structure to represent a conjugation object
struct ConjugationObject {
    let type: String
    let tense: String
    let word: String
    let subject: String
}

// Define a service to parse the API response and return conjugation objects
class ConjugationService {
    
    let conjugationApiUrl = URL(string: "https://mocki.io/v1/2e7196ac-1909-4883-bb17-ed996ea1c487")!
    
    // Function to parse the given JSON and return an array of ConjugationObject
    func fetchConjugationData(completion: @escaping ([ConjugationObject]?) -> Void) {
        URLSession.shared.dataTask(with: conjugationApiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let conjugations = self.parseConjugationResponse(from: jsonResponse)
                    completion(conjugations)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func parseConjugationResponse(from jsonResponse: [String: Any]) -> [ConjugationObject] {
        var conjugations = [ConjugationObject]()
        
        guard let data = jsonResponse["data"] as? [String: Any],
              let word = data["word"] as? String else {
            return []
        }
        
        if let infinitive = data["infinitive"] as? [String: String] {
                for (tense, verbForm) in infinitive {
                    conjugations.append(ConjugationObject(type: "Infinitive", tense: tense, word: verbForm, subject: ""))
                }
        }
        if let participe = data["participe"] as? [String: String] {
                for (tense, verbForm) in participe {
                    conjugations.append(ConjugationObject(type: "Participe", tense: tense, word: verbForm, subject: ""))
                }
        }
        
        let conjugationTypes = ["indicatif", "subjonctif", "conditionnel", "imperatif"]

        for type in conjugationTypes {
            if let tenseDict = data[type] as? [String: Any] {
                for (tenseKey, tenseValue) in tenseDict {
                    if let conjugationsForTense = tenseValue as? [String: String] {
                        for (fullSubjectKey, conjugatedForm) in conjugationsForTense {
                            let subject = extractSubject(from: fullSubjectKey)
                            let conjugation = ConjugationObject(
                                type: type.capitalized,
                                tense: tenseKey,
                                word: conjugatedForm,
                                subject: subject
                            )
                            conjugations.append(conjugation)
                        }
                    }
                }
            }
        }

        return conjugations
    }

    // Extracts the subject from the given key
    private func extractSubject(from key: String) -> String {
        // Split the key by uppercase letters
        let subjects = key.split(whereSeparator: { $0.isUppercase }).map(String.init)

        // Return the last part which should be the subject
        return subjects.last ?? key
    }
}
