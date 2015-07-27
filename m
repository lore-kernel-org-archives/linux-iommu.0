From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: Clean up DMA API usage
Date: Mon, 27 Jul 2015 19:18:11 +0100
Message-ID: <832ec87069a516232cb39e039b2abdcacc2a8406.1438019069.git.robin.murphy@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8e9ec81..caa01a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1304,23 +1304,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
 
-	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
+	/* The page table code handles flushing in the non-coherent case */
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		dsb(ishst);
-	} else {
-		dma_addr_t dma_addr;
-		struct device *dev = smmu->dev;
-
-		dma_addr = dma_map_page(dev, virt_to_page(addr), offset, size,
-					DMA_TO_DEVICE);
-
-		if (dma_mapping_error(dev, dma_addr))
-			dev_err(dev, "failed to flush pgtable at %p\n", addr);
-		else
-			dma_unmap_page(dev, dma_addr, size, DMA_TO_DEVICE);
-	}
 }
 
 static struct iommu_gather_ops arm_smmu_gather_ops = {
@@ -1503,6 +1490,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
 	};
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		pgtbl_cfg.iommu_dev = smmu->dev;
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
-- 
1.9.1
