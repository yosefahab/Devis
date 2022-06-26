//
//  QuoteStore.swift
//  Devis
//
//  Created by Youssef Ahab on 21/06/2022.
//
import Foundation
import SwiftUI

class QuoteStore: ObservableObject {
    
    @Published var quotes: [Quote] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("quotes.data")
    }
    
    static func load() async throws -> [Quote] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let quotes):
                    continuation.resume(returning: quotes)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Quote], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let quotes = try JSONDecoder().decode([Quote].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(quotes))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(quotes: [Quote]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(quotes: quotes) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let quoteSaved):
                    continuation.resume(returning: quoteSaved)
                }
            }
        }
    }
    
    static func save(quotes: [Quote], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(quotes)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(quotes.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
