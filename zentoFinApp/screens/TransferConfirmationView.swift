//
//  TransferConfirmationView.swift
//  zentoFinApp
//
//  Created by Relebohile Sekutlu on 2025/08/09.
//

import SwiftUI

struct TransferConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
    // Sample transfer data
    let recipientName: String = "Nomsa Motloung"
    let recipientNumber: String = "+266 5812 3456"
    let amount: Double = 500.00
    let fee: Double = 2.50
    let total: Double = 502.50
    
    let deepTeal = Color(red: 15/255, green: 118/255, blue: 110/255)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(deepTeal)
                    }
                    Spacer()
                    Text("Confirm Transfer")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Confirmation summary card
                VStack(alignment: .leading, spacing: 20) {
                    Text("Transfer Details")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 15) {
                        SummaryRow(label: "Recipient", value: recipientName)
                        SummaryRow(label: "Account Number", value: recipientNumber)
                        Divider()
                        SummaryRow(label: "Amount", value: String(format: "LSL %.2f", amount))
                        SummaryRow(label: "Transfer Fee", value: String(format: "LSL %.2f", fee))
                        Divider()
                        SummaryRow(label: "Total Amount", value: String(format: "LSL %.2f", total))
                            .font(.headline)
                            .foregroundColor(deepTeal)
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
                
                // Confirm button
                Button(action: {
                    // TODO: Implement transfer logic
                }) {
                    Text("Confirm Transfer")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(deepTeal)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding(.top)
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

// Helper struct for a summary row
struct SummaryRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}
