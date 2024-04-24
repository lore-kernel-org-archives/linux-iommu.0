Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2751598E5
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943124; cv=none; b=u+MYcVF1NjGlwlPwf9OudrMHVAaFV9CrEyqfUSwE+wwUxH0fJsXPkGHIIrVLfv2Xuvf1j3pYlWA3BYKv/+TYu4Xu+ZqHNAan0A/vgErmVqQI8RWiXnIqcYdUGaZo/qfqB2pgxNd6EYWI5aCGs6pfZpQXqWDNZyYTY/ESsmZuGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943124; c=relaxed/simple;
	bh=tiuDl1xI5CkYFpqMKUD4bk1W6QEitt80Xi10nXye/H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBFHIgPGfdlbH68b8brvItt5tgiyWTUnT3qLOaWXvEscObrlbgwT3JozpQWG2DABefuEq9CJeC3bS7og/ynBdw6vFma247WjaScYTjAMOWQi1/WBfArdR/X+FTMy1rMdIcNd2Basy68g6MLGaUyoCctBTotk9qOit8n9Zsk2+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrR9pH9+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrR9pH9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943123; x=1745479123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiuDl1xI5CkYFpqMKUD4bk1W6QEitt80Xi10nXye/H0=;
  b=mrR9pH9+x1qKly9xbHIap5/MfaFYsWiR41L8b/bYkJGoTaSrFOHzCwDJ
   fbeOQImKrwBwu8kp6OO5+aGxDhVT0VAjB5/UgnEVZs4Nk9Xp6G7BqJKZp
   +32L2Mo1JAa5VyTvd8QfOxY+eLiW/pov+/lmVyJJBigpNMuUFO6EkBd/s
   rXBqIr9iyG44HJMiXytxbLCMpEW9elDqQDUzz3tp/vRfBCu+vdJWWzQwY
   r3DlR4o3crYHqMPJqRw2nbosSYQQ2DJjY0WMTbSngobRAP5eY0j6g+fzb
   NXtwA0VcZGvlqp34X4P7+xUid1JSf9R86KWuIoilOguAtu5xD7oOt3Z9F
   A==;
X-CSE-ConnectionGUID: R/qpzwrhQQ+xvqXmfBlSVA==
X-CSE-MsgGUID: UGNjRldYQUepF+Ngo/0xhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073224"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073224"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:42 -0700
X-CSE-ConnectionGUID: nIwL4TjuRzWzYXR2MOn75A==
X-CSE-MsgGUID: ygECSLWDRkCgURb1OecAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665679"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
Date: Wed, 24 Apr 2024 15:16:40 +0800
Message-Id: <20240424071644.178250-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-9-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h  |  6 +++++
 drivers/iommu/intel/nested.c | 50 +++---------------------------------
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cb83b0995391..1d705a983dd7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1049,6 +1049,12 @@ static inline unsigned long aligned_nrpages(unsigned long host_addr, size_t size
 	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
 }
 
+/* Return a size from number of VTD pages. */
+static inline unsigned long nrpages_to_size(unsigned long npages)
+{
+	return npages << VTD_PAGE_SHIFT;
+}
+
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 13406ee742bf..16a2bcf5cfeb 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -88,50 +88,6 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
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
@@ -164,9 +120,9 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 			break;
 		}
 
-		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
-					 inv_entry.npages,
-					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+		cache_tag_flush_range(dmar_domain, inv_entry.addr,
+				      inv_entry.addr + nrpages_to_size(inv_entry.npages) - 1,
+				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
 		processed++;
 	}
 
-- 
2.34.1

