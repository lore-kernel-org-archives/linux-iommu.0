From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 03/13] Revert "iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel"
Date: Fri, 21 Jul 2017 16:59:01 +0800
Message-ID: <1500627551-12930-4-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

This reverts commit 54bd63570484167cb13edf81e31fff107b879981.

We still need the IO_PAGE_FAULT message to warn error after the
issue of on-flight dma in kdump kernel is fixed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c       | 3 +--
 drivers/iommu/amd_iommu_init.c  | 9 ---------
 drivers/iommu/amd_iommu_types.h | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 688e77576e5a..e8a6d8109564 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2086,8 +2086,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 		flags    |= tmp;
 	}
 
-
-	flags &= ~(DTE_FLAG_SA | 0xffffULL);
+	flags &= ~(0xffffUL);
 	flags |= domain->id;
 
 	amd_iommu_dev_table[devid].data[1]  = flags;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4ca6e3257d92..f6da5fe03b31 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -29,7 +29,6 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/kmemleak.h>
-#include <linux/crash_dump.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -1942,14 +1941,6 @@ static void init_device_table_dma(void)
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
 		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
 		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
-		/*
-		 * In kdump kernels in-flight DMA from the old kernel might
-		 * cause IO_PAGE_FAULTs. There are no reports that a kdump
-		 * actually failed because of that, so just disable fault
-		 * reporting in the hardware to get rid of the messages
-		 */
-		if (is_kdump_kernel())
-			set_dev_entry_bit(devid, DEV_ENTRY_NO_PAGE_FAULT);
 	}
 }
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index d15966b62b33..608e81ca5e92 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -322,7 +322,6 @@
 #define IOMMU_PTE_IW (1ULL << 62)
 
 #define DTE_FLAG_IOTLB	(1ULL << 32)
-#define DTE_FLAG_SA	(1ULL << 34)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
-- 
2.5.5
