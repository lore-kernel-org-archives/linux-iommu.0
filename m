Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603491802E
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876080; cv=none; b=CYz9KD+KsGoUILqEI6sjfLn4MScyQ+0bOa9CJRR4M8eLFX2R2zQ9Z+z2mfXqArh7u7NKvYRdiMraj6W/MUkjCihhFJAzMl476vfoadUU3E3cfI0EaxXnYabMN3RmasUAUfQimGCaCwrriZawnietihWwZMManIl2lQqxYosHD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876080; c=relaxed/simple;
	bh=FEaM12eT70ei9LMXlJcXv1siTmpjiKS6cujOpvid8FQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ArzUYjueuec8LX995HA9JV8zJ/Sk3O8Q64k0z7Zh1/AF95DtSeNQxPVyX2mCh8P6LKyKHbKWlqb6FCrCg/7f6F4xUANYXUHN3X+IvsICWuGkLZiOKcPUbs6Q9utQJvCJi+ehRqi+UpsMsr0aWKj2F7tx/LNTyg+3wbs7AtMQCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W4Zx05NLVzPs22;
	Thu, 20 Jun 2024 17:31:00 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 863C518007A;
	Thu, 20 Jun 2024 17:34:34 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 17:34:33 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <chenxiang66@hisilicon.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<baohua@kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v2] dma-mapping: benchmark: Don't starve others when doing the test
Date: Thu, 20 Jun 2024 17:28:55 +0800
Message-ID: <20240620092855.54581-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

The test thread will start N benchmark kthreads and then schedule out
until the test time finished and notify the benchmark kthreads to stop.
The benchmark kthreads will keep running until notified to stop.
There's a problem with current implementation when the benchmark
kthreads number is equal to the CPUs on a non-preemptible kernel:
since the scheduler will balance the kthreads across the CPUs and
when the test time's out the test thread won't get a chance to be
scheduled on any CPU then cannot notify the benchmark kthreads to stop.

This can be easily reproduced on a VM (simulated with 16 CPUs) with
PREEMPT_VOLUNTARY:
estuary:/mnt$ ./dma_map_benchmark -t 16 -s 1
 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:     10-...!: (5221 ticks this GP) idle=ed24/1/0x4000000000000000 softirq=142/142 fqs=0
 rcu:     (t=5254 jiffies g=-559 q=45 ncpus=16)
 rcu: rcu_sched kthread starved for 5255 jiffies! g-559 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=12
 rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
 rcu: RCU grace-period kthread stack dump:
 task:rcu_sched       state:R  running task     stack:0     pid:16    tgid:16    ppid:2      flags:0x00000008
 Call trace
  __switch_to+0xec/0x138
  __schedule+0x2f8/0x1080
  schedule+0x30/0x130
  schedule_timeout+0xa0/0x188
  rcu_gp_fqs_loop+0x128/0x528
  rcu_gp_kthread+0x1c8/0x208
  kthread+0xec/0xf8
  ret_from_fork+0x10/0x20
 Sending NMI from CPU 10 to CPUs 0:
 NMI backtrace for cpu 0
 CPU: 0 PID: 332 Comm: dma-map-benchma Not tainted 6.10.0-rc1-vanilla-LSE #8
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : arm_smmu_cmdq_issue_cmdlist+0x218/0x730
 lr : arm_smmu_cmdq_issue_cmdlist+0x488/0x730
 sp : ffff80008748b630
 x29: ffff80008748b630 x28: 0000000000000000 x27: ffff80008748b780
 x26: 0000000000000000 x25: 000000000000bc70 x24: 000000000001bc70
 x23: ffff0000c12af080 x22: 0000000000010000 x21: 000000000000ffff
 x20: ffff80008748b700 x19: ffff0000c12af0c0 x18: 0000000000010000
 x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
 x14: 0001ffffffffffff x13: 000000000000ffff x12: 00000000000002f1
 x11: 000000000001ffff x10: 0000000000000031 x9 : ffff800080b6b0b8
 x8 : ffff0000c2a48000 x7 : 000000000001bc71 x6 : 0001800000000000
 x5 : 00000000000002f1 x4 : 01ffffffffffffff x3 : 000000000009aaf1
 x2 : 0000000000000018 x1 : 000000000000000f x0 : ffff0000c12af18c
 Call trace:
  arm_smmu_cmdq_issue_cmdlist+0x218/0x730
  __arm_smmu_tlb_inv_range+0xe0/0x1a8
  arm_smmu_iotlb_sync+0xc0/0x128
  __iommu_dma_unmap+0x248/0x320
  iommu_dma_unmap_page+0x5c/0xe8
  dma_unmap_page_attrs+0x38/0x1d0
  map_benchmark_thread+0x118/0x2c0
  kthread+0xec/0xf8
  ret_from_fork+0x10/0x20

Solve this by adding scheduling point in the kthread loop,
so if there're other threads in the system they may have
a chance to run, especially the thread to notify the test
end. However this may degrade the test concurrency so it's
recommended to run this on an idle system.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Barry Song <baohua@kernel.org>
---
Change since v1:
- Correct the comment and mention the preferred use scenario, per Barry
Link: https://lore.kernel.org/all/20240619092133.37411-1-yangyicong@huawei.com/

 kernel/dma/map_benchmark.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 4950e0b622b1..cc19a3efea89 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -89,6 +89,22 @@ static int map_benchmark_thread(void *data)
 		atomic64_add(map_sq, &map->sum_sq_map);
 		atomic64_add(unmap_sq, &map->sum_sq_unmap);
 		atomic64_inc(&map->loops);
+
+		/*
+		 * We may test for a long time so periodically check whether
+		 * we need to schedule to avoid starving the others. Otherwise
+		 * we may hangup the kernel in a non-preemptible kernel when
+		 * the test kthreads number >= CPU number, the test kthreads
+		 * will run endless on every CPU since the thread resposible
+		 * for notifying the kthread stop (in do_map_benchmark())
+		 * could not be scheduled.
+		 *
+		 * Note this may degrade the test concurrency since the test
+		 * threads may need to share the CPU time with other load
+		 * in the system. So it's recommended to run this benchmark
+		 * on an idle system.
+		 */
+		cond_resched();
 	}
 
 out:
-- 
2.24.0

