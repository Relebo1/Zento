import SwiftUI

struct RegisterView: View {
    // Step 0: Personal Info
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth = Date()
    
    // Step 1: Contact Info & ID
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var idNumber: String = ""
    
    // Step 2: Security
    @State private var pin: String = ""
    @State private var confirmPin: String = ""
    @State private var acceptedTerms: Bool = false
    
    // Step control
    @State private var currentStep: Int = 0
    
    // Alert for validation messages
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // To dismiss keyboard
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // Detect size class to adapt datepicker style
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // MARK: Progress Indicator
                stepProgress
                
                Group {
                    switch currentStep {
                    case 0: stepPersonalInfo
                    case 1: stepContactAndID
                    case 2: stepSecurity
                    default: Text("Unknown Step")
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 4)
                .animation(.easeInOut, value: currentStep)
                
                Spacer(minLength: 20)
                
                HStack(spacing: 16) {
                    Button(action: {
                        dismissKeyboard()
                        if currentStep > 0 {
                            withAnimation {
                                currentStep -= 1
                            }
                        }
                    }) {
                        Text("Previous")
                            .fontWeight(.medium)
                            .foregroundColor(currentStep > 0 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(currentStep > 0 ? 0.1 : 0.05))
                            .cornerRadius(15)
                    }
                    .disabled(currentStep == 0)
                    
                    Button(action: {
                        dismissKeyboard()
                        if validateStep() {
                            if currentStep < 2 {
                                withAnimation {
                                    currentStep += 1
                                }
                            } else {
                                submitRegistration()
                            }
                        }
                    }) {
                        Text(currentStep < 2 ? "Next" : "Submit")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(color: Color.green.opacity(0.5), radius: 10, x: 0, y: 4)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .navigationBarTitle("Register", displayMode: .inline)
    }
    
    // MARK: Step progress dots
    var stepProgress: some View {
        HStack(spacing: 12) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(index == currentStep ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 14, height: 14)
                    .scaleEffect(index == currentStep ? 1.3 : 1.0)
                    .animation(.spring(), value: currentStep)
            }
        }
        .padding(.bottom, 8)
    }
    
    // MARK: Step Views
    
    var stepPersonalInfo: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Personal Information")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .overlay(Divider().offset(y: 18))
            
            Group {
                Text("First Name")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                TextField("Enter first name", text: $firstName)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Group {
                Text("Last Name")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                TextField("Enter last name", text: $lastName)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Group {
                Text("Date of Birth")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                // Adapt DatePicker style for compact on smaller screens
                if horizontalSizeClass == .compact {
                    DatePicker("Select your date of birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "en_US_POSIX"))
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                } else {
                    DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "en_US_POSIX"))
                        .labelsHidden()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                }
            }
        }
    }
    
    var stepContactAndID: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Contact & Identification")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .overlay(Divider().offset(y: 18))
            
            Group {
                Text("Phone Number")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                TextField("e.g., +26612345678", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Group {
                Text("Email (optional)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                TextField("you@example.com", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Group {
                Text("National ID / Passport Number")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                TextField("Enter your ID", text: $idNumber)
                    .keyboardType(.default)
                    .autocapitalization(.allCharacters)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
        }
    }
    
    var stepSecurity: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Security Setup")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .overlay(Divider().offset(y: 18))
            
            Group {
                Text("Create a 4-digit PIN")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                SecureField("PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Group {
                Text("Confirm PIN")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                SecureField("Confirm PIN", text: $confirmPin)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            }
            
            Toggle(isOn: $acceptedTerms) {
                Text("I agree to the Terms & Conditions")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
            .padding(.top, 8)
        }
    }
    
    // MARK: Validation for each step
    
    func validateStep() -> Bool {
        switch currentStep {
        case 0:
            if firstName.trimmingCharacters(in: .whitespaces).isEmpty {
                alertMessage = "Please enter your first name."
                showAlert = true
                return false
            }
            if lastName.trimmingCharacters(in: .whitespaces).isEmpty {
                alertMessage = "Please enter your last name."
                showAlert = true
                return false
            }
            let age = calculateAge(from: dateOfBirth)
            if age < 18 {
                alertMessage = "You must be at least 18 years old."
                showAlert = true
                return false
            }
        case 1:
            if phoneNumber.trimmingCharacters(in: .whitespaces).count < 8 {
                alertMessage = "Please enter a valid phone number."
                showAlert = true
                return false
            }
            if !email.isEmpty && !isValidEmail(email) {
                alertMessage = "Please enter a valid email address."
                showAlert = true
                return false
            }
            if idNumber.trimmingCharacters(in: .whitespaces).isEmpty {
                alertMessage = "Please enter your ID number."
                showAlert = true
                return false
            }
        case 2:
            if pin.count != 4 || !pin.allSatisfy({ $0.isNumber }) {
                alertMessage = "PIN must be exactly 4 digits."
                showAlert = true
                return false
            }
            if pin != confirmPin {
                alertMessage = "PIN and confirmation do not match."
                showAlert = true
                return false
            }
            if !acceptedTerms {
                alertMessage = "You must accept the Terms & Conditions."
                showAlert = true
                return false
            }
        default:
            break
        }
        return true
    }
    
    // MARK: Submit registration
    
    func submitRegistration() {
        let encryptedPin = encryptPin(pin)
        
        print("Registering user with details:")
        print("- Name: \(firstName) \(lastName)")
        print("- DOB: \(dateOfBirth)")
        print("- Phone: \(phoneNumber)")
        print("- Email: \(email.isEmpty ? "N/A" : email)")
        print("- ID: \(idNumber)")
        print("- Encrypted PIN: \(encryptedPin)")
        
        alertMessage = "Registration successful! (Demo)"
        showAlert = true
    }
    
    // MARK: Helper functions
    
    func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        return ageComponents.year ?? 0
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return pred.evaluate(with: email)
    }
    
    func encryptPin(_ pin: String) -> String {
        return String(pin.reversed())
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
    }
}
