From: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] iommu/amd: fix unused-variable warning
Date: Fri, 20 Apr 2018 11:28:36 +0200
Message-ID: <20180420092836.12219-1-tobias.regnery@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: bigeasy@linutronix.de, Tobias Regnery <tobias.regnery@gmail.com>
List-Id: iommu@lists.linux-foundation.org

The iommu_table_lock is only used by code inside an ifdef CONFIG_IRQ_REMAP
block. This leads to the following warning with CONFIG_IRQ_REMAP=n:

amd_iommu.c:86:24: warning: 'iommu_table_lock' defined but not used [-Wunused-variable]

Guard the spinlock definition with the same ifdef.

Fixes: ea6166f4b83e9 ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a99f0f14795..5ba141768000 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -83,7 +83,9 @@
 
 static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
+#ifdef CONFIG_IRQ_REMAP
 static DEFINE_SPINLOCK(iommu_table_lock);
+#endif
 
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
-- 
2.17.0
