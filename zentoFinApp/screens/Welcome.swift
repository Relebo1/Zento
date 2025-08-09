import SwiftUI

struct WelcomeView: View {
    // Animation state for floating effect
    @State private var animate = false
    
    var body: some View {
        NavigationView {  // Wrap in NavigationView
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.25), Color.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Floating fintech-themed spheres with icons
                    ZStack {
                        // Large blue sphere with a bank icon
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.85), Color.cyan.opacity(0.7)]),
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .frame(width: 160, height: 160)
                            .shadow(color: Color.blue.opacity(0.5), radius: 15, x: 0, y: 8)
                            .offset(x: animate ? -70 : -60, y: animate ? -40 : -30)
                            .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                        
                        Image(systemName: "banknote.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white.opacity(0.3))
                            .offset(x: -70, y: -40)
                        
                        // Medium green sphere with credit card icon
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.85), Color.teal.opacity(0.75)]),
                                                 startPoint: .topTrailing,
                                                 endPoint: .bottomLeading))
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.green.opacity(0.5), radius: 10, x: 0, y: 5)
                            .offset(x: animate ? 70 : 60, y: animate ? -60 : -50)
                            .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), value: animate)
                        
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.white.opacity(0.35))
                            .offset(x: 70, y: -60)
                        
                        // Small purple-blue sphere with chart icon
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.85), Color.blue.opacity(0.7)]),
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .frame(width: 40, height: 40)
                            .shadow(color: Color.purple.opacity(0.4), radius: 6, x: 0, y: 3)
                            .offset(x: animate ? 30 : 20, y: animate ? 60 : 50)
                            .animation(Animation.easeInOut(duration: 7).repeatForever(autoreverses: true), value: animate)
                        
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.4))
                            .offset(x: 30, y: 60)
                    }
                    .frame(height: 180)
                    .onAppear {
                        animate = true
                    }
                    
                    VStack(spacing: 16) {
                        Text("Welcome to")
                            .font(.subheadline)             // Slightly smaller, lighter intro
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                        
                        Text("Zento")
                            .font(.system(size: 44, weight: .bold, design: .rounded))  // Bigger and bolder for brand
                            .foregroundColor(Color.blue)
                            .padding(.bottom, 12)
                        
                        Text("Your trusted digital wallet for fast, secure payments in Lesotho.")
                            .font(.body)                   // A bit bigger than subheadline for better readability
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .lineSpacing(4)                // Better line spacing if text wraps
                        
                        Text("Smart and secure fintech for Lesotho")
                            .font(.footnote)               // Smaller, secondary tagline
                            .foregroundColor(.secondary.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .padding(.top, 4)
                    }

                    
                    Spacer()
                    
                    // NavigationLink embedded in button style
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Get Started")
                                .fontWeight(.semibold)
                            Image(systemName: "creditcard.fill")  // fintech icon
                                .font(.title2)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                        .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 6)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
