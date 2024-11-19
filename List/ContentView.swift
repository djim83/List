//
//  ContentView.swift
//  List
//
//  Created by David Jiménez on 19/11/24.
//

import Foundation
import SwiftUI

struct Tarea: Identifiable, Codable {
    let id: UUID
    var titulo: String
    var completada: Bool
    
    init(titulo: String, completada: Bool = false) {
        self.id = UUID() // Genera un identificador único.
        self.titulo = titulo // Establece el título de la tarea.
        self.completada = completada // El estado inicial es "no completada".
    }
}


struct ContentView: View {
    @StateObject private var viewModel = TareasViewModel() // Instancia de la vista modelo
    @State private var nuevaTarea: String = "" // Texto para el input de nueva tarea

    var body: some View {
        NavigationView {
            VStack {
                // Campo de texto y botón para agregar nuevas tareas
                HStack {
                    TextField("Nueva tarea", text: $nuevaTarea)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: agregarTarea) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }

                // Lista de tareas
                List {
                    ForEach(viewModel.tareas) { tarea in
                        HStack {
                            Text(tarea.titulo)
                            Spacer()
                            if tarea.completada {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .onTapGesture {
                            marcarTarea(tarea)
                        }
                    }
                    .onDelete(perform: viewModel.eliminarTarea)
                }
            }
            .navigationTitle("Lista de Tareas")
        }
    }

    // Agregar una nueva tarea
    private func agregarTarea() {
        guard !nuevaTarea.isEmpty else { return }
        viewModel.agregarTarea(titulo: nuevaTarea)
        nuevaTarea = "" // Limpiar el campo de texto
    }

    // Marcar o desmarcar una tarea como completada
    private func marcarTarea(_ tarea: Tarea) {
        if let index = viewModel.tareas.firstIndex(where: { $0.id == tarea.id }) {
            viewModel.tareas[index].completada.toggle()
        }
    }
}
