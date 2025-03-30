import pandas as pd
import random
import datetime

# Define income sources and expense categories
income_sources = ['freelance', 'business', 'salary', 'investment', 'interest']
expense_categories = ['transport', 'groceries', 'rent', 'utilities', 'entertainment', 'health', 'shopping', 'food']

# Initialize empty list to store data
data = []

# Generate 100 income records
for i in range(100):
    date = (datetime.datetime.today() - datetime.timedelta(days=random.randint(1, 365))).strftime('%d-%m-%y')
    amount = round(random.uniform(100, 5000), 2)  # Random amount between 100 and 5000
    category = 'income'
    description = random.choice(income_sources)
    data.append([date, amount, category, description])

# Generate 100 expense records
for i in range(100):
    date = (datetime.datetime.today() - datetime.timedelta(days=random.randint(1, 365))).strftime('%d-%m-%y')
    amount = round(random.uniform(10, 1500), 2)  # Random amount between 10 and 1500
    category = 'expense'
    description = random.choice(expense_categories)
    data.append([date, amount, category, description])

# Create DataFrame from the data
df = pd.DataFrame(data, columns=["date", "amount", "category", "description"])

# Save the DataFrame to a CSV file
df.to_csv('income_expense_200.csv', index=False)

print("CSV file with 200 records has been created!")
