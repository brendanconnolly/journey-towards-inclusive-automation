# frozen_string_literal: true

require '../lib/auto_todo_mvc_vanillajs.rb'
class RandomAutoTodoMvc
  def initialize(browser)
    @browser = browser
    @auto_todo = AutoTodoMvc.new(browser)
  end

  def clear_completed_todos
    puts 'clear completed'
    @auto_todo.clear_completed_todos
  end

  def create_random_todo
    time_in_milli_seconds = (Time.now.to_f * 1000).to_i

    # todo_text = "Random Todo #{Time.now.strftime('%H:%M:%S.%L')}"
    todo_text = "Random Todo #{time_in_milli_seconds}"
    @auto_todo.add_todo(todo_text)
  end

  def update_random_todo
    random_todo_index = get_random_todo_index

    if random_todo_index > 0
      time_in_milli_seconds = (Time.now.to_f * 1000).to_i
      replacement_text = "update todo #{random_todo_index} - #{time_in_milli_seconds}"

      puts "updated todo #{random_todo_index}"
      @auto_todo.update_todo(random_todo_index, replacement_text)
    end
  end

  def delete_random_todo
    random_todo_index = get_random_todo_index

    if random_todo_index > 0
      puts "deleting todo #{random_todo_index}"
      @auto_todo.delete_todo(random_todo_index)
    end
  end

  def toggle_random_todo
    random_todo_index = get_random_todo_index

    if random_todo_index > 0
      puts "toggle todo #{random_todo_index}"
      @auto_todo.toggle_todo(random_todo_index)
    end
  end

  def toggle_all
    puts 'toggle all'
    @auto_todo.toggle_all
  end

  def filter_all
    puts 'filter all'
    @auto_todo.filter_all
  end

  def filter_active
    puts 'filter active'
    @auto_todo.filter_active
  end

  def filter_completed
    puts 'filter completed'
    @auto_todo.filter_completed
  end

  private

  def get_random_todo_index
    todo_count = @auto_todo.number_of_todo_items
    random_todo_index = 0

    if todo_count == 0
      puts "no todo's to choose from"
    else
      random_todo_index = rand(todo_count)
    end

    random_todo_index
  end
end
