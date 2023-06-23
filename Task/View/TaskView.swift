//
//  TaskView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//


import SwiftUI

struct TaskView: View {
    
    let gradientColors = [
        Color(red: 0, green: 0, blue: 0.4),
        Color(red: 0, green: 0, blue: 0.5),
        Color(red: 0, green: 0, blue: 0.6),
        Color(red: 0, green: 0, blue: 0.7),
        Color(red: 0, green: 0, blue: 0.8),
        Color(red: 0, green: 0, blue: 0.9),
        Color(red: 0, green: 0, blue: 1.0),
        Color(red: 0, green: 0, blue: 1.1),
    ]

    
    @State private var newTaskTitle = ""
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
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
                    
                    ForEach(taskManager.tasks.indices, id: \.self) { index in
                        let color = gradientColors[index % gradientColors.count]
                        VStack {
                            HStack {
                                Text(taskManager.tasks[index].title)
                                    .strikethrough(taskManager.tasks[index].isDone)
                                    .foregroundColor(Color.white)
                                Spacer()
                                if isEditing {
                                    Button(action: {
                                        taskManager.deleteTask(taskManager.tasks[index])
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                
                                Button(action: {
                                    taskManager.toggleTaskDone(taskManager.tasks[index])
                                }) {
                                    Image(systemName: taskManager.tasks[index].isDone ? "circle" : "circle.fill")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .padding()
                        .background(color)
                        .cornerRadius(10)
                    }
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
