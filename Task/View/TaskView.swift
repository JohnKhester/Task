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
    @State private var isPressed = false
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 6) {
                    VStack {
                        ZStack(alignment: .leading) {
                            HStack {
                          if newTaskTitle.isEmpty && !isPressed {
                                    Text("New Task")
                                    .whiteForegroundWithOpacity()
                                        .padding(.horizontal)
                                }
                            }
                            TextField("", text: $newTaskTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.07))
                                .cornerRadius(12)
                                .textFieldStyle(.plain)
                                .accentColor(.white)
                                .onTapGesture {
                                    isPressed = true
                                }
                                
                        }                        
                        Button(action: {
                            taskManager.addTask(title: newTaskTitle)
                            newTaskTitle = ""
                            isEditing = false
                        }) {
                            Text("Done")
                                .foregroundColor(newTaskTitle.isEmpty ? .gray : .black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(newTaskTitle.isEmpty ? Color.gray.opacity(0.2) : Color.greenColor)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .disabled(newTaskTitle.isEmpty)
                    }
                    HStack {
                        Text("My Tasks")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    if taskManager.tasks.isEmpty {
                        VStack {
                            Text("No Tasks for Today")
                                .mediumFont_13()
                                .whiteForegroundWithOpacity()
                                .padding(.vertical, 12)
                            Image("EmptyTask")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 93)
                        }.padding(.top, 80)
                    } else {
                        ForEach(taskManager.tasks.indices, id: \.self) { index in
                                VStack {
                                    HStack {
                                        Text(taskManager.tasks[index].title)
                                            .strikethrough(taskManager.tasks[index].isDone, color: .greenColor)
                                            .foregroundColor(.white)

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
                                            Image(systemName: taskManager.tasks[index].isDone ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(Color.greenColor)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                                .padding(16)                                
                                .background(Color.white.opacity(0.07))
                                .cornerRadius(12)
                            }
                    }
                  
                }
            }.padding([.leading, .trailing], 16)
        }
        .animation(.easeInOut, value: UUID())
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

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            )
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .disabled(configuration.isPressed)
    }
}

 
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskManagerModel())
    }
}
