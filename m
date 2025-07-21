Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417A1ACED5
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753075160; cv=none; b=c6c/IilNasvtzfK6HrqWRLaL+GUiXa0PB/G0qLSOgdq2NtBWp6RCXsbTQfrlrjwxGG0Aq8+stNjfPbxV1NsNLj0uJhdnA52TlysiwwDmSaL++/wHrUg/6ilSdhv0xeuRI6w7sntRr7CqS5CxmMmEBWUZxeW4DUy7uQma2fN6EAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753075160; c=relaxed/simple;
	bh=k7AeqVpQc2gYoKy9niAIEhegqvqoDeNMahGus4tm2n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jylleICPUKLozPIxLBOqD+Ofi5wTH3EIlfI+nEIgeJpR2P6/reW0e3VN0qAe/3Ft5YYaZCDMLwn3BCv5ufln9RXg8JWgx53Wmqz+vtwha4P00WGfiesRNlFg36Q/PezxnI8sYwsMxBhcsTtIg2enu4W6XdER1zxA9d6dmXRj9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcfAspEp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcfAspEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753075159; x=1784611159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k7AeqVpQc2gYoKy9niAIEhegqvqoDeNMahGus4tm2n8=;
  b=jcfAspEpll9f+z3mgFCBtTJSO2rad8WHPgoPtNouYHVaCfWeL6FM8RRr
   ueSC/oaPF7CP5Z4Gxk/NIdcoOx2GkepZ9N1bO1RyODioWiO9qGunjEx0t
   RrDbAc7jU8h5r0igEqOEnGOyGU8rhWqlZoJ75Da6y+xrInBcYLmQfZWhp
   dNri4MIkI2Dp4kydexTzBy43RUZc+ZFvi6mQk6E8PnHbt05dKxzBObEd/
   aBymvtPOxZJ3/Hx1xbbN4aUyK2inDkakoV4NKxlKBn0vhGUHcteChi3M+
   WXvPoE4QG6RCF0U6QralJjJ4aAeSmlBRgBZtvcQQp0mgRH1cLJFZQ2Zmo
   g==;
X-CSE-ConnectionGUID: aHWGlHLOTD+MdMoEqyk9kw==
X-CSE-MsgGUID: GfakRjnSRp2vtdAQ0ktj4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="77816549"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="77816549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 22:19:19 -0700
X-CSE-ConnectionGUID: 54V94aIkSHmnfJUnfeQ/dw==
X-CSE-MsgGUID: scie0wzTSB2J8qakrkHK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158792931"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jul 2025 22:19:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain
Date: Mon, 21 Jul 2025 13:16:57 +0800
Message-ID: <20250721051657.1695788-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 12724ce3fe1a ("iommu/vt-d: Optimize iotlb_sync_map for
non-caching/non-RWBF modes") dynamically set iotlb_sync_map. This causes
synchronization issues due to lack of locking on map and attach paths,
racing iommufd userspace operations.

Invalidation changes must precede device attachment to ensure all flushes
complete before hardware walks page tables, preventing coherence issues.

Make domain->iotlb_sync_map static, set once during domain allocation. If
an IOMMU requires iotlb_sync_map but the domain lacks it, attach is
rejected. This won't reduce domain sharing: RWBF and shadowing page table
caching are legacy uses with legacy hardware. Mixed configs (some IOMMUs
in caching mode, others not) are unlikely in real-world scenarios.

Fixes: 12724ce3fe1a ("iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 43 +++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8db8be9b7e7d..7c64d88ece77 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -57,6 +57,8 @@
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
+#define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
+
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
  * (used when kernel is launched w/ TXT)
@@ -1780,18 +1782,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  __pa(pgd), flags, old);
 }
 
-static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
-				       struct intel_iommu *iommu)
-{
-	if (cap_caching_mode(iommu->cap) && intel_domain_is_ss_paging(domain))
-		return true;
-
-	if (rwbf_quirk || cap_rwbf(iommu->cap))
-		return true;
-
-	return false;
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -1831,8 +1821,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
-
 	return 0;
 
 out_block_translation:
@@ -3352,6 +3340,14 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 		return ERR_CAST(dmar_domain);
 
 	dmar_domain->domain.ops = &intel_fs_paging_domain_ops;
+	/*
+	 * iotlb sync for map is only needed for legacy implementations that
+	 * explicitly require flushing internal write buffers to ensure memory
+	 * coherence.
+	 */
+	if (rwbf_required(iommu))
+		dmar_domain->iotlb_sync_map = true;
+
 	return &dmar_domain->domain;
 }
 
@@ -3386,6 +3382,14 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
 		dmar_domain->domain.dirty_ops = &intel_dirty_ops;
 
+	/*
+	 * Besides the internal write buffer flush, the caching mode used for
+	 * legacy nested translation (which utilizes shadowing page tables)
+	 * also requires iotlb sync on map.
+	 */
+	if (rwbf_required(iommu) || cap_caching_mode(iommu->cap))
+		dmar_domain->iotlb_sync_map = true;
+
 	return &dmar_domain->domain;
 }
 
@@ -3446,6 +3450,11 @@ static int paging_domain_compatible_first_stage(struct dmar_domain *dmar_domain,
 	if (!cap_fl1gp_support(iommu->cap) &&
 	    (dmar_domain->domain.pgsize_bitmap & SZ_1G))
 		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_required(iommu)) && !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3469,6 +3478,12 @@ paging_domain_compatible_second_stage(struct dmar_domain *dmar_domain,
 		return -EINVAL;
 	if (!(sslps & BIT(1)) && (dmar_domain->domain.pgsize_bitmap & SZ_1G))
 		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_required(iommu) || cap_caching_mode(iommu->cap)) &&
+	    !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.0

