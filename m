From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev table if translation pre-enabled
Date: Fri, 21 Jul 2017 16:59:08 +0800
Message-ID: <1500627551-12930-11-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

AMD pointed out it's unsafe to update the device-table while iommu
is enabled. It turns out that device-table pointer update is split
up into two 32bit writes in the IOMMU hardware. So updating it while
the IOMMU is enabled could have some nasty side effects.

The only way to work around this is to allocate the device-table below
4GB if translation is pre-enabled in kdump kernel. If allocation failed,
still use the old one.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 052fa4a977d8..d7c301d0d672 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2149,11 +2149,23 @@ static void early_enable_iommu(struct amd_iommu *iommu)
  */
 static void early_enable_iommus(void)
 {
+	struct dev_table_entry *dev_tbl;
 	struct amd_iommu *iommu;
 	bool is_pre_enabled = false;
 
 	for_each_iommu(iommu) {
 		if (translation_pre_enabled(iommu)) {
+			gfp_t gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;;
+
+			dev_tbl = (void *)__get_free_pages(gfp_flag,
+						get_order(dev_table_size));
+			if (dev_tbl != NULL) {
+				memcpy(dev_tbl, amd_iommu_dev_table, dev_table_size);
+				free_pages((unsigned long)amd_iommu_dev_table,
+						get_order(dev_table_size));
+				amd_iommu_dev_table = dev_tbl;
+			}
+
 			is_pre_enabled = true;
 			break;
 		}
-- 
2.5.5
