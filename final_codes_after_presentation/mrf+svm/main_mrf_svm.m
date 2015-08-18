%
clear all;
clc;
close all;
load('C:\Users\ndy102\Desktop\thesis\final_markov-2015-07-26\final_markov\classifiedimage_10_0_9_993.mat');
[ RGB,x,en ] = combined_markov_svm(images_save );