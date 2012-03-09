From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix double free of mem-region in error-path
Date: Fri, 9 Mar 2012 13:41:37 +0100
Message-ID: <1331296897-11212-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When ioremap_nocache fails in iommu initialization the code
calls release_mem_region immediatly. But the function is
called again when the propagates into the upper init
functions leading to a double-free. Fix that.

Reported-by: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 75653da..526652a 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -358,8 +358,6 @@ static void iommu_disable(struct amd_iommu *iommu)
  */
 static u8 * __init iommu_map_mmio_space(u64 address)
 {
-	u8 *ret;
-
 	if (!request_mem_region(address, MMIO_REGION_LENGTH, "amd_iommu")) {
 		pr_err("AMD-Vi: Can not reserve memory region %llx for mmio\n",
 			address);
@@ -367,13 +365,7 @@ static u8 * __init iommu_map_mmio_space(u64 address)
 		return NULL;
 	}
 
-	ret = ioremap_nocache(address, MMIO_REGION_LENGTH);
-	if (ret != NULL)
-		return ret;
-
-	release_mem_region(address, MMIO_REGION_LENGTH);
-
-	return NULL;
+	return ioremap_nocache(address, MMIO_REGION_LENGTH);
 }
 
 static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
-- 
1.7.5.4
