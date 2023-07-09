pragma solidity >=0.7.0 <0.9.0;

contract DataAggregationContract {
    
    // Structure to represent a data analysis task
    struct Task {
        address owner;
        string taskType;
        bool completed;
    }
    
    // Array to hold all tasks
    Task[] public tasks;

    // Event to be emitted when a task is completed
    event TaskCompleted(address owner, string taskType);

    // Function to add a new task
    function addTask(address _owner, string memory _taskType) public {
        tasks.push(Task(_owner, _taskType, false));
    }

    // Function to mark a task as completed
    function completeTask(uint _taskId) public {
        require(_taskId < tasks.length, "Invalid task ID");
        tasks[_taskId].completed = true;
        emit TaskCompleted(tasks[_taskId].owner, tasks[_taskId].taskType);
    }

    // Function to get the total number of tasks
    function getTaskCount() public view returns (uint) {
        return tasks.length;
    }

    // Function to get the number of completed tasks
    function getCompletedTaskCount() public view returns (uint) {
        uint count = 0;
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].completed) {
                count++;
            }
        }
        return count;
    }
}
