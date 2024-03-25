Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78195155395
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333106; cv=none; b=BR6Vd6kRtqMrsWFrKNs6sjHUbBRsnQEY39rW/zIKGSbntL16eRHORq5xNqJwBmLeCP6ypDmtHOkf8G+dkycyU5shMK/xr2LQTg9DXl6OCKBLF91NFw414VNhJ+MMb/RUdT2GDKIsDFx3VkqyJbJ6KifVxnvNTgP6IJYBuYljuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333106; c=relaxed/simple;
	bh=GRqfeV/YKXedxQfVodmQRhJEmBymUSTAs5i+B3DOhSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBDPHC5eTAU6fmbaN0ddnH1hw1HDf3Jrsib0QI37jEEHltNhJptnmUZVGGqslvnxQ6txBNJGHe3T8DhPR6vFkbWM2bTFVjz2qdggMPJfTa/hZLhVYlj5gRUzCUu/0UoPSXNExFcmZxpPFXUBLnUKA/7mE4d9OqRUSVCJhhfVfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bElkZima; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bElkZima"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333104; x=1742869104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRqfeV/YKXedxQfVodmQRhJEmBymUSTAs5i+B3DOhSQ=;
  b=bElkZimaivYBxA8u80Ht5mvaAe+lp925LwL3abYl3XE8w4zdNLdWBVjm
   9HSo0KMjHsYFtLUlw5uL6cHUCaQoHdZOw21Ncm3PEXfKlg7YVq62LD5sS
   lUcyOwdZ7GfnBnJPNewSUa1yp4eseEIIyZs2dUG7szft/bSA43yOGZ8O6
   T1ZKZ9Z+AxAMzbfS+fxivCAI0hKJ83jfa0GQeCEL8x/m4dr3s+20dAbs8
   iNpJ5osh8ae5wyfsoAHCCmZhOWRsU/bnydlZWsrYpzcdBMH7sPg7qyq4M
   6NUjlZw6+bmAv6d/GsnQ7kjRjECQYixFGo1i922yt7pzsiWTb1bEzWd4c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271413"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353986"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 08/12] iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
Date: Mon, 25 Mar 2024 10:17:01 +0800
Message-Id: <20240325021705.249769-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cache_invalidate_user callback is called to invalidate a range
of caches for the affected user domain. Use cache_tag_flush_range()
in this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 50 +++---------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 85c744099558..e251507cfcc0 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -90,50 +90,6 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(dmar_domain);
 }
 
-static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
-				   unsigned int mask)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-	u16 sid, qdep;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, addr, mask);
-		quirk_extra_dev_tlb_flush(info, addr, mask,
-					  IOMMU_NO_PASID, qdep);
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
-				     u64 npages, bool ih)
-{
-	struct iommu_domain_info *info;
-	unsigned int mask;
-	unsigned long i;
-
-	xa_for_each(&domain->iommu_array, i, info)
-		qi_flush_piotlb(info->iommu,
-				domain_id_iommu(domain, info->iommu),
-				IOMMU_NO_PASID, addr, npages, ih);
-
-	if (!domain->has_iotlb_device)
-		return;
-
-	if (npages == U64_MAX)
-		mask = 64 - VTD_PAGE_SHIFT;
-	else
-		mask = ilog2(__roundup_pow_of_two(npages));
-
-	nested_flush_dev_iotlb(domain, addr, mask);
-}
-
 static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 					      struct iommu_user_data_array *array)
 {
@@ -166,9 +122,9 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 			break;
 		}
 
-		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
-					 inv_entry.npages,
-					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+		cache_tag_flush_range(dmar_domain, inv_entry.addr,
+				      inv_entry.npages,
+				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
 		processed++;
 	}
 
-- 
2.34.1

