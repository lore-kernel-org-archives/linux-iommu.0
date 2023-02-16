Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9720FB
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 07:12:46 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id jk14so1140111plb.8
        for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRJfoVOuCSLIf78Tk6rnAQ5m7tVOuXtuPC5IuUQp6R4=;
        b=FEpvpz7mUvMjqlm3jQ3PCJGj/ZK71ogs072O+aTQvHvll2bdi0VzLG5enkjmpeeTi8
         G5ua1ZIpC56xTVM/1Onk6Qr8qpmt1qH17E6CXo0XMwDmm26CuiQUeaaqOfq6TKTESUpk
         hEeCprjNFzSQ5mRE9MU/gutxEgamglP3q/YpBW3nsYL63NMnLSrJ78lJIKedq807NCtm
         FcEXPnfIFfUtyBXIoJCUBwF5KDhTTWusH+inkYdIuV0St6OVNKB+128izxNuZACCZfx8
         yDt7+JXgPNxwpGRgYzvZMS8Pf1PZoroiS0wUlKkdCnK+0wHShrr59gcNLl0wip609kVc
         uzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRJfoVOuCSLIf78Tk6rnAQ5m7tVOuXtuPC5IuUQp6R4=;
        b=jXkL6B78q6oFZtbHJr4wdNrwc3ybmKHwr8WdbeDZA9Gdr0dUlnnuC4C+bus2+xJTrx
         +97Nv1K+NHNtRMGsZ3i9WQJ/44WRmNdWGEhTEiqnUgUr4BgO485DPp394NJveg5mj9j8
         soRt8ywueGIa1P20hw5RaxvPrO6Xc+YUUYzamzQSn1JzVwd12AM62tRDCY8KM7Gv99EW
         i83ErXni9FFjEMnwSvsFh6UzJG/fa0gQhYUajpCdCikkC48i7RvFqy/PYShLi92st+H7
         T6N1q3DDID+WECQ6tmWm1ovz4NY0t2N9xeMKoXuZhVQSjWjm7tISEny6af2uTIxxeCky
         zDRQ==
X-Gm-Message-State: AO0yUKVL32Q8FY42SrCjTaw/GVSTeJ1s9fzjRgyCJptTDDMet6L2E3+6
	23ow4WGRi+onxbhlcv6yX9/Rzw==
X-Google-Smtp-Source: AK7set9YQaOKAwsu85KcDYCDCX/HCS3jh1iu4dV8DrS1VIphXH2yomAeQBnOqpPSdAnnMBdnW6ZPSg==
X-Received: by 2002:a05:6a20:441b:b0:c0:af73:be4d with SMTP id ce27-20020a056a20441b00b000c0af73be4dmr5946807pzb.54.1676531566264;
        Wed, 15 Feb 2023 23:12:46 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001994554099esm517126plz.173.2023.02.15.23.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Feb 2023 23:12:45 -0800 (PST)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Li Bin <huawei.libin@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] iommu: Avoid softlockup and rcu stall in fq_flush_timeout().
Date: Thu, 16 Feb 2023 15:11:48 +0800
Message-Id: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is softlockup under fio pressure test with smmu enabled:
watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
...
Call trace:
 fq_flush_timeout+0xc0/0x110
 call_timer_fn+0x34/0x178
 expire_timers+0xec/0x158
 run_timer_softirq+0xc0/0x1f8
 __do_softirq+0x120/0x324
 irq_exit+0x11c/0x140
 __handle_domain_irq+0x6c/0xc0
 gic_handle_irq+0x6c/0x170
 el1_irq+0xb8/0x140
 arch_cpu_idle+0x38/0x1c0
 default_idle_call+0x24/0x44
 do_idle+0x1f4/0x2d8
 cpu_startup_entry+0x2c/0x30
 secondary_start_kernel+0x17c/0x1c8

Rcu stall may also be triggered:

rcu: INFO: rcu_sched self-detected stall on CPU
NMI backtrace for cpu 21
CPU: 21 PID: 118 Comm: ksoftirqd/21
...
Call trace:
 fq_flush_timeout+0x6d/0x90
 ? fq_ring_free+0xc0/0xc0
 call_timer_fn+0x2b/0x120
 run_timer_softirq+0x1a6/0x420
 ? finish_task_switch+0x80/0x280
 __do_softirq+0xda/0x2da
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x26/0x40
 smpboot_thread_fn+0xb8/0x150
 kthread+0x110/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x30

This is because the timer callback fq_flush_timeout may run more than
10ms, and timer may be processed continuously in the softirq so trigger
softlockup and rcu stall. We can use work to deal with fq_ring_free for
each cpu which may take long time, that to avoid triggering softlockup
and rcu stall.

This patch is modified from the patch[1] of openEuler.

[1] https://mailweb.openeuler.org/hyperkitty/list/kernel@openeuler.org/message/C3KYS4BXTDMVVBQNEQYNAOGOQWFFINHJ/

Signed-off-by: Li Bin <huawei.libin@huawei.com>
Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/iommu/dma-iommu.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99b2646cb5c7..bc4c979d7091 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -59,6 +59,8 @@ struct iommu_dma_cookie {
 			struct timer_list	fq_timer;
 			/* 1 when timer is active, 0 when not */
 			atomic_t		fq_timer_on;
+			/* The work to free iova */
+			struct work_struct free_iova_work;
 		};
 		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
 		dma_addr_t		msi_iova;
@@ -155,20 +157,10 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
 static void fq_flush_timeout(struct timer_list *t)
 {
 	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
-	int cpu;
 
 	atomic_set(&cookie->fq_timer_on, 0);
 	fq_flush_iotlb(cookie);
-
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(cookie->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(cookie, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
-	}
+	schedule_work(&cookie->free_iova_work);
 }
 
 static void queue_iova(struct iommu_dma_cookie *cookie,
@@ -227,6 +219,7 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 		return;
 
 	del_timer_sync(&cookie->fq_timer);
+	cancel_work_sync(&cookie->free_iova_work);
 	/* The IOVAs will be torn down separately, so just free our queued pages */
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
@@ -238,6 +231,23 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 	free_percpu(cookie->fq);
 }
 
+static void free_iova_work_func(struct work_struct *work)
+{
+	struct iommu_dma_cookie *cookie;
+	int cpu;
+
+	cookie = container_of(work, struct iommu_dma_cookie, free_iova_work);
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct iova_fq *fq;
+
+		fq = per_cpu_ptr(cookie->fq, cpu);
+		spin_lock_irqsave(&fq->lock, flags);
+		fq_ring_free(cookie, fq);
+		spin_unlock_irqrestore(&fq->lock, flags);
+	}
+}
+
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
@@ -271,6 +281,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 
 	cookie->fq = queue;
 
+	INIT_WORK(&cookie->free_iova_work, free_iova_work_func);
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
-- 
2.20.1

