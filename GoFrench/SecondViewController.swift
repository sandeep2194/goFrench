import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtWord: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtWordVerbType: UITextField!
    @IBOutlet weak var txtSearchTerm: UITextField!

    var conjugations = [ConjugationObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }

    @IBAction func btnSearchTouchUpInside(_ sender: Any) {
        guard let searchTerm = txtSearchTerm.text, !searchTerm.isEmpty else {
            print("Search term is empty")
            return
        }

        let conjugationService = ConjugationService()
        conjugationService.fetchConjugationData { [weak self] conjugationData in
            DispatchQueue.main.async {
                guard let data = conjugationData else {
                    print("Error fetching conjugation data")
                    return
                }

                // Update UI elements
                self?.txtWord.text = data.word
                self?.txtDescription.text = data.fullDescription
                self?.txtWordVerbType.text = data.verbType

                // Save conjugations
                self?.conjugations = data.conjugations

                // Optionally, reload a table view or other UI elements to display conjugations
            }
        }
    }
}

