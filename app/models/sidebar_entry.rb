class SidebarEntry
  class << self
    include Rails.application.routes.url_helpers
  end

  def self.all
    [ {
        group_title: 'Navigazione'
      },
      {
        children: [
          {
            href: root_path,
            title: 'Dashboard',
            icon: 'home'
          },
          {
            group_title: 'Gestione Archivi'
          },
          {
            href: '#',
            title: 'Archivi',
            icon: 'archive',
            children: [
              {
                href: manager_food_categories_path,
                title: FoodCategory.model_name.human(count: 2),
              },
              {
                href: manager_foods_path,
                title: Food.model_name.human(count: 2),
              },
              {
                href: manager_pathologies_path,
                title: Pathology.model_name.human(count: 2),
              },
              {
                href: manager_rates_path,
                title: Rate.model_name.human(count: 2),
              }
            ]
          },
          {
            href: manager_customers_path,
            title: Customer.model_name.human(count: 2),
            icon: 'people',
          },
          {
            href: manager_appointments_path,
            title: Appointment.model_name.human(count: 2),
            icon: 'calendar_today',
          },
          {
            href: manager_diets_path,
            title: Diet.model_name.human(count: 2),
            icon: 'restaurant_menu',
          },
          {
            href: manager_documents_path,
            title: Document.model_name.human(count: 2),
            icon: 'insert_drive_file'
          },
          {
            href: manager_reports_path,
            title: Report.model_name.human(count: 2),
            icon: 'file_copy'
          },
          {
            href: edit_manager_company_path,
            title: 'Impostazioni',
            icon: 'settings',
            aria_controls: "settings"
          }
        ]
      }
    ]
  end
end