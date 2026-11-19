// -----------------------------------------------------------------------------
// IEEE 754 single-precision bit ayristirici ve sinif belirleyici
// Alanlar: [31] isaret, [30:23] us, [22:0] kesir
// -----------------------------------------------------------------------------
module hafta9 (
    input  logic [31:0] sayi,

    output logic        isaret,
    output logic [7:0]  us,
    output logic [22:0] kesir,

    output logic        sifir,
    output logic        denormal,
    output logic        normal,
    output logic        sonsuz,
    output logic        nan
);

    typedef enum logic [2:0] {
        SINIF_SIFIR    = 3'd0,
        SINIF_DENORMAL = 3'd1,
        SINIF_NORMAL   = 3'd2,
        SINIF_SONSUZ   = 3'd3,
        SINIF_NAN      = 3'd4
    } sinif_t;

    sinif_t sinif;

    // Alanlari ayir
    always_comb begin
        {isaret, us, kesir} = sayi;
    end

    // Sinifi belirle (us ve kesir degerine gore)
    always_comb begin
        if (us == 8'h00)
            begin
            if (|kesir) sinif = SINIF_DENORMAL;
            else        sinif = SINIF_SIFIR;
        end
        else if (&us)
            begin
            if (|kesir) sinif = SINIF_NAN;
            else        sinif = SINIF_SONSUZ;
        end
        else
            sinif = SINIF_NORMAL;
    end

    // Siniftan cikis bayraklarini uret
    always_comb begin
        sifir    = (sinif == SINIF_SIFIR);
        denormal = (sinif == SINIF_DENORMAL);
        normal   = (sinif == SINIF_NORMAL);
        sonsuz   = (sinif == SINIF_SONSUZ);
        nan      = (sinif == SINIF_NAN);
    end

endmodule
