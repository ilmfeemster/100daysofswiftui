//
//  ContentView.swift
//  iExpense
//
//  Created by Immanuel Matthews-Feemster on 4/7/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    private let expenseTypes = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenseTypes, id: \.self) {type in
                    Section(header: Text(type)) {
                        ForEach(expenses.items.filter{$0.type == type}) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(expenseStyling(amount: item.amount))
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func expenseStyling(amount: Double) -> any ShapeStyle{
        if amount < 10 {
            return .blue
        } else if amount < 100 {
            return .green
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
}
