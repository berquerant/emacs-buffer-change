;;; buffer-change.el --- buffer-change hook -*- lexical-binding: t -*-

;; Author: berquerant
;; Maintainer: berquerant
;; Created: 11 Feb 2026
;; Version: 0.1.0
;; Keywords: buffer hook
;; URL: https://github.com/berquerant/emacs-buffer-change

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Buffer-Change provides a hook run after buffer changed.
;;
;; To enable Buffer-Change,
;;
;;   (require 'buffer-change)
;;   (add-hook 'buffer-change-hook #'some-func)
;;   (buffer-change-setup)

;;; Code:

(defvar buffer-change--last-buffer nil)

(defun buffer-change--buffer-changed? ()
  (not (eq (current-buffer) buffer-change--last-buffer)))

(defun buffer-change--save-current-buffer ()
  (setq buffer-change--last-buffer (current-buffer)))

(defvar buffer-change-hook nil
  "A hook run after buffer changed.")

(defvar buffer-change--running nil
  "A guard to prevent re-entrant calls to `buffer-change--run-hook'.")

(defun buffer-change--run-hook ()
  (unless buffer-change--running
    (let ((buffer-change--running t))
      (when (buffer-change--buffer-changed?)
        (buffer-change--save-current-buffer)
        (run-hooks 'buffer-change-hook)))))

(defun buffer-change-setup ()
  "Setup `buffer-change'."
  (add-hook 'post-command-hook 'buffer-change--run-hook))

(provide 'buffer-change)
;;; buffer-change.el ends here
