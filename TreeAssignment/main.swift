//
//  main.swift
//  TreeAssignment
//
//  Created by Ts SaM on 2/8/2023.
//

import Foundation
// -------------------------------------------------------
// ------------------- Who’s my parent? ------------------
// -------------------------------------------------------
//func dfs(_ node: Int, _ graph: [[Int]], _ parent: inout [Int]) {
//    for neighbor in graph[node] {
//        if parent[neighbor] == 0 {
//            parent[neighbor] = node
//            dfs(neighbor, graph, &parent)
//        }
//    }
//}
//
//let n = Int(readLine()!)!
//var graph: [[Int]] = Array(repeating: [], count: n + 1)
//var parent: [Int] = Array(repeating: 0, count: n + 1)
//
//for _ in 1..<n {
//    let edge = readLine()!.split(separator: " ").map{ Int($0)! }
//    let a = edge[0]
//    let b = edge[1]
//    graph[a].append(b)
//    graph[b].append(a)
//}
//
//dfs(1, graph, &parent)
//
//print("Output : ")
//for node in 2...n {
//    print(parent[node])
//}
// ------------------------- END -------------------------



// -------------------------------------------------------
// --------------------- Diameter ------------------------
// -------------------------------------------------------
func dfs(_ graph: [[(vertex: Int, distance: Int)]], _ start: Int, _ visited: inout [Bool], _ distance: inout [Int]) {
    visited[start] = true
    for edge in graph[start] {
        let neighbor = edge.vertex
        let edgeDistance = edge.distance
        if !visited[neighbor] {
//            print("edgeDistance : \(edgeDistance)")
            distance[neighbor] = distance[start] + edgeDistance
            dfs(graph, neighbor, &visited, &distance)
        }
    }
}

func findDiameter(_ graph: [[(vertex: Int, distance: Int)]]) -> Int {
    var distance = Array(repeating: 0, count: graph.count)
    var visited = Array(repeating: false, count: graph.count)
    dfs(graph, 1, &visited, &distance)
    
    var farthestNode = 1
    for i in 2..<graph.count {
        if distance[i] > distance[farthestNode] {
//            print("farthestNode : \(farthestNode)")
            farthestNode = i
        }
    }
    visited = Array(repeating: false, count: graph.count)
    distance = Array(repeating: 0, count: graph.count);
    dfs(graph, farthestNode, &visited, &distance)
    
    return distance.max()!
}


let v = Int(readLine()!)!
var graph: [[(vertex: Int, distance: Int)]] = Array(repeating: [], count: v + 1)

for _ in 0..<v {
    let line = readLine()!.split(separator: " ").map{ Int($0)! }
    let vertex = line[0]
    
    var i = 1
    while line[i] != -1 {
        let connectedVertex = line[i]
        let distance = line[i + 1]
//        print("connectedVertex : \(connectedVertex)")
//        print("distance : \(distance)")
        graph[vertex].append((connectedVertex, distance))
        i += 2
    }
}

let diameter = findDiameter(graph)
print("Output : \(diameter)")
// ------------------------- END -------------------------
