import SwiftUI
import SwiftData

@main
struct MyGuitarsApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var modelContext: ModelContext?

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .onAppear {
                        if let container = try? ModelContainer(for: Instruments.self, Photos.self, Repairs.self, Strings.self) {
                            modelContext = container.mainContext
                        }
                    }
            }
            .modelContainer(for: [Instruments.self, Photos.self, Repairs.self, Strings.self])
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                saveModelContext()
            }
        }
    }

    private func saveModelContext() {
        guard let modelContext else { return }
        do {
            try modelContext.save()
            print("✅ SwiftData saved successfully when app went to background.")
        } catch {
            print("❌ Failed to save SwiftData: \(error.localizedDescription)")
        }
    }
}
