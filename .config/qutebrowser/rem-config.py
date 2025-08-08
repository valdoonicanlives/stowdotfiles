config.load_autoconfig(False)
c.auto_save.session = True
c.completion.shrink = True
c.confirm_quit = ["downloads"]
c.content.cache.size = 5242880
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.location.remember = True
c.editor.command = ["st", "-e", "nvim", "{file}"]
#c.editor.command = ["emacsclient", "+{line}:{column}", "{}"]
c.hints.scatter = False
c.hints.uppercase = True
c.input.partial_timeout = 2000
c.tabs.tabs_are_windows = True
c.new_instance_open_target = "window"
c.tabs.show = "multiple"

## lazy_restore does not work when idle.
# c.session.lazy_restore = True
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?site=imghp&tbm=isch&source=hp&biw=1676&bih=997&q={}",
    "arch": "http://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}&go=Go",
    "aur": "https://aur.archlinux.org/packages.php?O=0&K={}&do_Search=Go",
    "gi": "https://www.google.com/search?site=imghp&tbm=isch&source=hp&biw=1676&bih=997&q={}",
    "gm": "https://maps.google.com/maps?q={}",
    "gp": "http://localhost:6060/pkg/{}",
    "gr": "https://www.goodreads.com/search?q={}",
    "imdb": "http://www.imdb.com/find?q={}&s=all",
    "leo": "http://dict.leo.org/frde/index_de.html#/search={}",
    "w": "http://en.wikipedia.org/wiki/Special:Search?search={}",
    "wr": "http://www.wordreference.com/enfr/{}",
    "yt": "http://www.youtube.com/results?search_query={}",
}

config.bind(',v', 'spawn mpv {url}')
#config.bind(',t', 'hint links spawn transmission-auto -a {hint-url}')
#config.bind(',T', 'hint -r links spawn transmission-auto -a {hint-url}')
config.bind('yy', 'yank -s')
config.bind('yY', 'yank')
#config.bind('yd', 'yank -s domain')
#config.bind('yD', 'yank domain')
config.bind('yp', 'yank -s pretty-url')
config.bind('yP', 'yank pretty-url')
config.bind('yt', 'yank -s title')
config.bind('yT', 'yank title')
config.bind('pp', 'open -- {primary}')
config.bind('pP', 'open -- {clipboard}')
config.bind('Pp', 'open -t -- {primary}')
config.bind('PP', 'open -t -- {clipboard}')
config.bind('<ctrl-e>', 'edit-command', mode='command')
config.bind('<alt-h>', 'completion-item-focus prev-category', mode='command')
config.bind('<alt-l>', 'completion-item-focus next-category', mode='command')
config.bind('<alt-j>', 'completion-item-focus next', mode='command')
config.bind('<alt-k>', 'completion-item-focus prev', mode='command')
config.bind('<alt-[>', 'completion-item-focus prev-category', mode='command')
config.bind('<alt-]>', 'completion-item-focus next-category', mode='command')

## Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()
