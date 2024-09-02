document.addEventListener('DOMContentLoaded', () => {
    const ul = document.querySelector('#tasks ul');

    // Function to handle the delete button click event
    function deleteTask(e) {
        const li = e.target.closest('li');
        ul.removeChild(li);
        updateTaskInfo();
    }

    // Function to handle the clear all button click event
    function clearAllTasks() {
        ul.innerHTML = '';
        updateTaskInfo();
    }

    // Function to update task count
    function updateTaskInfo() {
        const taskCount = ul.children.length;
        const taskInfo = document.querySelector('.task-info span');
        taskInfo.textContent = taskCount;
    }

    // Attach event listeners to existing delete buttons
    ul.addEventListener('click', (e) => {
        if (e.target.classList.contains('delete')) {
            deleteTask(e);
        }
    });

    // Add task form submission handler
    const addForm = document.querySelector('#add-task');
    addForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const input = addForm.querySelector('input[type="text"]');
        const value = input.value.trim();
        if (!value) return;

        const li = document.createElement('li');
        li.innerHTML = `
            <input type="checkbox"> <span>${value}</span>
            <div>
                <button class="delete">Delete</button>
            </div>
        `;
        ul.appendChild(li);
        input.value = '';
        updateTaskInfo();
    });

    // Clear all tasks button handler
    const clearAllButton = document.querySelector('.clear-all');
    clearAllButton.addEventListener('click', clearAllTasks);

    // Initial task info update
    updateTaskInfo();
});
