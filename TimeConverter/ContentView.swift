//
//  ContentView.swift
//  TimeConverter
//
//  Created by Tomek on 17/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTime: Double = 0
    @State private var inputUnit: TimeInterval = .seconds
    @State private var outputUnit: TimeInterval = .seconds
    
    private var outputTime: Double {
        let inputInSeconds = getSeconds(time: inputTime, unit: inputUnit)
        return secondsToUnit(time: inputInSeconds, unit: outputUnit)
    }
    
    enum TimeInterval: String, CaseIterable {
        case seconds = "seconds",
             minutes = "minutes",
             hours   = "hours",
             days    = "days"
    }
    
    func getSeconds(time: Double, unit: TimeInterval) -> Double {
        var result = 0.0
        switch unit {
        case .seconds:
            result = time
        case .minutes:
            result = time * 60
        case .hours:
            result = time * 60 * 60
        case .days:
            result = time * 60 * 60 * 24
        }
        return result
    }
    
    func secondsToUnit(time: Double, unit: TimeInterval) -> Double {
        var result = 0.0
        switch unit {
        case .seconds:
            result = Double(time)
        case .minutes:
            result = Double(time) / 60
        case .hours:
            result = Double(time) / (60 * 60)
        case .days:
            result = Double(time) / (60 * 60 * 24)
        }
        return result
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("", selection: $inputUnit) {
                        ForEach(TimeInterval.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("", value: $inputTime, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Input time")
                }
                
                Section {
                    Picker("", selection: $outputUnit) {
                        ForEach(TimeInterval.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(outputTime.formatted())")
                } header: {
                    Text("Output time")
                }
            }
            .navigationTitle("Time converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
