class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
       @contact = Contact.new(contact_params)
       if @contact.save
        # Send email when the contact form is successfully saved.
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        ContactMailer.contact_email(name, email, body).deliver
        # Flash a message to the user letting them know the message was sent.
        flash[:success] = "Message Sent!"
        redirect_to new_contact_path
       else
         # Flash a message to the user letting the know the message wasn't sent.
         # Also show any possible errors.
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
       end
    end
    
    private
        def contact_params
          params.require(:contact).permit(:name, :email, :comments)
        end
end
