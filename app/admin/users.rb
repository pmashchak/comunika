ActiveAdmin.register User do
  form do |f|
    f.inputs do
      f.input :community
      f.input :name
      f.input :email
      f.input :phone
      f.input :role, collection: User::ROLES, include_blank: false
    end
    f.actions
  end

  action_item :new_message, only: :show do
    link_to 'New Message', new_admin_user_message_path(resource)
  end

  sidebar 'Messages', only: [:show, :edit] do
    ul do
      li link_to 'User Messages', admin_user_messages_path(resource)
    end
  end

  permit_params :community_id, :name, :email, :phone, :role
end
