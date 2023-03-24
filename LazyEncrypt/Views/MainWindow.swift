import SwiftUI

struct MainWindow: View {
    @StateObject var viewModel: MainWindowVM = MainWindowVM()
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(viewModel.list, selection: $viewModel.sidebarSelectedItem) { item in
                if (item.name == "") {
                    ForEach(item.items, id: \.self) { item in
                        HStack{
                            item.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16,height: 14)
                                .foregroundColor(.blue)
                            Spacer().frame(width: 12)
                            Text(item.name)
                        }
                    }
                }
                else {
                    Section(item.name) {
                        ForEach(item.items, id: \.self) { item in
                            HStack{
                                item.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16,height: 14)
                                    .foregroundColor(.blue)
                                Spacer().frame(width: 12)
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
            viewModel.sidebarSelectedItem.view
                .navigationTitle(viewModel.sidebarSelectedItem.name)
        }
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}


