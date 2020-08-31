from bot import bot

if __name__ == "__main__":
    bot = bot()
    bot.site_login()
    bot.find_page()
    bot.parse_grades()


