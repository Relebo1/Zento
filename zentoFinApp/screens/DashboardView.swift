import SwiftUI

// MARK: - Main App Tab View
struct AppTabView: View {
    var body: some View {
        TabView {
                    // First Tab: Home Dashboard
                    DashboardView()
                        .tabItem {
                          
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    BillsView()
                        .tabItem {
                            Label("Bills", systemImage: "doc.text.fill")
                        }

                    TransfersView()
                        .tabItem {
                            Label("Transfers", systemImage: "arrow.right.arrow.left.circle.fill")
                        }
                    
                    // Fourth Tab: User Profile
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle.fill")
                        }
                }
 
            }
}

// MARK: - Dashboard View
struct DashboardView: View {
    @State private var accountBalance = 12450.75
    @State private var showBalance = true
    @State private var showMenu = false
    let userName = "Relebohile"
    
    let deepTeal = Color(red: 15/255, green: 118/255, blue: 110/255)
    let accentGold = Color(red: 245/255, green: 158/255, blue: 11/255)
    
    let quickActions: [QuickAction] = [
        QuickAction(label: "Send Money", icon: "arrow.up.circle.fill", color: .purple),
        QuickAction(label: "Request", icon: "arrow.down.circle.fill", color: .green),
        QuickAction(label: "Top Up", icon: "plus.circle.fill", color: .blue),
        QuickAction(label: "More", icon: "ellipsis.circle.fill", color: .gray)
    ]
    
    let transactions: [Transaction] = [
        Transaction(contact: "Adel Khau", amount: 500.00, type: .received, date: "10:45 AM", icon: "person.crop.circle.fill"),
        Transaction(contact: "LEC Prepaid", amount: 200.00, type: .paid, date: "Yesterday", icon: "bolt.fill"),
        Transaction(contact: "Sello Motloli", amount: 1250.00, type: .sent, date: "Aug 8", icon: "person.crop.circle.fill"),
    ]

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // App Bar
                        HStack {
                            Button(action: { showMenu.toggle() }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            Text("Zento")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(colors: [deepTeal, accentGold], startPoint: .leading, endPoint: .trailing)
                                )
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "bell.badge.fill")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        
                        // Greeting and Balance Card
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Good morning, \(userName)")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            // Balance Card
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Balance")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                    
                                HStack {
                                    Text(showBalance ? String(format: "LSL %.2f", accountBalance) : "LSL ••••••••")
                                        .font(.system(size: 32, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            showBalance.toggle()
                                        }
                                    }) {
                                        Image(systemName: showBalance ? "eye.fill" : "eye.slash.fill")
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                }
                                
                                Text("Available Balance")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            .padding(24)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [deepTeal, deepTeal.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: deepTeal.opacity(0.3), radius: 12, x: 0, y: 6)
                        }
                        .padding(.horizontal, 24)

                        // Quick Actions
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(quickActions) { action in
                                    QuickActionButton(action: action)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.vertical, 8)

                        // Recent Activity
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Recent Activity")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button("See All") {}
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 24)
                            
                            VStack(spacing: 0) {
                                ForEach(transactions) { transaction in
                                    TransactionRow(transaction: transaction)
                                    
                                    if transaction.id != transactions.last?.id {
                                        Divider()
                                            .padding(.leading, 72)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                        }
                        
                        // Promo Banner
                        VStack(spacing: 0) {
                            Text("Special Offer")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 12)
                                .background(Color.red)
                                .cornerRadius(4)
                                .offset(y: 8)
                                .zIndex(1)
                            
                            VStack(spacing: 8) {
                                Text("Get up to 5% cashback")
                                    .font(.headline)
                                
                                Text("On bill payments this month")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                    .padding(.vertical, 16)
                }
                .background(Color(.systemGroupedBackground))
                .navigationBarHidden(true)
            }
            .scaleEffect(showMenu ? 0.9 : 1)
            .offset(x: showMenu ? UIScreen.main.bounds.width * 0.6 : 0)
            .disabled(showMenu)
            
            if showMenu {
                SideMenuView(showMenu: $showMenu)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.spring(), value: showMenu)
    }
}

// MARK: - Side Menu View
struct SideMenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.opacity(0.3)
                .onTapGesture {
                    withAnimation {
                        showMenu = false
                    }
                }
            
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Relebohile Sekutlu")
                                .font(.title3.weight(.semibold))
                            Text("Premium Member")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 48)
                    
                    Divider()
                }
                .padding(.horizontal, 24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(menuItems) { item in
                            Button(action: {}) {
                                HStack(spacing: 16) {
                                    Image(systemName: item.icon)
                                        .frame(width: 24)
                                    Text(item.title)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 24)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 16)
                }
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 16) {
                        Image(systemName: "power")
                            .frame(width: 24)
                        Text("Logout")
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal, 16)
                    .foregroundColor(.red)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.7)
            .frame(maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea()
    }
    
    let menuItems = [
        MenuItem(title: "Accounts", icon: "creditcard.fill"),
        MenuItem(title: "Transactions", icon: "list.bullet.rectangle.fill"),
        MenuItem(title: "Savings Goals", icon: "flag.fill"),
        MenuItem(title: "Investments", icon: "chart.line.uptrend.xyaxis"),
        MenuItem(title: "Cards", icon: "creditcard.fill"),
        MenuItem(title: "Settings", icon: "gearshape.fill"),
        MenuItem(title: "Help & Support", icon: "questionmark.circle.fill")
    ]
}

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

// MARK: - Quick Action Button
struct QuickActionButton: View {
    let action: QuickAction
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: action.icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(action.color)
                    .clipShape(Circle())
                
                Text(action.label)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .frame(width: 80)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct QuickAction: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
    let color: Color
}

// MARK: - Transaction Row
struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: transaction.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(transaction.type.color)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.contact)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(transaction.date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(String(format: "LSL %.2f", transaction.amount))
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(transaction.type.color)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let contact: String
    let amount: Double
    let type: TransactionType
    let date: String
    let icon: String
}

enum TransactionType {
    case sent, received, paid
    
    var color: Color {
        switch self {
        case .sent: return .red
        case .received: return .green
        case .paid: return .orange
        }
    }
}

// MARK: - Bills View

// MARK: - Models

enum BillerLogoType {
    case systemName
    case assetName
}

struct Biller: Identifiable {
    let id = UUID()
    let name: String
    let logo: String
    let logoType: BillerLogoType
    let color: Color
}

struct BillerCategory: Identifiable {
    let id = UUID()
    let name: String
    let billers: [Biller]
}

// MARK: - Main View

struct BillsView: View {
    @State private var searchText = ""
    
    let recentBillers: [Biller] = [
        Biller(name: "DSTV", logo: "tv.fill", logoType: .systemName, color: .purple),
        Biller(name: "WASCO", logo: "drop.fill", logoType: .systemName, color: .blue),
        Biller(name: "Electricity", logo: "bolt.fill", logoType: .systemName, color: .yellow),
        Biller(name: "Vodacom", logo: "phone.fill", logoType: .systemName, color: .red)
    ]
    
    let billCategories: [BillerCategory] = [
        BillerCategory(name: "Airtime & Data", billers: [
            Biller(name: "Vodacome", logo: "vodacom", logoType: .assetName, color: .red),
            Biller(name: "Econet", logo: "econet", logoType: .assetName, color: .green),
            // Biller(name: "M-Pesa", logo: "mpesa", logoType: .assetName, color: .orange)
        ]),
        BillerCategory(name: "PaySims & Wallet Transfer", billers: [
            // Biller(name: "VCL:", logo: "phone.fill", logoType: .systemName, color: .red),
            Biller(name: "Eco-Cash", logo: "ecocash", logoType: .assetName, color: .green),
            Biller(name: "M-Pesa", logo: "mpesa", logoType: .assetName, color: .orange)
        ]),
        BillerCategory(name: "Other Wallet Transfer", billers: [
            // Biller(name: "VCL:", logo: "phone.fill", logoType: .systemName, color: .red),
            Biller(name: "PayLesotho", logo: "paylesotho", logoType: .assetName, color: .green),
            Biller(name: "Khetsi", logo: "ecocash", logoType: .assetName, color: .green),
            Biller(name: "My Wallet", logo: "mywallet", logoType: .assetName, color: .green),
            Biller(name: "Cpay", logo: "cpay", logoType: .assetName, color: .orange)
        ]),
        BillerCategory(name: "Utilities", billers: [
            Biller(name: "WASCO", logo: "drop.fill", logoType: .systemName, color: .blue),
            Biller(name: "LEC", logo: "bolt.fill", logoType: .systemName, color: .yellow),
            Biller(name: "Internet", logo: "wifi", logoType: .systemName, color: .indigo)
        ]),
        BillerCategory(name: "Subscriptions", billers: [
            Biller(name: "DStv", logo: "tv.fill", logoType: .systemName, color: .purple),
            Biller(name: "Netflix", logo: "play.tv", logoType: .systemName, color: .red),
            Biller(name: "Spotify", logo: "music.note", logoType: .systemName, color: .green)
        ])
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bills & Payments")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Get up to LSL50 cashback this month!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                    
                    // Search
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search billers...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // Recent Billers
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Payments")
                            .font(.headline)
                            .padding(.horizontal, 24)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recentBillers) { biller in
                                    RecentBillerCard(biller: biller)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    // Categories
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(billCategories) { category in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(category.name)
                                    .font(.headline)
                                    .padding(.horizontal, 24)
                                
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 12) {
                                    ForEach(category.billers) { biller in
                                        BillerButton(biller: biller)
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Biller Components

struct RecentBillerCard: View {
    let biller: Biller
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
            
                if biller.logoType == .systemName {
                    Image(systemName: biller.logo)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 48, height: 48)
                        .background(biller.color)
                        .clipShape(Circle())
                } else {
                    Image(biller.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .background(biller.color)
                        .clipShape(Circle())
                }
                
                Text(biller.name)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(width: 80)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct BillerButton: View {
    let biller: Biller
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
//                Text("test location")
                if biller.logoType == .systemName {
                    Image(systemName: biller.logo)
                        .font(.title2)
                        .foregroundColor(biller.color)
                        .frame(width: 40, height: 40)
                        .background(biller.color.opacity(0.15))
                        .clipShape(Circle())
                } else {
                    Image(biller.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(4)
                        .background(biller.color.opacity(0.15))
                        .clipShape(Circle())
                }
                
//                Text(biller.name)
                Text(biller.name)
                    .font(.system(size: 8))
                    .fontWeight(.semibold)

                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(13)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Button style for scaling

//struct ScaleButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.95 : 1)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
//    }
//}

// MARK: - Preview

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}


// MARK: - Transfers View
struct TransfersView: View {
    @State private var amount = ""
    @State private var selectedAccount = 0
    @State private var showConfirmation = false
    
    let accounts = [
        Account(name: "Main Account", number: "•••• 7890", balance: 12450.75),
        Account(name: "Savings", number: "•••• 4567", balance: 5600.00)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Transfer Money")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Send money to accounts or other banks")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    
                    // Transfer Form
                    VStack(spacing: 16) {
                        // Amount
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Amount")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Text("LSL")
                                    .foregroundColor(.secondary)
                                TextField("0.00", text: $amount)
                                    .font(.title2.monospacedDigit())
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                        }
                        
                        // From Account
                        VStack(alignment: .leading, spacing: 8) {
                            Text("From Account")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Picker("Account", selection: $selectedAccount) {
                                ForEach(0..<accounts.count, id: \.self) { index in
                                    Text(accounts[index].name)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(accounts[selectedAccount].name)
                                        .font(.subheadline)
                                    Text(accounts[selectedAccount].number)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(String(format: "LSL %.2f", accounts[selectedAccount].balance))
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                        }
                        
                        // To Account
                        VStack(alignment: .leading, spacing: 8) {
                            Text("To Account")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            NavigationLink(destination: RecipientSelectionView()) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                    Text("Select Recipient")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Note
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Note (Optional)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            TextField("e.g. Rent payment", text: .constant(""))
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Transfer Button
                    Button(action: { showConfirmation = true }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 0, y: 4)
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .sheet(isPresented: $showConfirmation) {
                TransferConfirmationView()
            }
        }
    }
}

struct Account {
    let name: String
    let number: String
    let balance: Double
}

// MARK: - Profile View
struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 72))
                            .foregroundColor(.blue)
                        
                        VStack(spacing: 4) {
                            Text("Relebohile Sekutlu")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Premium Member")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 24)
                    
                    // Account Info
                    VStack(spacing: 0) {
                        ProfileInfoRow(icon: "person.fill", title: "Name", value: "Relebohile Sekutlu")
                        Divider()
                        ProfileInfoRow(icon: "envelope.fill", title: "Email", value: "relebohile@gmail.com")
                        Divider()
                        ProfileInfoRow(icon: "number.circle.fill", title: "Account Number", value: "1234 5678 9012")
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // Settings
                    VStack(spacing: 0) {
                        NavigationLink(destination: SettingsView()) {
                            ProfileActionRow(icon: "gearshape.fill", title: "Settings")
                        }
                        Divider()
                        ProfileActionRow(icon: "lock.shield.fill", title: "Security")
                        Divider()
                        ProfileActionRow(icon: "questionmark.circle.fill", title: "Help & Support")
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // Logout
                    Button(action: {}) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ProfileActionRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .contentShape(Rectangle())
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var biometricsEnabled = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Preferences
                    VStack(spacing: 0) {
                        Toggle(isOn: $notificationsEnabled) {
                            ProfileActionRow(icon: "bell.fill", title: "Notifications")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        
                        Divider()
                        
                        Toggle(isOn: $biometricsEnabled) {
                            ProfileActionRow(icon: "faceid", title: "Biometric Login")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // Legal
                    VStack(spacing: 0) {
                        NavigationLink(destination: Text("Privacy Policy")) {
                            ProfileActionRow(icon: "hand.raised.fill", title: "Privacy Policy")
                        }
                        Divider()
                        NavigationLink(destination: Text("Terms of Service")) {
                            ProfileActionRow(icon: "doc.text.fill", title: "Terms of Service")
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // App Info
                    VStack(spacing: 8) {
                        Text("Zento FinApp")
                            .font(.subheadline)
                        Text("Version 1.0.0")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 8)
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Helper Views
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Preview Provider
struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .preferredColorScheme(.light)
        AppTabView()
            .preferredColorScheme(.dark)
    }
}
