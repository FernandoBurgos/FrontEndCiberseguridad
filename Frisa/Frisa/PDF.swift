//
//  PDF.swift
//  Frisa
//
//  Created by Fernando Martínez on 10/10/23.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    var fileName: String
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "pdf"),
           let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
            pdfView.document = pdfDocument
        }
    }
}
