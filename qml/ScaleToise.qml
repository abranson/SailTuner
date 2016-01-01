import QtQuick 2.0

/**
 * ScaleToise
 *
 * Display notes from scale, with current note centered.
 */

Item {
	id: scale
	
	// note or note + 12 * octave
	property int note: 1

	property variant notes_fr: ["do", "do#", "ré", "mib", "mi", "fa", "fa#", "sol", "sol#", "la", "sib", "si"]
	property variant notes_en: [
		"C", "C#", "D", "Eb", "E", "F", "F#", "G", "G#", "A", "Bb", "B"
	]
	property variant notes: [notes_en, notes_fr]
	property int notes_style: 0

	property int nb_notes: 12
	/// current note is on the middle
	property double position: note + (nb_notes + 1) / 2

	property int first_note: Math.floor(position) % nb_notes
	property double delta: position - Math.floor(position)

	function note_name(i) {
		return notes[notes_style][i];
	}

	Behavior on position {
		NumberAnimation {
			duration: 200
			easing.amplitude: nb_notes
		}
	}

	Row {
		id: toise
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: - cellWidth * delta
		anchors.bottom: parent.bottom
		anchors.right: parent.right
		property double cellWidth: parent.width / nb_notes

		Repeater {
			model: nb_notes + 1
			Rectangle {
				width: toise.cellWidth
				height: parent.height
				border.width: 1

				Text {
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					text: note_name((index + nb_notes + first_note) % nb_notes)
				}
			}
		}
	}

	MouseArea {
		anchors.fill: parent
		onClicked: note = Math.random() * 100
	}
/*
	onPositionChanged: {
		console.log("note " + note_name(note % nb_notes) + " pos " + position + " first note " + first_note + " delta " + delta)
	}*/
}
