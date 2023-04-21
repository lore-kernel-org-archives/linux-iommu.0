Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEF20EE
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 08:08:51 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-63b51fd2972so1654055b3a.3
        for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682064531; x=1684656531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzB2tRHUMpY4/jWB4OcD6fcV69kfby6bK1LT2yyBg70=;
        b=g9kfim8d+Vk0mQnBvIOH4ImhS4V+c+JFV4XsRodLvmi576g3CWkjVBQhiGve+JGO2W
         ciCAzsUNG6deM3sUmB/IDi4J/OXFFlxbV5xXsg7zLhoZIE98++44wg9UQERwzuAUL+TW
         B39puxyPpjQn2Vi5j5bG6sTYfvF0kGSXTTX/J/WS0rDlz0iN6EOE3ep7dQqIdyWPG3xY
         frCXhqUOSHuwedCyAjnB0jumW6e4zHKAmD3+KxpdaXXClaiQWZmVQ+ckXRVDNSX5iKWU
         7wL0K4yqLUV8EYdhWs4yY/xjMIZAj+BdP2avNaal+Fsw6zl1wDdNqWHDfpS0xfLE/v04
         WpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682064531; x=1684656531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzB2tRHUMpY4/jWB4OcD6fcV69kfby6bK1LT2yyBg70=;
        b=S37mpprlXG4Fo7RmfAVfoYIzZLqC/Ug3CSG7pib7+OD3qPk0tmR9PvNERXQt+nVE6X
         aS7vRh4oOpB7HFDgyekHvRI01qSpnjMR6aWG2EQ7SfN1WgqMXgZGqbGs5zbBy34LIrtq
         raA+7JuM+I+UDT3Xa3GdmLUvhmR1lU1S28SELdsKIksPUbPRjOQIZ1vJoQ1GZt/+vTIF
         DGcDDwJvM2vvIXMtt8hbEwozc20+b21s7LujDq7v9O0S2PWjW9PHc9SsQAFn1VBqarDd
         uEpkXc3r0EKTxUfJmJpJg1Y/B1bxjvf2rRagHV7WTDcA/LCrcPx497Fmrya07OyYJzza
         cm4A==
X-Gm-Message-State: AAQBX9eW6OSjTo5oj5IrYzLOdMHZ4YvaG6nifS9y7ivJJH3D0kAON+JH
	7ak0uTX5JVLmrItw0PY9Zro=
X-Google-Smtp-Source: AKy350YGRd1wzVogkJKU8OrquqXB6g+GXFM2plXr4/0HV+QHcdO7zKGrsiRb3HrK+iYKL1k9vhhJtw==
X-Received: by 2002:a05:6a00:2e8b:b0:63c:6485:d5e5 with SMTP id fd11-20020a056a002e8b00b0063c6485d5e5mr5501907pfb.22.1682064530738;
        Fri, 21 Apr 2023 01:08:50 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-221-73.dynamic-ip.hinet.net. [220.143.221.73])
        by smtp.gmail.com with ESMTPSA id c139-20020a621c91000000b005d6999eec90sm2416817pfc.120.2023.04.21.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:08:50 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA optimized limitation
Date: Fri, 21 Apr 2023 16:08:00 +0800
Message-Id: <20230421080800.18837-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When running the fio test on a 448-core AMD server + a NVME disk,
a soft lockup or a hard lockup call trace is shown:

[soft lockup]
watchdog: BUG: soft lockup - CPU#126 stuck for 23s! [swapper/126:0]
RIP: 0010:_raw_spin_unlock_irqrestore+0x21/0x50
...
Call Trace:
 <IRQ>
 fq_flush_timeout+0x7d/0xd0
 ? __pfx_fq_flush_timeout+0x10/0x10
 call_timer_fn+0x2e/0x150
 run_timer_softirq+0x48a/0x560
 ? __pfx_fq_flush_timeout+0x10/0x10
 ? clockevents_program_event+0xaf/0x130
 __do_softirq+0xf1/0x335
 irq_exit_rcu+0x9f/0xd0
 sysvec_apic_timer_interrupt+0xb4/0xd0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1f/0x30
...

Obvisouly, fq_flush_timeout spends over 20 seconds. Here is ftrace log:

               |  fq_flush_timeout() {
               |    fq_ring_free() {
               |      put_pages_list() {
   0.170 us    |        free_unref_page_list();
   0.810 us    |      }
               |      free_iova_fast() {
               |        free_iova() {
 * 85622.66 us |          _raw_spin_lock_irqsave();
   2.860 us    |          remove_iova();
   0.600 us    |          _raw_spin_unlock_irqrestore();
   0.470 us    |          lock_info_report();
   2.420 us    |          free_iova_mem.part.0();
 * 85638.27 us |        }
 * 85638.84 us |      }
               |      put_pages_list() {
   0.230 us    |        free_unref_page_list();
   0.470 us    |      }
   ...            ...
 $ 31017069 us |  }

Most of cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[hard lockup]
NMI watchdog: Watchdog detected hard LOCKUP on cpu 351
RIP: 0010:native_queued_spin_lock_slowpath+0x2d8/0x330

Call Trace:
 <IRQ>
 _raw_spin_lock_irqsave+0x4f/0x60
 free_iova+0x27/0xd0
 free_iova_fast+0x4d/0x1d0
 fq_ring_free+0x9b/0x150
 iommu_dma_free_iova+0xb4/0x2e0
 __iommu_dma_unmap+0x10b/0x140
 iommu_dma_unmap_sg+0x90/0x110
 dma_unmap_sg_attrs+0x4a/0x50
 nvme_unmap_data+0x5d/0x120 [nvme]
 nvme_pci_complete_batch+0x77/0xc0 [nvme]
 nvme_irq+0x2ee/0x350 [nvme]
 ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
 __handle_irq_event_percpu+0x53/0x1a0
 handle_irq_event_percpu+0x19/0x60
 handle_irq_event+0x3d/0x60
 handle_edge_irq+0xb3/0x210
 __common_interrupt+0x7f/0x150
 common_interrupt+0xc5/0xf0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x2b/0x40
...

ftrace shows fq_ring_free spends over 10 seconds [1]. Again, most of
cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[Root Cause]
The root cause is that the max_hw_sectors_kb of nvme disk (mdts=10)
is 4096kb, which streaming DMA mappings cannot benefit from the
scalable IOVA mechanism introduced by the commit 9257b4a206fc
("iommu/iova: introduce per-cpu caching to iova allocation") if
the length is greater than 128kb.

To fix the lock contention issue, clamp max_hw_sectors based on
DMA optimized limitation in order to leverage scalable IOVA mechanism.

Note: The issue does not happen with another NVME disk (mdts = 5
and max_hw_sectors_kb = 128)

[1] https://gist.github.com/AdrianHuang/bf8ec7338204837631fbdaed25d19cc4

Suggested-by: Keith Busch <kbusch@kernel.org> 
Reported-and-tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
Changes since v1:
  - Clamp max_hw_sectors at lower level driver code per Keith's suggestion

 drivers/nvme/host/pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..fa351c56d690 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2914,6 +2914,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	size_t max_bytes = NVME_MAX_KB_SZ * 1024;
+
 	if (node == NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, first_memory_node);
 
@@ -2955,12 +2961,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+	max_bytes = min(max_bytes, dma_max_mapping_size(&pdev->dev));
+	max_bytes = min_not_zero(max_bytes, dma_opt_mapping_size(&pdev->dev));
+	dev->ctrl.max_hw_sectors = max_bytes >> 9;
+
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
-- 
2.34.1

