import SwiftUI

struct LoginView: View {
    @State private var phoneNumber: String = ""
    @State private var pin: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Navigation control
    @State private var navigateToDashboard = false
    @State private var navigateToRegister = false
    
    // To dismiss keyboard
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient (matching WelcomeView)
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.15), Color.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    Text("Login to Zento")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    
                    // Phone input with icon
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // PIN input with icon
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        SecureField("PIN", text: $pin)
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // Login button
                    Button(action: {
                        dismissKeyboard()
                        login()
                    }) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                                    .opacity(phoneNumber.isEmpty || pin.isEmpty ? 0.5 : 1.0)
                            )
                            .cornerRadius(30)
                            .padding(.horizontal)
                            .shadow(color: phoneNumber.isEmpty || pin.isEmpty ? Color.clear : Color.blue.opacity(0.5),
                                    radius: 8, x: 0, y: 5)
                    }
                    .disabled(phoneNumber.isEmpty || pin.isEmpty)
                    
                    // Register navigation button
                    Button(action: {
                        navigateToRegister = true
                    }) {
                        Text("Don't have an account? Register")
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // NavigationLinks hidden
                    NavigationLink(
                        destination: DashboardView(),
                        isActive: $navigateToDashboard,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: RegisterView(),
                        isActive: $navigateToRegister,
                        label: { EmptyView() }
                    )
                }
                .padding()
                // Dismiss keyboard tapping outside inputs
                .onTapGesture {
                    dismissKeyboard()
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    // Simple login validation (placeholder)
    func login() {
        if phoneNumber.count < 8 || pin.count < 4 {
            alertMessage = "Please enter valid phone number and PIN."
            showAlert = true
        } else {
            // TODO: Replace with real auth logic, call backend API, etc.
            print("Logging in with phone: \(phoneNumber), PIN: \(pin)")
            alertMessage = "Login successful! (Demo)"
            showAlert = true
            
            // Navigate to dashboard on success
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                navigateToDashboard = true
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
