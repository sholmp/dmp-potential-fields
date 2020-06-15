function vdes_fiddled = fiddle_vdes(Vdes)

    Vdes(abs(Vdes) < 0.001) = 0;
    vdes_fiddled = Vdes;
    
end

