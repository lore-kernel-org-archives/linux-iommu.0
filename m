Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9138A712
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544483; cv=none; b=MwsjWCxzQrzi0rlbZu86eq7iP8HCyq2NcuYwzuFMUv9XVr7KjZC4Y/vM4zh5AsNylmU5Ya203buswKawKqdiqmuVpiobm2ljrhzetgk9UKhzhNNkLbA74ocVLn2gPBDtCVZeRYQu0Ci7mPArTFUxKNVXmsTc+Bs6WUV36hArehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544483; c=relaxed/simple;
	bh=e9xdXmNA76UpdQTtlZKb/afKRjRobjx+1qiBHIS4ISA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLZs/wO5ESbQGV1BobnNzrd+dKmrDKwpZHEiGsno/LE2B2rSc05cvL+jeMXBdBbQON7wrNkuvHWMLRk0GqpT7g/kasR8WpBuuBZ3NzxD3ZcNfVdqckZyjPLtVgL7hv5VvCqkAve4AhN1oyalqooNZKrgLwWN0k4xh2N7Gts4BS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPttgsD5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPttgsD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775544483; x=1807080483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9xdXmNA76UpdQTtlZKb/afKRjRobjx+1qiBHIS4ISA=;
  b=PPttgsD5gUX4s6jMlYWTyGKNa1huRpz8dIRRBC0xyJSp08RH78JoLbOB
   SJg8kHvkhAN91vvRk488GXt1Qdo/AqOCyOHB39xNFmvM2DsFtpr8T/GP+
   +vGTlfXAAE8da1OnIaH4ocSlkdyott5wrcU3yWr/Ej+rSyvJrOETRkg9+
   mDOukxjx0uf7WnX/dlyKFdFuxCfTesf27NsP2QPOx5+O3/FcT7zQCNyZq
   1yN56OpP7VGi8MT2hJgNS+rlXtWNZ7ePE3trz2YB8Mb0wmoQHUIGcxQRI
   jic751wrOiVoBMBK17KcqOwNFsu3Qk473RSmx00dADoodg2k9SugxLqsr
   A==;
X-CSE-ConnectionGUID: OYaa1eFMRwyBa0cYGwUCbQ==
X-CSE-MsgGUID: f2MFU3UrTE6EZWplHgnypA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99125926"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99125926"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:48:03 -0700
X-CSE-ConnectionGUID: MIoz4ZDIReK5Thbk63cBtw==
X-CSE-MsgGUID: RY/PtE3HTCK+aq3TpQ8cqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266066642"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 06 Apr 2026 23:48:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/vt-d: Simplify calculate_psi_aligned_address()
Date: Tue,  7 Apr 2026 14:45:22 +0800
Message-ID: <20260407064522.1814193-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407064522.1814193-1-baolu.lu@linux.intel.com>
References: <20260407064522.1814193-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

This is doing far too much math for the simple task of finding a
power of 2 that fully spans the given range. Use fls directly on
the xor which computes the common binary prefix.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/0-v2-895748900b39+5303-iommupt_inv_vtd_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 49 ++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index be8410f0e841..fdc88817709f 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -254,37 +254,29 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
 }
 
 static unsigned long calculate_psi_aligned_address(unsigned long start,
-						   unsigned long end,
-						   unsigned long *_mask)
+						   unsigned long last,
+						   unsigned long *size_order)
 {
-	unsigned long pages = aligned_nrpages(start, end - start + 1);
-	unsigned long aligned_pages = __roundup_pow_of_two(pages);
-	unsigned long bitmask = aligned_pages - 1;
-	unsigned long mask = ilog2(aligned_pages);
-	unsigned long pfn = IOVA_PFN(start);
-
-	/*
-	 * PSI masks the low order bits of the base address. If the
-	 * address isn't aligned to the mask, then compute a mask value
-	 * needed to ensure the target range is flushed.
-	 */
-	if (unlikely(bitmask & pfn)) {
-		unsigned long end_pfn = pfn + pages - 1, shared_bits;
+	unsigned int sz_lg2;
 
+	/* Compute a sz_lg2 that spans start and last */
+	start &= GENMASK(BITS_PER_LONG - 1, VTD_PAGE_SHIFT);
+	sz_lg2 = fls_long(start ^ last);
+	if (sz_lg2 <= 12) {
+		*size_order = 0;
+		return start;
+	}
+	if (unlikely(sz_lg2 >= BITS_PER_LONG)) {
 		/*
-		 * Since end_pfn <= pfn + bitmask, the only way bits
-		 * higher than bitmask can differ in pfn and end_pfn is
-		 * by carrying. This means after masking out bitmask,
-		 * high bits starting with the first set bit in
-		 * shared_bits are all equal in both pfn and end_pfn.
+		 * MAX_AGAW_PFN_WIDTH triggers full invalidation in all
+		 * downstream users.
 		 */
-		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
+		*size_order = MAX_AGAW_PFN_WIDTH;
+		return 0;
 	}
 
-	*_mask = mask;
-
-	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
+	*size_order = sz_lg2 - VTD_PAGE_SHIFT;
+	return start & GENMASK(BITS_PER_LONG - 1, sz_lg2);
 }
 
 static void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
@@ -441,12 +433,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 	struct cache_tag *tag;
 	unsigned long flags;
 
-	if (start == 0 && end == ULONG_MAX) {
-		addr = 0;
-		mask = MAX_AGAW_PFN_WIDTH;
-	} else {
-		addr = calculate_psi_aligned_address(start, end, &mask);
-	}
+	addr = calculate_psi_aligned_address(start, end, &mask);
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-- 
2.43.0

