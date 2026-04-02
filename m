Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBF386435
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113234; cv=none; b=XljGkTklzr22Tc4QUmYjSHFfdNLQj13xpyq0l+npzJtSeM28KwPiXcvRMEnAAfK5v3yefR7Et883koZImx5YOSg1y/AewASD0SK1zODW7nRmeasTNR5IabNEec9TOYHEouctXz6lzdobbKCQslCEEKizT+cnF/DLComzEI0USkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113234; c=relaxed/simple;
	bh=u7fF/ddONOLKg0WwWUbmO+yX+gsZTM2lqDXRoYOcklE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prm/s0SpP9mOQu0UO2dozMckYkk6pI/ExmkDkZr8ZrvWAGnVXCL2mtgtuWHOcSKcrqXHIhGyKDnHhCv1mpzJTL9dQ7ur1cs1h+VodMIKTPJE0XAO+9s3SGIIkJ6rpO9AuIDXO5ZbvZCDWuxz2Ei+s6IFYDn+o7yU8OkAVsrFyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qngowzed; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qngowzed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113230; x=1806649230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7fF/ddONOLKg0WwWUbmO+yX+gsZTM2lqDXRoYOcklE=;
  b=QngowzedOn+Bm5MHIkqC1rdojDXUaah2mYriUd/v+8zIenDm+x0C+v7E
   66KC4nZl2Xs7Zy8KbQGzE3j68p7jdNcADeWngQ+n+S4njt+kJjKVvMhII
   qXVi3MJtq0Ab8+bUD02cDjSpXQik7L5isfIJl82dwUDyQLovHuz1Rrwn5
   sHSF+1qPk3VK1SU7FAHMF9oIoTcxkjnU0cN/UHYGGpzPcYQbK0IUqs3Bf
   BiHIVo9Ll3dtHE/XdXuLoVS4ZjV1grXOXHaBF99PTaCTgHpU2yt/4C0HK
   ZfNcWtFdT+FN/hXrp8fcDFwi9MMCa6GkT3ND+4VS5snBcaJXGnNrQ2Fpz
   Q==;
X-CSE-ConnectionGUID: TBxCkz/7S4uz5l7awfP9Ww==
X-CSE-MsgGUID: go6z1iJeQXCh+Q8kt7o6Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053670"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053670"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:29 -0700
X-CSE-ConnectionGUID: 4Om3JASDRBK7tWsneACz4w==
X-CSE-MsgGUID: zIjgn8h+S9eWsE6bv62BAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847903"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iommu/vt-d: Remove the remaining pages along the invalidation path
Date: Thu,  2 Apr 2026 14:57:32 +0800
Message-ID: <20260402065734.1687476-10-baolu.lu@linux.intel.com>
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

This was only being used to signal that a flush all should be used.
Use mask/size_order >= 52 to signal this instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/3-v1-f175e27af136+11647-iommupt_inv_vtd_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/trace.h | 18 ++++++++----------
 drivers/iommu/intel/cache.c | 27 +++++++++++----------------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 6311ba3f1691..9f0ab43539ea 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -132,8 +132,8 @@ DEFINE_EVENT(cache_tag_log, cache_tag_unassign,
 
 DECLARE_EVENT_CLASS(cache_tag_flush,
 	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
-		 unsigned long addr, unsigned long pages, unsigned long mask),
-	TP_ARGS(tag, start, end, addr, pages, mask),
+		 unsigned long addr, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, mask),
 	TP_STRUCT__entry(
 		__string(iommu, tag->iommu->name)
 		__string(dev, dev_name(tag->dev))
@@ -143,7 +143,6 @@ DECLARE_EVENT_CLASS(cache_tag_flush,
 		__field(unsigned long, start)
 		__field(unsigned long, end)
 		__field(unsigned long, addr)
-		__field(unsigned long, pages)
 		__field(unsigned long, mask)
 	),
 	TP_fast_assign(
@@ -155,10 +154,9 @@ DECLARE_EVENT_CLASS(cache_tag_flush,
 		__entry->start = start;
 		__entry->end = end;
 		__entry->addr = addr;
-		__entry->pages = pages;
 		__entry->mask = mask;
 	),
-	TP_printk("%s %s[%d] type %s did %d [0x%lx-0x%lx] addr 0x%lx pages 0x%lx mask 0x%lx",
+	TP_printk("%s %s[%d] type %s did %d [0x%lx-0x%lx] addr 0x%lx mask 0x%lx",
 		  __get_str(iommu), __get_str(dev), __entry->pasid,
 		  __print_symbolic(__entry->type,
 			{ CACHE_TAG_IOTLB,		"iotlb" },
@@ -166,20 +164,20 @@ DECLARE_EVENT_CLASS(cache_tag_flush,
 			{ CACHE_TAG_NESTING_IOTLB,	"nesting_iotlb" },
 			{ CACHE_TAG_NESTING_DEVTLB,	"nesting_devtlb" }),
 		__entry->domain_id, __entry->start, __entry->end,
-		__entry->addr, __entry->pages, __entry->mask
+		__entry->addr, __entry->mask
 	)
 );
 
 DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range,
 	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
-		 unsigned long addr, unsigned long pages, unsigned long mask),
-	TP_ARGS(tag, start, end, addr, pages, mask)
+		 unsigned long addr, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, mask)
 );
 
 DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range_np,
 	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
-		 unsigned long addr, unsigned long pages, unsigned long mask),
-	TP_ARGS(tag, start, end, addr, pages, mask)
+		 unsigned long addr, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, mask)
 );
 #endif /* _TRACE_INTEL_IOMMU_H */
 
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 20df2c16475b..be8410f0e841 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -255,7 +255,6 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
 
 static unsigned long calculate_psi_aligned_address(unsigned long start,
 						   unsigned long end,
-						   unsigned long *_pages,
 						   unsigned long *_mask)
 {
 	unsigned long pages = aligned_nrpages(start, end - start + 1);
@@ -281,10 +280,8 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
 		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
-		aligned_pages = 1UL << mask;
 	}
 
-	*_pages = aligned_pages;
 	*_mask = mask;
 
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
@@ -371,14 +368,13 @@ static bool intel_domain_use_piotlb(struct dmar_domain *domain)
 }
 
 static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
-				  unsigned long addr, unsigned long pages,
-				  unsigned long mask, int ih)
+				  unsigned long addr, unsigned long mask, int ih)
 {
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
 	if (intel_domain_use_piotlb(domain)) {
-		if (pages == -1)
+		if (mask >= MAX_AGAW_PFN_WIDTH)
 			qi_batch_add_piotlb_all(iommu, tag->domain_id,
 						tag->pasid, domain->qi_batch);
 		else
@@ -392,7 +388,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	 * is too big.
 	 */
 	if (!cap_pgsel_inv(iommu->cap) ||
-	    mask > cap_max_amask_val(iommu->cap) || pages == -1) {
+	    mask > cap_max_amask_val(iommu->cap)) {
 		addr = 0;
 		mask = 0;
 		ih = 0;
@@ -441,16 +437,15 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			   unsigned long end, int ih)
 {
 	struct intel_iommu *iommu = NULL;
-	unsigned long pages, mask, addr;
+	unsigned long mask, addr;
 	struct cache_tag *tag;
 	unsigned long flags;
 
 	if (start == 0 && end == ULONG_MAX) {
 		addr = 0;
-		pages = -1;
 		mask = MAX_AGAW_PFN_WIDTH;
 	} else {
-		addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+		addr = calculate_psi_aligned_address(start, end, &mask);
 	}
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
@@ -462,7 +457,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
-			cache_tag_flush_iotlb(domain, tag, addr, pages, mask, ih);
+			cache_tag_flush_iotlb(domain, tag, addr, mask, ih);
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
 			/*
@@ -480,7 +475,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			break;
 		}
 
-		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
+		trace_cache_tag_flush_range(tag, start, end, addr, mask);
 	}
 	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
@@ -510,11 +505,11 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end)
 {
 	struct intel_iommu *iommu = NULL;
-	unsigned long pages, mask, addr;
+	unsigned long mask, addr;
 	struct cache_tag *tag;
 	unsigned long flags;
 
-	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+	addr = calculate_psi_aligned_address(start, end, &mask);
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
@@ -530,9 +525,9 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 
 		if (tag->type == CACHE_TAG_IOTLB ||
 		    tag->type == CACHE_TAG_NESTING_IOTLB)
-			cache_tag_flush_iotlb(domain, tag, addr, pages, mask, 0);
+			cache_tag_flush_iotlb(domain, tag, addr, mask, 0);
 
-		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
+		trace_cache_tag_flush_range_np(tag, start, end, addr, mask);
 	}
 	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
-- 
2.43.0

