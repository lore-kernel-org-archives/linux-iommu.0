From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/tegra: smmu: Don't allocate pte at iova_to_phys
Date: Mon, 1 Oct 2012 11:19:20 +0300
Message-ID: <1349079560-31133-2-git-send-email-hdoyu@nvidia.com>
References: <1349079560-31133-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1349079560-31133-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

No need to allocate new pte if it doesn't exsit just for translation.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f7e9bf8..dee8f22 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -766,14 +766,14 @@ static phys_addr_t smmu_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned long *pte;
 	unsigned int *count;
 	struct page *page;
-	unsigned long pfn;
+	unsigned long pfn = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&as->lock, flags);
 
-	pte = locate_pte(as, iova, true, &page, &count);
-	pfn = *pte & SMMU_PFN_MASK;
-	WARN_ON(!pfn_valid(pfn));
+	pte = locate_pte(as, iova, false, &page, &count);
+	if (pte)
+		pfn = *pte & SMMU_PFN_MASK;
 	dev_dbg(as->smmu->dev,
 		"iova:%08lx pfn:%08lx asid:%d\n", iova, pfn, as->asid);
 
-- 
1.7.5.4
