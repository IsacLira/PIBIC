function capacity=getCapacity(Hg)

M=Hg'*inv(Hg*Hg');
M=M/norm((M),'fro');
groupSize=size(Hg,1);
D=eye(groupSize);
M=real(D*Hg*M);
capacity= log2(det(eye(groupSize)+M*M'));

end