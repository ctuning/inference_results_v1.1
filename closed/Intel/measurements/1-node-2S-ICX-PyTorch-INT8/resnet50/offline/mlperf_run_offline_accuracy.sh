export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib/python3.7/site-packages/torch_ipex-1.8.0-py3.7-linux-x86_64.egg/lib:${CONDA_PREFIX}/lib:$LD_LIBRARY_PATH"
export LD_PRELOAD=$CONDA_PREFIX/lib/libiomp5.so
export LD_PRELOAD=/opt/workdir/jemalloc/lib/libjemalloc.so:$LD_PRELOAD
export MALLOC_CONF="oversize_threshold:1,background_thread:true,metadata_thp:auto,dirty_decay_ms:9000000000,muzzy_decay_ms:9000000000"
export DNNL_MAX_CPU_ISA=AVX512_CORE_AMX
export DNNL_PRIMITIVE_CACHE_CAPACITY=1024
python3 run.py --workload-name resnet50 \
    --mlperf-conf mlperf.conf \
    --user-conf resnet50/pytorch-cpu/scripts/ICX/user.conf.ICX40C_2S \
    --workload-config resnet50/pytorch-cpu/scripts/ICX/resnet50-config_OfflineAcc_ICX40C_2S.yml \
    --num-instance 20 \
    --cpus-per-instance 4 \
    --warmup 0 \
    --scenario Offline \
    --mode Accuracy
python resnet50/pytorch-cpu/accuracy-imagenet.py --mlperf-accuracy-file output_logs/mlperf_log_accuracy.json --imagenet-val-file /root/mlperf_data/resnet50/dataset/ILSVRC2012_img_val/val_map.txt --dtype int32
