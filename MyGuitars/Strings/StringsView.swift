import SwiftUI

struct StringsView: View {
    
    static let tag: String? = "Strings"
    
    @Environment(\.colorScheme) var colorScheme
//    @StateObject var viewModel: ViewModel
    @State private var showEditingScreen = false

//    init(dataController: DataController) {
//        let viewModel = ViewModel(dataController: dataController)
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }

    var body: some View {

        Text("Strigns View Soon")

//        NavigationView {
//
//            List {
//
//                ForEach(viewModel.instruments) { instrument in
//
//                    HStack {
//
//                        Text("\(instrument.instModel)")
//                            .font(.headline)
//
//                        Spacer()
//
//                        Button(action: {
//                            withAnimation {
//                                self.viewModel.addString(for: instrument)
//                            }
//                        }, label: {
//                            Label(
//                                title: { Text("") },
//                                icon: { Image(systemName: "plus.square")
//                                    .foregroundColor(.blue)
//                                }
//                            )
//
//                        })
//
//                    }
//
//                    ForEach(instrument.allStrings) { stringInfo in
//
//                        HStack {
//
//                            VStack(alignment: .leading) {
//                                Image("guitar-strings")
//                                    .resizable()
//                                    .renderingMode(colorScheme == .dark ? .template : .original)
//                                    .colorMultiply(.white)
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 35, height: 35, alignment: .leading)
//                                    
//                            }
//                            
//                            VStack(alignment: .leading) {
//
//                                Text(stringInfo.brand ?? "")
//                                    .font(.headline)
//                                    .foregroundColor(.blue)
//
//                                Text(stringInfo.gauge ?? "")
//                                    .font(.footnote)
//                                    .foregroundColor(.blue)
//
//                                Text(stringInfo.date?.toString() ?? "")
//                                    .font(.footnote)
//                                    .foregroundColor(.blue)
//
//                            }
//
//                            Spacer()
//
//                            Button(action: {
//                                self.showEditingScreen.toggle()
//                            }, label: {
//                                Image(systemName: "pencil")
//                                    .foregroundColor(.blue)
//                            })
//
//                        }
//                        .padding(.top)
//                        .padding(.bottom)
//                        .sheet(isPresented: $showEditingScreen) {
//                            StringsEditView(stringSet: stringInfo, instrument: instrument)
//                        }
//
//                    }
//
//                }
//
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationBarTitle("Strings")
//
//        }
//        .navigationViewStyle(StackNavigationViewStyle())

    }


}

struct StringsView_Previews: PreviewProvider {

    static var previews: some View {
        StringsView()
//        StringsView(dataController: DataController.preview)
    }

}
