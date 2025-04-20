host = case Rails.env
       when 'development'
         'localhost'
       when 'production'
         'quiz.local'
       end

company = Company.find_or_create_by(name: 'QuizApp', host: "#{host}")

manager = company.managers.find_or_initialize_by(email: 'andreadiquattro95@gmail.com')
manager.name = 'Andrea Diquattro'
manager.password = '12345678'
manager.role = :admin
manager.save(validate: false)