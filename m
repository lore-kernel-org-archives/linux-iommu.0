From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 2/2] iommu/tegra: smmu: Fix unsleepable memory allocation at
	alloc_pdir()
Date: Fri, 29 Jun 2012 09:15:27 +0300
Message-ID: <1340950527-16482-2-git-send-email-hdoyu@nvidia.com>
References: <20120628.221945.1306825810095951985.hdoyu@nvidia.com>
	<1340950527-16482-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1340950527-16482-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
held. memory allocations in alloc_pdir() had to be atomic. Instead of
converting into atomic allocation, this patch once releases a lock,
does the allocation, holds the lock again and then sees if it's raced
or not in order to avoid introducing mutex and preallocation.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
v3:
Added -EAGAIN in alloc_pdir when raced to retry.
---
 drivers/iommu/tegra-smmu.c |   77 +++++++++++++++++++++++++------------------
 1 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 532c8a4..dbba94c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -539,28 +539,39 @@ static inline void put_signature(struct smmu_as *as,
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
+		err = -EAGAIN;
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
 
@@ -577,6 +588,12 @@ static int alloc_pdir(struct smmu_as *as)
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
@@ -768,29 +785,29 @@ out:
 
 static int smmu_iommu_domain_init(struct iommu_domain *domain)
 {
-	int i;
+	int i, err = -ENODEV;
 	unsigned long flags;
 	struct smmu_as *as;
 	struct smmu_device *smmu = smmu_handle;
 
 	/* Look for a free AS with lock held */
 	for  (i = 0; i < smmu->num_as; i++) {
-		struct smmu_as *tmp = &smmu->as[i];
-
-		spin_lock_irqsave(&tmp->lock, flags);
-		if (!tmp->pdir_page) {
-			as = tmp;
-			goto found;
+		as = &smmu->as[i];
+		spin_lock_irqsave(&as->lock, flags);
+		if (!as->pdir_page) {
+			err = alloc_pdir(as, &flags);
+			if (!err)
+				goto found;
 		}
-		spin_unlock_irqrestore(&tmp->lock, flags);
+		spin_unlock_irqrestore(&as->lock, flags);
+		if (err != -EAGAIN)
+			break;
 	}
-	dev_err(smmu->dev, "no free AS\n");
-	return -ENODEV;
+	if (i == smmu->num_as)
+		dev_err(smmu->dev,  "no free AS\n");
+	return err;
 
 found:
-	if (alloc_pdir(as) < 0)
-		goto err_alloc_pdir;
-
 	spin_lock(&smmu->lock);
 
 	/* Update PDIR register */
@@ -806,10 +823,6 @@ found:
 
 	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
 	return 0;
-
-err_alloc_pdir:
-	spin_unlock_irqrestore(&as->lock, flags);
-	return -ENODEV;
 }
 
 static void smmu_iommu_domain_destroy(struct iommu_domain *domain)
-- 
1.7.5.4
