"""
At the command line, only need to run once to install the package via pip:

$ pip install google-generativeai
"""
import datetime
import google.generativeai as genai

genai.configure(api_key="[ENTER API KEY HERE]")

# Set up the model
generation_config = {
  "temperature": 1,
  "top_p": 0.95,
  "top_k": 0,
  "max_output_tokens": 8192,
}

safety_settings = [
  {
    "category": "HARM_CATEGORY_HARASSMENT",
    "threshold": "BLOCK_MEDIUM_AND_ABOVE"
  },
  {
    "category": "HARM_CATEGORY_HATE_SPEECH",
    "threshold": "BLOCK_MEDIUM_AND_ABOVE"
  },
  {
    "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
    "threshold": "BLOCK_MEDIUM_AND_ABOVE"
  },
  {
    "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
    "threshold": "BLOCK_MEDIUM_AND_ABOVE"
  },
]

model = genai.GenerativeModel(model_name="gemini-1.5-pro-latest",
                              generation_config=generation_config,
                              safety_settings=safety_settings)

prompt = [
  "Concise tone extracting only the important information for a task list",
  "input: Make flyer and post instagram to advertise upcoming Chocolate Festival Event. I should post it by May 5th\ncurrent_date: 04/18/2024",
  "output: task_1: Chocolate Festival Flyer\ndue_1: 05/05/2024\ndue_time_1: [NOT GIVEN]\nurgent_1: No\nimportant_1: Yes\nurgent_given_1: No\nimportant_given_1: No\ntask_description_1: make and post a flyer for the chocolate festival",
  "input: Look at tickets for flights back home for summer break\ncurrent_date: 04/18/2024",
  "output: task_1: Look at Flight Tickets\ndue_1: 06/01/2024\ndue_time_1: [NOT GIVEN]\nurgent_1: No\nimportant_1: Yes\nurgent_given_1: No\nimportant_given_1: No\ntask_description_1: look for flight tickets back home for summer break",
  "input: Finish DSC 40A homework. Due every thrusday at midnight. Takes a long time so START EARLY\ncurrent_date: 04/18/2024",
  "output: task_1: DSC 40A homework\ndue_1: every Thursday\ndue_time_1: 23:59\nurgent_1: Yes\nimportant_1: Yes\nurgent_given_1: No\nimportant_given_1: No\ntask_description_1: DSC 40A homework. START EARLY",
  "input: Buy groceries. Only have enough food for 3 more days. Running out of milk and eggs today\ncurrent_date: 04/18/2024",
  "output: task_1: Buy Groceries\ndue_1: 04/21/2024\ndue_time_1: [NOT GIVEN]\nurgent_1: Yes\nimportant_1: Yes\nurgent_given_1: No\nimportant_given_1: No\ntask_description_1: Buy groceries ASAP, need to get Milk and Eggs amongst other things",
  "input: Study for DSC 20 Midterm in 2 weeks on Wed 12:00pm. Super important because it is 20% of your grade.\ncurrent_date: 04/18/2024",
  "output: task_1: Study for DSC 20 Midterm\ndue_1: 05/01/2024\ndue_time_1: 12:00\nurgent_1: No\nimportant_1: Yes\nurgent_given_1: No\nimportant_given_1: Yes\ntask_description_1: Study for DSC20 Midterm",
  "input: call mom.\ncurrent_date: 04/20/2024",
  "output: task_1: Call mom\nDue: [NO DUE]\ndue_time_1: [NOT GIVEN]\nurgent_1: Yes\nimportant_1: Yes\nurgent_given_1: no\nimportant_given_1: no\ntask_description_1: call mom",
  "input: buy snacks for girls night tonight, not that important it'll fine even if i forget. \ncurrent_date: 04/20/2024",
  "output: task_1: buy snacks\ndue_1: 04/20/2024\ndue_time_1: 18:00\nurgent_1: Yes\nimportant_1: No\nurgent_given_1: No\nimportant_given_1: Yes\ntask_description_1: Buy snacks for girls night",
  "input: study for ochem midterm this thursday by finishing the homework due tomorrow at midnight and then working on practice problems, and also catch up on lectures before starting the homework\ncurrent_date: 04/22/2024",
  "output: Task_1: finish ochem homework\nDue_1: 04/23/2024\nDue_time_1: 23:59\nUrgent_1: Yes\nImportant_1: Yes\nUrgent_given_1: No\nImportant_given_1: No\nTask Description_1: catch up on lectures and then finish ochem homework\n\nTask_2: study for ochem midterm\nDue_2: 04/24/2024\nDue_time_2: [NOT GIVEN]\nUrgent_2: Yes\nImportant_2: Yes\nUrgent_given_2: No\nImportant_given_2: No\nTask Description_2: study for ochem midterm by working on practice problems",
  "input: make flyers to advertise CoBoard's spring formal on May 23rd. have flyers done and posted a least a week before and repost flyers on instagram story on the day before\ncurrent_date: 04/22/2024",
  "output: Task_1: post flyers for spring formal\nDue_1: 05/16/2024\nDue_time_1: [NOT GIVEN]\nUrgent_1: No\nImportant_1: Yes\nUrgent_given_1: No\nImportant_given_1: No\nTask Description_1: make and post flyers for CoBoard spring formal\n\nTask_2: advertise spring formal\nDue_2: 05/22/2023\nDue_time_2: [NOT GIVEN]\nUrgent_2: No\nImportant_2: Yes\nUrgent_given_2: No\nImportant_given_2: No\nTask Description_2: repost spring formal flyer on instagram story",
]


def generate_output(task_paragraph):
    now = datetime.datetime.now()
    current_date = now.strftime("%m/%d/%Y")

    input_text = "input: " + task_paragraph + "\ncurrent_date: " + current_date
    print(input_text)
    prompt.append(input_text)
    prompt.append("output: ")

    response = model.generate_content(prompt)
    return response.text