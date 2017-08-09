From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 10/12] iommu/amd: Allocate memory below 4G for dev table if translation pre-enabled
Date: Wed,  9 Aug 2017 16:33:42 +0800
Message-ID: <1502267624-7066-11-git-send-email-bhe@redhat.com>
References: <1502267624-7066-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502267624-7066-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

AMD pointed out it's unsafe to update the device-table while iommu
is enabled. It turns out that device-table pointer update is split
up into two 32bit writes in the IOMMU hardware. So updating it while
the IOMMU is enabled could have some nasty side effects.

The safe way to work around this is to always allocate the device-table
below 4G, including the old device-table in normal kernel and the
device-table used for copying the content of the old device-table in kdump
kernel. Meanwhile we need check if the address of old device-table is
above 4G because it might has been touched accidentally in corrupted
1st kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v9->v10:
  The judgement of the address of old_devtb_phys should be '>= 0x100000000ULL'.

 drivers/iommu/amd_iommu_init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d08ad74b0928..c348732f27d7 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -885,11 +885,15 @@ static bool copy_device_table(void)
 	}
 
 	old_devtb_phys = entry & PAGE_MASK;
+	if (old_devtb_phys >= 0x100000000ULL) {
+		pr_err("The address of old device table is above 4G, not trustworthy!/n");
+		return false;
+	}
 	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
 	if (!old_devtb)
 		return false;
 
-	gfp_flag = GFP_KERNEL | __GFP_ZERO;
+	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
 	old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
 				get_order(dev_table_size));
 	if (old_dev_tbl_cpy == NULL) {
@@ -2432,7 +2436,8 @@ static int __init early_amd_iommu_init(void)
 
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
-	amd_iommu_dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+	amd_iommu_dev_table = (void *)__get_free_pages(
+				      GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
 				      get_order(dev_table_size));
 	if (amd_iommu_dev_table == NULL)
 		goto out;
-- 
2.5.5
