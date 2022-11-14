Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26E10F2
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 01:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390484; x=1699926484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkg2QOYq9dFPTr9pKF9x/c3y14FfEeHXLWjnD4WbICM=;
  b=K7IR2O7aEIz/q7RmeJSjHqQfG4cuI0hcsLl0RnwAtNtYSFB6wfMzD7gc
   vqk3csVrwrHrY2bNCxJzNUoVv5kEQobAesptwnI+roLsxQiMq7A+2Wj7y
   K5JtYWq/ZkpLfYvEGpYX8cKYG0HKiTFT+qbhk4FyBQL6IHm+/jTINEZ7b
   GPAONIv9KkTvVoWsHsrQpLVogvQiQzTcKMqWAya8pL8dNAmp2VQaQyxaU
   ce2MDbb6JFtX225cUpXa4fCeRc7FeBiMKu5LbfWZAmBDAwX6zLp7nwVQ7
   mWOgcBf5hwSqM6BG8B1fcbmpBbqFFHq/uHbY1OGtn66mydyp0uXKqbbIR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398151528"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398151528"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124274"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124274"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:48:01 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 7/7] iommu/vt-d: Use real field for indication of first level
Date: Mon, 14 Nov 2022 09:40:49 +0800
Message-Id: <20221114014049.3959-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014049.3959-1-baolu.lu@linux.intel.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmar_domain uses bit field members to indicate the behaviors. Add
a bit field for using first level and remove the flags member to avoid
duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h | 15 +++++----------
 drivers/iommu/intel/iommu.c | 25 ++++++++++---------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 251a609fdce3..7b7234689cb4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -515,14 +515,6 @@ struct context_entry {
 	u64 hi;
 };
 
-/*
- * When VT-d works in the scalable mode, it allows DMA translation to
- * happen through either first level or second level page table. This
- * bit marks that the DMA translation for the domain goes through the
- * first level page table, otherwise, it goes through the second level.
- */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
-
 struct iommu_domain_info {
 	struct intel_iommu *iommu;
 	unsigned int refcnt;		/* Refcount of devices per iommu */
@@ -539,6 +531,11 @@ struct dmar_domain {
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
+	u8 use_first_level:1;		/* DMA translation for the domain goes
+					 * through the first level page table,
+					 * otherwise, goes through the second
+					 * level.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
@@ -548,8 +545,6 @@ struct dmar_domain {
 
 	/* adjusted guest address width, 0 is level 2 30-bit */
 	int		agaw;
-
-	int		flags;		/* flags to find out type of domain */
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 83d941b792f2..2e6829da460a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -383,11 +383,6 @@ static inline int domain_type_is_si(struct dmar_domain *domain)
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
-static inline bool domain_use_first_level(struct dmar_domain *domain)
-{
-	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL;
-}
-
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -501,7 +496,7 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (iommu != skip) {
-			if (domain && domain_use_first_level(domain)) {
+			if (domain && domain->use_first_level) {
 				if (!cap_fl1gp_support(iommu->cap))
 					mask = 0x1;
 			} else {
@@ -579,7 +574,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 * paging and 57-bits with 5-level paging). Hence, skip bit
 	 * [N-1].
 	 */
-	if (domain_use_first_level(domain))
+	if (domain->use_first_level)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
 	else
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
@@ -947,7 +942,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
-			if (domain_use_first_level(domain)) {
+			if (domain->use_first_level) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 				if (iommu_is_dma_domain(&domain->domain))
 					pteval |= DMA_FL_PTE_ACCESS;
@@ -1500,7 +1495,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (ih)
 		ih = 1 << 6;
 
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
@@ -1554,7 +1549,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 	 * It's a non-present to present mapping. Only flush if caching mode
 	 * and second level.
 	 */
-	if (cap_caching_mode(iommu->cap) && !domain_use_first_level(domain))
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
@@ -1570,7 +1565,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		struct intel_iommu *iommu = info->iommu;
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
-		if (domain_use_first_level(dmar_domain))
+		if (dmar_domain->use_first_level)
 			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
@@ -1743,7 +1738,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
-		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
+		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	spin_lock_init(&domain->lock);
@@ -2175,7 +2170,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 		if (prot & DMA_PTE_WRITE)
 			attr |= DMA_FL_PTE_DIRTY;
@@ -2445,7 +2440,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
-		else if (domain_use_first_level(domain))
+		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
 					PASID_RID2PASID);
 		else
@@ -4388,7 +4383,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
 	 */
-	if (!domain_use_first_level(domain)) {
+	if (!domain->use_first_level) {
 		domain->set_pte_snp = true;
 		return;
 	}
-- 
2.34.1

