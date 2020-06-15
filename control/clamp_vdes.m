function vdes_clamped = clamp_vdes(Vdes, max_norm)  
    if norm(Vdes) > max_norm
        vdes_clamped = (Vdes / norm(Vdes)) * max_norm;
    else
        vdes_clamped = Vdes;
    end
end