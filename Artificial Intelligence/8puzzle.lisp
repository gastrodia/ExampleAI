; Reyes Fragoso Roberto
(defparameter *fronteraDeBusqueda* '())
(defparameter *memoria* '())

;Definicion de Operadores, los definimos como nil por que cada operador es
; diferente dependiendo de la casilla en blanco
(defparameter *operadores* '((:Arriba nil)
                             (:Abajo nil)
                             (:Izquierda nil)
                             (:Derecha nil)))

;Definicion de parametros para el problema
(defparameter *id* 0)
(defparameter *ancestro* nil)
(defparameter *solucion* nil)


;Contadores para poder saber como fue nuestra solucion
(defparameter *contadorNodos* 0)
(defparameter *contadorExpandir* 0)
(defparameter *contadorFronteraBusqueda* 0)
(defparameter *tiempoFinal* 0)
(defparameter *tiempoFinal* 0)

;[Validacion] Nos permite saber en donde esta el 0
(defun dondeEstaEspacioEnBlanco (estado)
  (let*((filaDelEspacioEnBlanco 0)
        (casillaDelEspacioEnBlanco 0))
    (dolist (fila estado filaDelEspacioEnBlanco)
    (if (or (zerop(first fila)) (zerop(second fila)) (zerop(third fila)))
        (cond ((zerop (first fila)) (return (list
                                             filaDelEspacioEnBlanco
                                             casillaDelEspacioEnBlanco)))
              ((zerop (second fila)) (return (list
                                              filaDelEspacioEnBlanco
                                              (setq casillaDelEspacioEnBlanco (1+ casillaDelEspacioEnBlanco)))))
              (T (return (list
                          filaDelEspacioEnBlanco
                          (setq casillaDelEspacioEnBlanco (+ 2 casillaDelEspacioEnBlanco)))))))
        (setq filaDelEspacioEnBlanco (1+ filaDelEspacioEnBlanco)))))

;[Operador] Aplicamos el operador Arriba
(defun operadorArriba (operador estado)
  (let* ((filaDelEspacioEnBlanco (first(dondeEstaEspacioEnBlanco estado)))
         (elementoDelEspacioEnBlanco (second(dondeEstaEspacioEnBlanco estado)))
         (filaACambiarPorEspacio (nth (1- filaDelEspacioEnBlanco) estado))
         (elementoACambiarPorEspacio (nth elementoDelEspacioEnBlanco filaACambiarPorEspacio))
         (filaACambiarSinEspacio (nth filaDelEspacioEnBlanco estado)))

    (if (= filaDelEspacioEnBlanco 2)
        (list (first estado)
              (substitute 0 elementoACambiarPorEspacio filaACambiarPorEspacio)
              (substitute elementoACambiarPorEspacio 0 filaACambiarSinEspacio))
        (list (substitute 0 elementoACambiarPorEspacio filaACambiarPorEspacio)
              (substitute elementoACambiarPorEspacio 0 filaACambiarSinEspacio)
              (third estado)))))

;[Operador] Aplicamos el operador Abajo
(defun operadorAbajo (operador estado)
  (let* ((filaDelEspacioEnBlanco (first(dondeEstaEspacioEnBlanco estado)))
         (elementoDelEspacioEnBlanco (second(dondeEstaEspacioEnBlanco estado)))
         (filaACambiarPorEspacio (nth (1+ filaDelEspacioEnBlanco) estado))
         (elementoACambiarPorEspacio (nth elementoDelEspacioEnBlanco filaACambiarPorEspacio))
         (filaACambiarSinEspacio (nth filaDelEspacioEnBlanco estado)))

    (if (= filaDelEspacioEnBlanco 0)
        (list (substitute elementoACambiarPorEspacio 0 filaACambiarSinEspacio)
              (substitute 0 elementoACambiarPorEspacio filaACambiarPorEspacio)
              (third estado))
        (list (first estado)
              (substitute elementoACambiarPorEspacio 0 filaACambiarSinEspacio)
              (substitute 0 elementoACambiarPorEspacio filaACambiarPorEspacio)))))

;[Operador] Aplicamos el operador Izquierda
(defun operadorDerecha (operador estado)
  (let* ((filaDelEspacioEnBlanco (first(dondeEstaEspacioEnBlanco estado)))
         (elementoDelEspacioEnBlanco (second(dondeEstaEspacioEnBlanco estado)))
         (filaACambiarPorEspacio (nth filaDelEspacioEnBlanco estado))
         (elementoACambiarPorEspacio (nth (1+ elementoDelEspacioEnBlanco) filaACambiarPorEspacio)))

    (format  t  "Esto es el primero~A%" (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio))
    (format  t  "Esto es el segundo~A%" (substitute 0 elementoACambiarPorEspacio
                                                    (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 :from-end t))

    (cond ((= filaDelEspacioEnBlanco 0)
           (list (substitute 0 elementoACambiarPorEspacio
                             (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 :from-end t)
                 (second estado)
                 (third estado)))
          ((= filaDelEspacioEnBlanco 1)
           (list (first estado)
                 (substitute 0 elementoACambiarPorEspacio
                             (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 :from-end t)
                 (third estado)))
          (T (list (first estado)
                   (second estado)
                   (substitute 0 elementoACambiarPorEspacio
                               (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 :from-end t))))))

;[Operador] Aplicamos el operador Izquierdo
(defun operadorIzquierda (operador estado)
  (let* ((filaDelEspacioEnBlanco (first(dondeEstaEspacioEnBlanco estado)))
         (elementoDelEspacioEnBlanco (second(dondeEstaEspacioEnBlanco estado)))
         (filaACambiarPorEspacio (nth filaDelEspacioEnBlanco estado))
         (elementoACambiarPorEspacio (nth (1- elementoDelEspacioEnBlanco) filaACambiarPorEspacio)))

    (format  t  "Esto es el primero~A%" (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio))
    (format  t  "Esto es el segundo~A%" (substitute 0 elementoACambiarPorEspacio
                                                    (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1))

    (cond ((= filaDelEspacioEnBlanco 0)
           (list (substitute 0 elementoACambiarPorEspacio
                             (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 )
                 (second estado)
                 (third estado)))
          ((= filaDelEspacioEnBlanco 1)
           (list (first estado)
                 (substitute 0 elementoACambiarPorEspacio
                             (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1)
                 (third estado)))
          (T (list (first estado)
                   (second estado)
                   (substitute 0 elementoACambiarPorEspacio
                               (substitute elementoACambiarPorEspacio 0 filaACambiarPorEspacio ) :count 1 ))))))

;[Validacion] Nos permite saber si el operador arriba se puede aplicar
(defun operadorValido? (operador estado)
  (let* ((filaDelEspacioEnBlanco (first(dondeEstaEspacioEnBlanco estado)))
         (casillaDelEspacioEnBlanco (second(dondeEstaEspacioEnBlanco estado))))
    (cond ((equal operador :Arriba) (if(= filaDelEspacioEnBlanco 0) nil T))
          ((equal operador :Abajo) (if (= filaDelEspacioEnBlanco 2) nil T))
          ((equal operador :Izquierda) (if (= casillaDelEspacioEnBlanco 0) nil T))
          (T (if (= casillaDelEspacioEnBlanco 2) nil T)))))

;[Operador] Aplicamos los diferentes Operadores
(defun aplicaOperador (operador estado))

(dondeEstaEspacioEnBlanco '((1 2 1)(1 5 2 )(7 1 0)))
(operadorIzquierda 0 '((1 2 2)(2 0 3)(7 10 8)))
(substitute 'xx 2 '(0 2 3))
(operadorValido? :Izquierda '((1 2 1)(1 0 1)(1 1 1))) 









