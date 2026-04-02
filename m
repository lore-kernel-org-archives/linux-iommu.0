Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3905382392
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113230; cv=none; b=JlbkOe+0zGhKnkt6WtdlWjy+c/XLmXJuTm3Tni3PbLqy1lmYDc6vHmX+B+OFSFkFXSMhg9n4OWVytAeVtr3cV4HYNXCtLphA1+6jU/q6h6QCf/hjxQEvkhK8ZZ4HFlPTpeqI8QuSvKpzjknfRJt7v7AXLhYo0MEesWYwZporbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113230; c=relaxed/simple;
	bh=sEL1nEF0TTm0fxu+q7BKcCBsp6QQh9aAnBQO6u77b5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci9dHRQqXJg5LX+5vLRW4ZNxLjSAjEhpEVIS+/rgQR8jc5PmbAmBO2SnWuv9mROp+SpeK4G5O64H1Dk4e0kWHuTAcCfyuiTY7+eG8Hx0ptvbx/Ki1vK3io/tDsOu8IaRmTn4V2GrFdBqI8T43GuPsv7YSjlJ4EOIVmrKEKqBfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4NDCm5N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4NDCm5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113228; x=1806649228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEL1nEF0TTm0fxu+q7BKcCBsp6QQh9aAnBQO6u77b5g=;
  b=L4NDCm5Nr5MHRoVmSV1FYwUWpNHVKkfIPfSztd5ffQMIQ1Xxh/svMc78
   rUfytX+vW8Jj3B93yIwHmxUq/jcqkpNFV4Ugdz/7A3/UznJdjzK5y6ilV
   Vb4Rn7WTaxKzebkkjtaY3Lz8vJ1AlyrVQFUJ4oUHQZPfu5YO5SHkuhoGR
   ftE23x7U3pebG2ikWRZ5GlzUXdk5UcwtikSXErFbKxFJR3Ugf0DxkX7Kb
   BardtFKBmgc1MeQcXzj0TpYqdhMZpRt6wogMQCSEvZCwthnzfJT2Dquad
   QNlg53i51gPJz17q2xarRsENN9i+65HRgq6mEuA5kGQFSznnrihNfsyxh
   A==;
X-CSE-ConnectionGUID: 87OGSjKeR4+/eD4WswbwZg==
X-CSE-MsgGUID: R3foREI/TlmuA/32tHuJtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053663"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053663"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:28 -0700
X-CSE-ConnectionGUID: wiHgS2kOTyWlWUyTXpeWWg==
X-CSE-MsgGUID: vjn+a/g1S6qk4gIZL6VOpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847893"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iommu/vt-d: Pass size_order to qi_desc_piotlb() not npages
Date: Thu,  2 Apr 2026 14:57:31 +0800
Message-ID: <20260402065734.1687476-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

It doesn't make sense for the caller to compute mask, throw it away
and then have qi_desc_piotlb() compute it again.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/2-v1-f175e27af136+11647-iommupt_inv_vtd_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 13 +++++--------
 drivers/iommu/intel/cache.c | 10 ++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9b193bbcfd58..ef145560aa98 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1087,19 +1087,16 @@ static inline void qi_desc_piotlb_all(u16 did, u32 pasid, struct qi_desc *desc)
 
 /* Page-selective-within-PASID IOTLB invalidation */
 static inline void qi_desc_piotlb(u16 did, u32 pasid, u64 addr,
-				  unsigned long npages, bool ih,
+				  unsigned int size_order, bool ih,
 				  struct qi_desc *desc)
 {
-	int mask = ilog2(__roundup_pow_of_two(npages));
-	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
-
-	if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
-		addr = ALIGN_DOWN(addr, align);
-
+	/*
+	 * calculate_psi_aligned_address() must be used for addr and size_order
+	 */
 	desc->qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
 		    QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) | QI_EIOTLB_TYPE;
 	desc->qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
-		    QI_EIOTLB_AM(mask);
+		    QI_EIOTLB_AM(size_order);
 }
 
 static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 3ae0d21ecb9f..20df2c16475b 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -338,13 +338,11 @@ static void qi_batch_add_piotlb_all(struct intel_iommu *iommu, u16 did,
 }
 
 static void qi_batch_add_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid,
-				u64 addr, unsigned long npages, bool ih,
+				u64 addr, unsigned int size_order, bool ih,
 				struct qi_batch *batch)
 {
-	if (!npages)
-		return;
-
-	qi_desc_piotlb(did, pasid, addr, npages, ih, &batch->descs[batch->index]);
+	qi_desc_piotlb(did, pasid, addr, size_order, ih,
+		       &batch->descs[batch->index]);
 	qi_batch_increment_index(iommu, batch);
 }
 
@@ -385,7 +383,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 						tag->pasid, domain->qi_batch);
 		else
 			qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid,
-					    addr, pages, ih, domain->qi_batch);
+					    addr, mask, ih, domain->qi_batch);
 		return;
 	}
 
-- 
2.43.0

