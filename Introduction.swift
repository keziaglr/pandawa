//
//  Introduction.swift
//  WayangCoba
//
//  Created by Kezia Gloria on 16/04/23.
//

import SwiftUI
import SpriteKit

struct Introduction: View {
    @State private var moveLayer1 = false
    @State private var showTitle = false
    @State private var showDesc = false
    @State private var showPandawa = false
    @State private var showNextButton = false
    @StateObject var dataWayang = DataWayang()
    @State private var refreshID = UUID()
    @State private var moveCloud1 = true
    @State private var moveCloud2 = false
    @State private var moveCloud3 = true
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
                            
                            
                            VStack {
                                Text("Pandawa")
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(showTitle ? 1 : 0)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                showTitle = true
                                            }
                                        }
                                    }
                                
                                Text("Pandawa is the name given to five siblings in the shadow puppet characters featured in the story of the Mahabharata. As the name suggests, Pandawa consists of five characters who are the children of Pandu, a king in Hastinapura. Each of these five characters has different personalities and traits.")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 900)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                                    .opacity(showDesc ? 1 : 0)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                showDesc = true
                                            }
                                        }
                                    }
                                
                                if showNextButton{
                                    NavigationLink(destination: Main()) {
                                    Text("Get to Know Pandawa")
                                            .font(.system(size: 35))
                                            .fontWeight(.bold)
                                            .padding()
                                            .foregroundColor(.white)
                                            .shadow(radius: 8)
                                        
                                    }.padding(.top, 20)
                                }
                                
                                SpriteView(scene: PandawaScene(size: CGSize(width: 390, height: 200), dataWayang: dataWayang), options: [.allowsTransparency])
                                    .frame(width: 1000, height: 700, alignment: .bottom)
                                    .id(refreshID)
                                    .transition(.move(edge: .leading))
                                    .opacity(showPandawa ? 1 : 0)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                                showPandawa = true
                                            }
                                        }
                                    }
                            }.onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                                        showNextButton = true
                                    }
                                }
                            }
                        }
                }
            }.navigationViewStyle(.stack)
            .navigationBarBackButtonHidden(true)
        }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}
