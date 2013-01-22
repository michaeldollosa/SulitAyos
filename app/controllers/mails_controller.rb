class MailsController < ApplicationController
def index #for received messages
    recipient_id = current_user.id
    @mails = Mail.where(:receiver_id => recipient_id)
  end

  def index_sent
    sender_id = current_user.id
    @mails = Mail.where(:sender_id => sender_id) 
  end

  def read
    recipient_id = current_user.id
    @temp = Mail.where(:receiver_id => recipient_id)
    @mails = @temp.where(:read => true)
  end

  def unread
    recipient_id = current_user.id
    @temp = Mail.where(:receiver_id => recipient_id)
    @mails = @temp.where(:read => !true)
  end
 
  def new
    @recipient = User.where(id: params[:user_id]).first if params[:user_id]
    # raise @recipient.to_yaml
    @mail = Mail.new

  end

  def create
    @mail = Mail.new(params[:mail])
    @mail.sender_id = current_user.id
    @mail.save
    redirect_to index_sent_mail_path(current_user.id)
  end

  def show
    @mail = Mail.find(params[:id])
    @sender = @mail.sender
    @recipient = @mail.receiver
    @mail.read = true
    @mail.save
  end

  def edit
    @mail = Mail.find(params[:id])
    @reply = @mail.dup
    @reply.save
    @reply.read = false
    @reply.subject = "Re: #{@reply.subject}"
    @reply.msgbody = "Sent: #{@reply.created_at} #{@reply.msgbody}"
    @sender = @reply.sender
    @recipient = @reply.receiver
  end

  def update
    @mail = Mail.find(params[:id])
    @mail.update_attributes(params[:mail])
    redirect_to index_sent_mail_path(current_user.id)
  end

  def destroy
    Mail.find(params[:id]).destroy
    redirect_to (:back)
  end
end
