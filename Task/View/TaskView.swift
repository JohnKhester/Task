//
//  TaskView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//


import SwiftUI
import CoreData


struct TaskView: View {
    @EnvironmentObject var taskModel: TaskManagerModel
    
    // MARK: All Environment Values in one Variable
    @Environment(\.self) var env
    
    // MARK: Fetching Task
    @FetchRequest(entity: TaskData.entity(), sortDescriptors: [], predicate: nil, animation: .easeInOut) var tasksItems: FetchedResults<TaskData>

    @State private var isEditing = false
    @State private var isPressed = false
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 6) {
                    VStack {
                        Text("\(taskModel.countCompletedTasks())")
                        ZStack(alignment: .leading) {
                            HStack {
                          if taskModel.taskTitle.isEmpty && !isPressed {
                                    Text("New Task")
                                    .whiteForegroundWithOpacity()
                                        .padding(.horizontal)
                                }
                            }
                            TextField("", text: $taskModel.taskTitle)
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
                            if taskModel.addTask(context: env.managedObjectContext) {
                                print("Задача успешно создана")
                            }
                        }) {
                            Text("Done")
                                .foregroundColor(taskModel.taskTitle.isEmpty ? .gray : .black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(taskModel.taskTitle.isEmpty ? Color.gray.opacity(0.2) : Color.greenColor)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .disabled(taskModel.taskTitle.isEmpty)
                    }
                    HStack {
                        Text("My Tasks")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    if tasksItems.isEmpty {
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
                        ForEach(tasksItems) { taskItem in
                            VStack {
                                HStack {
                                    Text(taskItem.titleTask ?? "")
                                        .strikethrough(taskItem.isDone, color: .greenColor)
                                        .foregroundColor(.white)

                                    Spacer()
                                    if isEditing {
                                        Button(action: {
                                             taskModel.deleteTask(task: taskItem, context: env.managedObjectContext)
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                    Button(action: {
                                        taskModel.toggleTaskDone(task: taskItem, context: env.managedObjectContext)
                                    }) {
                                        Image(systemName: taskItem.isDone ? "checkmark.circle.fill" : "circle")
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

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskManagerModel())
    }
}
