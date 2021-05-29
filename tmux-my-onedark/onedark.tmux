#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/scripts/helpers.sh

onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

prefix_highlight_fg="$onedark_black"
prefix_highlight_bg="$onedark_green"
prefix_highlight_copy_mode_attr="fg=$onedark_black,bg=$onedark_green"
prefix_highlight_output_prefix="" 


colour_interpolation=(
        "\#{onedark_black}"
        "\#{onedark_blue}"
        "\#{onedark_yellow}"
        "\#{onedark_red}"
        "\#{onedark_white}"
        "\#{onedark_green}"
        "\#{onedark_visual_grey}"
        "\#{onedark_comment_grey}"
	"\#{prefix_highlight_f}"
	"\#{prefix_highlight_b}"
	"\#{prefix_highlight_copy_mode_att}"
	"\#{prefix_highlight_output_prefix}"
)

colour_commands=(
        "$onedark_black"
        "$onedark_blue"
        "$onedark_yellow"
        "$onedark_red"
        "$onedark_white"
        "$onedark_green"
        "$onedark_visual_grey"
	"$onedark_comment_grey"
	"$prefix_highlight_f"
	"$prefix_highlight_b"
	"$prefix_highlight_copy_mode_att"
	"$prefix_highlight_output_prefix"
)


options() {
	set_tmux_option "status" "on"
	set_tmux_option "status-justify" "left"

	set_tmux_option "status-left-length" "100"
	set_tmux_option "status-right-length" "100"
	set_tmux_option "status-right-attr" "none"

	set_tmux_option "message-fg" "$onedark_white"
	set_tmux_option "message-bg" "$onedark_black"

	set_tmux_option "message-command-fg" "$onedark_white"
	set_tmux_option "message-command-bg" "$onedark_black"

	set_tmux_option "status-attr" "none"
	set_tmux_option "status-left-attr" "none"

	set_tmux_window_option "window-status-fg" "$onedark_black"
	set_tmux_window_option "window-status-bg" "$onedark_black"
	set_tmux_window_option "window-status-attr" "none"

	set_tmux_window_option "window-status-activity-bg" "$onedark_black"
	set_tmux_window_option "window-status-activity-fg" "$onedark_black"
	set_tmux_window_option "window-status-activity-attr" "none"

	set_tmux_window_option "window-status-separator" ""

	set_tmux_option "window-style" "fg=$onedark_comment_grey"
	set_tmux_option "window-active-style" "fg=$onedark_white"

	set_tmux_option "pane-border-fg" "$onedark_white"
	set_tmux_option "pane-border-bg" "$onedark_black"
	set_tmux_option "pane-active-border-fg" "$onedark_green"
	set_tmux_option "pane-active-border-bg" "$onedark_black"

	set_tmux_option "display-panes-active-colour" "$onedark_yellow"
	set_tmux_option "display-panes-colour" "$onedark_blue"

	set_tmux_option "status-bg" "$onedark_black"
	set_tmux_option "status-fg" "$onedark_white"

}


do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#colour_commands[@]}; i++)); do
		all_interpolated=${all_interpolated//${colour_interpolation[$i]}/${colour_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	options
	update_tmux_option "status-right"
	update_tmux_option "status-left"
	update_tmux_option "window-status-format"
	update_tmux_option "window-status-current-format"
}
main
