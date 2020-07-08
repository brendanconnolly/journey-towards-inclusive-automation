# frozen_string_literal: true

class RandomTodoMvcBot
  def initialize(browser)
    @browser = browser
  end

  def start; end

  def get_random_todo_action
    todo_functions = AutoTodoMvc.instance_methods(false)

    random_function_number = rand(todo_functions.length)
    todo_functions[random_function_number]
  end
end
