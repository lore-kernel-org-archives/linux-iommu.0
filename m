Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D716FF26
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684489; cv=none; b=AiC7hrW25vRoRxyyJXRee+O/FQNDOt3H4CXNSdOo0p8C/QtuHOHziZ2GW8i1mjgrVOT8VXvl2Y0iKWF/bBTkKYLP+uftLZ1vOJOBlE3cg0FF2oD8J8ZQtfYltdqKaEWLC+RKoxlVzIl6iNb+1Pzko2BuVEmHF2mf1j6wGQ04ZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684489; c=relaxed/simple;
	bh=QcpfltD2S83XCgx4pKIL4C7A7GJ6FPnuWx1b9wVQnTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpypu0zPJhopD6I9VxuQfWOifBKbJ+MTaAp3VimLi6qeRVhVmuO7REfnIjbyVlPtHxETuZUiXW1Q85DYtyxxtCSxcKwnofq96cO45FE9BPX5p/0MFFazvtISEV5mg2Zap+IKpEQ1t+GuJqc2lEGBd6mWzUdI7dBxxN5xybJpUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJpjOyBg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJpjOyBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684488; x=1762220488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QcpfltD2S83XCgx4pKIL4C7A7GJ6FPnuWx1b9wVQnTo=;
  b=HJpjOyBgNWnI+xLVquAUCZzNaV7gAIlanq0shF1BBteMSJhXdf1jymNW
   e0E4ZgJE8vN98g5Y0IbonMoeR+uL4qsmIZ+JwI394Jcj+Tb0JuY1YRhLA
   TI0ICMsKNTQ2Nwm39LThmwLb1yIX6FSlSQ4W0IXO4d0aqZBi8QaeWEpbd
   K0z+gUMONt8yGMgb3MQgSdVxOx4pI5IqeC9lzbHKPCXJP7UW2Z6C+rOhe
   Ykf0y/DXWtduUlmC1CtDKBEDmKstS2s3vLA2BoTLuY9zo0joOK6tMexWK
   l072MnGpQ4AcK36zWFetHWJr6QukvYQMNRDqqnYkQ82wTLOH277ISoJzB
   g==;
X-CSE-ConnectionGUID: /vhkJA11T2WNKB76lUYBNQ==
X-CSE-MsgGUID: GlIx+J04Rw+pvS6RuskXoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221915"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221915"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:26 -0800
X-CSE-ConnectionGUID: 9otV2VA0Tf6j5wAGZAzq5w==
X-CSE-MsgGUID: VXw7C+4ySL2EsbLRaXEKRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020871"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] iommu/vt-d: Remove unused domain_alloc callback
Date: Mon,  4 Nov 2024 09:40:22 +0800
Message-ID: <20241104014040.106100-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20241021085125.192333-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 90 -------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0d2237b55b6b..204e624b3f9a 100644
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
@@ -3381,27 +3346,6 @@ void device_block_translation(struct device *dev)
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
@@ -3488,39 +3432,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
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
@@ -4611,7 +4522,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.identity_domain	= &identity_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
-	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
-- 
2.43.0

