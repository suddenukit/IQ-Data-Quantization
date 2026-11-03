%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decompression of raw channel IQ data based on uniform quantization
% Author(s): Daler Rakhmatov (daler@ece.uvic.ca)
% Date: 19 August 2024, University of Victoria
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[IQ] = f_quantDecompress_IQ_RI(IQ_code,IQ_pilot,codebook)

[Nt,Nx,Na] = size(IQ_code.real);

%-- simulate dequantization
IQ = zeros(Nt,Nx,Na);
for ia = 1:Na
    for it = 1:Nt
        indR = single(squeeze(IQ_code.real(it,:,ia))) + 1;
        indI = single(squeeze(IQ_code.imag(it,:,ia))) + 1;
        
        r  = single(IQ_pilot(it,ia)) * codebook(indR);
        im = single(IQ_pilot(it,ia)) * codebook(indI);
        IQ(it,:,ia) = complex(r, im);
    end
end

end