Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94710E6
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 06:36:25 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbVSMVz_1676270164;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VbVSMVz_1676270164)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 14:36:05 +0800
From: "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To: hch@lst.de,
	m.szyprowski@samsung.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	GuoRui.Yu@linux.alibaba.com,
	xiaokang.hxk@alibaba-inc.com
Subject: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
Date: Mon, 13 Feb 2023 14:36:04 +0800
Message-Id: <20230213063604.127526-1-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guorui Yu <GuoRui.Yu@linux.alibaba.com>

In general, if swiotlb is sufficient, the logic of index =
wrap_area_index(mem, index + 1) is fine, it will quickly take a slot and
release the area->lock; But if swiotlb is insufficient and the device
has min_align_mask requirements, such as NVME, we may not be able to
satisfy index == wrap and exit the loop properly. In this case, other
kernel threads will not be able to acquire the area->lock and release
the slot, resulting in a deadlock.

The current implementation of wrap_area_index does not involve a modulo
operation, so adjusting the wrap to ensure the loop ends is not trivial.
Introduce the index_nowrap variable to record the number of loops and
exit the loop after completing the traversal.

Backtraces:
[10199.924391] RIP: 0010:swiotlb_do_find_slots+0x1fe/0x3e0
[10199.924403] Call Trace:
[10199.924404]  <TASK>
[10199.924405]  swiotlb_tbl_map_single+0xec/0x1f0
[10199.924407]  swiotlb_map+0x5c/0x260
[10199.924409]  ? nvme_pci_setup_prps+0x1ed/0x340
[10199.924411]  dma_direct_map_page+0x12e/0x1c0
[10199.924413]  nvme_map_data+0x304/0x370
[10199.924415]  nvme_prep_rq.part.0+0x31/0x120
[10199.924417]  nvme_queue_rq+0x77/0x1f0
[10199.924420]  blk_mq_dispatch_rq_list+0x17e/0x670
[10199.924422]  __blk_mq_sched_dispatch_requests+0x129/0x140
[10199.924424]  blk_mq_sched_dispatch_requests+0x34/0x60
[10199.924426]  __blk_mq_run_hw_queue+0x91/0xb0
[10199.924428]  process_one_work+0x1df/0x3b0
[10199.924430]  worker_thread+0x49/0x2e0
[10199.924432]  ? rescuer_thread+0x390/0x390
[10199.924433]  kthread+0xe5/0x110
[10199.924435]  ? kthread_complete_and_exit+0x20/0x20
[10199.924436]  ret_from_fork+0x1f/0x30
[10199.924439]  </TASK>

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: Guorui Yu <GuoRui.Yu@linux.alibaba.com>
Signed-off-by: Xiaokang Hu <xiaokang.hxk@alibaba-inc.com>
---
 kernel/dma/swiotlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..935858f16cfd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -632,7 +632,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, count = 0, i;
+	unsigned int index, index_nowrap, wrap, count = 0, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
 	unsigned int slot_base;
@@ -665,6 +665,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		    (slot_addr(tbl_dma_addr, slot_index) &
 		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
 			index = wrap_area_index(mem, index + 1);
+			index_nowrap += 1;
 			continue;
 		}
 
@@ -680,7 +681,8 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 				goto found;
 		}
 		index = wrap_area_index(mem, index + stride);
-	} while (index != wrap);
+		index_nowrap += stride;
+	} while (index_nowrap < wrap + mem->area_nslabs);
 
 not_found:
 	spin_unlock_irqrestore(&area->lock, flags);
-- 
2.31.1

