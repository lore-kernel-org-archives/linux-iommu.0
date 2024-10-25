Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8F1D8E1A
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850769; cv=none; b=t1HACCWtl2RetSJRNuAo/mGQf7j0yERDBSLTuCIKee258KAQbIZaw/jGgClI/ag7bL56rwLmAPDthrQC3Pa8i5oMPJl494g2vVd8l1NPMGI7iJdMGVrdWAWv+C3gAijKgInJdQjDcGOrZdcD4/VRzdYpU/u5TLUbJFl9uQVIkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850769; c=relaxed/simple;
	bh=Qurwk7pbOhMzZBqpjremdnONK2ibPirydS2tnVXV9eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EqTs7X1wT6q06HlPENEswCsrja8gll560Oi97B6vGcE7sK4ihkPtG/xDjVDI1tj1Uz/p8oUG+VQFj0/U0HeHTfm4NkbHlrnldutfH/g4agd4nOMWOU6QNI9ky5/yeP3HIMLmX3FcOCQZZ1q9zjsN6J79XvEJMppVOihWw93Vbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E47339;
	Fri, 25 Oct 2024 03:06:34 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B67B63F73B;
	Fri, 25 Oct 2024 03:06:03 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: nd@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>
Subject: [PATCH] dma/debug.c: fix possible deadlock scenario
Date: Fri, 25 Oct 2024 11:06:00 +0100
Message-Id: <20241025100600.3076319-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

radix_lock() shouldn't be held while holding dma_hash_entry[idx].lock
otherwise, there's a possible deadlock scenario when
dma debug API is called holding rq_lock():

CPU0                   CPU1                       CPU2
dma_free_attrs()
check_unmap()          add_dma_entry()            __schedule() //out
                                                  (A) rq_lock()
get_hash_bucket()
(A) dma_entry_hash
                                                  check_sync()
                       (A) radix_lock()           (W) dma_entry_hash
dma_entry_free()
(W) radix_lock()
                       // CPU2's one
                       (W) rq_lock()

CPU1 situation can happen when it extending radix tree and
it tries to wake up kswapd via wake_all_kswapd().

CPU2 situation can happen while perf_event_task_sched_out()
(i.e. dma sync operation is called while deleting perf_event using
 etm and etr tmc which are Arm Coresight hwtracing driver backends).

To remove this possible situation, call dma_entry_free() after
put_hash_bucket() in check_unmap().

Reported-by: Denis Nikitin <denik@chromium.org>
Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/2WMS7BBSF5OZYB63VT44U5YWLFP5HL6U/#RWM6MLQX5ANBTEQ2PRM7OXCBGCE6NPWU
Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
Here is related lockdep splat above scenario:
[12453.456427] ======================================================
[12453.456471] WARNING: possible circular locking dependency detected
[12453.456518] 6.6.21-lockdep-01250-gbecf1787b73c #1 Not tainted
[12453.456575] ------------------------------------------------------
[12453.456618] perf/12414 is trying to acquire lock:
[12453.456671] ffffffc084bc0990 (&dma_entry_hash[i].lock){-.-.}-{2:2}, at: check_sync+0x84/0x11a0
[12453.456896]
               but task is already holding lock:
[12453.456938] ffffff80cdb940f8 (&drvdata->spinlock){....}-{2:2}, at: tmc_update_etr_buffer+0xbc/0x898 [coresight_tmc]
[12453.457332]
               which lock already depends on the new lock.

[12453.457375]
               the existing dependency chain (in reverse order) is:
[12453.457417]
               -> #6 (&drvdata->spinlock){....}-{2:2}:
[12453.457535]        _raw_spin_lock_irqsave+0x74/0xf8
[12453.457629]        tmc_update_etr_buffer+0xbc/0x898 [coresight_tmc]
[12453.457879]        etm_event_stop+0x3b8/0x508 [coresight]
[12453.458303]        etm_event_del+0x2c/0x48 [coresight]
[12453.458716]        event_sched_out+0x284/0x808
[12453.458803]        group_sched_out+0x11c/0x530
[12453.458884]        __pmu_ctx_sched_out+0x248/0x2d8
[12453.458967]        ctx_sched_out+0x2d8/0x418
[12453.459049]        __perf_event_task_sched_in+0x450/0x790
[12453.459125]        finish_task_switch+0x350/0x568
[12453.459210]        __schedule+0x13f8/0x2238
[12453.459283]        schedule+0xd0/0x1b8
[12453.459353]        kvm_vcpu_block+0x128/0x200
[12453.459420]        kvm_vcpu_halt+0x210/0xa68
[12453.459482]        kvm_vcpu_wfi+0xe4/0x268
[12453.459553]        kvm_handle_wfx+0x25c/0x3b8
[12453.459621]        handle_exit+0x1dc/0x368
[12453.459685]        kvm_arch_vcpu_ioctl_run+0x13f0/0x1b48
[12453.459758]        kvm_vcpu_ioctl+0x81c/0x2170
[12453.459828]        __arm64_sys_ioctl+0x154/0x1d8
[12453.459902]        invoke_syscall+0x98/0x280
[12453.459968]        el0_svc_common+0x1f8/0x260
[12453.460030]        do_el0_svc+0x90/0xc8
[12453.460091]        el0_svc+0x50/0xd8
[12453.460163]        el0t_64_sync_handler+0x44/0xf0
[12453.460236]        el0t_64_sync+0x1a8/0x1b0
[12453.460302]
               -> #5 (&ctx->lock){....}-{2:2}:
[12453.460420]        _raw_spin_lock+0x5c/0xa8
[12453.460502]        __perf_event_task_sched_out+0x618/0x1158
[12453.460577]        __schedule+0x200c/0x2238
[12453.460648]        schedule+0xd0/0x1b8
[12453.460720]        kvm_vcpu_block+0x128/0x200
[12453.460784]        kvm_vcpu_halt+0x210/0xa68
[12453.460847]        kvm_vcpu_wfi+0xe4/0x268
[12453.460914]        kvm_handle_wfx+0x25c/0x3b8
[12453.460980]        handle_exit+0x1dc/0x368
[12453.461044]        kvm_arch_vcpu_ioctl_run+0x13f0/0x1b48
[12453.461115]        kvm_vcpu_ioctl+0x81c/0x2170
[12453.461185]        __arm64_sys_ioctl+0x154/0x1d8
[12453.461256]        invoke_syscall+0x98/0x280
[12453.461318]        el0_svc_common+0x1f8/0x260
[12453.461381]        do_el0_svc+0x90/0xc8
[12453.461442]        el0_svc+0x50/0xd8
[12453.461511]        el0t_64_sync_handler+0x44/0xf0
[12453.461584]        el0t_64_sync+0x1a8/0x1b0
[12453.461648]
               -> #4 (&rq->__lock){-.-.}-{2:2}:
[12453.461764]        _raw_spin_lock_nested+0x60/0xa8
[12453.461828]        raw_spin_rq_lock_nested+0x34/0x58
[12453.461903]        task_fork_fair+0x70/0x1a8
[12453.461982]        sched_cgroup_fork+0x2f4/0x3a8
[12453.462061]        copy_process+0x2138/0x3130
[12453.462145]        kernel_clone+0x198/0x950
[12453.462208]        user_mode_thread+0xd8/0x130
[12453.462274]        rest_init+0x34/0x300
[12453.462349]        arch_call_rest_init+0x1c/0x28
[12453.462421]        start_kernel+0x3e0/0x540
[12453.462487]        __primary_switched+0xb8/0xc8
[12453.462569]
               -> #3 (&p->pi_lock){-.-.}-{2:2}:
[12453.462685]        _raw_spin_lock_irqsave+0x74/0xf8
[12453.462769]        try_to_wake_up+0x6c/0xeb0
[12453.462844]        default_wake_function+0x60/0x88
[12453.462925]        autoremove_wake_function+0x2c/0x108
[12453.463011]        __wake_up_common+0x228/0x3c0
[12453.463094]        __wake_up_common_lock+0xfc/0x190
[12453.463177]        __wake_up+0x20/0x38
[12453.463255]        wakeup_kswapd+0x368/0x6d8
[12453.463321]        get_page_from_freelist+0x2254/0x24f8
[12453.463403]        __alloc_pages+0x2bc/0x728
[12453.463479]        __folio_alloc+0x1c/0x30
[12453.463555]        __filemap_get_folio+0x35c/0x8d8
[12453.463628]        ext4_da_write_begin+0x378/0x7b8
[12453.463701]        generic_perform_write+0x240/0x510
[12453.463776]        ext4_buffered_write_iter+0x108/0x318
[12453.463853]        ext4_file_write_iter+0x120/0xfd8
[12453.463927]        do_iter_readv_writev+0x268/0x398
[12453.464006]        do_iter_write+0x148/0x3e0
[12453.464079]        vfs_writev+0xe8/0x160
[12453.464154]        do_pwritev+0x104/0x210
[12453.464227]        __arm64_sys_pwritev+0xa8/0xc8
[12453.464303]        invoke_syscall+0x98/0x280
[12453.464365]        el0_svc_common+0x1f8/0x260
[12453.464428]        do_el0_svc+0x90/0xc8
[12453.464489]        el0_svc+0x50/0xd8
[12453.464558]        el0t_64_sync_handler+0x44/0xf0
[12453.464630]        el0t_64_sync+0x1a8/0x1b0
[12453.464695]
               -> #2 (&pgdat->kswapd_wait){....}-{2:2}:
[12453.464815]        _raw_spin_lock_irqsave+0x74/0xf8
[12453.464899]        __wake_up_common_lock+0xdc/0x190
[12453.464981]        __wake_up+0x20/0x38
[12453.465058]        wakeup_kswapd+0x368/0x6d8
[12453.465121]        get_page_from_freelist+0x2254/0x24f8
[12453.465199]        __alloc_pages+0x2bc/0x728
[12453.465274]        new_slab+0xc4/0x508
[12453.465350]        ___slab_alloc+0x7d8/0xcc8
[12453.465428]        kmem_cache_alloc+0x300/0x428
[12453.465505]        radix_tree_node_alloc+0x184/0x328
[12453.465577]        radix_tree_insert+0x188/0x4f0
[12453.465645]        add_dma_entry+0x1c0/0x5b0
[12453.465721]        debug_dma_map_sg+0x79c/0x948 [12453.465797]        __dma_map_sg_attrs+0x128/0x1d0
[12453.465866]        dma_map_sg_attrs+0x50/0x78
[12453.465936]        cqhci_request+0x720/0x1420
[12453.466010]        mmc_cqe_start_req+0xec/0x2a0
[12453.466094]        mmc_blk_mq_issue_rq+0x6f8/0xd28
[12453.466170]        mmc_mq_queue_rq+0x4b4/0x8b0
[12453.466252]        blk_mq_dispatch_rq_list+0xaf0/0x1838
[12453.466332]        __blk_mq_sched_dispatch_requests+0xbe8/0x1220
[12453.466405]        blk_mq_sched_dispatch_requests+0xc4/0x148
[12453.466477]        blk_mq_run_hw_queue+0x3d8/0x738
[12453.466553]        blk_mq_flush_plug_list+0xc34/0x1718
[12453.466631]        __blk_flush_plug+0x348/0x3c0
[12453.466711]        blk_finish_plug+0x70/0xa0
[12453.466788]        read_pages+0x498/0x628
[12453.466856]        page_cache_ra_unbounded+0x480/0x5a8
[12453.466926]        do_page_cache_ra+0x108/0x130
[12453.466997]        ondemand_readahead+0x5e8/0xc50
[12453.467067]        page_cache_async_ra+0x154/0x1d8
[12453.467138]        filemap_get_pages+0x4a4/0x1520
[12453.467209]        filemap_read+0x2e8/0xaa8
[12453.467280]        generic_file_read_iter+0xa4/0x318
[12453.467353]        ext4_file_read_iter+0x22c/0x2d0
[12453.467424]        do_iter_readv_writev+0x268/0x398
[12453.467500]        do_iter_read+0x148/0x3e0
[12453.467572]        vfs_readv+0xe0/0x150
[12453.467645]        do_preadv+0x104/0x210
[12453.467720]        __arm64_sys_preadv+0xa8/0xc8
[12453.467794]        invoke_syscall+0x98/0x280
[12453.467857]        el0_svc_common+0x1f8/0x260
[12453.467920]        do_el0_svc+0x90/0xc8
[12453.467980]        el0_svc+0x50/0xd8
[12453.468048]        el0t_64_sync_handler+0x44/0xf0
[12453.468121]        el0t_64_sync+0x1a8/0x1b0
[12453.468185]
               -> #1 (radix_lock){-.-.}-{2:2}:
[12453.468303]        _raw_spin_lock_irqsave+0x74/0xf8
[12453.468386]        check_unmap+0xcd8/0x1920
[12453.468460]        debug_dma_free_coherent+0x26c/0x2e8
[12453.468540]        d+0x100/0x1b8
[12453.468609]        qcom_scm_assign_mem+0x5b8/0x6c8
[12453.468692]        qcom_rmtfs_mem_probe+0x624/0x8b0
[12453.468769]        platform_probe+0x150/0x1d0
[12453.468849]        really_probe+0x2b0/0x8c0
[12453.468919]        __driver_probe_device+0x1b4/0x3c0
[12453.468992]        driver_probe_device+0x74/0x1b0
[12453.469062]        __driver_attach+0x174/0x300
[12453.469132]        bus_for_each_dev+0xf0/0x168
[12453.469195]        driver_attach+0x54/0x70
[12453.469262]        bus_add_driver+0x21c/0x4b0
[12453.469327]        driver_register+0x228/0x320
[12453.469398]        __platform_driver_register+0x7c/0xa0
[12453.469476]        qcom_rmtfs_mem_init+0x84/0x100
[12453.469561]        do_one_initcall+0x1e8/0x978
[12453.469629]        do_initcall_level+0x11c/0x170
[12453.469698]        do_initcalls+0x60/0xc0
[12453.469764]        do_basic_setup+0x94/0xb0
[12453.469831]        kernel_init_freeable+0x308/0x508
[12453.469900]        kernel_init+0x2c/0x1f8
[12453.469976]        ret_from_fork+0x10/0x20
[12453.470047]
               -> #0 (&dma_entry_hash[i].lock){-.-.}-{2:2}:
[12453.470163]        __lock_acquire+0x2ae8/0x60b8
[12453.470229]        lock_acquire+0x204/0x6c0
[12453.470291]        _raw_spin_lock_irqsave+0x74/0xf8
[12453.470373]        check_sync+0x84/0x11a0
[12453.470447]        debug_dma_sync_single_for_cpu+0x130/0x1c8
[12453.470526]        dma_sync_single_for_cpu+0x2a0/0x308
[12453.470597]        tmc_sg_table_sync_data_range+0x110/0x168 [coresight_tmc]
[12453.470851]        tmc_etr_sync_sg_buf+0x340/0x470 [coresight_tmc]
[12453.471098]        tmc_sync_etr_buf+0x24c/0x3d0 [coresight_tmc]
[12453.471344]        tmc_update_etr_buffer+0x15c/0x898 [coresight_tmc]
[12453.471592]        etm_event_stop+0x3b8/0x508 [coresight]
[12453.472005]        etm_event_del+0x2c/0x48 [coresight]
[12453.472416]        event_sched_out+0x284/0x808
[12453.472498]        group_sched_out+0x11c/0x530
[12453.472580]        __perf_event_disable+0x128/0x1b0
[12453.472651]        event_function+0x348/0x510
[12453.472731]        remote_function+0xf0/0x190
[12453.472812]        generic_exec_single+0x23c/0x928
[12453.472887]        smp_call_function_single+0x1ec/0x4b0
[12453.472960]        event_function_call+0x238/0x3c8
[12453.473043]        _perf_event_disable+0x90/0xd8
[12453.473113]        perf_event_for_each_child+0x8c/0x120
[12453.473187]        perf_ioctl+0x2b8/0x1d60
[12453.473254]        __arm64_sys_ioctl+0x154/0x1d8
[12453.473321]        invoke_syscall+0x98/0x280
[12453.473384]        el0_svc_common+0x1f8/0x260
[12453.473446]        do_el0_svc+0x90/0xc8
[12453.473506]        el0_svc+0x50/0xd8
[12453.473575]        el0t_64_sync_handler+0x44/0xf0
[12453.473649]        el0t_64_sync+0x1a8/0x1b0
[12453.473712]
---
 kernel/dma/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index d570535342cb..3ae78b1535b1 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1052,9 +1052,13 @@ static void check_unmap(struct dma_debug_entry *ref)
 	}

 	hash_bucket_del(entry);
-	dma_entry_free(entry);
-
 	put_hash_bucket(bucket, flags);
+
+	/*
+	 * Now that bucket has been released, the removed entry can be
+	 * freed without risk of deadlock:
+	 */
+	dma_entry_free(entry);
 }

 static void check_for_stack(struct device *dev,
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

