;;; random-idle-quote.el --- display a random quote during idle

;; Copyright (C) 2004  Jeremy Cowgar <jeremy@cowgar.com>

;; Version: 1.0
;; Author: Jeremy Cowgar <jeremy@cowgar.com>
;; URL: http://jeremy.cowgar.com/EmacsRandomIdleQuote.html

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;; Add:
;;
;;   (require 'random-idle-quote)
;;   (random-idle-quote)
;;
;; to your ~/.emacs ... when your emacs goes into idle mode, a quote
;; will appear in your echo window. I use it to help me remember new
;; things. The quotes that have come with it are straight from
;; http://www.emacswiki.org/cgi-bin/wiki/EmacsNiftyTricks
;;
;; But feel free to customize the random-idle-quotes to something more
;; useful to yourself.

;;; Thanks:

;; Many people on irc.freenode.net#emacs

;;; Code:

;; Customization

;;(defgroup random-idle-quote nil
;;  "Options concerning the configuration of random-idle-quote"
;;  :group 'random-idle-quote)

(defcustom random-idle-quote-delay 300
  "Number of seconds to display quote after emacs enters idle mode"
  :group 'random-idle-quote
  :type 'number)

(defcustom random-idle-quotes
  '(
;;"Work on stuff that matters!"
		"Get rid of the 'nice to do' things, and focus on the 'must do' things to accelerate them."
;;		"Impact: Find things that others have accepted as the status quo and make them significantly, noticably and remarkably better."
		"Impact: Find things that you're attached to that are slowing you down, realize that they are broken beyond repair and eliminate them."
		"When it's you against the project, the goal is to do more work."
		"Are you making something?"
		"Have you released something this week? Why not?"
		"The first rule of doing work that matters: Go to work on a regular basis."
		"What are you working on? If someone asks you that, are you excited to tell them the answer?"
		"What's the best thing you could be working on, and why aren't you?"
		"If you want to succeed, double your failure rate."
;;		"Plan on being misunderstood. Repeat yourself. When in doubt, repeat yourself."
		"Busy does not equal important. Measured doesn't mean mattered."
		"Never piss off the sound guy."
;;		"Perfectionism leads to procrastination."
		"Create more value than you capture"
		"Bonddad - The word amateur is from a French word that means, 'one who does it for love'"
		"Live as if you were to die tomorrow. Learn as if you were to live forever."
		"Replace your but's with and's."
		"Find one thing you are avoiding and do it now!"
		"If you're going to pussyfoot around for 30 minutes in your 'fatburn' zone three times a week, don't even bother."
		"Pause... Think... Type..."
		"The answer is always more art...  If you start to think that less art is the answer, start over."
		"We will not celebrate. Every day will be awesome, or we stop what we’re doing and make it awesome. Cake is for gazelles, and we are lions."
		"We will NOT ignore problems, and we will swarm when issues arise."
		"Just start working on something for 10 min. Anyone can work for 10 min."
		"Expect increased calm to be more calm."
		"Spiral upwards by coming out ahead of expectations every time."
		"Increase Arousal: imagine something wrong, increase novelty, expect reward"
		"Decrease Arousal: write ideas down, activate other parts of brain, reduce speed/volume of info"
		"Get Insight: light focus on impasse, simply described, reflect on thinking process"
		"Is your pre-frontal cortex tired? Should you be running? Napping?"
		"Goals are for losers. Have a system. - Scott Adams"
		"Everyone thinks at some point that they aren't as good as everyone else.  Don't let it bother you.")
  "List of quotes to show during idle"
  :group 'random-idle-quote
  :type '(repeat string))

(defun random-idle-quote-get ()
  (nth (random (length random-idle-quotes)) random-idle-quotes))

(defun random-idle-quote-show ()
  (interactive)
  (message (format "Quote Time: %s" (random-idle-quote-get))))

(defun random-idle-quote()
  (interactive)
  (setq random-idle-quote-timer (run-with-idle-timer random-idle-quote-delay 5 'random-idle-quote-show)))

(defun random-idle-quote-stop()
  (interactive)
  (cancel-timer random-idle-quote-timer))

(provide 'random-idle-quote)

;;; random-idle-quote.el ends here
