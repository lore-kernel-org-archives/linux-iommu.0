From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 20/22] iommu/amd: Get rid of device_dma_ops_init()
Date: Thu, 28 May 2015 18:41:43 +0200
Message-ID: <1432831305-11126-21-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

With device intialization done in the add_device call-back
now there is no reason for this function anymore.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8682786..978741b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2268,6 +2268,7 @@ static int amd_iommu_add_device(struct device *dev)
 	ret = iommu_init_device(dev);
 	if (ret == -ENOTSUPP) {
 		iommu_ignore_device(dev);
+		dev->archdata.dma_ops = &nommu_dma_ops;
 		goto out;
 	}
 	init_iommu_group(dev);
@@ -2840,36 +2841,6 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 	.dma_supported = amd_iommu_dma_supported,
 };
 
-static unsigned device_dma_ops_init(void)
-{
-	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev = NULL;
-	unsigned unhandled = 0;
-
-	for_each_pci_dev(pdev) {
-		if (!check_device(&pdev->dev)) {
-
-			iommu_ignore_device(&pdev->dev);
-
-			unhandled += 1;
-			continue;
-		}
-
-		dev_data = get_dev_data(&pdev->dev);
-
-		if (!dev_data->passthrough)
-			pdev->dev.archdata.dma_ops = &amd_iommu_dma_ops;
-		else
-			pdev->dev.archdata.dma_ops = &nommu_dma_ops;
-	}
-
-	return unhandled;
-}
-
-/*
- * The function which clues the AMD IOMMU driver into dma_ops.
- */
-
 void __init amd_iommu_init_api(void)
 {
 	bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
@@ -2877,18 +2848,9 @@ void __init amd_iommu_init_api(void)
 
 int __init amd_iommu_init_dma_ops(void)
 {
-	int unhandled;
-
 	iommu_detected = 1;
 	swiotlb = 0;
 
-	/* Make the driver finally visible to the drivers */
-	unhandled = device_dma_ops_init();
-	if (unhandled && max_pfn > MAX_DMA32_PFN) {
-		/* There are unhandled devices - initialize swiotlb for them */
-		swiotlb = 1;
-	}
-
 	amd_iommu_stats_init();
 
 	if (amd_iommu_unmap_flush)
-- 
1.9.1
