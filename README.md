# Generative AI Program - Open University of Kenya

This repository contains all assignments and projects for the **Generative AI Program** at the **Open University of Kenya**.

---

## Repository Structure

generative-ai-ouk/
├─ datasets/ # Placeholder for datasets used in assignments  
├─ notebooks/ # Jupyter notebooks for course weeks  
│  ├─ week1_intro.ipynb # Week 1: Introduction to Generative AI  
│  └─ week2_assignment.ipynb # Week 2: Basic Generative AI tasks assignment  
├─ projects/ # Project outputs and reports  
│  ├─ .gitkeep  
│  └─ reports/ # PDF or other reports from assignments/projects  
├─ .gitignore  
├─ LICENSE # MIT License  
├─ README.md  
└─ requirements.txt # Required Python packages

---

## How to Use

1. **Clone this repository:**

```bash
git clone https://github.com/Ndarila/generative-ai-ouk.git
cd generative-ai-ouk
Install required Python packages:

bash
Copy code
pip install -r requirements.txt
Report Card Generator (Jac)
File: projects/report_card.jac

A dynamic Report Card Generator built with the Jac programming language and AI-enhanced hints.

Features
Interactive CLI input: add student names and grades live.

Subject-wise grades for multiple subjects per student.

AI-powered feedback for low grades.

Dynamic ranking & gamification: badges for top students.

Term-wise trends showing performance improvement/decline.

Animated ASCII progress bars in the CLI.

CSV export: results saved automatically.

How to Use
Ensure Jac is installed:

bash
Copy code
pip install jaclang
Open the file in a Jac environment (Jupyter Notebook with Jac kernel or Colab with Jac installed).

Run the program:

bash
Copy code
jac run projects/report_card.jac
Follow the interactive prompts to add students and grades.

report_cards.csv will be generated automatically with all student data.

Example Output (ASCII CLI)
yaml
Copy code
--- Report Card: Alice 🏅 Honor Roll ---
Math: 85 |█████████████
English: 90 |███████████████
Total: 175
Average: 87.5
Letter Grade: B
Trend: Improved by 10 points since last term! 🎉
Notes
Demonstrates Jac walkers, nodes, AI integration (byLLM), and CSV export.

Great for assignments, interactive reports, or learning Jac programming.

✅ Next Steps
Add more projects or assignments to the repository.

Keep the README updated with screenshots, ASCII examples, or explanations for clarity.
