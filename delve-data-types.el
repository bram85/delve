;;; delve-data-types.el --- data types for the delve tool  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  

;; Author:  <joerg@joergvolbers.de>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Defines same basic types for the delve zettelkasten explorer.

;;; Code:

(require 'cl-lib)

;;; * Root object, for displaying additional info

(cl-defstruct (delve-basis (:constructor delve-make-basis))
  details)

;;; * Item data types
;;; Every data type has to include delve-basis.

(cl-defstruct (delve-tag (:constructor delve-make-tag)
			 (:include delve-basis))
  tag
  count)

(cl-defstruct (delve-zettel (:constructor delve-make-zettel)
			    (:include delve-basis))
  needs-update
  title
  file
  tags
  mtime
  atime
  backlinks
  tolinks)

(cl-defstruct (delve-page
	       (:constructor delve-make-page)
	       (:include delve-zettel)))

(cl-defstruct (delve-tolink 
	       (:constructor delve-make-tolink)
	       (:include delve-zettel)))

(cl-defstruct (delve-backlink
	       (:constructor delve-make-backlink)
	       (:include delve-zettel)))

;;; * Searches
;;; Every search type has to include delve-basis.

(cl-defstruct (delve-generic-search (:constructor delve-make-generic-search)
				    (:include delve-basis))
  name
  with-clause
  constraint
  args
  postprocess
  result-makefn)

(cl-defstruct (delve-page-search
	       (:constructor delve-make-page-search)
	       (:include delve-generic-search
			 (result-makefn 'delve-make-page))))

;;; * Info items

;; These items do not descend from delve-basis, since they are
;; intended to be used for the display of details

;;; Database Error Messages

(cl-defstruct (delve-error
               (:constructor delve-make-error))
  message
  buffer)

(provide 'delve-data-types)
;;; delve-data-types.el ends here
