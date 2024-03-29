% Measure the mutual information of some LLRs using the histogram method
% Created by Dr. Khoirul Anwar
% JAIST
% December 17, 2008
% (A revised version of Robert G. Maunder)

function mutual_information = measure_MI_histogram(llrs, bits)
 
	bit_1_count = sum(bits);
	bit_0_count = length(bits) - bit_1_count;		
	if(bit_0_count == 0 || bit_1_count == 0)
        mutual_information = 0.0;
	else
	
    	llr_0_noninfinite_count = 0; % start count for bit 0
    	llr_1_noninfinite_count = 0; % start count for bit 1
    	llr_0_max = -Inf; % it is safe to start the max from the minimum
    	llr_0_min = Inf; % it is safe to start the min from the maximum
        llr_1_max = -Inf;  
    	llr_1_min = Inf;	
        % searching the highest LLRs for bit 0 and bit 1
        for bit_index = 1:length(bits)
            if(llrs(bit_index) ~= -Inf && llrs(bit_index) ~= Inf)
                if(bits(bit_index) == 0)
    				llr_0_noninfinite_count = llr_0_noninfinite_count+1;
    
                    if(llrs(bit_index) > llr_0_max)
    					llr_0_max = llrs(bit_index);
                    end
                    if(llrs(bit_index) < llr_0_min)
    					llr_0_min = llrs(bit_index);
                    end
                else
    				llr_1_noninfinite_count = llr_1_noninfinite_count+1;
    
                    if(llrs(bit_index) > llr_1_max)
    						llr_1_max = llrs(bit_index);
                    end
                    if(llrs(bit_index) < llr_1_min)
    					llr_1_min = llrs(bit_index);
                    end
                end
            end
        end
        
        % make sure the intersection
        if(llr_0_noninfinite_count > 0 && llr_1_noninfinite_count > 0 && llr_0_min <= llr_1_max && llr_1_min <= llr_0_max)
    		llr_0_mean = 0.0;
    		llr_1_mean = 0.0;
            % summing all llrs for bit 0 and 1 
            for bit_index = 1:length(bits)
                if(llrs(bit_index) ~= -Inf && llrs(bit_index) ~= Inf)
                    if(bits(bit_index) == 0)
    					llr_0_mean = llr_0_mean+llrs(bit_index);
                    else
    					llr_1_mean = llr_1_mean+llrs(bit_index);	
                    end
                end
            end		
            
            %getting the mean of llrs
            llr_0_mean = llr_0_mean/llr_0_noninfinite_count;
    		llr_1_mean = llr_1_mean/llr_1_noninfinite_count;
			
            % calculating the variance
    		llr_0_variance = 0.0;
    		llr_1_variance = 0.0;
            for bit_index = 1:length(bits)
                if(llrs(bit_index) ~= -Inf && llrs(bit_index) ~= Inf)
			
                    if(bits(bit_index) == 0)
    					llr_0_variance = llr_0_variance + (llrs(bit_index) - llr_0_mean)^2;
                    else
    					llr_1_variance = llr_1_variance + (llrs(bit_index) - llr_1_mean)^2;			
                    end
                end			
            end
            % normalizations
            llr_0_variance = llr_0_variance/llr_0_noninfinite_count;
            llr_1_variance = llr_1_variance/llr_1_noninfinite_count;
			
            % calculate bins
            %http://www.fmrib.ox.ac.uk/analysis/techrep/tr00mj2/tr00mj2/node24.html
            bin_width = 0.5*(3.49*sqrt(llr_0_variance)*(llr_0_noninfinite_count^(-1.0/3.0)) + 3.49*sqrt(llr_1_variance)*(llr_1_noninfinite_count^(-1.0/3.0)));	
            if(bin_width > 0.0)
            	bin_offset = floor(min(llr_0_min, llr_1_min)/bin_width)-1;
                temp = max(llr_0_max, llr_1_max)/bin_width-bin_offset+1;
            	bin_count = ceil(temp);
                if(bin_count == temp)
                    bin_count = bin_count+1;
                end
            else
        		bin_offset = -1;
        		bin_count = 3;
            end
            lots_of_bins = true;

        else % else of check intersection
            lots_of_bins = false;
        	bin_count = 4;
        end
	
        histogram = zeros(2,bin_count);
	
        for bit_index = 1:length(bits)
            if(llrs(bit_index) == -Inf)
    			histogram(bits(bit_index)+1,1) = histogram(bits(bit_index)+1,1)+1;
            elseif(llrs(bit_index) == Inf)
    			histogram(bits(bit_index)+1,bin_count) = histogram(bits(bit_index)+1,bin_count)+1;
            else
                if(lots_of_bins == true)
                    if(bin_width > 0.0)
    					histogram(bits(bit_index)+1,floor(llrs(bit_index)/bin_width)-bin_offset+1) = histogram(bits(bit_index)+1,floor(llrs(bit_index)/bin_width)-bin_offset+1)+1;
                    else
    					histogram(bits(bit_index)+1,2) = histogram(bits(bit_index)+1,2)+1;
                    end
                else
                    histogram(bits(bit_index)+1,bits(bit_index)+2) = histogram(bits(bit_index)+1,bits(bit_index)+2)+1;
                end
            end
        end	
	
        pdf = zeros(2,bin_count);
    	pdf(1,:) = histogram(1,:)/bit_0_count;
    	pdf(2,:) = histogram(2,:)/bit_1_count;
	
    	mutual_information = 0.0;
        for bit_value = 0:1
            for bin_index = 1:bin_count
                if(pdf(bit_value+1,bin_index) > 0.0)
    				mutual_information = mutual_information + 0.5*pdf(bit_value+1,bin_index)*log2(2.0*pdf(bit_value+1,bin_index)/(pdf(1,bin_index) + pdf(2,bin_index)));
                end
            end
        end
	end
end
