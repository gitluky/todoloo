module TasksHelper

  def display_assignment_links(task)
    if !task.assigned?
      link_to('Volunteer', assign_user_path(task), method: 'post', class: 'nav-item nav-link px-2')
    elsif task.assigned_to == current_user
      link_to('Drop Task', unassign_user_path(task), method: 'post', class: 'nav-item nav-link px-2')
    end
  end

end
