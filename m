Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9B20F088
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468777; cv=none; b=LOhZvXBD898gng9ai9caO4S2+R9k1+rOMX0P2Qkt4ZxZ6vNOAkez1/rwYkjeE+OeNEI4/DImJ9qGFd4dRqOaAmtxxpW9hWk4IQXTOmCwJ3XhIn59FxzAdhWnJZrO4gzbmtlDAuZw8CrCtLSzJst/hRrAU1tDW4jXDPul9SJfCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468777; c=relaxed/simple;
	bh=Vax7/G9E5YAfEbBHn6+S9xTegQB26ThUYjD6uXo6bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbQQwVRT3smpJk1q4ei/lCx8AuI1MILHFHEduvPqnMD/miO7bztvryjPDpHAcHD/n7pH5mgoTMNQd+VfLKXFnN7IgFQL9xjxZQKyAo97fHZe6V2ltiGg1VBe2kQ2Td0J9wQtm+kxKVdt2DvjLMJgUvlo6PFglMuH3BMOkRnMBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moFfp7Ly; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moFfp7Ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468775; x=1784004775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vax7/G9E5YAfEbBHn6+S9xTegQB26ThUYjD6uXo6bz8=;
  b=moFfp7LyaQsl9sB+JtNRw7LEW1s/hGz2TtrRrDswnf9EOWdk+ZDVY9UX
   lH209SaDdkYogelQf75Yyf6N/7psTEPKDpN3d4wuwmLhQ6ZmRyJNlM3Mz
   ZFtjS5xZKMp7+0bRgl8U3p9vP2vusjPDZk/SuoSxT+7c7AP9KWX1JuRaa
   1+MSmK1FzPRJwg9iAiGbXx7/gc0El6X51iPaJgp6DO2Q21qR3E8xmAYST
   aT/OyJ7gTNgFmLRkolkslbF/mDblBb/6SKVVe/X8KMsBPcRBSGzeKaMnF
   Nn0d5cIOrcA1NkW22uCe/z/fKbqLVw4leOFwgOZlRsMBZVa0eiBsHQCj1
   w==;
X-CSE-ConnectionGUID: ZIQr+je6RE6lnP6KFtZkwA==
X-CSE-MsgGUID: Php6JcH2T1y5Y3SyQplTcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765058"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765058"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:55 -0700
X-CSE-ConnectionGUID: yC9+eIHTTLubNaLHsxwlXg==
X-CSE-MsgGUID: Z/cQkoVMQqSCy8GLSXb65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166175"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] iommu/vt-d: Split intel_iommu_domain_alloc_paging_flags()
Date: Mon, 14 Jul 2025 12:50:23 +0800
Message-ID: <20250714045028.958850-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Create stage specific functions that check the stage specific conditions
if each stage can be supported.

Have intel_iommu_domain_alloc_paging_flags() call both stages in sequence
until one does not return EOPNOTSUPP and prefer to use the first stage if
available and suitable for the requested flags.

Move second stage only operations like nested_parent and dirty_tracking
into the second stage function for clarity.

Move initialization of the iommu_domain members into paging_domain_alloc().

Drop initialization of domain->owner as the callers all do it.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/4-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 98 +++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 55e0ba4d20ae..0ac3c3a6d9e7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3281,10 +3281,15 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	spin_lock_init(&domain->lock);
 	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
+	INIT_LIST_HEAD(&domain->s1_domains);
+	spin_lock_init(&domain->s1_lock);
 
 	domain->nid = dev_to_node(dev);
 	domain->use_first_level = first_stage;
 
+	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	domain->domain.ops = intel_iommu_ops.default_domain_ops;
+
 	/* calculate the address width */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -3326,62 +3331,73 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
-				      const struct iommu_user_data *user_data)
+intel_iommu_domain_alloc_first_stage(struct device *dev,
+				     struct intel_iommu *iommu, u32 flags)
+{
+	struct dmar_domain *dmar_domain;
+
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Only SL is available in legacy mode */
+	if (!sm_supported(iommu) || !ecap_flts(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dmar_domain = paging_domain_alloc(dev, true);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+	return &dmar_domain->domain;
+}
+
+static struct iommu_domain *
+intel_iommu_domain_alloc_second_stage(struct device *dev,
+				      struct intel_iommu *iommu, u32 flags)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
-	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
-	bool first_stage;
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
 	       IOMMU_HWPT_ALLOC_PASID)))
 		return ERR_PTR(-EOPNOTSUPP);
-	if (nested_parent && !nested_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
+
+	if (((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+	     !nested_supported(iommu)) ||
+	    ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+	     !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * Always allocate the guest compatible page table unless
-	 * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
-	 * is specified.
-	 */
-	if (nested_parent || dirty_tracking) {
-		if (!sm_supported(iommu) || !ecap_slts(iommu->ecap))
-			return ERR_PTR(-EOPNOTSUPP);
-		first_stage = false;
-	} else {
-		first_stage = first_level_by_default(iommu);
-	}
+	/* Legacy mode always supports second stage */
+	if (sm_supported(iommu) && !ecap_slts(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	dmar_domain = paging_domain_alloc(dev, first_stage);
+	dmar_domain = paging_domain_alloc(dev, false);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
-	domain = &dmar_domain->domain;
-	domain->type = IOMMU_DOMAIN_UNMANAGED;
-	domain->owner = &intel_iommu_ops;
-	domain->ops = intel_iommu_ops.default_domain_ops;
 
-	if (nested_parent) {
-		dmar_domain->nested_parent = true;
-		INIT_LIST_HEAD(&dmar_domain->s1_domains);
-		spin_lock_init(&dmar_domain->s1_lock);
-	}
+	dmar_domain->nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if (dirty_tracking) {
-		if (dmar_domain->use_first_level) {
-			iommu_domain_free(domain);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-		domain->dirty_ops = &intel_dirty_ops;
-	}
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		dmar_domain->domain.dirty_ops = &intel_dirty_ops;
 
-	return domain;
+	return &dmar_domain->domain;
+}
+
+static struct iommu_domain *
+intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
+				      const struct iommu_user_data *user_data)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_domain *domain;
+
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Prefer first stage if possible by default. */
+	domain = intel_iommu_domain_alloc_first_stage(dev, iommu, flags);
+	if (domain != ERR_PTR(-EOPNOTSUPP))
+		return domain;
+	return intel_iommu_domain_alloc_second_stage(dev, iommu, flags);
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
-- 
2.43.0

