From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v2 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation at
	alloc_pdir()
Date: Thu, 28 Jun 2012 13:51:47 +0300
Message-ID: <1340880707-6934-1-git-send-email-hdoyu@nvidia.com>
References: <20120628134202.2102f715496a3b980b43f3b0@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120628134202.2102f715496a3b980b43f3b0-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

alloc_pdir() is called from smmu_iommu_domain_init() with spin_lock
held. memory allocations in alloc_pdir() had to be
atomic/unsleepable. Instead of converting into atomic allocation, this
patch once releases a lock, do the allocation, hold the lock again and
then see if it's raced or not in order to avoid introducing mutex.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   49 +++++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ecd6790..ec656ec 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -539,31 +539,42 @@ static inline void put_signature(struct smmu_as *as,
 /*
  * Caller must lock/unlock as
  */
-static int alloc_pdir(struct smmu_as *as)
+static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
 {
 	unsigned long *pdir;
-	int pdn;
+	int pdn, err = 0;
 	u32 val;
 	struct smmu_device *smmu = as->smmu;
+	struct page *page;
+	unsigned int *cnt;
 
 	if (as->pdir_page)
 		return 0;
 
-	as->pte_count = devm_kzalloc(smmu->dev,
-		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
-	if (!as->pte_count) {
-		dev_err(smmu->dev,
-			"failed to allocate smmu_device PTE cunters\n");
-		return -ENOMEM;
+	/*
+	 * do the allocation outside the as lock
+	 */
+	spin_unlock_irqrestore(&as->lock, *flags);
+	cnt = devm_kzalloc(smmu->dev,
+			   sizeof(cnt[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL | __GFP_DMA);
+	spin_lock_irqsave(&as->lock, *flags);
+
+	if (as->pdir_page) {
+		/* We raced, free the redundant */
+		err = -ENODEV;
+		goto err_out;
 	}
-	as->pdir_page = alloc_page(GFP_KERNEL | __GFP_DMA);
-	if (!as->pdir_page) {
-		dev_err(smmu->dev,
-			"failed to allocate smmu_device page directory\n");
-		devm_kfree(smmu->dev, as->pte_count);
-		as->pte_count = NULL;
-		return -ENOMEM;
+
+	if (!page || !cnt) {
+		dev_err(smmu->dev, "failed to allocate at %s\n", __func__);
+		err = -ENOMEM;
+		goto err_out;
 	}
+
+	as->pdir_page = page;
+	as->pte_count = cnt;
+
 	SetPageReserved(as->pdir_page);
 	pdir = page_address(as->pdir_page);
 
@@ -580,6 +591,12 @@ static int alloc_pdir(struct smmu_as *as)
 	FLUSH_SMMU_REGS(as->smmu);
 
 	return 0;
+
+err_out:
+	devm_kfree(smmu->dev, cnt);
+	if (page)
+		__free_page(page);
+	return err;
 }
 
 static void __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
@@ -791,7 +808,7 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
 	return -ENODEV;
 
 found:
-	if (alloc_pdir(as) < 0)
+	if (alloc_pdir(as, &flags) < 0)
 		goto err_alloc_pdir;
 
 	spin_lock(&smmu->lock);
-- 
1.7.5.4
