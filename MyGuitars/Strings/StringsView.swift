import SwiftUI

struct StringsView: View {
    
    static let tag: String? = "Strings"
    
    @StateObject var viewModel: ViewModel
    @State private var showEditingScreen = false

    init(dataController: DataController) {

        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)

    }

    var body: some View {

        NavigationView {

            List {

                ForEach(viewModel.instruments) { instrument in

                    HStack {

                        Text("\(instrument.instModel)")
                            .font(.headline)

                        Spacer()

                        Button(action: {
                            self.viewModel.addString(for: instrument)
                        }, label: {
                            Label(
                                title: { Text("") },
                                icon: { Image(systemName: "plus.square")
                                    .foregroundColor(.blue)
                                }
                            )

                        })

                    }

                    ForEach(instrument.allStrings) { stringInfo in

                        HStack {

                            VStack(alignment: .leading) {

                                Text(stringInfo.brand ?? "")
                                    .font(.headline)
                                    .foregroundColor(.blue)

                                Text(stringInfo.gauge ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.blue)

                                Text(stringInfo.date?.toString() ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.blue)

                            }

                            Spacer()

                            Button(action: {
                                self.showEditingScreen.toggle()
                            }, label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            })

                        }
                        .padding()
                        .sheet(isPresented: $showEditingScreen) {
                            StringsEditView(stringSet: stringInfo, instrument: instrument)
                        }

                    }

                }

            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Strings")

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }


}

struct StringsView_Previews: PreviewProvider {

    static var previews: some View {
        StringsView(dataController: DataController.preview)
    }

}
