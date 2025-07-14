Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF34223DDE
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468786; cv=none; b=TQUY0iwnEqcqw5+9Y/RALAXYhSCDkpy8JOgzkNgh8wk5DPXRjRBOg49gykuI8WBGaDSXxXhOTBWOvxIwNO3v9ar2vFKCw9Poc3aLQ1ekGvusTuOsKJURbiVIyhRMohu5USvRBKBfL9tIM7e/8TVSR4qWwKl/V3terDpiM72/nI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468786; c=relaxed/simple;
	bh=DzEkyFZQ28u7x7SePqyWjjDO5a/QUmvg26E6ZupBXSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOmCINjFymAPJfxJQzgerRiV9ep7TKA9si0wo+qve5vB1w1Plaed7qWVWw1MDqF9SUfMRoDEwMfuRNlL3wDIf21lUP7InuzbOiRRl2hVk9imCYuudmuNrgOWblrlfnmjSVcR0Bbgi+ZCVtTAc6LokloKYyBX28RfLYnwB48W7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHJd7sXQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHJd7sXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468784; x=1784004784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzEkyFZQ28u7x7SePqyWjjDO5a/QUmvg26E6ZupBXSw=;
  b=mHJd7sXQl3Am/BMcrvkXyJq0sp2HLZQMl3uKTGsyPxliToh74KOVTcCK
   5fkBf6AIVO4bYE+eygBnURstXhJPs6v4U+DtySt5eiGwe68g2J1mku/8Q
   EsUEY/iC/FajCZApU7txLhLjc/hpQ7O+WH81yQhF1NLbFnSe3P8UGTTvl
   RW1kp/nQre++pn7meJ3ivK0XhbJPMQxEITrIWhnerrK2Z6vvFYcXzBvE7
   kCW69XwLO2It6Jd4HF89D+GB+wAo/IPkmz9NCMo0v9ZD+cCnXl6TArSNL
   m9ZCnIib5mdp+VoVzlYbLi/PTGC4s2/+fgqnjJOmIIM8GD8iffXYodOTe
   g==;
X-CSE-ConnectionGUID: c4esxHLuQWi/O5QMDktaJg==
X-CSE-MsgGUID: QOhdRC6LQKG2Lzb9GdXNOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765087"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:53:03 -0700
X-CSE-ConnectionGUID: Lt7pOygmSAur0rtlYmbjuQ==
X-CSE-MsgGUID: 1wMDH8jnTxe1+aIhgi0kaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166219"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:53:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] iommu/vt-d: Fix missing PASID in dev TLB flush with cache_tag_flush_all
Date: Mon, 14 Jul 2025 12:50:27 +0800
Message-ID: <20250714045028.958850-11-baolu.lu@linux.intel.com>
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

From: Ethan Milon <ethan.milon@eviden.com>

The function cache_tag_flush_all() was originally implemented with
incorrect device TLB invalidation logic that does not handle PASID, in
commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")

This causes regressions where full address space TLB invalidations occur
with a PASID attached, such as during transparent hugepage unmapping in
SVA configurations or when calling iommu_flush_iotlb_all(). In these
cases, the device receives a TLB invalidation that lacks PASID.

This incorrect logic was later extracted into
cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
Refactor IOTLB and Dev-IOTLB flush for batching")

The fix replaces the call to cache_tag_flush_devtlb_all() with
cache_tag_flush_devtlb_psi(), which properly handles PASID.

Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs")
Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all")
Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
Link: https://lore.kernel.org/r/20250708214821.30967-1-ethan.milon@eviden.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 876630e10849..071f78e67fcb 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -422,22 +422,6 @@ static void cache_tag_flush_devtlb_psi(struct dmar_domain *domain, struct cache_
 					     domain->qi_batch);
 }
 
-static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_tag *tag)
-{
-	struct intel_iommu *iommu = tag->iommu;
-	struct device_domain_info *info;
-	u16 sid;
-
-	info = dev_iommu_priv_get(tag->dev);
-	sid = PCI_DEVID(info->bus, info->devfn);
-
-	qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-			       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-	if (info->dtlb_extra_inval)
-		qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-				       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-}
-
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -508,7 +492,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
-			cache_tag_flush_devtlb_all(domain, tag);
+			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
 			break;
 		}
 
-- 
2.43.0

