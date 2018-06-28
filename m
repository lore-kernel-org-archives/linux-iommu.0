From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/5 V4] Remap the device table of IOMMU in encrypted manner for kdump
Date: Thu, 28 Jun 2018 16:58:04 +0800
Message-ID: <20180628085806.9280-4-lijiang@redhat.com>
References: <20180628085806.9280-1-lijiang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628085806.9280-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

In kdump mode, it will copy the device table of IOMMU from the old
device table, which is encrypted when SME is enabled in the first
kernel. So we must remap it in encrypted manner in order to be
automatically decrypted when we read.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Some changes:
1. add some comments
2. clean compile warning.
3. remove unnecessary code when we clear sme mask bit.

 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..4cebb00 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -888,12 +888,22 @@ static bool copy_device_table(void)
 		}
 	}
 
-	old_devtb_phys = entry & PAGE_MASK;
+	/*
+	 * When SME is enabled in the first kernel, the entry includes the
+	 * memory encryption mask(sme_me_mask), we must remove the memory
+	 * encryption mask to obtain the true physical address in kdump mode.
+	 */
+	old_devtb_phys = __sme_clr(entry) & PAGE_MASK;
+
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	old_devtb = (sme_active() && is_kdump_kernel())
+		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
+							dev_table_size)
+		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+
 	if (!old_devtb)
 		return false;
 
-- 
2.9.5
