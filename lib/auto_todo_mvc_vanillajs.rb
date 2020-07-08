# frozen_string_literal: true

class AutoTodoMvc
  def initialize(browser)
    @browser = browser
  end

  def add_todo(todo_text)
    todo_text_box = @browser.text_field(class: 'new-todo')
    todo_text_box.set(todo_text)
    todo_text_box.send_keys(:enter)
  end

  def update_todo(update_todo_number, replacement_text)
    todo_to_update = @browser.element(css: ".todo-list li:nth-child(#{update_todo_number})")
    todo_to_update.double_click

    update_value_script = "
    var inputSelector ='ul.todo-list > li.editing > input.edit';
    document.querySelector(inputSelector).value='#{replacement_text}';
    document.querySelector(inputSelector).dispatchEvent(new Event('blur'));"

    @browser.execute_script(update_value_script)
  end

  def delete_todo(delete_todo_number)
    @browser.element(css: ".todo-list li:nth-child(#{delete_todo_number})").hover
    @browser.element(css: ".todo-list li:nth-child(#{delete_todo_number}) button.destroy").click
  end

  def toggle_all
    toggle_all_element = @browser.element(id: 'toggle-all')
    toggle_all_element.click if toggle_all_element.present?
  end

  def toggle_todo(toggle_todo_number)
    @browser.element(css: ".todo-list li:nth-child(#{toggle_todo_number}) input.toggle").click
  end

  def filter_all
    filter_link = @browser.link(href: '#/')
    filter_link.click if filter_link.present?
  end

  def filter_active
    filter_link = @browser.link(href: '#/active')
    filter_link.click if filter_link.present?
  end

  def filter_completed
    filter_link = @browser.link(href: '#/completed')
    filter_link.click if filter_link.present?
  end

  def clear_completed_todos
    clear_button = @browser.button(class: 'clear-completed')
    clear_button.click if clear_button.present?
  end

  def clear_all_todos
    @browser.execute_script('localStorage.clear();')
    @browser.refresh
  end

  def todo_items_left
    todos_left_element = @browser.element(class: 'todo-count')
    todos_left_element.text if todos_left_element.present?
  end

  def number_of_todo_items
    @browser.elements(css: 'ul.todo-list li').count
  end
end
