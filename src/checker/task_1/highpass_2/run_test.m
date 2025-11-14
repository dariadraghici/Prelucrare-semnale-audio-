function run_test()
    "task-1";
    tol = 1e-4;

    fout = fopen("out", "w");

    load("../../input/task_1/in_highpass_2.mat");
    load("../../input/task_1/ref_highpass_2.mat");

    _sig3_high = high_pass(sig3, fs3, high_pass_cutoff);
    save "output.mat" _sig3_high;

    dsig = abs(_sig3_high - sig3_high);

    is_sig_good = mean(dsig) < tol

    fprintf(fout, "%d", is_sig_good);

    fclose(fout);
end
