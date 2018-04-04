From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu: amd: hide unused iommu_table_lock
Date: Wed,  4 Apr 2018 12:56:59 +0200
Message-ID: <20180404105713.633983-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Baoquan He <bhe@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The newly introduced lock is only used when CONFIG_IRQ_REMAP is enabled:

drivers/iommu/amd_iommu.c:86:24: error: 'iommu_table_lock' defined but not used [-Werror=unused-variable]
 static DEFINE_SPINLOCK(iommu_table_lock);

This moves the definition next to the user, within the #ifdef protected
section of the file.

Fixes: ea6166f4b83e ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a99f0f14795..8fb8c737fffe 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -83,7 +83,6 @@
 
 static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
-static DEFINE_SPINLOCK(iommu_table_lock);
 
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -3562,6 +3561,7 @@ EXPORT_SYMBOL(amd_iommu_device_info);
  *****************************************************************************/
 
 static struct irq_chip amd_ir_chip;
+static DEFINE_SPINLOCK(iommu_table_lock);
 
 static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 {
-- 
2.9.0
