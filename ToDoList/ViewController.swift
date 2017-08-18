
//  ViewController.swift
//  ToDoList
//
//  Created by Shi Yuan Meng on 8/13/17.


import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout { //CollectionView = non-nav part of screen

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Elly's To-Do List"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.registerClass(TaskCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.registerClass(TaskHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var tasks = ["Buy groceries", "Fill up gas", "Pay bills"]
    
    //control number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //return cells
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let taskCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! TaskCell
        taskCell.nameLabel.text = tasks[indexPath.item]
        return taskCell
    }
    
    //places each cell on its own row
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 50)
    }
    
    //return header
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerID", forIndexPath: indexPath) as! TaskHeader
        
        //link header to controller so page reloads correctly
        header.viewController = self
        return header
    }
    
    //header size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
    func addNewTask(taskName: String) {
        tasks.append(taskName)
        collectionView?.reloadData()
    }
}

    
class TaskHeader: BaseCell {
    
    var viewController: ViewController? //? = no need to initialize it
    
    //create text field bar
    let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .RoundedRect
        return textField
    }()
    
    //create "Add Task" button
    let addTaskButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Add Task", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //control placement of items
    override func setupViews() {
        
        addSubview(taskNameTextField)
        addSubview(addTaskButton)
        
        addTaskButton.addTarget(self, action: #selector(TaskHeader.addTask), forControlEvents: .TouchUpInside)
        
        //width/horizontal
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0]-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskNameTextField, "v1": addTaskButton]))
        
        //height/vertical
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-24-[v0]-24-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskNameTextField]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": addTaskButton]))
    }
    
    //when "Add Task" button is pressed:
    func addTask() {
        viewController?.addNewTask(taskNameTextField.text!)
        taskNameTextField.text = " "
    }
}

class TaskCell: BaseCell {
    
    //create label for cell
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Task"
        //get it to use the constraints we specified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    override func setupViews() {
        
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}

class BaseCell: UICollectionViewCell {
    //own frame initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}

















