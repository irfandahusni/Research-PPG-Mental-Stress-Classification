function outmRR = mRR(rri)

	n = length(rri);
	s = 0;

	for i = 1:n
		s = s + rri(i);
	end

	outmRR = s/n;

end