import Foundation

class NewsService {
    
    private static let apiKey = "0742fdca352a4c4c957d1832594ee04c"
    private static let baseURL = "https://newsapi.org/v2"
    
    static func searchArticles(query: String) async throws -> [Article] {
        
        // using 'top-headlines' for simplicity, and encoding the query and API key.
        guard let url = URL(string: "\(baseURL)/top-headlines?q=\(query)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            // URLSession.shared.data(from:) is an asyncfunction that throws.
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // if the status code is outside 200-299, throw an error
                throw URLError(.badServerResponse)
            }
            
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            
            return newsResponse.articles
            
        } catch let error as URLError {
            // error handling for URLSession Network issues
            print("Network Request Error: \(error.localizedDescription)")
            throw error
        } catch let error as DecodingError {
            // error handling for JSON Decoding issues
            print("Decoding Error: \(error.localizedDescription)")
            throw error
        } catch {
            // catch all other errors
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
}
