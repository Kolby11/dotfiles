// Personal Zen Browser preferences managed by the dotfiles repository.
// Keep mutable profile databases (history, sessions, cookies, passwords) out
// of dotfiles; this file contains only intentional preferences.

// Allow the profile's chrome/userChrome.css stylesheet to customize Zen's UI.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Keep Zen's native gradient/accent controls available for the CSS layer.
user_pref("zen.theme.gradient", true);
user_pref("zen.theme.gradient.show-custom-colors", true);
