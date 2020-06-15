function [J, Vdes] = applyMask(mask, J, Vdes)
    for i = 6:-1:1
        if ~mask(i)
            J(i,:) = [];
            Vdes(i,:) = [];
        end
    end
end