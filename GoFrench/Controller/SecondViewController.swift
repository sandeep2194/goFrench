import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtWord: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtWordVerbType: UITextField!
    @IBOutlet weak var txtSearchTerm: UITextField!

    var conjugations = [Conjugation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }

    @IBAction func btnSearchTouchUpInside(_ sender: Any) {
        guard let searchTerm = txtSearchTerm.text, !searchTerm.isEmpty else {
            print("Search term is empty")
            return
        }

        ConjugationProvider.fetchConjugationData(for: txtSearchTerm.text!) { [weak self] conjugationData in
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

            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == Segue.toThirdViewController){
            return conjugations.count > 0;
        }
        
        return false;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Segue.toThirdViewController){
            let thirdViewController = segue.destination as! ThirdViewController;
            thirdViewController.conjugations = conjugations;
        }
    }
}

