import AVFoundation
///we basically have to import three sounds responsible for carrying most of the operations in the application
/// It'll result in trimodal sound design:  Three design principles must be followed being robustness , simplicity and soothness{might sound weird but its important in these niche ui cases}
class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    /// Play a bundled sound file (e.g., "cycle.wav")
    func play(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            print("⚠️ Missing sound:", name)
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 0.5
            player?.play()
        } catch {
            print("⚠️ Sound error:", error)
        }
    }
}
