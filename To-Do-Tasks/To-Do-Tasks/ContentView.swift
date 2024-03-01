//
//  ContentView.swift
//  To-Do-Tasks
//
//  Created by StudentAM on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfTasks: Int = 0
    @State private var completedTasks: Int = 0
    @State var task: String = ""
    @State var tasks: [String] = []
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // Shows user the number of tasks that is created
                Text("Number of Tasks: \(numOfTasks)")
                    .padding()
                    .position(x: 90, y: 30)
                // Shows the number of tasks that is completed
                Text("Tasks Completed: \(completedTasks)")
                    .padding()
                    .position(x: 90, y: -10)
            // Where users enter what they need to do
                TextField("Enter a new task", text: $task)
                    .position(x: 180, y: -20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Button("Add Task", action:{
                        if task.isEmpty {
                        
                        } else {
                        tasks.append(task)
                        numOfTasks += 1
                        task = ""
                        }
                    })
                        .padding()
                        .background(task.isEmpty ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    Button("Remove All Tasks", action: clearTaskList)
                        .padding()
                        .background(tasks.count == 0 ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .position(x: 180, y: -40)
            }
            .navigationTitle("To-Do List")
            // This list was created for allowing users to delete tasks. Users can also slide the task when the task is completed which deletes the task
            List {
                ForEach(tasks, id: \.self) { item in
                    Text("\(item)")
                        .swipeActions(edge: .trailing) {
                            Button {
                                if let index = tasks.firstIndex(of: item) {
                                    deleteTask(offset: IndexSet(integer: index))
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .background(Color.red)
                                    .cornerRadius(5)
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                if let index = tasks.firstIndex(of: item) {
                                    completeTask(index: index)
                                }
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .background(Color.green)
                                    .cornerRadius(5)
                            }
                            .tint(.green)
                        }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        deleteTask(offset: IndexSet(integer: index))
                    }
                })
            }
            .position(x: 180, y: 80)

            }
        .padding()
    }
    func completeTask(index: Int) {
        // Mark the task as completed
        // For example, you might update a property in your data model
        // or perform any other necessary action
        // For demonstration purposes, let's remove the task from the array
        tasks.remove(at: index)
        numOfTasks -= 1
        completedTasks += 1
    }
    
    func deleteTask(offset: IndexSet) {
        tasks.remove(atOffsets: offset)
        numOfTasks -= 1
    }
    
    func clearTaskList() {
        tasks = []
        numOfTasks = 0
    }
}

#Preview {
    ContentView()
}


// Scrap Yard

//            List {
//                ForEach(tasks.indices, id: \.self) { index in
//                    let item = tasks[index]
//                    Text(item)
//                        .foregroundColor(completedTasks > index ? .white : .primary) // Set text color based on completion
//                                    .frame(maxWidth: .infinity, alignment: .leading) // Expand text to fill the width
//                                    .padding()
//                                    .background(completedTasks > index ? Color.green : Color.clear) // Set background color based on completion
//                                    .cornerRadius(5) // Apply corner radius
//                        .swipeActions(edge: .leading) {
//                            Button {
//                                completedTasks += 1
//                            } label: {
//                                Text("Completed")
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 10)
//                                    .background(Color.green)
//                                    .cornerRadius(5)
//                            }
//                            .tint(.green)
//                        }
//                }
//                .onDelete(perform: deleteTask)
//            }
//                List{
//                    ForEach(tasks, id: \.self){ item in Text("\(item)")
//                            .swipeActions(edge: .leading) {
//                                Button {
//
//                                    completedTasks += 1
//
//                                } label: {
//                                    Text("Completed")
//                                        .background(Color.green)
//
//                                }
//                                .tint(.green)
//                            }
//                    }
//                    .onDelete(perform: deleteTask)
//                }
