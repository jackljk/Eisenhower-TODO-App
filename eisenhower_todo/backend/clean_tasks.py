from dateutil.relativedelta import relativedelta
from dateutil.parser import parse
import datetime

def get_tasks(generated_text):
    tasks = generated_text.strip().split("\n\n")
    # Initialize a list to store the dictionary for each task
    task_list = []

    # Process each task block
    for task in tasks:
        # Split the task into lines
        lines = task.split("\n")
        # Initialize a dictionary to store the task details
        task_dict = {}
        # Process each line
        for line in lines:
            print(line)
            # Split the line into key and value
            try: 
                key, value = line.split(": ")
            except ValueError:
                key, value = line.split(":")
            # Store in dictionary with modified key (remove the numeric suffix)
            key = key[:-2] # Assumes the suffix is always two characters (e.g., "_1", "_2")
            key = key.lower()
            task_dict[key] = value
        # Add the dictionary to the list
        task_list.append(task_dict)

    return task_list


