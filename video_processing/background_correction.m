function traces_corrected = background_correction(traces,pixel_sum_radius,bg,frames)
    %subtracts background accumulated over pixel_sum_radius square    
    traces_corrected = double(traces(:,frames)) - double(((2*pixel_sum_radius+1)^2*bg));
end