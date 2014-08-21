
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Make cross system config easier

(defmacro require-maybe (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(require ,feature ,file 'noerror)) 

(defmacro when-available (func foo)
  "*Do something if FUNCTION is available."
  `(when (fboundp ,func) ,foo)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Key Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "M-<up>") 'beginning-of-buffer)
(global-set-key (kbd "M-<down>") 'end-of-buffer)
(global-set-key (kbd "M-<right>") 'end-of-line)
(global-set-key (kbd "M-<left>") 'beginning-of-line)

(global-set-key '[(kp-delete)] 'delete-char)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;prevent annoying bell from ringing all the time
(setq visible-bell t)

;(global-set-key [M-left] 'windmove-left)          ; move to left windnow
;(global-set-key [M-right] 'windmove-right)        ; move to right window
;(global-set-key [M-up] 'windmove-up)              ; move to upper window
;(global-set-key [M-down] 'windmove-down)          ; move to downer window
;(global-set-key (kbd "C-<tab>") 'other-frame)    ; move to other frame

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TRAMP

(require 'tramp)

;speed up TRAMP
(setq tramp-default-method "rsyncc")
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

;;cache the file names of open files so we can C-TAB for auto finding them
(require 'filecache)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remote file open from: http://andy.wordpress.com/2013/01/03/automatic-emacsclient/


;(setq server-use-tcp t
;      server-port    9999)
;(defun server-start-and-copy ()
;  (server-start)
;  (copy-file "~/.emacs.d/server/server" "/wpsb:.emacs.d/server/server" t))
;(add-hook 'emacs-startup-hook 'server-start-and-copy)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Simplenote Sync

;(add-to-list 'load-path "~/.etc/elisp/simplenote.el")
;(require 'simplenote)
;(setq simplenote-email "blah")
;(setq simplenote-password "blah")
;(simplenote-setup)
;
;
;(global-set-key (kbd "C-x C-g") (lambda ()
;        (interactive)
;        (simplenote-pull-buffer)
;        (org-overview)
;        (beginning-of-buffer)))
;
;(global-set-key (kbd "C-x C-t") (lambda ()
;        (interactive)
;        (simplenote-push-buffer)))

; create a new command to pull/push
; need a simplenote-pull, and then go to the overview/beginning of the file


;; (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;All Tabs all the time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn on tabs everywhere
(setq default-tab-width 2)
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(setq js-indent-level 2)
(setq c-basic-offset 2)
(setq c-basic-indent 2)
(setq tab-width 2)
(setq cperl-indent-level 2)
(setq c-indent-level 2)

;; sometimes you need to turn on tabs when loading the mode
(add-hook 'php-mode-hook 'tab-set-mode-hook)
(defun tab-set-mode-hook ()
  (setq default-tab-width 2)
  (setq indent-tabs-mode t)
  (setq-default indent-tabs-mode t)
  (setq js-indent-level 2)
  (setq c-basic-offset 2)
  (setq c-basic-indent 2)
  (setq tab-width 2)
  (setq cperl-indent-level 2)
  (setq c-indent-level 2))

;; Remove trailing whitespace
; (remove-hook 'before-save-hook 'delete-trailing-whitespace)

;; Bind the TAB key
(global-set-key (kbd "TAB") 'self-insert-command)


;;;;;;;;;;;;;;;;;;;;;
; Config Automattic Login

; useful locations
(setenv "wpcom" "/wpsb:/home/wpcom/public_html")
(setenv "pdsp" "/pdsb:/home/pd/")
(setenv "mc" "/wpsb:/home/missioncontrol/public_html")
(setenv "pit" "/wpsb:/home/wpcom/the-pit-of-despair")
(setenv "wpsb" "/wpsb:/home/wpcom")

;hacky workaround
; for https://lists.gnu.org/archive/html/help-gnu-emacs/2014-06/msg00207.html
(setq save-interprogram-paste-before-kill nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a8c grok

(require-maybe 'grok)
(eval-after-load "grok"
		 '(progn
				(require 'socks)

				;; wpdev-abbe-wpcom - SSH hostname corresponding to wpdev@sandbox in $HOME/.ssh/config
				(setq opengrok-repo-fs-map '(("trunk" . "/wpsb:public_html/")
																		 ("mc" . "/wpsb:/home/missioncontrol/public_html/")
																		 ("vip" . "/wpsb:public_html/wp-content/themes/vip/")))

				;; Advices to activate/deactivate SOCKS proxy before/after function invocation
				(defadvice opengrok-search (before opengrok-search-use-proxy first)
					(setq opengrok-url-gateway-method url-gateway-method
								opengrok-socks-server socks-server
								url-gateway-method 'socks
								socks-server '("Default server" "localhost" 8080 5)))

				(defadvice opengrok-search (after opengrok-search-unuse-proxy first)
					(setq url-gateway-method opengrok-url-gateway-method
								socks-server opengrok-socks-server))

				(defadvice opengrok-search-1 (before opengrok-search-1-use-proxy first)
					(setq opengrok-url-gateway-method url-gateway-method
								opengrok-socks-server socks-server
								url-gateway-method 'socks
								socks-server '("Default server" "localhost" 8080 5)))

				(defadvice opengrok-search-1 (after opengrok-search-1-unuse-proxy first)
					(setq url-gateway-method opengrok-url-gateway-method
								socks-server opengrok-socks-server))

				(ad-activate 'opengrok-search)
				(ad-activate 'opengrok-search-1)))

;(require 'grok)
;(setq opengrok-repo-fs-map '(("trunk" . "/wpsb:/home/wpcom/public_html/")
;									("mc" . "/wpsb:/home/missioncontrol/public_html")
;									("vip" . "/wpsb:/home/wpcom/public_html/wp-content/themes/vip/")))


;;;;;;;;;;;;;;;;;;;;;
;;Org Setup

;required to activate
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; org-mode buffers only

;gtd file organization
(setq org-agenda-files
      (list "~/notes/gtd_work.org"))

(setq org-enforce-todo-dependencies t)

;fast access to gtd file - M-x gtd
(defun gtd ()
   (interactive)
   (find-file "~/notes/gtd_work.org")
 )

;custom agenda settings
(setq org-agenda-custom-commands
           '(("h" "Tasks"
              ((todo "DONE")
               (todo "ERRAND")
               (todo "TODAY")
               (todo "TOMORROW")
               (todo "SOON")))
             ("d" todo-tree "DONE")
             ("s" todo-tree "SOON")
             ("p" todo-tree "PUNT")
             ("l" todo-tree "LATER")))

; I prefer return to activate a link
(setq org-return-follows-link t)


; EasyPG setup for file encryption
;;(add-to-list 'load-path "~/.etc/epg/")
;;(require 'epa-setup)
;;(epa-file-enable)
(setq exec-path (append exec-path '("/usr/local/bin")))
(require 'epa-file)
(epa-file-enable)

;load php mode
;(require 'php-mode)

;journal code
(defun insert-date (format)
  (interactive "*")
  (insert (format-time-string format
                              (current-time))))
(defun srch-date (format)
  (search-forward
   (format-time-string format (current-time))
   nil
   t))

(defun journal ()
  (interactive)
  (find-file "~/notes/journal.org.gpg")
  (auto-fill-mode)
  (goto-line 1)
  (org-cycle '(4))
  (cond ((srch-date "* %Y")
         (org-cycle)
         (cond ((srch-date "** %B") (org-cycle) (end-of-buffer))
               (t (end-of-buffer) (insert "\n** ") (insert-date "%B"))))
        (t (end-of-buffer)
           (insert "\n* ")
           (insert-date "%Y")
           (insert "\n** ")
           (insert-date "%B")))
  (insert "\n*** ")
  (insert-date "%A, %B %e, %Y %H:%M")
  (insert "\n")
)

;MobileOrg syncing
;; Set to the location of your Org files on your local system
(setq org-directory "~/notes")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/notes/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(defun org-mobile-pullpush nil nil (org-mobile-pull)
                                    (org-mobile-push))

;run pushpull every hour
; (run-at-time "00:59" 86400 'org-mobile-pullpush)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Enable random quotes during idle times
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'random-idle-quote)
(random-idle-quote)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code Editing Hacks

; delete selections
(setq delete-active-region t)
(setq delete-selection-mode t)
(setq-default delete-selection-mode t)


(require 'linum)

(setq scroll-step 1)

;count words function
(defun count-words (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))

;; Spaces to Tabs
(defun tabify-buffer ()
  "Tabify the whole (accessible part of the) current buffer"
  (interactive)
  (save-excursion
    (tabify (point-min) (point-max))))

;imenu!
;(add-hook 'my-mode-hook 'imenu-add-menubar-index)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Lang specific changes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Load Scala Mode
(add-to-list 'load-path "/Users/gbrown/.etc/scala-mode")
(require-maybe 'scala-mode-auto)


(provide 'init-local)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; IDO imenu command
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
 
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
 
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
 
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))
