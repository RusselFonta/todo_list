#!/bin/bash
if [[ ! -f "task.txt" ]]; then
    touch task.txt
fi
show_help(){
    echo "Usage: $0 [Add|List|delete|Help]"
    echo " Avaiable options:"
    echo "  Add: Adding a new task to the list."
    echo "  List: Display all tasks in the list."
    echo "  Delete: Delete a task from the list by its number."
    echo "  Help: Show this help message."
}
if [[ -n "$1" ]]; then
    case "$1" in
        "Add")
            read -rp "enter task to be added: " Add
            echo "$Add" >> task.txt
            echo "$Add was added to the file."
            ;;
        "List")
                echo "Tasks in the list:"
                cat task.txt
            
            ;;
        "Delete")
               total_tasks=$(wc -l < task.txt)
                if [[ "$total_tasks" -eq 0 ]]; then
               echo "empty list"
               else
               while true;do
               read -rp "enter the number of the task to delete: " del
               if [[ "$del" =~ ^[0-9]+$ ]] && [[ "$del" -ge 1 ]] && [[ "$del" -le "$total_tasks" ]]; then
                     sed -i "${del}d" task.txt
                     echo "Task $del has been deleted."
                     break
                else
                     echo "Invalid task number. Please enter a number between 1 and $total_tasks."
                fi
                done
                fi
            ;;
        "Help")
            show_help
            ;;
        *)
            echo "Invalid option. Use 'Help' for usage information."
            ;;
    esac
else
    show_help
fi