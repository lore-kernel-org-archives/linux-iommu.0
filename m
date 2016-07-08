From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/20] iommu/amd: Introduce dir2prot() helper
Date: Fri,  8 Jul 2016 13:45:06 +0200
Message-ID: <1467978311-28322-16-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This function converts dma_data_direction to
iommu-protection flags. This will be needed on multiple
places in the code, so this will save some code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1bb003e..78b278b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2260,6 +2260,17 @@ static void update_domain(struct protection_domain *domain)
 	domain->updated = false;
 }
 
+static int dir2prot(enum dma_data_direction direction)
+{
+	if (direction == DMA_TO_DEVICE)
+		return IOMMU_PROT_IR;
+	else if (direction == DMA_FROM_DEVICE)
+		return IOMMU_PROT_IW;
+	else if (direction == DMA_BIDIRECTIONAL)
+		return IOMMU_PROT_IW | IOMMU_PROT_IR;
+	else
+		return 0;
+}
 /*
  * This function contains common code for mapping of a physically
  * contiguous memory region into DMA address space. It is used by all
@@ -2270,7 +2281,7 @@ static dma_addr_t __map_single(struct device *dev,
 			       struct dma_ops_domain *dma_dom,
 			       phys_addr_t paddr,
 			       size_t size,
-			       int direction,
+			       enum dma_data_direction direction,
 			       u64 dma_mask)
 {
 	dma_addr_t offset = paddr & ~PAGE_MASK;
@@ -2286,12 +2297,7 @@ static dma_addr_t __map_single(struct device *dev,
 	if (address == DMA_ERROR_CODE)
 		goto out;
 
-	if (direction == DMA_TO_DEVICE)
-		prot = IOMMU_PROT_IR;
-	else if (direction == DMA_FROM_DEVICE)
-		prot = IOMMU_PROT_IW;
-	else if (direction == DMA_BIDIRECTIONAL)
-		prot = IOMMU_PROT_IW | IOMMU_PROT_IR;
+	prot = dir2prot(direction);
 
 	start = address;
 	for (i = 0; i < pages; ++i) {
-- 
1.9.1
