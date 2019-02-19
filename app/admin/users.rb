ActiveAdmin.register User do
  form do |f|
    f.inputs do
      f.input :community
      f.input :name
      f.input :email
      f.input :role, collection: User::ROLES, include_blank: false
    end
    f.actions
  end
end
