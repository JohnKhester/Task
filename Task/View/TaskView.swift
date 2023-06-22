//
//  TaskView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//


import SwiftUI

struct TaskView: View {
    @State private var newTaskTitle = ""
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                HStack {
                    TextField("Название", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        taskManager.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Text("Добавить")
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
                .padding()
                
                Text("Все: \(taskManager.totalTasksCount)")
                Text("Завершено: \(taskManager.completedTasksCount)")
                
                ForEach(taskManager.tasks) { task in
                    VStack {
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isDone)
                            
                            Spacer()
                            if isEditing {
                                Button(action: {
                                    taskManager.deleteTask(task)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            
                            Button(action: {
                                taskManager.toggleTaskDone(task)
                            }) {
                                Image(systemName: task.isDone ? "circle" : "circle.fill")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                }
            }
        }
    }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskManagerModel())
    }
}
