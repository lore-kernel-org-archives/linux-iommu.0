From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 3.2] iommu/amd: Initialize device table after dma_ops
Date: Thu, 28 Feb 2013 14:39:50 -0700
Message-ID: <1362087590.2822.44.camel@lorien2>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When dma_ops are initialized the unity mappings are created. The
init_device_table_dma() function makes sure DMA from all devices is
blocked by default. This opens a short window in time where DMA to
unity mapped regions is blocked by the IOMMU. Make sure this does not
happen by initializing the device table after dma_ops.

Back-port upstream commit: f528d980c17b8714aedc918ba86e058af914d66b
Tested on 3.2.38

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 3.2
---
 drivers/iommu/amd_iommu_init.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 62a4d5c..b7d1cdd 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1396,6 +1396,7 @@ static struct syscore_ops amd_iommu_syscore_ops = {
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int i, ret = 0;
 
 	/*
@@ -1444,9 +1445,6 @@ static int __init amd_iommu_init(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto free;
 
-	/* init the device table */
-	init_device_table();
-
 	/*
 	 * let all alias entries point to itself
 	 */
@@ -1496,6 +1494,12 @@ static int __init amd_iommu_init(void)
 	if (ret)
 		goto free_disable;
 
+	/* init the device table */
+	init_device_table();
+
+	for_each_iommu(iommu)
+		iommu_flush_all_caches(iommu);
+
 	amd_iommu_init_api();
 
 	amd_iommu_init_notifier();
-- 
1.7.10.4
