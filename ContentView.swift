import SwiftUI

struct ContentView: View {
    //行列Aの変数
    @State private var rowsA: Int = 0
    @State private var colsA: Int = 0
    @State private var tmp_rowsA: Int = 0
    @State private var tmp_colsA: Int = 0
    @State private var matrixA: [[Double]] = []
    //行列Bの変数
    @State private var rowsB: Int = 0
    @State private var colsB: Int = 0
    @State private var tmp_rowsB: Int = 0
    @State private var tmp_colsB: Int = 0
    @State private var matrixB: [[Double]] = []
    //結果行列
    @State private var createSucceeded: Bool = true
    @State private var resultMatrix: [[Double]] = []
    
    var body: some View {
        VStack{
            //行列Aの入力・作成
            Text("行列Aのサイズを入力してください")

            HStack {
                TextField("行数", text: Binding<String>(
                    get: { String(self.tmp_rowsA) },
                    set: {
                        if let newValue = Int($0) {
                            self.tmp_rowsA = newValue
                        }
                    }
                ))
                .keyboardType(.numberPad)
                
                TextField("列数", text: Binding<String>(
                    get: { String(self.tmp_colsA) },
                    set: {
                        if let newValue = Int($0) {
                            self.tmp_colsA = newValue
                        }
                    }
                ))
                .keyboardType(.numberPad)
                
                Button("作成", action: {
                    //行数、列数を更新してmatrixAを初期化してから作成
                    self.rowsA = self.tmp_rowsA
                    self.colsA = self.tmp_colsA
                    matrixA = [[Double]]()
                    create_MatrixA()
                }
                )
            }
            .border(Color.blue, width: 0.5)

            if !matrixA.isEmpty {
                Text("行列Aの要素")
                ForEach(0..<rowsA, id: \.self) { row in
                    HStack {
                        ForEach(0..<colsA, id: \.self) { col in
                            TextField("A\(row+1)\(col+1)", value: $matrixA[row][col], formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                }
            }

            Text("行列Bのサイズを入力してください:")
            
            HStack {
                TextField("行数", text: Binding<String>(
                    get: { String(self.tmp_rowsB) },
                    set: {
                        if let newValue = Int($0) {
                            self.tmp_rowsB = newValue
                        }
                    }
                ))
                .keyboardType(.numberPad)
                
                TextField("列数", text: Binding<String>(
                    get: { String(self.tmp_colsB) },
                    set: {
                        if let newValue = Int($0) {
                            self.tmp_colsB = newValue
                        }
                    }
                ))
                .keyboardType(.numberPad)
                
                Button("作成", action: {
                    //行数、列数を更新してmatrixBを初期化してから作成
                    self.rowsB = self.tmp_rowsB
                    self.colsB = self.tmp_colsB
                    matrixB = [[Double]]()
                    create_MatrixB()
                })
            }
            .border(Color.blue, width: 0.5)

            
            if !matrixB.isEmpty {
                Text("行列Bの要素")
                ForEach(0..<rowsB, id: \.self) { row in
                    HStack {
                        ForEach(0..<colsB, id: \.self) { col in
                            TextField("B\(row+1)\(col+1)", value: $matrixB[row][col], formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                }
            }
            
            Button(action: {
                resultMatrix = [[Double]]()
                createSucceeded = calculate_Matrix_Product()
                
            },label: {
                Text("計算する")
                    .bold()
                    .padding()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Circle())
            })
            
            
            if !resultMatrix.isEmpty {
                Text("行列A × 行列B の結果")
                if(createSucceeded){
                    ForEach(0..<resultMatrix.count, id: \.self) { row in
                        HStack {
                            ForEach(0..<resultMatrix[row].count, id: \.self) { col in
                                Text(String(format: "%.2f", resultMatrix[row][col]))
                            }
                        }
                    }
                }
                else{
                    Text("Aの列数とBの行数が違うので計算できません")
                }
            }
        }
    }
    func create_MatrixA() {
        matrixA = [[Double]](repeating: [Double](repeating: 0.0, count: colsA), count: rowsA)
    }
    
    func create_MatrixB() {
        matrixB = [[Double]](repeating: [Double](repeating: 0.0, count: colsB), count: rowsB)
    }
    
    func calculate_Matrix_Product() -> Bool {
        resultMatrix = [[Double]](repeating: [Double](repeating: 0.0, count: colsB), count: rowsA)
        if(colsA != rowsB){
            return false
        }
        for i in 0..<rowsA{
            for j in 0..<colsB{
                for k in 0..<colsA{
                    resultMatrix[i][j] += matrixA[i][k] * matrixB[k][j]
                }
            }
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
