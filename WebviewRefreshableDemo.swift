
import SwiftUI
import WebKit

struct WebviewRefreshableDemo: View {
    @State private var webPage: WebPage = .init()
    
    var body: some View {
        ScrollView {
            Text("WebView + Refreshable")
                .fontWeight(.bold)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
            
            WebView(webPage)
                .onAppear {
                    webPage.load(URL(string: "https://medium.com/@itsuki.enjoy"))
                }
                // to make sure webview takes the full height of the container
                .containerRelativeFrame(.vertical)

        }
        .ignoresSafeArea(.all, edges: .bottom)
        // attach refreshable directly to webview without scrollview will not have any effect.
        .refreshable {
            let result = webPage.reload()
            do {
                for try await _ in result {}
            } catch (_) {}
        }
        .background(.yellow.opacity(0.1))
    }
}
