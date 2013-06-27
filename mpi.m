MPI_Init;
comm = MPI_COMM_WORLD;

comm_size = MPI_Comm_size(comm);
my_rank = MPI_Comm_rank(comm);

disp(['my_rank: ',num2str(my_rank)]);

pause(2.0);

leader = 0;

coefs_tag = 10000;
input_tag = 20000;
output_tag = 30000;

N1 = 1000;
N2 = 70;

if (my_rank == leader)
  coefs = ones(N1,1);
  input = ones(N1,N2);
  output = zeros(N1,N2);

  MPI_Bcast( leader, coefs_tag, comm, coefs );

  for i=1:N2 
    MPI_Send(mod((i - 1),comm_size), input_tag + i, comm, input(:,i));
  end
end

% Everyone but the leader receives the coefs.
if (my_rank ~= leader)
    coefs = MPI_Recv( leader, coefs_tag, comm );
end

% Everyone receives the input data and processes the results.
for i=1:N2
  if (my_rank == mod((i - 1),comm_size))	% Check if this destination is me.
    i_input =  MPI_Recv(leader, input_tag + i,comm);
    i_output = ifft(fft(coefs) .* i_input);
    MPI_Send(leader, output_tag + i, comm, i_output);
  end
end

% Leader receives all the results.
if (my_rank == leader)
  for i=1:N2 
    output(:,i) =  MPI_Recv(mod((i - 1),comm_size),output_tag + i,comm);
  end
end

MPI_Finalize;
disp('SUCCESS');
if (my_rank ~= MatMPI_Host_rank(comm))
  exit;
end
