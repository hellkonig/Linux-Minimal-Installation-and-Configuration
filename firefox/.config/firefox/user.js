// Firefox privacy and performance baseline for a daily-use profile.
//
// Keep this file small: Firefox applies these values at every startup. Remove
// a preference from prefs.js as well if it is removed here and must return to
// its Firefox default.

// Block tracking content in all windows while retaining per-site exceptions.
user_pref("browser.contentblocking.category", "strict");

// Upgrade navigations to HTTPS and warn before using plain HTTP.
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_pbm", true);

// Send the Global Privacy Control signal to sites that support it.
user_pref("privacy.globalprivacycontrol.enabled", true);

// Disable Firefox studies and telemetry uploads.
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);

// Remove sponsored content from the new tab page and address bar.
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

// Do not let sites prompt for desktop notifications by default. Individual
// sites can still be granted permission explicitly.
user_pref("permissions.default.desktop-notification", 2);

// Keep session restore useful without carrying a large closed-tab backlog
// between browser launches. Open tabs are still restored on demand, and
// recently closed tabs remain available during the current browser session.
user_pref("browser.sessionstore.max_tabs_undo", 10);
user_pref("browser.sessionstore.max_windows_undo", 2);
user_pref("browser.sessionstore.persist_closed_tabs_between_sessions", false);

// On Linux, allow Firefox to unload inactive tabs if the system reaches real
// memory pressure. Selecting an unloaded tab reloads it automatically.
user_pref("browser.tabs.unloadOnLowMemory", true);
