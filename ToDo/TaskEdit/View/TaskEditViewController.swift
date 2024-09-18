//
//  TaskEditViewController.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import UIKit

final class TaskEditViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let presenter: TaskEditPresenterInput
    
    // MARK: Subviews
    
    private let editTaskTitle = UILabel()
    private let saveButton = UIButton()
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    private let descripotionTextLabel = UILabel()
    private let descriptionTextField = UITextView()
    
    // MARK: Properties
    
    // MARK: Init
    
    init(presenter: TaskEditPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        presenter.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        setupSaveButton()
        setupEditTaskTitle()
        setupTitleLabel()
        setupTitleTextField()
        setupDescripotionTextLabel()
        setupDescriptionTextField()
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("SAVE TASK", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]))
        config.baseForegroundColor = .systemBlue
        config.imagePadding = 8
        config.imagePlacement = .leading
        
        saveButton.configuration = config
        saveButton.backgroundColor = .buttonColor
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 12
        saveButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(140)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
    }
    
    private func setupEditTaskTitle() {
        view.addSubview(editTaskTitle)
        editTaskTitle.backgroundColor = .clear
        editTaskTitle.text = "Edit Task"
        editTaskTitle.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        editTaskTitle.textColor = .black
        editTaskTitle.textAlignment = .center
        editTaskTitle.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .clear
        titleLabel.text = "Task Title"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(editTaskTitle.snp.bottom).offset(40)
        }
    }
    
    private func setupTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.backgroundColor = .systemBackground
        titleTextField.placeholder = "   Enter the task name"
        titleTextField.clipsToBounds = true
        titleTextField.layer.cornerRadius = 12
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
    }
    
    private func setupDescripotionTextLabel() {
        view.addSubview(descripotionTextLabel)
        descripotionTextLabel.backgroundColor = .clear
        descripotionTextLabel.text = "Description"
        descripotionTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        descripotionTextLabel.textColor = .gray
        descripotionTextLabel.textAlignment = .center
        descripotionTextLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
    }
    
    private func setupDescriptionTextField() {
        view.addSubview(descriptionTextField)
        descriptionTextField.backgroundColor = .systemBackground
        descriptionTextField.clipsToBounds = true
        descriptionTextField.layer.cornerRadius = 12
        descriptionTextField.snp.makeConstraints {
            $0.top.equalTo(descripotionTextLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(250)
        }
    }
    
    @objc
    private func saveButtonDidTap() {
        let titleText = titleTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        presenter.saveTaskDidTap(titleText: titleText, descriptionText: descriptionText)
    }
    
}



// MARK: - TaskEditViewControllerInput

extension TaskEditViewController: TaskEditViewControllerInput {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func update(title: String, description: String?) {
        titleTextField.text = title
        descriptionTextField.text = description
    }
}
