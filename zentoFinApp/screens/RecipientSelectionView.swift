//
//  RecipientSelectionView.swift
//  zentoFinApp
//
//  Created by Relebohile Sekutlu on 2025/08/09.
//

import SwiftUI

struct RecipientSelectionView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    // Sample data for recent contacts
    let recentContacts: [Contact] = [
        Contact(name: "Nomsa Motloung", phoneNumber: "+266 5812 3456", avatarName: "person.circle.fill"),
        Contact(name: "Thuso Mthembu", phoneNumber: "+266 5987 6543", avatarName: "person.circle.fill"),
        Contact(name: "Mosa Nkoto", phoneNumber: "+266 5734 5678", avatarName: "person.circle.fill"),
        Contact(name: "Lira Makara", phoneNumber: "+266 5678 9012", avatarName: "person.circle.fill")
    ]
    
    let deepTeal = Color(red: 15/255, green: 118/255, blue: 110/255)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with custom back button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(deepTeal)
                    }
                    Spacer()
                    Text("Select Recipient")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search by name or number", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(12)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Recent contacts section
                if !recentContacts.isEmpty {
                    Text("Recent Contacts")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 1) {
                            ForEach(recentContacts) { contact in
                                ContactRow(contact: contact)
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

// Helper struct for a contact row
struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: contact.avatarName)
                .font(.system(size: 30))
                .foregroundColor(.secondary)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray4))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(contact.name)
                    .font(.headline)
                Text(contact.phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(10)
        .background(Color(.systemBackground))
    }
}

// Helper struct for contact data
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    let avatarName: String
}
