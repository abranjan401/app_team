//  ContentView.swift
//  Spotify Project
//
//  Created by arshi bhartia ranjan on 9/30/25.

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.purple.opacity(0.8), .black],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                // top bar
                HStack {
                    Button(action: {}){
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("currents!")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                // song photo
                Image("bad_idea_right")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                Spacer().frame(height: 40)
                
                VStack(spacing: 4) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("bad idea right")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Olivia Rodrigo")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "heart")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                Spacer().frame(height: 20)
                
                // listening bar
                VStack {
                    Slider(value: .constant(0.3))
                    HStack{
                        Text("1:12")
                            .font(.caption)
                            .foregroundColor(.white)
                        Spacer()
                        Text("-2:45")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 30)
                Spacer().frame(height: 20)
                
                // playback stuff
                HStack(spacing: 40){
                    Button(action: {}){
                        Image(systemName: "shuffle")
                            .foregroundColor(.green)
                    }
                    Button(action: {}){
                        Image(systemName: "backward.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                    Button(action: {}){
                        Image(systemName: "playpause.fill")
                            .font(.system(size: 45))
                            .foregroundColor(.white)
                    }
                    Button(action: {}){
                        Image(systemName: "forward.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                    Button(action: {}){
                        Image(systemName: "repeat")
                            .font(.system(size: 28))
                            .foregroundColor(.green)
                    }
                    
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                // bottom symbols
                HStack(spacing: 40){
                    Image(systemName: "hifispeaker.fill")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                    Image(systemName: "text.justify")
                        .foregroundColor(.white)
                }
                .font(.title3)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}

