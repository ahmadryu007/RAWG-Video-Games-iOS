//
//  Games.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let games = try? JSONDecoder().decode(Games.self, from: jsonData)

import Foundation

// MARK: - Games
struct Games: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let description: String?
    let filters: Filters?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description, filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int?
    let filter: String?
    let decade: Int?
    let years: [YearYear]?
    let nofollow: Bool?
    let count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int?
    let nofollow: Bool?
}

// MARK: - Result
struct Game: Codable {
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let genres: [Genre]?
    let stores: [Store]?
    let clip: String?
    let tags: [Genre]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    var language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

// MARK: - RequirementsEn
struct RequirementsEn: Codable {
    let minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Store
struct Store: Codable {
    let id: Int?
    let store: Genre?
}
