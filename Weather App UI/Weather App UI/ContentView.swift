//
//  ContentView.swift
//  Weather App UI
//
//  Created by arshi bhartia ranjan on 10/21/25.
//

import SwiftUI

struct Hour: Identifiable {
    let id = UUID() // A unique ID for ForEach loops
    let time: String
    let iconName: String // SF Symbol name like 'sun.max.fill'
    let temperature: Int
}

// This struct holds the data for each day in the 10-day forecast!
struct Day: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let iconName: String
    let probability: Int // Chance of rain or snow (the little percentage)
    let lowTemp: Int
    let highTemp: Int
}


// some pretend data for the hourly forecast!
let hourlyForecastData: [Hour] = [
    Hour(time: "Now", iconName: "sun.max.fill", temperature: 24),
    Hour(time: "10AM", iconName: "sun.max.fill", temperature: 25),
    Hour(time: "11AM", iconName: "cloud.sun.fill", temperature: 26),
    Hour(time: "12PM", iconName: "cloud.fill", temperature: 27),
    Hour(time: "1PM", iconName: "cloud.rain.fill", temperature: 26),
    Hour(time: "2PM", iconName: "cloud.rain.fill", temperature: 25),
    Hour(time: "3PM", iconName: "cloud.drizzle.fill", temperature: 24),
    Hour(time: "4PM", iconName: "cloud.fill", temperature: 23),
    Hour(time: "5PM", iconName: "cloud.moon.fill", temperature: 21),
    Hour(time: "6PM", iconName: "moon.fill", temperature: 20),
]

// some pretend data for the weekly forecast
let weeklyForecastData: [Day] = [
    Day(dayOfWeek: "Today", iconName: "sun.max.fill", probability: 0, lowTemp: 18, highTemp: 28),
    Day(dayOfWeek: "Wed", iconName: "cloud.sun.fill", probability: 0, lowTemp: 19, highTemp: 27),
    Day(dayOfWeek: "Thu", iconName: "cloud.rain.fill", probability: 60, lowTemp: 16, highTemp: 22),
    Day(dayOfWeek: "Fri", iconName: "cloud.drizzle.fill", probability: 75, lowTemp: 15, highTemp: 20),
    Day(dayOfWeek: "Sat", iconName: "cloud.snow.fill", probability: 80, lowTemp: 10, highTemp: 17),
    Day(dayOfWeek: "Sun", iconName: "snow", probability: 90, lowTemp: 9, highTemp: 14),
    Day(dayOfWeek: "Mon", iconName: "wind.snow", probability: 50, lowTemp: 12, highTemp: 18),
    Day(dayOfWeek: "Tue", iconName: "sun.max.fill", probability: 0, lowTemp: 15, highTemp: 25),
    Day(dayOfWeek: "Wed", iconName: "cloud.sun.fill", probability: 0, lowTemp: 17, highTemp: 26),
    Day(dayOfWeek: "Thu", iconName: "sun.max.fill", probability: 0, lowTemp: 18, highTemp: 28),
]

struct HourlyRowView: View {
    let hour: Hour

    var body: some View {
        VStack(spacing: 8) {
            Text(hour.time)
                .font(.caption) // Small text for time
            
            Image(systemName: hour.iconName)
                .font(.title2) // Bigger icon
                .symbolRenderingMode(.multicolor)
            
            Text("\(hour.temperature)°")
                .font(.title3)
                .fontWeight(.medium)
        }
    
        .padding(.horizontal, 10)
    }
}


struct HourlyForecastView: View {
    let forecast: [Hour]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
           
            Text("HOURLY FORECAST")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
                .padding(.leading)
            
            Divider() // The thin line separator!
                .overlay(Color.white.opacity(0.3))
            
            // intermediate requirement!
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    // loop through all hourly data
                    ForEach(forecast) { hour in
                        HourlyRowView(hour: hour)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.vertical, 10)
        
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.4))
        )
    }
}

struct TemperatureBarView: View {
    let low: Int
    let high: Int
    

    let minOverall: Double = 9.0
    let maxOverall: Double = 28.0

   
    let barWidth: CGFloat = 120

    var body: some View {
    
        GeometryReader { geometry in
            // 1. Calculate the position and width of the dark blue bar (actual daily range)
            let totalRange = maxOverall - minOverall
            let dailyRange = Double(high - low)
            let dailyStart = Double(low) - minOverall
            
            // Find where the bar should start (like an x-offset)
            let startOffset = (dailyStart / totalRange) * barWidth
            // Find how wide the daily range should be
            let rangeWidth = (dailyRange / totalRange) * barWidth

            // challenging randomization part
            // 2. Randomize the inner (lighter blue) bar
            // Make the inner bar between 30% and 70% of the daily range width
            let innerRangeFraction = Double.random(in: 0.3...0.7)
            let innerWidth = rangeWidth * innerRangeFraction

            // Place the inner bar randomly within the daily range
            let maxInnerStartOffset = rangeWidth - innerWidth
            let innerStartPlacement = Double.random(in: 0...maxInnerStartOffset)
            
            // The final starting X position for the inner bar
            let innerStartX = startOffset + innerStartPlacement
            
            ZStack(alignment: .leading) {
                // The light grey background for the whole weekly range (9-28)
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 5)
                
                // The dark blue bar representing the day's high/low range
                Capsule()
                    .fill(Color.blue.opacity(0.7))
                    .frame(width: rangeWidth, height: 5)
                    .offset(x: startOffset) // Push it to the right position
                
                // The lighter blue bar representing the inner, randomized range!
                Capsule()
                    .fill(Color.cyan.opacity(0.8)) // Brighter color for the inner part
                    .frame(width: innerWidth, height: 5)
                    .offset(x: innerStartX) // Push it to its random spot
            }
        }
       
        .frame(width: barWidth, height: 10)
    }
}

// 2.4. Weekly Row View (This would be in WeeklyRowView.swift)
// This is the row for one day in the 10-day list!
struct WeeklyRowView: View {
    let day: Day

    var body: some View {
        HStack {
            // 1. Day of Week
            Text(day.dayOfWeek)
                .frame(width: 50, alignment: .leading)
            
            Spacer()
            
           
            HStack(spacing: 6) {
                
                if day.probability > 0 {
                    Text("\(day.probability)%")
                        .font(.caption)
                        .foregroundColor(.cyan)
                }
                
                Image(systemName: day.iconName)
                    .font(.title3)
                    .symbolRenderingMode(.multicolor)
                    .frame(width: 25)
            }
            .frame(width: 75, alignment: .trailing)
            
            Spacer()

         
            Text("\(day.lowTemp)°")
                .foregroundColor(.gray)
                .frame(width: 30, alignment: .trailing)
            
            // 4. The custom temperature bar!
            TemperatureBarView(low: day.lowTemp, high: day.highTemp)
            
            // 5. High Temperature
            Text("\(day.highTemp)°")
                .frame(width: 30, alignment: .trailing) //
        }
        
        .padding(.vertical, 4)
    }
}


// This container holds the 10-day forecast list!
struct WeeklyForecastView: View {
    let forecast: [Day]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title for the box
            Text("10-DAY FORECAST")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
                .padding(.leading)
            
            Divider()
                .overlay(Color.white.opacity(0.3))
            
            // List of all the day rows!
            ForEach(forecast) { day in
                WeeklyRowView(day: day)
                
            
                if day.id != forecast.last?.id {
                    Divider()
                        .padding(.leading, 10) // Indent the divider line
                        .overlay(Color.white.opacity(0.2))
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        // Make the background look like a card again!
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.4))
        )
    }
}


// This is the big text block at the top with the main weather info!
struct CurrentWeatherView: View {
    var body: some View {
        VStack(spacing: -5) {
            Text("San Francisco")
                .font(.largeTitle)
                .fontWeight(.regular)

            Text("24°")
                .font(.system(size: 80, weight: .thin)) // Extra large and thin!

            Text("Mostly Sunny")
                .font(.title3)
            
            // Low and High temp at the bottom
            HStack {
                Text("H:28°")
                Text("L:18°")
            }
            .font(.title3)
        }
        .padding(.top, 40) // Push it down a little from the top edge
    }
}


struct ContentView: View {
    
    // i made a super dark blue gradient for the background to look like the app!
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color(red: 0.2, green: 0.4, blue: 0.8)]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        // use a ZStack to put the background behind the scrolling content
        ZStack {
            // the dark blue background that fills the whole screen
            backgroundGradient
                .ignoresSafeArea() // make sure it goes all the way up and down

            // the main scroll view so we can see all the content!
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    // 1. the top current temperature section
                    CurrentWeatherView()
                    
                    // 2. the hourly forecast component (the scrolling box)
                    HourlyForecastView(forecast: hourlyForecastData)
                        .padding(.horizontal)
                    
                    // 3. the weekly 10-day forecast component
                    WeeklyForecastView(forecast: weeklyForecastData)
                        .padding(.horizontal)
                    
                    // Add some space at the bottom!
                    Spacer(minLength: 40)
                }
            }
            // all the text and icons should be white on the dark background!
            .foregroundColor(.white)
        }
    }
}


#Preview {
    ContentView()
}
