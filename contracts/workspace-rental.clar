;; STX Workspace Rentals Smart Contract

;; This Clarity smart contract implements a decentralized workspace rental system.
;; Users can list workspaces for rent, reserve available spaces, and process payments.
;; The contract is structured to allow platform owners to set global parameters like pricing,
;; commission rates, refund policies, and reservation limits, while providing users 
;; with the ability to rent and manage their reservations.

;; Define constants
(define-constant platform-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-enough-space (err u101))
(define-constant err-reservation-failed (err u102))
(define-constant err-invalid-price (err u103))
(define-constant err-invalid-duration (err u104))
(define-constant err-invalid-fee (err u105))
(define-constant err-refund-failed (err u106))
(define-constant err-same-user (err u107))
(define-constant err-reservation-limit-exceeded (err u108))
(define-constant err-invalid-reservation-limit (err u109))

;; Define data variables
(define-data-var workspace-price uint u500) ;; Price per hour in microstacks (1 STX = 1,000,000 microstacks)
(define-data-var max-reservation-per-user uint u100) ;; Maximum hours a user can reserve
(define-data-var commission-rate uint u5) ;; Commission rate in percentage (e.g., 5 means 5%)
(define-data-var refund-rate uint u90) ;; Refund rate in percentage (e.g., 90 means 90% of current price)
(define-data-var workspace-reservation-limit uint u10000) ;; Global reservation limit (in hours)
(define-data-var current-reserved-space uint u0) ;; Current total reserved space (in hours)

;; Define data maps
(define-map user-reservation-balance principal uint)
(define-map user-stx-balance principal uint)
(define-map workspace-for-rent {user: principal} {hours: uint, price: uint})

;; Private functions

;; Calculate commission
(define-private (calculate-commission (amount uint))
  (/ (* amount (var-get commission-rate)) u100))

;; Calculate refund amount
(define-private (calculate-refund (amount uint))
  (/ (* amount (var-get workspace-price) (var-get refund-rate)) u100))

;; Update workspace reservation
(define-private (update-workspace-reservation (hours int))
  (let (
    (current-reservation (var-get current-reserved-space))
    (new-reservation (if (< hours 0)
                         (if (>= current-reservation (to-uint (- 0 hours)))
                             (- current-reservation (to-uint (- 0 hours)))
                             u0)
                         (+ current-reservation (to-uint hours))))
  )
    (asserts! (<= new-reservation (var-get workspace-reservation-limit)) err-reservation-limit-exceeded)
    (var-set current-reserved-space new-reservation)
    (ok true)))
