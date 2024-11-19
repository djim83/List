//
//  TareasViewModel.swift
//  List
//
//  Created by David Jiménez on 19/11/24.
//

import SwiftUI

class TareasViewModel: ObservableObject {
    // Propiedad para almacenar las tareas de manera persistente
    @AppStorage("tareas") private var tareasData: Data = Data()

    // Lista de tareas observada por la vista
    @Published var tareas: [Tarea] = [] {
        didSet {
            guardarTareas()
        }
    }

    // Inicializador para cargar las tareas guardadas
    init() {
        cargarTareas()
    }

    // Función para guardar las tareas en persistencia
    private func guardarTareas() {
        if let data = try? JSONEncoder().encode(tareas) {
            tareasData = data
        }
    }

    // Función para cargar las tareas desde persistencia
    private func cargarTareas() {
        if let tareasGuardadas = try? JSONDecoder().decode([Tarea].self, from: tareasData) {
            tareas = tareasGuardadas
        }
    }

    // Función para agregar una nueva tarea
    func agregarTarea(titulo: String) {
        let nuevaTarea = Tarea(titulo: titulo)
        tareas.append(nuevaTarea)
    }

    // Función para eliminar tareas por índice
    func eliminarTarea(at offsets: IndexSet) {
        tareas.remove(atOffsets: offsets)
    }
}
