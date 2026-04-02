Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E3386568
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113235; cv=none; b=HB7MpPfxROPUWc9Q9/hw4kSL38eTGiDXJul/mnhQtkt/2FO5GDaWdBgclFLEBDwZL88KqQjmjLPZUr61pK7nirpmCNH+1ohAHuLR2biQ0TWmCZyY8zZPie+clDjXV2bzXDBAFC6JaVVE9rQxLhhaexySZRV2MSSHpwJo5ysrN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113235; c=relaxed/simple;
	bh=Yu63ydkahPogUMvV2raVoIg5D9VM0YAdDSsvucDzLfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edwwx+s4OOuccHNv6+h44CiZpQdtbJsVwIr3Qkva5e7aeog4rUkLoEnC0aS+PrWv34xlsP6r8tVOXwMG1mMaA6mSXjtRP3SJqyH0vQIAgzosq20JY6CAdQtnZCSzqN56gtvtZD3Myb1VXlfwh9L9C/F3kgrfoUtdLSZQwom1qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd9UZsd4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd9UZsd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113232; x=1806649232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yu63ydkahPogUMvV2raVoIg5D9VM0YAdDSsvucDzLfI=;
  b=jd9UZsd4SoiR6mFM7ZwnwgUhYtHXlENPKCcis5UvGyquJKd977owpyGn
   KoNH53w/10pbiCPtn/6KXEhMPaNOD+qg5TCj6FR8qNUVbj1v2SKEJJ3R8
   I0v36T1Hdy0/zO5ufSTYPaejaOL54K6y4jiaXvs6BYw+jd/AjW8ViAcQi
   LiMX8x+3t8mXPBLmo+8gI2ATZoXUjgN9ynk9NfHuUq896RK2AlFGjxxUc
   8xxroV1OnY/toG4RC1Z0jzFhA0iVN4v5JBmUoOfnK1mgflTYhPqjJ2LA6
   9CjBviKvxQO1OX8BJIVVoHpi+0y2sr3paMYqLUgwY70UEeVoZch31uInR
   g==;
X-CSE-ConnectionGUID: 9ILVozf5TZ2POiDFK+rvDA==
X-CSE-MsgGUID: XnL/ml6OS4KBGL33Py1BWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053676"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:31 -0700
X-CSE-ConnectionGUID: eGiuhs1kQiaoaJrfZnII9Q==
X-CSE-MsgGUID: TeFpf/a1TwadyTa3RcF5hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847921"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iommu/vt-d: Simplify calculate_psi_aligned_address()
Date: Thu,  2 Apr 2026 14:57:33 +0800
Message-ID: <20260402065734.1687476-11-baolu.lu@linux.intel.com>
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

This is doing far too much math for the simple task of finding a power
of 2 that fully spans the given range. Use fls directly on the xor
which computes the common binary prefix.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/4-v1-f175e27af136+11647-iommupt_inv_vtd_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 49 ++++++++++++-------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index be8410f0e841..54dd9f7323bd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -254,37 +254,25 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
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
+	unsigned int sz_lg2;
 
-	/*
-	 * PSI masks the low order bits of the base address. If the
-	 * address isn't aligned to the mask, then compute a mask value
-	 * needed to ensure the target range is flushed.
-	 */
-	if (unlikely(bitmask & pfn)) {
-		unsigned long end_pfn = pfn + pages - 1, shared_bits;
-
-		/*
-		 * Since end_pfn <= pfn + bitmask, the only way bits
-		 * higher than bitmask can differ in pfn and end_pfn is
-		 * by carrying. This means after masking out bitmask,
-		 * high bits starting with the first set bit in
-		 * shared_bits are all equal in both pfn and end_pfn.
-		 */
-		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
+	/* Compute a sz_lg2 that spans start and last */
+	start &= GENMASK(BITS_PER_LONG - 1, VTD_PAGE_SHIFT);
+	sz_lg2 = fls_long(start ^ last);
+	if (sz_lg2 <= 12) {
+		*size_order = 0;
+		return start;
+	}
+	if (unlikely(sz_lg2 >= MAX_AGAW_PFN_WIDTH)) {
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
@@ -441,12 +429,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
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

