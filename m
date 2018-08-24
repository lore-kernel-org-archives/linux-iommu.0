From: murphyt7@tcd.ie
Subject: [PATCH] Changing the AMD IOMMU API path to work in an atomic context which is necessary for any custom drivers using the IOMMU API while holding a spinlock.
Date: Fri, 24 Aug 2018 14:28:49 +0000
Message-ID: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: leo.duran@amd.com
Cc: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Tom Murphy <murphyt7@tcd.ie>

---

This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.

 drivers/iommu/amd_iommu.c       | 14 ++++++++------
 drivers/iommu/amd_iommu_types.h |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0c910a8..642afc9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2904,7 +2904,7 @@ static void protection_domain_free(struct protection_domain *domain)
 static int protection_domain_init(struct protection_domain *domain)
 {
 	spin_lock_init(&domain->lock);
-	mutex_init(&domain->api_lock);
+	spin_lock_init(&domain->api_lock);
 	domain->id = domain_id_alloc();
 	if (!domain->id)
 		return -ENOMEM;
@@ -3088,6 +3088,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 phys_addr_t paddr, size_t page_size, int iommu_prot)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
 	int prot = 0;
 	int ret;
 
@@ -3099,9 +3100,9 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
+	spin_lock_irqsave(&domain->api_lock, flags);
+	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_ATOMIC);
+	spin_unlock_irqrestore(&domain->api_lock, flags);
 
 	return ret;
 }
@@ -3110,14 +3111,15 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			   size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
 	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
-	mutex_lock(&domain->api_lock);
+	spin_lock_irqsave(&domain->api_lock, flags);
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
-	mutex_unlock(&domain->api_lock);
+	spin_unlock_irqrestore(&domain->api_lock, flags);
 
 	domain_flush_tlb_pde(domain);
 	domain_flush_complete(domain);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0d91785..a9077a5 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -444,7 +444,7 @@ struct protection_domain {
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
 	spinlock_t lock;	/* mostly used to lock the page table*/
-	struct mutex api_lock;	/* protect page tables in the iommu-api path */
+	spinlock_t api_lock;	/* protect page tables in the iommu-api path */
 	u16 id;			/* the domain id written to the device table */
 	int mode;		/* paging mode (0-6 levels) */
 	u64 *pt_root;		/* page table root pointer */
-- 
2.7.4
