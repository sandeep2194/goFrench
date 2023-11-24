//
//  Data.swift
//  GoFrench
//
//  Created by sandeep singh on 2023-11-24.
//

class Data {
    let word: String
    let fullDescription: String
    let verbGroup: String
    let verbType: String
    let conjugateWith: String
    let conjugateRule: String
    let conjugations: [Conjugation]

    init(word: String, fullDescription: String, verbGroup: String, verbType: String, conjugateWith: String, conjugateRule: String, conjugations: [Conjugation]) {
        self.word = word
        self.fullDescription = fullDescription
        self.verbGroup = verbGroup
        self.verbType = verbType
        self.conjugateWith = conjugateWith
        self.conjugateRule = conjugateRule
        self.conjugations = conjugations
    }
}
