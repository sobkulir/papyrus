PROGRAM TEST14_FORTRAN
    USE MPI
    USE PAPYRUS
    IMPLICIT NONE
    
    INTEGER :: RANK, NRANKS, IERROR, PROVIDED, PEER, DB
    CHARACTER, DIMENSION(4) :: KEY * 32
    CHARACTER, DIMENSION(4) :: VAL * 256
    CHARACTER, POINTER :: VAL1(:)
    CHARACTER, POINTER :: VAL2(:)
    INTEGER(KIND=8) :: KEYLEN, VALLEN

    CALL MPI_INIT_THREAD(MPI_THREAD_MULTIPLE, PROVIDED, IERROR)
    CALL PAPYRUSKV_INIT('./pkv_repo', IERROR)
    IF (IERROR /= PAPYRUSKV_OK) THEN
        PRINT*, 'FAILED'
    ENDIF
    CALL MPI_COMM_RANK(MPI_COMM_WORLD, RANK, IERROR)
    CALL MPI_COMM_SIZE(MPI_COMM_WORLD, NRANKS, IERROR)

    KEY(1) = 'GOOGLE'
    KEY(2) = 'FACEBOOK'
    KEY(3) = 'TWITTER'
    KEY(4) = 'PAPYRUS'

    VAL(1) = 'https://google.com'
    VAL(2) = 'https://facebook.com'
    VAL(3) = 'https://twitter.com'
    VAL(4) = 'https://code.ornl.gov/eck/papyrus'

    ALLOCATE(VAL1(256))
    NULLIFY(VAL2)

    IF (RANK == NRANKS - 1) THEN
        PEER = 0
    ELSE
        PEER = RANK + 1
    ENDIF

    CALL PAPYRUSKV_OPEN('TEST_DB', IOR(PAPYRUSKV_CREATE, PAPYRUSKV_RDWR), DB, IERROR)
    IF (IERROR /= PAPYRUSKV_OK) THEN
        PRINT*, 'FAILED'
    ENDIF

    IF (RANK < SIZE(KEY)) THEN
        PRINT*, 'PUT --> RANK', RANK, 'KEY:', TRIM(KEY(RANK + 1)), ' VAL:', TRIM(VAL(RANK + 1))
        KEYLEN = LEN(TRIM(KEY(RANK + 1)), KIND = 8)
        VALLEN = LEN(TRIM(VAL(RANK + 1)), KIND = 8)
        CALL PAPYRUSKV_PUT(DB, TRIM(KEY(RANK + 1)), KEYLEN, TRIM(VAL(RANK + 1)), VALLEN, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
    END IF

    CALL PAPYRUSKV_BARRIER(DB, PAPYRUSKV_MEMTABLE, IERROR)
    IF (IERROR /= PAPYRUSKV_OK) THEN
        PRINT*, 'FAILED'
    ENDIF

    IF (RANK < SIZE(KEY)) THEN
        CALL PAPYRUSKV_GET(DB, TRIM(KEY(RANK + 1)), KEYLEN, VAL1, VALLEN, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
        PRINT*, 'GET--> RANK', RANK, 'KEY:', TRIM(KEY(RANK + 1)), ' VAL:', VAL1(1: VALLEN)

        CALL PAPYRUSKV_GET(DB, TRIM(KEY(RANK + 1)), KEYLEN, VAL2, VALLEN, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
        PRINT*, 'GET--> RANK', RANK, 'KEY:', TRIM(KEY(RANK + 1)), ' VAL:', VAL2(1: VALLEN)
        CALL PAPYRUSKV_FREE(VAL2, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF

        KEYLEN = LEN(TRIM(KEY(PEER + 1)), KIND = 8)
        CALL PAPYRUSKV_GET(DB, TRIM(KEY(PEER + 1)), KEYLEN, VAL1, VALLEN, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
        PRINT*, 'GET--> RANK', RANK, 'KEY:', TRIM(KEY(PEER + 1)), ' VAL:', VAL1(1: VALLEN)
        
        KEYLEN = LEN(TRIM(KEY(PEER + 1)), KIND = 8)
        CALL PAPYRUSKV_GET(DB, TRIM(KEY(PEER + 1)), KEYLEN, VAL2, VALLEN, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
        PRINT*, 'GET--> RANK', RANK, 'KEY:', TRIM(KEY(PEER + 1)), ' VAL:', VAL2(1: VALLEN)
        CALL PAPYRUSKV_FREE(VAL2, IERROR)
        IF (IERROR /= PAPYRUSKV_OK) THEN
            PRINT*, 'FAILED'
        ENDIF
    END IF

    CALL PAPYRUSKV_CLOSE(DB, IERROR)
    IF (IERROR /= PAPYRUSKV_OK) THEN
        PRINT*, 'FAILED'
    ENDIF

    DEALLOCATE(VAL1)

    CALL PAPYRUSKV_FINALIZE(IERROR)
    IF (IERROR /= PAPYRUSKV_OK) THEN
        PRINT*, 'FAILED'
    ENDIF
    CALL MPI_FINALIZE(IERROR)
END PROGRAM TEST14_FORTRAN
