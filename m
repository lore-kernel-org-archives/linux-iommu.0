From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra: smmu: Fix smmu_iommu_unmap() return value
Date: Mon, 1 Oct 2012 11:19:19 +0300
Message-ID: <1349079560-31133-1-git-send-email-hdoyu@nvidia.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Fix to return 0 if fails.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0b4d62e..f7e9bf8 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -680,7 +680,7 @@ err_out:
 	return err;
 }
 
-static void __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
+static int __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
 {
 	unsigned long *pte;
 	struct page *page;
@@ -688,10 +688,10 @@ static void __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
 
 	pte = locate_pte(as, iova, false, &page, &count);
 	if (WARN_ON(!pte))
-		return;
+		return -EINVAL;
 
-	if (WARN_ON(*pte == _PTE_VACANT(iova)))
-		return;
+	if (*pte == _PTE_VACANT(iova))
+		return -EINVAL;
 
 	*pte = _PTE_VACANT(iova);
 	FLUSH_CPU_DCACHE(pte, page, sizeof(*pte));
@@ -700,6 +700,8 @@ static void __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
 		free_ptbl(as, iova);
 		smmu_flush_regs(as->smmu, 0);
 	}
+
+	return 0;
 }
 
 static void __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
@@ -747,13 +749,14 @@ static size_t smmu_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 {
 	struct smmu_as *as = domain->priv;
 	unsigned long flags;
+	int err;
 
 	dev_dbg(as->smmu->dev, "[%d] %08lx\n", as->asid, iova);
 
 	spin_lock_irqsave(&as->lock, flags);
-	__smmu_iommu_unmap(as, iova);
+	err = __smmu_iommu_unmap(as, iova);
 	spin_unlock_irqrestore(&as->lock, flags);
-	return SMMU_PAGE_SIZE;
+	return err ? 0 : SMMU_PAGE_SIZE;
 }
 
 static phys_addr_t smmu_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
1.7.5.4
