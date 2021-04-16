//
//  HomeViewModel.swift
//  Quiz-App
//
//  Created by Phong Le on 15/04/2021.
//

import Foundation
import FirebaseFirestore
import Firebase

final class HomeViewModel: ObservableObject {
    @Published var results: [Question] = []
    let db = Firestore.firestore()
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        self.db.collection("all_quizz")
            .addSnapshotListener { (snap, err) in
                if err != nil {
                    print(err!.localizedDescription)
                    return
                }
                
                guard let data = snap else { return }
                data.documentChanges.forEach { doc in
                    if doc.type == .added {
                        let item = try! doc.document.data(as: Question.self)!
                        DispatchQueue.main.async {
                            self.results.append(item)
                        }
                    }
                }
            }
    }

}
