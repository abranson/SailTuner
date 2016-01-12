/* Copyright 2016 (C) Louis-Joseph Fournier 
 * louisjoseph.fournier@gmail.com
 *
 * This file is part of SailTuner.
 *
 * SailTuner is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * SailTuner is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

import QtQuick 2.0

/**
 * Main tuner screen
 *
 */

Item {
	id: main
	/// tuner object
	property QtObject tuner
	/// theme corresponding to Silica Theme object
	property QtObject theme

	anchors.fill: parent
	property int h_margin: (height - toise.height * 2 - image_play.height) / 5

	// landscape / portrait
	property bool is_portrait: height > width

	// maximum absolute deviation to display green led
	property double deviation_ok: 0.05
	property color led_green: "green"
	property color led_red: "red"

	property bool dev_is_ok: Math.abs(tuner.deviation) <= deviation_ok

	// frequency and temperament
	Column {
		id: freq_temp
		x: theme.paddingLarge
		y: theme.paddingLarge
		width: parent.width * 0.4
		height: width / 2

		Text {
			text: tuner.la + " hz"
			font.pixelSize: theme.fontSizeSmall
			color: theme.secondaryColor
		}
		Text {
			text: tuner.temperament_list[tuner.temperament_idx]
			font.pixelSize: theme.fontSizeSmall
			color: theme.secondaryColor
		}
	}

	// icon for pause status
	Image {
		id: image_play
		anchors.top: parent.top
		anchors.topMargin: h_margin
		anchors.horizontalCenter: parent.horizontalCenter
		width: theme.iconSizeLarge
		height: width
		source: tuner.playing ? (theme.icon_play_large ? theme.icon_play_large : "image://theme/icon-l-play?" + theme.secondaryColor) : (theme.icon_pause_large ? theme.icon_pause_large : "image://theme/icon-l-pause?" + theme.secondaryColor)
	}

	Item {
		id: note_info

		anchors.top: image_play.bottom
		anchors.topMargin: h_margin

		width: parent.width
		height: parent.height - image_play.height - image_play.y - h_margin * 2

		property int toise_h: Math.max(width / 10, theme.fontSizeLarge * 1.8)
		property double margin_h: parent.is_portrait ? (height - toise_h * 2) / 7 : (height - toise_h) / 6

		Text {
			id: title_note
			visible: main.is_portrait
			text: qsTr("Note")

			font.pixelSize: theme.fontSizeMedium
			color: theme.highlightColor

			anchors.top: parent.top
			anchors.topMargin: parent.margin_h
			anchors.horizontalCenter: parent.horizontalCenter
		}

		ScaleToise {
			id: toise
			theme: main.theme

			anchors.top: main.is_portrait ? title_note.bottom : parent.top
			anchors.topMargin: parent.margin_h

			anchors.left: parent.left
			anchors.leftMargin: parent.width * 0.1

			width: parent.width * 0.8
			height: parent.toise_h

			note: tuner.note
			octave: tuner.octave
		}

		Text {
			id: title_octave
			visible: main.is_portrait
			text: qsTr("Octave")

			font.pixelSize: theme.fontSizeMedium
			color: theme.highlightColor

			anchors.top: toise.bottom
			anchors.topMargin: parent.margin_h
			anchors.horizontalCenter: parent.horizontalCenter
		}

		// octave toise
		ToiseFlickable {
			anchors.top: main.is_portrait ? title_octave.bottom : toise.bottom
			anchors.topMargin: parent.margin_h

			anchors.left: parent.left
			anchors.leftMargin: parent.width * 0.2

			theme: main.theme

			marks: [1, 2, 3, 4, 5, 6, 7, 8]
			//nb_marks_displayed: is_portrait ? 4 : 3

			width: parent.width * 0.6
			height: parent.toise_h

			index: tuner.octave
		}
	}
}