import SwiftUI

struct MainWindow: View {
    @ObservedObject var viewModel: MainWindowVM = MainWindowVM()
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(viewModel.list, selection: $viewModel.sidebarSelectedItem) { item in
                if (item.name == "") {
                    ForEach(item.items, id: \.self) { item in
                        HStack{
                            item.image.foregroundColor(.blue)
                            Text(item.name)
                        }
                    }
                }
                else {
                    Section(item.name) {
                        ForEach(item.items, id: \.self) { item in
                            HStack{
                                item.image.foregroundColor(.blue)
                                Text(item.name)
                            }
                        }
                    }.collapsible(false)
                }
            }.listStyle(.sidebar)
                .navigationSplitViewColumnWidth(256)
            Spacer()
            Text("Roman Zheglov, 2023").foregroundColor(.gray)
                .padding(16)
        }) {
            switch(viewModel.sidebarSelectedItem?.name) {
            case String(localized: "The Atbash Cipher"):
                AtbashCipherView()
                    .navigationTitle(viewModel.windowTitle)
            case String(localized: "The Caesar's Cipher"):
                CesarsCipherView()
                    .navigationTitle(viewModel.windowTitle)
            default:
                Text("No Editor")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .frame(minWidth: 512)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}


