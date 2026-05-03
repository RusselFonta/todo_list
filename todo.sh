#!/bin/bash
if [[ ! -f "task.txt" ]]; then
    touch task.txt
fi
show_help(){
    echo "Usage:"
    echo " Avaiable options:"
    echo "  Add: $0 add \"Descript what you are adding\""
    echo "  list: $0 list \"Display all tasks in the list.\""
    echo "  del: $0  del \"Enter task number you want to delete.\""
}
if [[ "$#" -eq 2 ]]; then
    case "$1" in
        "add")
            echo "$2" >> task.txt
            echo "$2 was added to the file."
            ;;
        "del")
               total_tasks=$(wc -l < task.txt)
                if [[ "$total_tasks" -eq 0 ]]; then
               echo "empty list"
               else
               while true;do
               if [[ "$2" =~ ^[0-9]+$ ]] && [[ "$2" -ge 1 ]] && [[ "$2" -le "$total_tasks" ]]; then
                     sed -i "${2}d" task.txt
                     echo "Task $2 has been deleted."
                     break
                else
                     echo "Invalid task number. Please enter a number between 1 and $total_tasks."
                fi
                done
                fi
            ;;
        *)
            show_help
            ;;
    esac
elif [[ "$#" -eq 1 ]]; then
if [[ "$1" == "list" ]]; then
  if [[ ! -s "task.txt" ]]; then
    echo "list is empty"
else
  echo "task in the list"
  cat -n task.txt
 fi
else
 show_help
fi
else
    show_help
fi