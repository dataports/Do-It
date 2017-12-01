//
//  TasksViewController.swift
//  Do It
//
//  Created by Sophie Amin on 2017-11-25.
//  Copyright © 2017 Sophie Amin. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks : [Task] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tasks = makeTasks()
        
        tableView.dataSource = self //look to this class
        tableView.delegate = self
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count //count the current number of tasks
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        if task.important {
            cell.textLabel?.text = "❗️\(task.name)"
        }
        else {
            cell.textLabel?.text = task.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "selectTaskSegue", sender: task)
    }
    
    func makeTasks() -> [Task] {
        let task1 = Task()
        task1.name = "Walk the dog"
        task1.important = false
        
        let task2 = Task()
        task2.name = "Buy cheese"
        task2.important = true
        
        let task3 = Task()
        task3.name = "Mow the lawn"
        task3.important = false
        
        return [task1, task2, task3]
    }

    @IBAction func plusTapped(_ sender: Any){
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue"{
        let nextVC = segue.destination as! CreateTaskViewController
        nextVC.previousVC = self
        }
        if segue.identifier == "selectTaskSegue"{
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task  = sender as! Task
            nextVC.previousVC = self
        }
    }
}

