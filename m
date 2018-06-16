From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted manner for kdump
Date: Sat, 16 Jun 2018 16:27:13 +0800
Message-ID: <20180616082714.32035-4-lijiang@redhat.com>
References: <20180616082714.32035-1-lijiang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180616082714.32035-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, thomas.lendacky@amd.com, dyoung@redhat.com
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

 drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..a20af4c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -889,11 +889,24 @@ static bool copy_device_table(void)
 	}
 
 	old_devtb_phys = entry & PAGE_MASK;
+
+	/*
+	 *  When sme enable in the first kernel, old_devtb_phys includes the
+	 *  memory encryption mask(sme_me_mask), we must remove the memory
+	 *  encryption mask to obtain the true physical address in kdump mode.
+	 */
+	if (mem_encrypt_active() && is_kdump_kernel())
+		old_devtb_phys = __sme_clr(old_devtb_phys);
+
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
+		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
+							dev_table_size)
+		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+
 	if (!old_devtb)
 		return false;
 
-- 
2.9.5
