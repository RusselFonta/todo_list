#!/bin/bash

if [[ ! -f "tasks.txt" ]]; then
  touch tasks.txt
fi

show_help() {
  echo "Usage:"
  echo " Available options:"
  echo "  add: $0 add \"Description of the task\""
  echo "  list: $0 list"
  echo "  del: $0 del [task_number]"
}

if [[ "$#" -eq 2 ]]; then
  case "$1" in
    "add")
      task_string="$2"
      if [[ "$task_string" =~ ^[0-9]+$ ]]; then
        echo "Error: Numbers alone are not allowed. Only text strings are accepted."
      elif [[ -z "${task_string// }" ]]; then
        echo "Error: Task description cannot be empty."
        read -rp "Please enter a valid text description: " task_string
      elif grep -Fxq "$task_string" tasks.txt; then
        echo "Error: Task already existing "
        else
        echo "$task_string" >> tasks.txt
        echo "\"$task_string\" was added to the file."
      fi
    #   echo "$task_string" >> tasks.txt
    #   echo "\"$task_string\" was added to the file."
    ;;
    "del")
      total_tasks=$(wc -l < tasks.txt)
      if [[ "$total_tasks" -eq 0 ]]; then
        echo "The list is empty."
      else
        task_num="$2"
        if [[ "$task_num" =~ ^[0-9]+$ ]] && [[ "$task_num" -ge 1 ]] && [[ "$task_num" -le "$total_tasks" ]]; then
          sed -i "${task_num}d" tasks.txt
          echo "Task $task_num has been deleted."
        else
          echo "Invalid task number. Please enter a number between 1 and $total_tasks."
        fi
      fi
    ;;
    *)
      show_help
    ;;
  esac
elif [[ "$#" -eq 1 ]]; then
  if [[ "$1" == "list" ]]; then
    if [[ ! -s "tasks.txt" ]]; then
      echo "The list is empty."
    else
      echo "Tasks in the list:"
      cat -n tasks.txt
    fi
  else
    show_help
  fi
else
  show_help
fi
