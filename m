From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v8 6/7] iommu/io-pgtable-arm-v7s: Add support for non-strict mode
Date: Thu, 20 Sep 2018 17:10:26 +0100
Message-ID: <b6f3140cb5f4f4beb24b507c16d8d142e7389d06.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

As for LPAE, it's simply a case of skipping the leaf invalidation for a
regular unmap, and ensuring that the one in split_blk_unmap() is paired
with an explicit sync ASAP rather than relying on one which might only
eventually happen way down the line.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8: Do this properly instead of just hacking around not doing it
    (look, it turns out barely any more complicated!)

 drivers/iommu/io-pgtable-arm-v7s.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index b5948ba6b3b3..445c3bde0480 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -587,6 +587,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 	}
 
 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+	io_pgtable_tlb_sync(&data->iop);
 	return size;
 }
 
@@ -642,6 +643,13 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				io_pgtable_tlb_sync(iop);
 				ptep = iopte_deref(pte[i], lvl);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
+			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
+				/*
+				 * Order the PTE update against queueing the IOVA, to
+				 * guarantee that a flush callback from a different CPU
+				 * has observed it before the TLBIALL can be issued.
+				 */
+				smp_wmb();
 			} else {
 				io_pgtable_tlb_add_flush(iop, iova, blk_size,
 							 blk_size, true);
@@ -712,7 +720,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 			    IO_PGTABLE_QUIRK_NO_PERMS |
 			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
 			    IO_PGTABLE_QUIRK_ARM_MTK_4GB |
-			    IO_PGTABLE_QUIRK_NO_DMA))
+			    IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
-- 
2.19.0.dirty
