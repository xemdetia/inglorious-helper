;;; xemdetia
;;; inglorious-mode elisp

;;; User options
(defvar inglorious-mode-debug nil
  "*If t then all messages passed to the build process are
  written to a buffer called *inglorious-mode-debug* which should
  provide enough information about the comings and goings of data
  between the frontend and backend. Standard errors will be
  written to *Messages* as expected.")

;;; Port Default Settings
(defvar inglorious-mode-default-host "127.0.0.1"
  "Default host to try and connect to, generally should be mapped
  to your representation of localhost.")
(defvar inglorious-mode-default-port 1955
  "Default port to try and connect to, the general port is 1955.")

(defun inglorious-mode-get-debug-buffer ()
  "If inglorious-mode-debug is not t, then this function returns nil.

   If inglorious-mode-debug is t, then get the buffer
   *inglorious-mode-debug* unless it does not exist. If it does
   not exist then create it and return that."
  
  (if inglorious-mode-debug
      (get-buffer-create "*inglorious-mode-debug*")
    nil))

;;; Internal Variables
(defvar inglorious-mode-stream nil
  "Represents the socket for the server connection. Use
  inglorious-mode-connect to set this value.")

(defun inglorious-mode-connect (host port)
  "Using the given host and port connect to a foreign
  inglorious-helper instance. If either host or port is nil they use
  the respective variables inglorious-mode-default-host and
  inglorious-mode-default-port.

  When this function succeeds the variable inglorious-mode-stream
  is set to a socket and this function returns t, if there is a
  failure of any kind this function returns nil and
  inglorious-mode-stream should also be nil.

  If there is an existing connection in inglorious-mode-stream
  close it and then open a new one. This function is designed to
  be called when starting a new project/connection."

  (let* ((hostv (if host
		    host
		  inglorious-mode-default-host))
	 (portv (if port
		    port
		  inglorious-mode-default-host)))
    (open-network-stream "inglorious-mode-tcp-stream" (inglorious-mode-get-debug-buffer) hostv portv)))

(inglorious-mode-connect nil nil)
		

  
  
  
  