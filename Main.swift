//
//  Main.swift
//  Pandawa
//
//  Created by Kezia Gloria on 18/04/23.
//

import SwiftUI
import SpriteKit


class DataWayang: ObservableObject {
    @Published var showYudhistiraDesc: Bool = false
    @Published var showBimaDesc: Bool = false
    @Published var showArjunaDesc: Bool = false
    @Published var showNakulaDesc: Bool = false
    @Published var showSadewaDesc: Bool = false
    @Published var isNakula: Bool = true
}


struct Main: View {
    @State var bimaPage : Bool = false
    @State var arjunaPage : Bool = false
    @State var yudhistiraPage : Bool = true
    @State var nakulaPage : Bool = false
    @State var sadewaPage : Bool = false
    @State var endStoryPage : Bool = false
    @StateObject var dataWayang = DataWayang()
    @State private var refreshID = UUID()
    @State private var moveLayer1 = false
    @State private var moveCloud1 = true
    @State private var moveCloud2 = false
    @State private var moveCloud3 = true
    @State private var moveCloud4 = false
    @State private var showYudhistira = false
    @State private var showBima = false
    @State private var showArjuna = false
    @State private var showNakula = false
    @State private var showSadewa = false
    @State private var showEnding = false
    @State private var showNextLevel = false
    @State private var rotationAngle1: Double = 0.0
    @State private var rotationAngle2: Double = -10.0

    
    var body: some View {
        NavigationView{
            ZStack {
                ZStack{
                    Image("base-bg")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                    
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
                VStack{
                    if yudhistiraPage{
                        VStack{
                            Text("Level 1")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                .frame(width: 900)
                                .multilineTextAlignment(.center)
                                .offset(y: 200)
                                .opacity(showYudhistira ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showYudhistira = true
                                        }
                                    }
                                }
                            
                            Text("Follow the shape of the shadow by using sticks to move the puppet")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.center)
                                .padding(2)
                                .frame(width: 800)
                                .offset(y: 200)
                                .foregroundColor(.white)
                                .opacity(showYudhistira ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showYudhistira = true
                                        }
                                    }
                                }
                            SpriteView(scene: YudhistiraScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                .frame(width: 1100, height: 900, alignment: .bottom)
                                .id(refreshID)
                                .transition(.move(edge: .bottom))
                                .offset(y: 200)
                                .opacity(showYudhistira ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showYudhistira = true
                                        }
                                    }
                                }
                        }
                        .sheet(isPresented: $dataWayang.showYudhistiraDesc) {
                            ZStack {
                                ZStack{
                                    Image("bg-pop")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                    Image("cloud-pop1")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud1 ? 0 : 60))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud1.toggle()
                                                }
                                        }
                                    Image("cloud-pop2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud3 ? 0 : 50))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud3.toggle()
                                                }
                                        }
                                    Image("cloud-pop3")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud4 ? 0 : 70))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud4.toggle()
                                                }
                                        }
                                    Image("cloud-pop4")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud2 ? 0 : 80))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud2.toggle()
                                                }
                                        }
                                }
                                VStack{
                                    SpriteView(scene: YudhistiraScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                                    .frame(width: 400, height: 300, alignment: .center)
                                                    .id(refreshID)
                                                    .transition(.move(edge: .bottom))
                                                    .offset(x: 30)
                                    Text("Yudistira")
                                        .font(.system(size: 40))
                                        .fontWeight(.bold)
                                    Text("Yudistira is the eldest son of Pandu Dewanata and Dewi Kunti. Yudistira is depicted as the incarnation of God Yama, who reigns in the Kingdom of Amarta. This character is known for his wisdom, rarely telling lies or deceit throughout his life, having very high morals, and being a forgiving person.")
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                        .frame(width: 600)
                                    Button(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.yudhistiraPage = false
                                            self.bimaPage = true
                                            showNextLevel = false
                                        }
                                    }, label: {
                                        Text("Next Level")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        
                                    }).offset(y: 50)
                                        .opacity(showNextLevel ? 1 : 0)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                    showNextLevel = true
                                                }
                                            }
                                        }
                                }
                                
                            }.interactiveDismissDisabled(true)
                            
                        }
                    }else if bimaPage
                    {
                        VStack{
                            Text("Level 2")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .shadow(radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 900)
                                .multilineTextAlignment(.center)
                                .offset(y: 200)
                                .opacity(showBima ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showBima = true
                                        }
                                    }
                                }
                            
                            
                            Text("Follow the shape of the shadow by using sticks to move the puppet")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.center)
                                .padding(2)
                                .frame(width: 800)
                                .offset(y: 200)
                                .foregroundColor(.white)
                                .opacity(showBima ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showBima = true
                                        }
                                    }
                                }
                            SpriteView(scene: BimaScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                .frame(width: 1100, height: 900, alignment: .bottom)
                                .id(refreshID)
                                .transition(.move(edge: .bottom))
                                .offset(y: 200)
                                .opacity(showBima ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showBima = true
                                        }
                                    }
                                }
                        }
                        .sheet(isPresented: $dataWayang.showBimaDesc) {
                            ZStack {
                                ZStack{
                                    Image("bg-pop")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                    Image("cloud-pop1")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud1 ? 0 : 60))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud1.toggle()
                                                }
                                        }
                                    Image("cloud-pop2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud3 ? 0 : 50))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud3.toggle()
                                                }
                                        }
                                    Image("cloud-pop3")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud4 ? 0 : 70))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud4.toggle()
                                                }
                                        }
                                    Image("cloud-pop4")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud2 ? 0 : 80))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud2.toggle()
                                                }
                                        }
                                }
                                VStack{
                                    SpriteView(scene: BimaScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                        .frame(width: 400, height: 300, alignment: .center)
                                        .offset(x: 30)
                                        .id(refreshID)
                                        .transition(.move(edge: .bottom))
                                    Text("Bima")
                                        .font(.system(size: 40))
                                        .fontWeight(.bold)
                                    Text("Bima is the second son of Pandu Dewanata and Dewi Kunti. He is depicted as the incarnation of the Wind God, who resides in the Kadipaten Jodipati in the Indraprastha region. This character is portrayed as a strong, rough, and intimidating figure to his enemies, but with a very gentle heart. Bima is brave, firm, strong, resilient, obedient, and honest in nature.")
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                        .frame(width: 600)
                                    Button(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.bimaPage = false
                                            self.arjunaPage = true
                                            showNextLevel = false
                                        }
                                    }, label: {
                                        Text("Next Level")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        
                                    }).offset(y: 50)
                                        .opacity(showNextLevel ? 1 : 0)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                    showNextLevel = true
                                                }
                                            }
                                        }
                                }
                                
                            }.interactiveDismissDisabled(true)
                            
                        }
                    }
                    else if arjunaPage
                    {
                        VStack{
                            Text("Level 3")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .shadow(radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 900)
                                .multilineTextAlignment(.center)
                                .offset(y: 200)
                                .opacity(showArjuna ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showArjuna = true
                                        }
                                    }
                                }
                            
                            
                            Text("Follow the shape of the shadow by using sticks to move the puppet")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.center)
                                .padding(2)
                                .frame(width: 800)
                                .offset(y: 200)
                                .foregroundColor(.white)
                                .opacity(showArjuna ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showArjuna = true
                                        }
                                    }
                                }
                            SpriteView(scene: ArjunaScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                .frame(width: 1100, height: 900, alignment: .bottom)
                                .id(refreshID)
                                .transition(.move(edge: .bottom))
                                .offset(y: 200)
                                .opacity(showArjuna ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showArjuna = true
                                        }
                                    }
                                }
                        }
                        .sheet(isPresented: $dataWayang.showArjunaDesc) {
                            ZStack {
                                ZStack{
                                    Image("bg-pop")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                    Image("cloud-pop1")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud1 ? 0 : 60))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud1.toggle()
                                                }
                                        }
                                    Image("cloud-pop2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud3 ? 0 : 50))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud3.toggle()
                                                }
                                        }
                                    Image("cloud-pop3")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud4 ? 0 : 70))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud4.toggle()
                                                }
                                        }
                                    Image("cloud-pop4")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud2 ? 0 : 80))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud2.toggle()
                                                }
                                        }
                                }
                                VStack{
                                    SpriteView(scene: ArjunaScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                        .frame(width: 400, height: 300, alignment: .center)
                                        .offset(x: 30)
                                        .id(refreshID)
                                        .transition(.move(edge: .bottom))
                                    Text("Arjuna")
                                        .font(.system(size: 40))
                                        .fontWeight(.bold)
                                    Text("Arjuna is the youngest son of Prabu Dewanata and Dewi Kunti. Arjuna is believed to be the incarnation of the god Indra, who rules the kingdom of Madukara. He is depicted as a wise and adventurous warrior, who enjoys wandering, meditating, and seeking knowledge. He is known for his noble character, warrior spirit, strong faith, and bravery.")
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                        .frame(width: 600)
                                    Button(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.arjunaPage = false
                                            self.nakulaPage = true
                                            showNextLevel = false
                                        }
                                    }, label: {
                                        Text("Next Level")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        
                                    }).offset(y: 50)
                                        .opacity(showNextLevel ? 1 : 0)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                    showNextLevel = true
                                                }
                                            }
                                        }
                                }
                                
                            }.interactiveDismissDisabled(true)
                            
                        }
                    }
                    else if nakulaPage
                    {
                        VStack{
                            Text("Level 4")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .shadow(radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 900)
                                .multilineTextAlignment(.center)
                                .offset(y: 200)
                                .opacity(showNakula ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showNakula = true
                                        }
                                    }
                                }
                            
                            
                            Text("Follow the shape of the shadow by using sticks to move the puppet")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.center)
                                .padding(2)
                                .frame(width: 800)
                                .offset(y: 200)
                                .foregroundColor(.white)
                                .opacity(showNakula ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showNakula = true
                                        }
                                    }
                                }
                            SpriteView(scene: TwinsScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                .frame(width: 1100, height: 900, alignment: .bottom)
                                .id(refreshID)
                                .transition(.move(edge: .bottom))
                                .offset(y: 200)
                                .opacity(showNakula ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showNakula = true
                                        }
                                    }
                                }
                        }
                        .sheet(isPresented: $dataWayang.showNakulaDesc) {
                            ZStack {
                                ZStack{
                                    Image("bg-pop")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                    Image("cloud-pop1")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud1 ? 0 : 60))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud1.toggle()
                                                }
                                        }
                                    Image("cloud-pop2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud3 ? 0 : 50))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud3.toggle()
                                                }
                                        }
                                    Image("cloud-pop3")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud4 ? 0 : 70))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud4.toggle()
                                                }
                                        }
                                    Image("cloud-pop4")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud2 ? 0 : 80))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud2.toggle()
                                                }
                                        }
                                }
                                VStack{
                                    SpriteView(scene: TwinsScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                        .frame(width: 400, height: 300, alignment: .center)
                                        .offset(x: 30)
                                        .id(refreshID)
                                        .transition(.move(edge: .bottom))
                                    Text("Nakula")
                                        .font(.system(size: 40))
                                        .fontWeight(.bold)
                                    Text("Nakula is one of the twin sons of Pandu and Madrim. Nakula is depicted as the incarnation of the Twin Gods Aswin (gods of healing), and is skilled in playing weapons. He is a tough sword warrior with the character of honesty, loyalty, obedience to parents, ability to keep secrets, and gratitude.")
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                        .frame(width: 600)
                                    Button(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            self.nakulaPage = false
                                            dataWayang.isNakula = false
                                            
                                            
                                            showNextLevel = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            dataWayang.showNakulaDesc = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.sadewaPage = true
                                        }
                                        
                                    }, label: {
                                        Text("Next Level")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        
                                    }).offset(y: 50)
                                        .opacity(showNextLevel ? 1 : 0)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                    showNextLevel = true
                                                }
                                            }
                                        }
                                }
                                
                            }.interactiveDismissDisabled(true)
                            
                        }
                    }
                    else if sadewaPage
                    {
                        VStack{
                            Text("Level 5")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .shadow(radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 900)
                                .multilineTextAlignment(.center)
                                .offset(y: 200)
                                .opacity(showSadewa ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showSadewa = true
                                        }
                                    }
                                }
                            
                            
                            Text("Follow the shape of the shadow by using sticks to move the puppet")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.center)
                                .padding(2)
                                .frame(width: 800)
                                .offset(y: 200)
                                .foregroundColor(.white)
                                .opacity(showSadewa ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showSadewa = true
                                        }
                                    }
                                }
                            SpriteView(scene: TwinsScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                .frame(width: 1100, height: 900, alignment: .bottom)
                                .id(refreshID)
                                .transition(.move(edge: .bottom))
                                .offset(y: 200)
                                .opacity(showSadewa ? 1 : 0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                                            showSadewa = true
                                        }
                                    }
                                }
                        }
                        .sheet(isPresented: $dataWayang.showSadewaDesc) {
                            ZStack {
                                ZStack{
                                    Image("bg-pop")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                    Image("cloud-pop1")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud1 ? 0 : 60))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud1.toggle()
                                                }
                                        }
                                    Image("cloud-pop2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud3 ? 0 : 50))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud3.toggle()
                                                }
                                        }
                                    Image("cloud-pop3")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud4 ? 0 : 70))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud4.toggle()
                                                }
                                        }
                                    Image("cloud-pop4")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .offset(CGSize(width: 0 , height: moveCloud2 ? 0 : 80))
                                        .onAppear {
                                            withAnimation(
                                                .linear(duration: 2)
                                                .speed(0.2)
                                                .repeatForever(autoreverses: true)) {
                                                    moveCloud2.toggle()
                                                }
                                        }
                                }
                                VStack{
                                    SpriteView(scene: TwinsScene(size: CGSize(width: 300, height: 220), dataWayang: dataWayang), options: [.allowsTransparency])
                                        .frame(width: 400, height: 300, alignment: .center)
                                        .offset(x: 30)
                                        .id(refreshID)
                                        .transition(.move(edge: .bottom))
                                    Text("Sadewa")
                                        .font(.system(size: 40))
                                        .fontWeight(.bold)
                                    Text("Sadewa is one of the twin sons of Pandu and Dewi Madrim. Sadewa is the incarnation of the Twin God Aswin. He is portrayed as a figure skilled in astronomy. He has a diligent, wise, loyal, obedient to parents, capable of keeping secrets, and grateful character.")
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                        .frame(width: 600)
                                    Button(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.sadewaPage = false
                                            self.endStoryPage = true
                                        }
                                    }, label: {
                                        Text("Finish")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        
                                    }).offset(y: -150)
                                    
                                        .opacity(showSadewa ? 1 : 0)
                                        .offset(y: 200)
                                }
                                
                            }.interactiveDismissDisabled(true)
                            
                        }
                    }else if endStoryPage{
                        Text("The Pandawa knights emerged as the victors in the Bharatayudha battle, and they were finally able to claim the throne of the Hastinapura Kingdom. Despite the many casualties on both sides, the Pandawa's perseverance and Bima's valorous acts ensured their victory over the Kurawa. With peace restored in the kingdom, the Pandawa brothers were able to rule justly and wisely, bringing prosperity and happiness to their people...")
                            .font(.system(size: 35))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .frame(width: 900)
                            .opacity(showEnding ? 1 : 0)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                                        showEnding = true
                                    }
                                }
                            }
                            .offset(y: -120)
                    }
                }.ignoresSafeArea()
            }
        }.navigationBarHidden(true)
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden(true)
    }
    
}

