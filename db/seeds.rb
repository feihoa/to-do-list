c1 = Project.create({title: "Семья"})
c2 = Project.create({title: "Друзья"})

c1.tasks.create({text: "Купить хлеб", isCompleted: false,})
c1.tasks.create({text: "Поздравить с др",isCompleted: false})
c1.tasks.create({text: "Помыть кота",isCompleted: false})
c1.tasks.create({text: "Сжечь ветки",isCompleted: false})
c2.tasks.create({text: "Встретиться в 6", isCompleted: false})