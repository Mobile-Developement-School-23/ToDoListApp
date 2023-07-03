import UIKit

class MainViewController: UIViewController{

    let fileCache = FileCache()
    let scrollView = UIScrollView()
    let containerView = UIView()
    let showButton = UIButton()
    var tableViewHeightConstraint: NSLayoutConstraint? // Add this line

    var items: [ToDoItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var stackView = setupStackView()
    private lazy var tableView = setupTableView()
    override func viewDidLoad() {
        
        super.viewDidLoad()

                
        fileCache.items = fileCache.loadFromJSONFile(named: "Tasks.geojson")
        setupNavigationBar()
        view.addSubview(scrollView)
        self.scrollView.backgroundColor = UIColor(named: "BackPrimary")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
   //     scrollView.contentSize = tableView.bounds.size
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
                
        scrollView.addSubview(containerView)
    
        
       
        
        containerView.addSubview(stackView)
       
        

        containerView.addSubview(tableView)
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(56 * (fileCache.items.count + 1)))
            tableViewHeightConstraint?.isActive = true
        
//        let height = 56 * (fileCache.items.count + 1)// change 56 to your cell's height and 30 to the number of cells
//        tableView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                    containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

                    stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
                    stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
                    stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),

                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
                    // Add these lines to your viewDidLoad method:
                    

                    // Adjust the bottom constraint of your tableView like so:
                    tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)

                ])


        
        
        let addNewTaskButton = UIButton()
        addNewTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addNewTaskButton.addTarget(self, action: #selector(addNewTaskButtonTapped), for: .touchUpInside)
        view.addSubview(addNewTaskButton)
        
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 44, weight: .medium, scale: .large)
        let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)
        addNewTaskButton.setImage(symbolImage, for: .normal)
        
        NSLayoutConstraint.activate([
            addNewTaskButton.heightAnchor.constraint(equalToConstant: 100),
            addNewTaskButton.widthAnchor.constraint(equalToConstant: 100),
            addNewTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewTaskButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    @objc func updateTableViewHeight() {
        print("updateTableViewHeight")
        tableViewHeightConstraint?.constant = CGFloat(56 * (fileCache.items.count + 1))
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    func saveItemsToJSONFile() {
        // Save the items to the JSON file
        fileCache.saveToJSONFile(named: "Tasks.geojson")
    }
    func setupStackView() -> UIStackView{
        let stackView = UIStackView()
        
        showButton.setTitle("Показать", for: .normal)
        showButton.widthAnchor.constraint(equalToConstant: 148).isActive = true
        showButton.titleLabel?.textAlignment = .right
        showButton.contentHorizontalAlignment = .right
        showButton.setTitleColor(UIColor(named: "ColorBlue"), for: .normal) //
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
        
        let counterLabel = UILabel()
        counterLabel.widthAnchor.constraint(equalToConstant: 148).isActive = true
        counterLabel.textAlignment = .left
        counterLabel.text = "Выполнено - 0"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(counterLabel)
        stackView.addArrangedSubview(showButton)
        return stackView
    }
    func checkFileExistence() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectory?.appendingPathComponent("Tasks.geojson")
        
        if let fileURL = fileURL {
            if fileManager.fileExists(atPath: fileURL.path) {
                print("The file exists at path: \(fileURL.path)")
            } else {
                print("The file does not exist at path: \(fileURL.path)")
            }
        } else {
            print("Invalid file URL")
        }
    }

    func setupNavigationBar(){
        self.navigationController?.navigationBar.backgroundColor = scrollView.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Mои дела"
        self.navigationController?.navigationBar.layoutMargins.left = 32
        
    }

    func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "BackSecondary")
        tableView.layer.cornerRadius = 15
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.delegate = self
tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")

        return tableView
    }



    @objc func showButtonTapped(){
        print("showButtonTapped")
        showButton.setTitle("Скрыть", for: .normal)
        
        showButton.removeTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
        showButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
    }
    @objc func hideButtonTapped(){
        print("hideButtonTapped")
        showButton.setTitle("Показать", for: .normal)
        showButton.removeTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
    }
    @objc func addNewTaskButtonTapped() {
        let newTaskVC = ViewController()
        
        // Set the closure to handle the saving logic in MainViewController
        newTaskVC.didSaveItem = { [weak self] newItem in
            // Add the item to the file cache
            self?.fileCache.addItem(item: newItem)
            self?.updateTableViewHeight()

            // Save the items to the JSON file
            self?.fileCache.saveToJSONFile(named: "Tasks.geojson")

            // Refresh the items
            self?.items = self?.fileCache.items ?? []
        }
        
        present(newTaskVC, animated: true)
    }


    

}
