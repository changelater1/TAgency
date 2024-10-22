# require 'googleauth'

# scope = 'https://mail.google.com/'
# authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
#   json_key_io: File.open('/home/vova/Downloads/Telegram Desktop/client_secret_171931349291_5t99v5h3kqjf6hgrvapn5rhdgtk2lers_apps.json'),
#   scope: scope
# )

# authorizer.fetch_access_token!

# # Настройка ActionMailer для отправки через Gmail SMTP с OAuth2
# ActionMailer::Base.smtp_settings = {
#   address: 'smtp.gmail.com',
#   port: 587,
#   domain: 'http://localhost:3000/', # Замените на ваш домен
#   client_email: 'tagency@tagency.iam.gserviceaccount.com',
#   user_name: 'bsuabiturient2018@gmail.com',
#   password: authorizer.access_token,
#   authentication: 'plain',
#   enable_starttls_auto: true
# }

