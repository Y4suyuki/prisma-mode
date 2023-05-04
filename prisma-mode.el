;;; prisma-mode.el --- Major mode for editing prisma files.

;; Copyright (C) 2023 Ageishi Yasuyuki

;; Author: Yasuyuki Ageishi
;; URL: https://github.com/y4suyuki/prisma-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "28.4"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; extend the builtin js-mode's syntax highlighting

;;; Code:

(defgroup prisma-mode '()
  "Major mode for editing prisma files."
  :group 'languages)

(defconst prisma-mode-standard-file-ext '(".prisma")
  "List of prisma file extensions.")

(defcustom prisma-indent-offset 2
  "Indent prisma code by this number of spaces."
  :type 'integer
  :group 'prisma-mode
  :safe #'integerp)

(defvar prisma-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; Define syntax rules
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\( "()" table)
    (modify-syntax-entry ?\) ")(" table)
    (modify-syntax-entry ?\; "." table)
    (modify-syntax-entry ?\[ "(]" table)
    (modify-syntax-entry ?\] ")[" table)
    (modify-syntax-entry ?\{ "(}" table)
    (modify-syntax-entry ?\} "){" table)
    (modify-syntax-entry ?# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?\n "> b" table)
    table))

(defvar prisma-mode-highlights
  '(("\\b\\(model\\|enum\\|type\\|datasource\\|generator\\|enum\\|input\\|scalar\\|true\\|false\\)\\b" . font-lock-type-face)
    ("\\b\\(if\\|else\\|let\\|in\\|for\\|of\\)\\b" . font-lock-keyword-face)
    ("\\b\\(Int\\|String\\|Boolean\\|DateTime\\|Float\\)\\b" . font-lock-builtin-face)
    ("\\b\\(create\\|update\\|delete\\|select\\|from\\|where\\|asc\\|desc\\)\\b" . font-lock-function-name-face)
    ("\"[^\"]+\"" . font-lock-string-face)
    ("'[^']+'" . font-lock-string-face)))

(defsubst prisma-mode--update-auto-mode ()
  "Update the `prisma-mode' entry of `auto-mode-alist'."
  (let ((new-entry (cons "\\.prisma$" 'prisma-mode)))
    (add-to-list 'auto-mode-alist new-entry)
    new-entry))

(defvar prisma-mode--auto-mode-entry (prisma-mode--update-auto-mode)
  "Regexp generated from the `prisma-mode-auto-mode-list'.")

;;;###autoload
(define-derived-mode prisma-mode prog-mode "Prisma"
  "Major mode for editing Prisma files."
  :syntax-table prisma-mode-syntax-table
  (setq font-lock-defaults '(prisma-mode-highlights)))

(provide 'prisma-mode)
;;; prisma-mode.el ends here
