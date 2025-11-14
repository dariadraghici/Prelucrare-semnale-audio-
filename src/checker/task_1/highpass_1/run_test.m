function run_test()
    "task-1";
    tol = 1e-4;

    fout = fopen("out", "w");

    load("../../input/task_1/in_highpass_1.mat");
    load("../../input/task_1/ref_highpass_1.mat");

    _sig2_highpass = high_pass(sig2, fs2, high_pass_cutoff);
    save "output.mat" _sig2_highpass;

    dsig = abs(_sig2_highpass - sig2_highpass);

    is_sig_good = mean(dsig) < tol

    fprintf(fout, "%d", is_sig_good);

    fclose(fout);
end
