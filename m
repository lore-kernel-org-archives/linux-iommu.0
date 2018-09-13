From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 4/7] iommu/io-pgtable: Add helper for toggling non-strict mode
Date: Thu, 13 Sep 2018 17:42:21 +0100
Message-ID: <63a2a074219ff045c4616b9f5680d0dd9e922b59.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Since this might become a repeated idiom in drivers, let's add a tidy
encapsulation from the outset.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable.c | 9 +++++++++
 drivers/iommu/io-pgtable.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 127558d83667..af9abe52cf06 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -77,3 +77,12 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_tlb_flush_all(iop);
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
+
+void io_pgtable_set_non_strict(struct io_pgtable_ops *ops, bool val) {
+	struct io_pgtable *iop = io_pgtable_ops_to_pgtable(ops);
+
+	if (val)
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+	else
+		iop->cfg.quirks &= ~IO_PGTABLE_QUIRK_NON_STRICT;
+}
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae559329..0602a132655c 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -153,6 +153,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
  */
 void free_io_pgtable_ops(struct io_pgtable_ops *ops);
 
+void io_pgtable_set_non_strict(struct io_pgtable_ops *ops, bool val);
 
 /*
  * Internal structures for page table allocator implementations.
-- 
2.19.0.dirty
