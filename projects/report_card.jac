"""Report Card Generator with AI hints, term trends & animated progress"""

import from byllm.llm { Model };
import csv;
import time;

# Initialize AI model
glob llm = Model(model_name='gemini/gemini-2.0-flash', verbose=False);

def give_hint(grade: float) -> str by llm();

# ----------------------
# Step 1: Define Student object
# ----------------------
obj Student {
    has name: str;
    has term_grades: list[dict[str,int]];  # e.g., [{"Math": 78, "English": 90}, {...}]
    has current_grades: dict[str,int];
    has total: int = 0;
    has average: float = 0.0;
    has letter: str;
    has badge: str = "";

    def compute_total;
    def compute_average;
    def get_letter;
    def assign_badge;
    def trend_summary;
}

impl Student.compute_total {
    self.total = sum([value for value in self.current_grades.values()]);
    return self.total;
}

impl Student.compute_average {
    self.average = self.total / len(self.current_grades);
    return self.average;
}

impl Student.get_letter {
    avg = self.average;
    if avg < 0 or avg > 100 {
        self.letter = "Invalid";
    } elif avg <= 30:
        self.letter = "E";
    elif avg <= 50:
        self.letter = "D";
    elif avg <= 70:
        self.letter = "C";
    elif avg <= 90:
        self.letter = "B";
    else:
        self.letter = "A";
    return self.letter;

impl Student.assign_badge {
    if self.average >= 90:
        self.badge = "🏅 Honor Roll";
    elif self.average >= 70:
        self.badge = "🌟 Great Effort";
    elif self.average <= 50:
        self.badge = "🚀 Needs Improvement";
    else:
        self.badge = "";
    return self.badge;

impl Student.trend_summary {
    if len(self.term_grades) < 2 {
        return "No previous terms to compare.";
    }
    prev_total = sum([sum(t.values()) for t in self.term_grades[:-1]]) / (len(self.term_grades)-1);
    improvement = self.total - prev_total;
    if improvement > 0:
        return f"Improved by {improvement} points since last term! 🎉";
    elif improvement < 0:
        return f"Decreased by {abs(improvement)} points 😢";
    else:
        return "Same performance as last term.";
}

# ----------------------
# Step 2: Input Student interactively
# ----------------------
walker InputStudent {
    has student: Student;

    can start with `root entry;
    def capture_input;
}

impl InputStudent.capture_input {
    name = input("Enter student name: ");
    subjects = input("Enter subjects separated by commas: ").split(",");
    grades = {};
    for subject in subjects {
        grade = int(input(f"Enter grade for {subject.strip()}: "));
        grades[subject.strip()] = grade;
    }
    self.student = Student(name, term_grades=[grades], current_grades=grades);
    print(f"Student {name} added with grades {grades}");
    root spawn ReportCard(self.student);
}

# ----------------------
# Step 3: ReportCard walker
# ----------------------
walker ReportCard {
    has student: Student;
    has filename: str = "report_cards.csv";

    can start with `root entry;
    can check_grade with turn entry;
}

node turn {}

impl ReportCard.start {
    next = root ++> turn();
    visit next;
}

impl ReportCard.check_grade {
    self.student.compute_total();
    self.student.compute_average();
    letter = self.student.get_letter();
    badge = self.student.assign_badge();

    # Animated ASCII bars for each subject
    print(f"\n--- Report Card: {self.student.name} {badge} ---")
    for subject, grade in self.student.current_grades.items() {
        bar = "█"*(grade//2)
        print(f"{subject}: {grade} |{bar}", end="");
        # Animate bar
        for i in range(len(bar)):
            print("█", end="", flush=True);
            time.sleep(0.01);
        print();
    }
    print(f"Total: {self.student.total}");
    print(f"Average: {self.student.average}");
    print(f"Letter Grade: {letter}");
    print("Trend: ", self.student.trend_summary());

    if self.student.average <= 50:
        print("Hint: ", give_hint(self.student.average));

    # Append to CSV
    with open(self.filename, 'a', newline='') as file {
        writer = csv.writer(file);
        writer.writerow([self.student.name, self.student.current_grades, self.student.total, self.student.average, letter, badge]);
    }
    disengage;

# ----------------------
# Step 4: Class summary and ranking
# ----------------------
walker ClassSummary {
    has students: list[Student];

    can start with `root entry;
    def show_ranking;
}

impl ClassSummary.show_ranking {
    sorted_students = sorted(self.students, key=lambda s: s.average, reverse=True);
    print("\n--- Class Ranking ---");
    for idx, s in enumerate(sorted_students):
        rank = idx + 1;
        print(f"{rank}. {s.name} ({s.average}) {s.badge}");
    disengage;

# ----------------------
# Step 5: Entry point
# ----------------------
with entry:_main_ {
    # Create CSV header
    with open("report_cards.csv", 'w', newline='') as file {
        writer = csv.writer(file);
        writer.writerow(["Name", "Grades", "Total", "Average", "Letter Grade", "Badge"]);
    }

    all_students = [];
    while True {
        input_walker = InputStudent();
        root spawn input_walker;
        all_students.append(input_walker.student);

        cont = input("Add another student? (y/n): ").lower();
        if cont != 'y':
            break;

    summary = ClassSummary(all_students);
    root spawn summary.show_ranking();

    print("All report cards generated and saved to report_cards.csv");
}

