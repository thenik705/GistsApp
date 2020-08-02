//
//  StringUtils.swift
//  GistsApp
//
//  Created by Nik on 27.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation

extension String {

    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn( matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet as CharacterSet) != nil
    }

    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn( matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet as CharacterSet) != nil
    }

    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn( matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet as CharacterSet) != nil
    }

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func isNotEmpty() -> Bool {
        return !self.trim().isEmpty
    }

    func containsIgnoringCase( find: String) -> Bool {
        return (range(of: find) != nil)
    }
}
