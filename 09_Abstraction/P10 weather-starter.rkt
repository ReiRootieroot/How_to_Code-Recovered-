;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P10 weather-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require racket/file)

;; weather-starter.rkt

(define-struct weather (date max-tmp avg-tmp min-tmp rain snow precip))
;; Weather is (make-weather String Number Number Number Number Number Number)
;; interp. Data about weather in Vancouver on some date 
;; (make-weather date xt at nt r s p) means that
;; on the day indicated by date:
;; - the maximum temperature in Celsius was xt 
;; - the average temperature in Celsius was at
;; - the minimum temperature in Celsius was nt
;; - r millimeters of rain fell
;; - s millimeters of snow fell
;; - p millimeters of total precipitation fell

(define W0 (make-weather "7/2/88" 21.9 17.7 13.4 0.2 0 0.2))
(define LOW1 (list (make-weather "7/2/88" 21.9 17.7 13.4 0.2 0 0.2)
                 (make-weather "7/2/88" 21.9 0 16 0.2 0 0.2)))

(define (fn-for-weather w)
  (... (weather-date w)
       (weather-max-tmp w)
       (weather-avg-tmp w)
       (weather-min-tmp w)
       (weather-rain w)
       (weather-snow w)
       (weather-precip w)))


; PROBLEM:
; 
; Complete the design of a function that takes a list of weather data
; and produces the sum total of rainfall in millimeters on days where
; the average temperature was greater than 15 degrees Celsius.
; 
; The function that you design must make at least one call to 
; built-in abstract functions (there is a very nice solution that
; composes calls to three built-in abstract functions).




;  If you would like to use the real daily weather data from Vancouver
;  from 10/3/1987 to 10/24/2013, 
;  place the weather.ss file in your current directory and uncomment
;  the following definition and add the given check-expect to your
;  examples.
; 
; (define WEATHER-DATA 
;   (local [(define (data->weather d)
;             (make-weather (first d) (second d) (third d) (fourth d)
;                           (fifth d) (sixth d) (seventh d)))]
;     (map data->weather (file->value "weather.ss"))))
; 
; (check-expect (total-warm-rain WEATHER-DATA) 2545.3)
; 


;; (listOf Weather) -> Number
;; produce the total rainfall in millimeters of days with > 15 C average temp.
;; !!!
;;(define (total-warm-rain low) 0)

(define WEATHER-DATA 
  (local [(define (data->weather d)
            (make-weather (first d) (second d) (third d) (fourth d)
                          (fifth d) (sixth d) (seventh d)))]
    (map data->weather (file->value "P10 weather.ss"))))

(check-expect (total-warm-rain LOW1) 0.2)
(check-expect (total-warm-rain WEATHER-DATA) 2545.3)
;; foldr (sum all rain)
;;   map (get weather rain)
;;    filter (weather avg temp > 15)

(define (total-warm-rain low)
  (local [(define (pred w) (> (weather-avg-tmp w) 15))]
    (foldr + 0
           (map weather-rain
                (filter pred low)
           )
    )
  )
)

;; ABSTRACTION FUNCTION CREATION PRACTICE
;; ----------------------------------------------

(check-expect (filter-me (local [
                                 (define (pred w) (> (weather-avg-tmp w) 15))
                                ]
                           pred)
                         LOW1)
              (list (make-weather "7/2/88" 21.9 17.7 13.4 0.2 0 0.2)))

(check-expect (map-me (local [
                              (define (pred w) (weather-avg-tmp w))
                             ]
                           pred)
                         LOW1)
              (list 17.7 0))

(check-expect (foldr-me + 0 (list 17.7 0)) (+ 17.7 0))

(define (filter-me fn low)
  (cond [(empty? low) empty]
        [else
         (if (fn (first low))
             (cons (first low) (filter-me fn (rest low)))
             (filter-me fn (rest low))    
         )
        ]
  )
)

(define (map-me fn low)
  (cond [(empty? low) empty]
        [else
         (cons (fn (first low)) (map-me fn (rest low)))
        ]
  )
)

(define (foldr-me fn base low)
  (cond [(empty? low) 0]
        [else
         (fn (first low) base (foldr-me fn base (rest low)))
        ]
  )
)

;; FINAL ABSTRACTION FUNCTION USING ABOVE FN'S
;; ----------------------------------------------------------
(check-expect (total-warm-rain-me LOW1) 0.2)
(check-expect (total-warm-rain-me WEATHER-DATA) 2545.3)
;; foldr (sum all rain)
;;   map (get weather rain)
;;    filter (weather avg temp > 15)

(define (total-warm-rain-me low)
  (local [(define (pred w) (> (weather-avg-tmp w) 15))]
    (foldr-me + 0
           (map-me weather-rain
                (filter-me pred low)
           )
    )
  )
)
