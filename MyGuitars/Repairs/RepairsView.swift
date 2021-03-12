import SwiftUI

struct RepairsView: View {
    
    @StateObject var viewModel: ViewModel
    @State private var showEditingScreen = false
    
    static let tag: String? = "Repairs"
    
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
                            withAnimation {
                                viewModel.addNewRepair(for: instrument)
                            }
                        }, label: {
                            Label(
                                title: { Text("") },
                                icon: { Image(systemName: "plus.square")
                                    .foregroundColor(.blue)
                                }
                            )

                        })

                    }

                    ForEach(instrument.allRepairs) { repairs in

                        HStack {

                            VStack(alignment: .leading) {
                                Image("guitar-repairs")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                    
                            }
                            
                            VStack(alignment: .leading) {

                                Text(repairs.repairtype ?? "")
                                    .font(.headline)
                                    .foregroundColor(.blue)

                                Text(repairs.repairedby ?? "")
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
                        .padding(.top)
                        .padding(.bottom)
                        .sheet(isPresented: $showEditingScreen) {
                            RepairsEditView(repairs: repairs, instrument: instrument)
                        }

                    }

                }

            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Repairs")

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct WorkPerformedView_Previews: PreviewProvider {

    static var previews: some View {
        RepairsView(dataController: DataController.preview)
    }

}
