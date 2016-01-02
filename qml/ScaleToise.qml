import QtQuick 2.0

/**
 * ScaleToise
 *
 * Display notes from scale, with current note centered.
 */

Toise {
	id: scale

	// note or note + 12 * octave
	property int note: 1
	// en or fr
	property int notes_style: 0

	property variant notes_fr: [
		"do", "do#", "ré", "mib", "mi", "fa", "fa#", "sol", "sol#", "la", "sib", "si"]
	property variant notes_en: [
		"C", "C#", "D", "Eb", "E", "F", "F#", "G", "G#", "A", "Bb", "B"]
	property variant notes: [notes_en, notes_fr]

	// case colors
	property color colorAltered: "#40888888"
	property color colorNatural: "transparent"

	// Toise parameters
	index: note
	marks: notes[notes_style]
	nb_marks_displayed: Math.min(nb_marks, width / theme.fontSizeLarge * 0.8)

	mark_color: function(note) {
		if (isAltered(note)) return colorAltered;
		else return colorNatural;
	}

	function isAltered(i) {
		return (i < 4 && (i & 1)) || (i > 5 && !(i & 1))
	}
}
