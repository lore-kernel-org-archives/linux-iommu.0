From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [v3.6 3/3] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
Date: Tue, 17 Jul 2012 12:09:01 +0200
Message-ID: <20120717100901.GH4213@amd.com>
References: <1341228398-6878-1-git-send-email-hdoyu@nvidia.com>
 <1341228398-6878-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341228398-6878-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 02, 2012 at 02:26:38PM +0300, Hiroshi DOYU wrote:

> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
> Cc: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
> Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

Applied patch 2 and 3 but not patch 1. The resulting conflicts are
solved while merging the next branch. Also I am not happy with the way
the as->lock is taken and released multiple times in patch 3. So I added
another commit on-top. Please have a look at it as I can only
compile-test that change:

>From f9a4f063a88297e361fd6676986cf3e39b22de72 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 17 Jul 2012 11:47:14 +0200
Subject: [PATCH] iommu/tegra: Don't call alloc_pdir with as->lock

Instead of taking as->lock before calling alloc_pdir() and
releasing it in that function to allocate memory, just take
the lock only in the alloc_pdir function and run the loop
without any lock held. This simplifies the complicated
lock->unlock->alloc->lock->unlock sequence into
alloc->lock->unlock.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 68a15a0..541d210 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -553,11 +553,11 @@ static inline void put_signature(struct smmu_as *as,
 #endif
 
 /*
- * Caller must lock/unlock as
+ * Caller must not hold as->lock
  */
-static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
+static int alloc_pdir(struct smmu_as *as)
 {
-	unsigned long *pdir;
+	unsigned long *pdir, flags;
 	int pdn, err = 0;
 	u32 val;
 	struct smmu_device *smmu = as->smmu;
@@ -565,13 +565,14 @@ static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
 	unsigned int *cnt;
 
 	/*
-	 * do the allocation outside the as->lock
+	 * do the allocation, then grab as->lock
 	 */
-	spin_unlock_irqrestore(&as->lock, *flags);
 	cnt = devm_kzalloc(smmu->dev,
-			   sizeof(cnt[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
+			   sizeof(cnt[0]) * SMMU_PDIR_COUNT,
+			   GFP_KERNEL);
 	page = alloc_page(GFP_KERNEL | __GFP_DMA);
-	spin_lock_irqsave(&as->lock, *flags);
+
+	spin_lock_irqsave(&as->lock, flags);
 
 	if (as->pdir_page) {
 		/* We raced, free the redundant */
@@ -603,9 +604,13 @@ static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
 	smmu_write(smmu, val, SMMU_TLB_FLUSH);
 	FLUSH_SMMU_REGS(as->smmu);
 
+	spin_unlock_irqrestore(&as->lock, flags);
+
 	return 0;
 
 err_out:
+	spin_unlock_irqrestore(&as->lock, flags);
+
 	devm_kfree(smmu->dev, cnt);
 	if (page)
 		__free_page(page);
@@ -809,13 +814,11 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
 	/* Look for a free AS with lock held */
 	for  (i = 0; i < smmu->num_as; i++) {
 		as = &smmu->as[i];
-		spin_lock_irqsave(&as->lock, flags);
 		if (!as->pdir_page) {
-			err = alloc_pdir(as, &flags);
+			err = alloc_pdir(as);
 			if (!err)
 				goto found;
 		}
-		spin_unlock_irqrestore(&as->lock, flags);
 		if (err != -EAGAIN)
 			break;
 	}
@@ -824,7 +827,7 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
 	return err;
 
 found:
-	spin_lock(&smmu->lock);
+	spin_lock_irqsave(&smmu->lock, flags);
 
 	/* Update PDIR register */
 	smmu_write(smmu, SMMU_PTB_ASID_CUR(as->asid), SMMU_PTB_ASID);
@@ -832,12 +835,12 @@ found:
 		   SMMU_MK_PDIR(as->pdir_page, as->pdir_attr), SMMU_PTB_DATA);
 	FLUSH_SMMU_REGS(smmu);
 
-	spin_unlock(&smmu->lock);
+	spin_unlock_irqrestore(&smmu->lock, flags);
 
-	spin_unlock_irqrestore(&as->lock, flags);
 	domain->priv = as;
 
 	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
+
 	return 0;
 }
 
-- 
1.7.9.5


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
