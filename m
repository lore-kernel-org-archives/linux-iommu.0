Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978B1E32AD
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500988; cv=none; b=hY4f8oBNbNk0lt58sDbwWVd0PsbFHDZMnncu+MZxjYUqrjPvIg+iMshnoPLp4AOzuumOQm3YqjwvWROpZDJY4sEVSGDYTcK/YP0/5ZrJX8i63kvWPtidzDs7BEk5zuSxg3jEZL1pD5shW21bUFJ6y6j/xBipX1dmj7rbBXkuFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500988; c=relaxed/simple;
	bh=Ipggo0JmfDpQ0wdjbffP3UNsOLeRkPCrGAoJRWLXKUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/EagiemHFOHa69SA2CivB6eoPj9iXy1R/5NvvQQfWxInf6CquGdUd1SXyu1VSm9UymvRVF26r6NUj6vphAkz/ttL+td3wQesYeByLDCrAVkerUFCEmhTwxMe8L6DM3EB/lhQ3rwM8RUXC+yGxqvZw8Wq3SaLoPWxV4tHEugBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/M/0isH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/M/0isH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500987; x=1761036987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ipggo0JmfDpQ0wdjbffP3UNsOLeRkPCrGAoJRWLXKUk=;
  b=b/M/0isHHI1FdqtWziiFYaGRzgmGYzpxnUqEVRncFUOa3DjjHuQdTVYP
   NROWAqfZJMFA7gGmtPJPY5iCbmQlxpROMYUAmf4fHUTIGQzRqtr1oFV7s
   m1oslmFbXUAnjs3eXf6mGJY/KFWQO6wlU0/jfOl6wGwA6Qe+1BNofX9Fy
   nzx0OZyTiCMURXaFy6KaCTVkEW2NdGxp/HC1SOy5plqCRZbAaHaffTnSR
   voC0UQzitM1AQGurZoVpW4IQTlEzey20wqqd16Ls4sX+SaClacVovBs8D
   Ok6RDQcp2pjHAT2sVVjiO5XecwE6C2lgFOdX+A40Dl900q/XEUWJJUjv5
   A==;
X-CSE-ConnectionGUID: Y+cT+Rx1T4irRC7kETPYBA==
X-CSE-MsgGUID: MMlujattRBm5aVtvvgHJEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780331"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:27 -0700
X-CSE-ConnectionGUID: mKwt2/uCTVKYmg5oXIn4AA==
X-CSE-MsgGUID: B7UPBxjfT9SU2iFko+CULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812720"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/7] iommu/vt-d: Remove unused domain_alloc callback
Date: Mon, 21 Oct 2024 16:51:19 +0800
Message-ID: <20241021085125.192333-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With domain_alloc_paging callback supported, the legacy domain_alloc
callback will never be used anymore. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 90 -------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4803e0cb8279..dd158ff5fd45 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1454,27 +1454,6 @@ static bool first_level_by_default(unsigned int type)
 	return type != IOMMU_DOMAIN_UNMANAGED;
 }
 
-static struct dmar_domain *alloc_domain(unsigned int type)
-{
-	struct dmar_domain *domain;
-
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
-	domain->nid = NUMA_NO_NODE;
-	if (first_level_by_default(type))
-		domain->use_first_level = true;
-	INIT_LIST_HEAD(&domain->devices);
-	INIT_LIST_HEAD(&domain->dev_pasids);
-	INIT_LIST_HEAD(&domain->cache_tags);
-	spin_lock_init(&domain->lock);
-	spin_lock_init(&domain->cache_lock);
-	xa_init(&domain->iommu_array);
-
-	return domain;
-}
-
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
@@ -1546,20 +1525,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	spin_unlock(&iommu->lock);
 }
 
-static int guestwidth_to_adjustwidth(int gaw)
-{
-	int agaw;
-	int r = (gaw - 12) % 9;
-
-	if (r == 0)
-		agaw = gaw;
-	else
-		agaw = gaw + 9 - r;
-	if (agaw > 64)
-		agaw = 64;
-	return agaw;
-}
-
 static void domain_exit(struct dmar_domain *domain)
 {
 	if (domain->pgd) {
@@ -3379,27 +3344,6 @@ void device_block_translation(struct device *dev)
 	info->domain = NULL;
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width)
-{
-	int adjust_width;
-
-	/* calculate AGAW */
-	domain->gaw = guest_width;
-	adjust_width = guestwidth_to_adjustwidth(guest_width);
-	domain->agaw = width_to_agaw(adjust_width);
-
-	domain->iommu_coherency = false;
-	domain->iommu_superpage = 0;
-	domain->max_addr = 0;
-
-	/* always allocate the top pgd */
-	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
-	if (!domain->pgd)
-		return -ENOMEM;
-	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
-	return 0;
-}
-
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev)
 {
@@ -3486,39 +3430,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	return domain;
 }
 
-static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
-{
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
-
-	switch (type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(type);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
-			return NULL;
-		}
-		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-			pr_err("Domain initialization failed\n");
-			domain_exit(dmar_domain);
-			return NULL;
-		}
-
-		domain = &dmar_domain->domain;
-		domain->geometry.aperture_start = 0;
-		domain->geometry.aperture_end   =
-				__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-		domain->geometry.force_aperture = true;
-
-		return domain;
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 static struct iommu_domain *
 intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
@@ -4609,7 +4520,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.identity_domain	= &identity_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
-	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
-- 
2.43.0

