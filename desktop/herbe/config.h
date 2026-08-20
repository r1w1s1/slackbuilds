/* Appearance aligned with dwm config */
static const char *background_color = "#1c1c1c";   /* same as col_bg */
static const char *border_color     = "#e0b800";   /* gold focused border */
static const char *font_color       = "#cccccc";   /* same as col_fg */

static const char *font_pattern =
    "Iosevka Term:size=11:antialias=true:autohint=true";

static const unsigned line_spacing = 4;
static const unsigned int padding  = 12;

/* Geometry */
static const unsigned int width       = 380;
static const unsigned int border_size = 2;
static const unsigned int pos_x       = 20;
static const unsigned int pos_y       = 40;

enum corners { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT };
enum corners corner = TOP_RIGHT;

/* Behavior */
static const unsigned int duration = 3; /* seconds */

#define DISMISS_BUTTON Button1
#define ACTION_BUTTON  Button3
