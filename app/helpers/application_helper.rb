module ApplicationHelper
  include Pagy::Frontend

  def active_class(path)
    return 'md:dark:text-blue-500 md:text-blue-700' if request.path == path

    ''
  end
end
