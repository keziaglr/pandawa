//
//  SplashScreen.swift
//  WayangCoba
//
//  Created by Kezia Gloria on 16/04/23.
//

import SwiftUI
import AVKit

struct SplashScreen: View {
    @State private var showLayer1 = false
    @State private var moveLayer1 = false
    @State private var showLayer2 = false
    @State private var showLayer3 = false
    @State private var showDeco1 = false
    @State private var showDeco2 = false
    @State private var zoomOutTitle = false
    @State private var showStartButton = false
    @State var audioPlayer: AVAudioPlayer?
    @State private var rotationAngle1: Double = 0.0
    @State private var rotationAngle2: Double = -10.0
    @State private var showCloud1 = false
    @State private var moveCloud1 = true
    @State private var showCloud2 = false
    @State private var moveCloud2 = false
    @State private var showCloud3 = false
    @State private var moveCloud3 = true
    @State private var showCloud4 = false
    @State private var moveCloud4 = false
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                ZStack{
                    Image("base-bg")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                    
                    if showLayer1{
                        Image("bg-layer1")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .bottom))
                            .offset(CGSize(width: 0, height: moveLayer1 ? 0 : 10))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveLayer1.toggle()
                                    }
                            }
                        
                    }
                    if showDeco1{
                        Image("decor1")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(width: 200, height: 600)
                            .transition(.move(edge: .bottom))
                            .rotationEffect(.degrees(rotationAngle1), anchor: .bottom)
                            .offset(x: 300, y: 200)
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.1)
                                    .repeatForever(autoreverses: true)) {
                                        rotationAngle1 = rotationAngle1 == -20.0 ? 20.0 : -20.0
                                    }
                            }
                        
                    }
                    
                    
                    if showLayer2{
                        Image("bg-layer2")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .bottom))
                            .offset(CGSize(width: 0, height: moveLayer1 ? 0 : 20))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveLayer1.toggle()
                                    }
                            }
                    }
                    
                    if showDeco2{
                        Image("decor1")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(width: 200, height: 800)
                            .transition(.move(edge: .bottom))
                            .rotationEffect(.degrees(rotationAngle2), anchor: .bottom)
                            .offset(x: -325, y: 300)
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.1)
                                    .repeatForever(autoreverses: true)) {
                                        rotationAngle2 = rotationAngle2 == -10.0 ? 10.0 : -10.0
                                    }
                            }
                        
                    }
                    
                    if showLayer3{
                        Image("bg-layer3")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .bottom))
                            .offset(CGSize(width: 0, height: moveLayer1 ? 0 : 30))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveLayer1.toggle()
                                    }
                            }
                    }
                    
                    if showCloud1{
                        Image("cloud1")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .leading))
                            .offset(CGSize(width: moveCloud1 ? 0 : 10, height: 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveCloud1.toggle()
                                    }
                            }
                    }
                    if showCloud2{
                        Image("cloud2")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .leading))
                            .offset(CGSize(width: moveCloud2 ? 0 : 10, height: 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveCloud2.toggle()
                                    }
                            }
                    }
                    if showCloud3{
                        Image("cloud3")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .trailing))
                            .offset(CGSize(width: moveCloud3 ? 0 : 10, height: 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveCloud3.toggle()
                                    }
                            }
                    }
                    if showCloud4{
                        Image("cloud4")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .trailing))
                            .offset(CGSize(width: moveCloud4 ? 0 : 10, height: 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 1)
                                    .speed(0.5)
                                    .repeatForever(autoreverses: true)) {
                                        moveCloud4.toggle()
                                    }
                            }
                    }
                    
                }.onAppear {
                    for i in stride(from: 0, to: 15, by: 0.25) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                switch i {
                                case 1.5:
                                    showLayer1 = true
                                case 2.5:
                                    showLayer2 = true
                                case 3.5:
                                    showLayer3 = true
                                case 4.0:
                                    showDeco2 = true
                                case 5.0:
                                    showDeco1 = true
                                case 6.0:
                                    showCloud2 = true
                                case 6.75:
                                    showCloud3 = true
                                case 7.25:
                                    showCloud1 = true
                                case 7.75:
                                    showCloud4 = true
                                case 10.0:
                                    showStartButton = true
                                default:
                                    break
                                }
                            }
                        }
                    }
                    
                }
                
                VStack {
                    Text("Pandawa")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaleEffect(zoomOutTitle ? 1.0 : 0.0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                    zoomOutTitle = true
                                }
                            }
                            playSound()
                        }
                    
                    Text("The Tough Knight in the Indonesia Leather Puppet Story")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .scaleEffect(zoomOutTitle ? 1.0 : 0.0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                    zoomOutTitle = true
                                }
                            }
                        }
                    
                    if showStartButton{
                        NavigationLink(destination: Introduction()) {
                            Text("START")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }.padding(.top, 20)
                    }
                    
                }.padding(.bottom, 250)
            }
        }.navigationViewStyle(.stack)
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "background-music", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
            audioPlayer?.setVolume(0.3, fadeDuration: 0.5)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
