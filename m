From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/amd: pr_err() strings should end with newlines
Date: Tue, 26 Sep 2017 13:07:46 +0530
Message-ID: <a981b82525849ccf4fa869c74c0358f350a9998d.1506411289.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated. So replace '/n' with '\n'.

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 382de42..6fe2d03 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -874,7 +874,7 @@ static bool copy_device_table(void)
 		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
 		entry = (((u64) hi) << 32) + lo;
 		if (last_entry && last_entry != entry) {
-			pr_err("IOMMU:%d should use the same dev table as others!/n",
+			pr_err("IOMMU:%d should use the same dev table as others!\n",
 				iommu->index);
 			return false;
 		}
@@ -882,7 +882,7 @@ static bool copy_device_table(void)
 
 		old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
 		if (old_devtb_size != dev_table_size) {
-			pr_err("The device table size of IOMMU:%d is not expected!/n",
+			pr_err("The device table size of IOMMU:%d is not expected!\n",
 				iommu->index);
 			return false;
 		}
@@ -890,7 +890,7 @@ static bool copy_device_table(void)
 
 	old_devtb_phys = entry & PAGE_MASK;
 	if (old_devtb_phys >= 0x100000000ULL) {
-		pr_err("The address of old device table is above 4G, not trustworthy!/n");
+		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
 	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -901,7 +901,7 @@ static bool copy_device_table(void)
 	old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
 				get_order(dev_table_size));
 	if (old_dev_tbl_cpy == NULL) {
-		pr_err("Failed to allocate memory for copying old device table!/n");
+		pr_err("Failed to allocate memory for copying old device table!\n");
 		return false;
 	}
 
-- 
1.9.1
