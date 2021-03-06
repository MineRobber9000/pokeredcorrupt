; Corrupts a random WRAM address.
; Takes no arguments.
CorruptMemory::
	ld a,[wCorruptionFlag]
	and a
	ret z			; if wCorruptionFlag == 0, return
	call Random 		; get lower byte
	and $1e			; confine to $c0-$de
	add $c0
	ld h,a
	ld a,[hRandomSub]
	ld l,a			; now hl is a random address $c000 - $deff (chosen because otherwise we risk corrupting the stack)
;	call Random		; waste a random number of cycles (to make next random number more random)
;	and $1f
;.loop	dec a
;	jr nz,.loop
	call Random		; get a random value
	ld [hl], a		; store it in a random location
	ret			; return
