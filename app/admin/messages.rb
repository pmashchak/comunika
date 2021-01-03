ActiveAdmin.register Message do
  belongs_to :user, optional: true

  form do |f|
    f.inputs do
      f.input :text
      if f.object.new_record?
        f.input :state, value: :new
      else
        f.input :state, collection: Message.all_states
      end
      f.input :user, collection: User.all, include_blank: false
    end
    f.actions
  end

  preserve_default_filters!
  filter :state, as: :select, collection: Message.all_states
  permit_params :user_id, :text, :state

  member_action :send_message, method: :put do
    SendTextJob.perform_later(resource.id)
    redirect_to admin_message_path(resource), notice: "SMS was sent"
  end

  action_item :send_message, only: [:show, :edit] do
    if resource.can_enque?
      link_to 'Send Message', send_message_admin_message_path(resource), method: :put
    end
  end
end
