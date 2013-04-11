From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] iommu: Fix printk formats for dma_addr_t
Date: Thu, 11 Apr 2013 09:19:44 +0530
Message-ID: <1365652184-4340-1-git-send-email-Varun.Sethi@freescale.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Fix printk formats for dma_addr_t:

   drivers/iommu/tegra-smmu.c: In function 'smmu_iommu_iova_to_phys':
>> drivers/iommu/tegra-smmu.c:774:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]
--
   drivers/iommu/tegra-gart.c: In function 'gart_iommu_iova_to_phys':
>> drivers/iommu/tegra-gart.c:298:3: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'dma_addr_t' [-Wformat]

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    3 ++-
 drivers/iommu/tegra-smmu.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 4aec8be..108c0e9 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -295,7 +295,8 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = (pte & GART_PAGE_MASK);
 	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08lx:%08x\n", iova, pa);
+		dev_err(gart->dev, "No entry for %08llx:%08x\n",
+			 (unsigned long long)iova, pa);
 		gart_dump_table(gart);
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index bc9b599..f6f120e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -772,7 +772,8 @@ static phys_addr_t smmu_iommu_iova_to_phys(struct iommu_domain *domain,
 	pfn = *pte & SMMU_PFN_MASK;
 	WARN_ON(!pfn_valid(pfn));
 	dev_dbg(as->smmu->dev,
-		"iova:%08lx pfn:%08lx asid:%d\n", iova, pfn, as->asid);
+		"iova:%08llx pfn:%08lx asid:%d\n", (unsigned long long)iova,
+		 pfn, as->asid);
 
 	spin_unlock_irqrestore(&as->lock, flags);
 	return PFN_PHYS(pfn);
-- 
1.7.4.1
