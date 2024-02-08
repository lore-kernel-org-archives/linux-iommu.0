Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6186A34C
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380595; cv=none; b=FJoliE8J+c5ee/7bS3LiuP8tETNpQMkprZc+ELx7bbiJwcp99Vk5cILNjGWsDkzJWYkL3/9Wk01yzN0yN49wh88YmduvXdr/lnDK5DJdKwCWbHyDgOlZFQBYPor++6jKCMekzPs6zwJIlJpe0Dc5L+TbgRCFNdUXXKmRgYPohBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380595; c=relaxed/simple;
	bh=6WL8z2aMLDo6O3Bz7gM5e9uPczPryXbWDTbbIrVy8k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFImf2SxpYttCbhFlf2b6/VPk8zGSIfNl3i6fGS3reC4hxB2OcVY06os9uWgcvRIR/w6kV2cdxjPvWbX0h1KWjpSVBnYGhPy3smW7BtEWGEs1kfvib0KXpzO0rKs/6008qNmoNzMxo/5mkZaAAqTWNDw/5tYTl+b2bZxtgFT2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcAQlHJC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcAQlHJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380594; x=1738916594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WL8z2aMLDo6O3Bz7gM5e9uPczPryXbWDTbbIrVy8k8=;
  b=mcAQlHJCSyyW55MgutPKnkRqtTuenJOM4wDmu5c+lVT+7JI/ZDXh+hK+
   FgaXVjmrfzRweotamaMcGttvl62ijhPSPYWgJQHWmYVMCtZhF4Ezii0hM
   stljhU4mrS3f/Fx0svZALSt6vUHJm9Ly25ueLdr9riJMUKwFoS85xNNaP
   QkpjshzEs0kgOKQm1Zu98Jn36uCTjBm8FC4cMzOIyldCK64UvU7MGcjKc
   Bhq8bh7O1aSdN2Hhtvnreq5WNa/5Gw+e1B5jtJ5XRcaTa7ZAjRiEFrSgG
   5nazkWxW+txwAzUzZmv9RJEOyQzQOOClaXHKDghFY8Ho8OUa8V/hwqeJb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036310"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252102"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:11 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH rc 2/8] iommu/vt-d: Add __iommu_flush_iotlb_psi()
Date: Thu,  8 Feb 2024 00:23:01 -0800
Message-Id: <20240208082307.15759-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208082307.15759-1-yi.l.liu@intel.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __iommu_flush_iotlb_psi() to do the psi iotlb flush with a DID input
rather than calculating it within the helper.

This is useful when flushing cache for parent domain which reuses DIDs of
its nested domains.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 79 +++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e393c62776f3..eef6a187b651 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1368,6 +1368,47 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
+				    unsigned long pfn, unsigned int pages,
+				    int ih)
+{
+	unsigned int aligned_pages = __roundup_pow_of_two(pages);
+	unsigned int mask = ilog2(aligned_pages);
+	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
+	unsigned long bitmask = aligned_pages - 1;
+
+	/*
+	 * PSI masks the low order bits of the base address. If the
+	 * address isn't aligned to the mask, then compute a mask value
+	 * needed to ensure the target range is flushed.
+	 */
+	if (unlikely(bitmask & pfn)) {
+		unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+		/*
+		 * Since end_pfn <= pfn + bitmask, the only way bits
+		 * higher than bitmask can differ in pfn and end_pfn is
+		 * by carrying. This means after masking out bitmask,
+		 * high bits starting with the first set bit in
+		 * shared_bits are all equal in both pfn and end_pfn.
+		 */
+		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+	}
+
+	/*
+	 * Fallback to domain selective flush if no PSI support or
+	 * the size is too big.
+	 */
+	if (!cap_pgsel_inv(iommu->cap) ||
+	    mask > cap_max_amask_val(iommu->cap))
+		iommu->flush.flush_iotlb(iommu, did, 0, 0,
+					 DMA_TLB_DSI_FLUSH);
+	else
+		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
+					 DMA_TLB_PSI_FLUSH);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1384,42 +1425,10 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (ih)
 		ih = 1 << 6;
 
-	if (domain->use_first_level) {
+	if (domain->use_first_level)
 		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
-	} else {
-		unsigned long bitmask = aligned_pages - 1;
-
-		/*
-		 * PSI masks the low order bits of the base address. If the
-		 * address isn't aligned to the mask, then compute a mask value
-		 * needed to ensure the target range is flushed.
-		 */
-		if (unlikely(bitmask & pfn)) {
-			unsigned long end_pfn = pfn + pages - 1, shared_bits;
-
-			/*
-			 * Since end_pfn <= pfn + bitmask, the only way bits
-			 * higher than bitmask can differ in pfn and end_pfn is
-			 * by carrying. This means after masking out bitmask,
-			 * high bits starting with the first set bit in
-			 * shared_bits are all equal in both pfn and end_pfn.
-			 */
-			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
-		}
-
-		/*
-		 * Fallback to domain selective flush if no PSI support or
-		 * the size is too big.
-		 */
-		if (!cap_pgsel_inv(iommu->cap) ||
-		    mask > cap_max_amask_val(iommu->cap))
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-							DMA_TLB_DSI_FLUSH);
-		else
-			iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-							DMA_TLB_PSI_FLUSH);
-	}
+	else
+		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
 	/*
 	 * In caching mode, changes of pages from non-present to present require
-- 
2.34.1

