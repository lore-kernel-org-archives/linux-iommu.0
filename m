Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60489801
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906266; cv=none; b=EDQItn635zY7KKdaqcyMIXoGWLeHz7Pu3YjiXws5+qPNA0+EWqRmYDhYYvtJDJiHTYg9bhTuazxgFNtzMwEg5mBmASn04zE190Wjh4K1tfc5R0g7KbTYUT9B93iPUrD0vRGQNjrk0KigzBW2McRrJVU3jKWWaND9F7bkNVlGrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906266; c=relaxed/simple;
	bh=rCELIm+/iSZK3vm3AvrW+qbILVs+UI7wLMywjXOc6tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbilpIols8U6eJWXG+cZIorAIMQQ99g7rVWInuVoudaHZVBkFYLI1vmOJRQqmkC6bWlWle8X18IvE2jp3WJxKpZmetw8mEYGUCRIKsorMGU2tI3twfJxGCDLQAKBrxuceg/BDn7zMcfa/DjnLtes7kv3gFzD3+rdTXTix7Cp/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0dzKuJi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0dzKuJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715906263; x=1747442263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCELIm+/iSZK3vm3AvrW+qbILVs+UI7wLMywjXOc6tc=;
  b=d0dzKuJi9Pm6joxrCJ0C1i13oG10qaocGfrbLExjroUh0eCcaXdLQrJK
   456xBhloXdeCeCXQyP/oGGTrpx1yqt9vilhZMZBTxq++F+1CFYyDx0Dxf
   GGJIbwXtzcsqQZuEASBVJ63FAzHesigIXTFd7M0XwydMxrmp6zwJnJ0Qj
   nZMtw7JMsu0IqsoXxZxGWDuloI4rH+kahag5G0onm0OVPXcj9iQolUxT4
   j0U99EfG2mu+a6J0NGOSbL9rq1+LzdVC8XYhur60H3G3mrd1XVYCd0854
   Lwx8sddAHXQVL7N4w1skWm5sFkN//jHCKATjeflLwn5VzYttewc5n1mMP
   w==;
X-CSE-ConnectionGUID: jNWVrdhBR+6k65W3ecZwvQ==
X-CSE-MsgGUID: 1UAwFSzWT/2kxpg48V8K5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11902653"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11902653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:43 -0700
X-CSE-ConnectionGUID: FvrFxF8TTFaG8H7FlUE+aA==
X-CSE-MsgGUID: bQlA4tDRTU6qNnFjZjXw/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="32217192"
Received: from chunleis-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.214.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:41 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB invalidation commands
Date: Fri, 17 May 2024 08:37:27 +0800
Message-Id: <20240517003728.251115-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517003728.251115-1-tina.zhang@intel.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new parameter batch_desc to the QI based IOTLB/dev-IOTLB
invalidation operations to support batching invalidation descriptors.
This batch_desc is a pointer to the descriptor entry in a batch cmds
buffer. If the batch_desc is NULL, it indicates that batch submission
is not being used, and descriptors will be submitted individually.

Also fix an issue reported by checkpatch about "unsigned mask":
        "Prefer 'unsigned int' to bare use of 'unsigned'"

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 33 +++++++++++-------
 drivers/iommu/intel/dmar.c  | 67 ++++++++++++++++++++-----------------
 drivers/iommu/intel/iommu.c | 27 +++++++++------
 drivers/iommu/intel/iommu.h | 21 ++++++++----
 drivers/iommu/intel/pasid.c | 20 ++++++-----
 5 files changed, 100 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..dcf5e0e6af17 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -278,7 +278,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 		case CACHE_TAG_NESTING_IOTLB:
 			if (domain->use_first_level) {
 				qi_flush_piotlb(iommu, tag->domain_id,
-						tag->pasid, addr, pages, ih);
+						tag->pasid, addr, pages, ih, NULL);
 			} else {
 				/*
 				 * Fallback to domain selective flush if no
@@ -287,11 +287,13 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 				if (!cap_pgsel_inv(iommu->cap) ||
 				    mask > cap_max_amask_val(iommu->cap))
 					iommu->flush.flush_iotlb(iommu, tag->domain_id,
-								 0, 0, DMA_TLB_DSI_FLUSH);
+								 0, 0, DMA_TLB_DSI_FLUSH,
+								 NULL);
 				else
 					iommu->flush.flush_iotlb(iommu, tag->domain_id,
 								 addr | ih, mask,
-								 DMA_TLB_PSI_FLUSH);
+								 DMA_TLB_PSI_FLUSH,
+								 NULL);
 			}
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
@@ -311,13 +313,15 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 			if (tag->pasid == IOMMU_NO_PASID)
 				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
-						   info->ats_qdep, addr, mask);
+						   info->ats_qdep, addr, mask,
+						   NULL);
 			else
 				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
 							 tag->pasid, info->ats_qdep,
-							 addr, mask);
+							 addr, mask, NULL);
 
-			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid,
+						  info->ats_qdep, NULL);
 			break;
 		}
 
@@ -346,10 +350,12 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 		case CACHE_TAG_NESTING_IOTLB:
 			if (domain->use_first_level)
 				qi_flush_piotlb(iommu, tag->domain_id,
-						tag->pasid, 0, -1, 0);
+						tag->pasid, 0, -1, 0,
+						NULL);
 			else
 				iommu->flush.flush_iotlb(iommu, tag->domain_id,
-							 0, 0, DMA_TLB_DSI_FLUSH);
+							 0, 0, DMA_TLB_DSI_FLUSH,
+							 NULL);
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
@@ -357,9 +363,10 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			sid = PCI_DEVID(info->bus, info->devfn);
 
 			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
-					   0, MAX_AGAW_PFN_WIDTH);
+					   0, MAX_AGAW_PFN_WIDTH, NULL);
 			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
-						  IOMMU_NO_PASID, info->ats_qdep);
+						  IOMMU_NO_PASID, info->ats_qdep,
+						  NULL);
 			break;
 		}
 
@@ -406,11 +413,13 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			if (!cap_pgsel_inv(iommu->cap) ||
 			    mask > cap_max_amask_val(iommu->cap))
 				iommu->flush.flush_iotlb(iommu, tag->domain_id,
-							 0, 0, DMA_TLB_DSI_FLUSH);
+							 0, 0, DMA_TLB_DSI_FLUSH,
+							 NULL);
 			else
 				iommu->flush.flush_iotlb(iommu, tag->domain_id,
 							 addr, mask,
-							 DMA_TLB_PSI_FLUSH);
+							 DMA_TLB_PSI_FLUSH,
+							 NULL);
 		}
 
 		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..943712b97973 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1518,11 +1518,12 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-		    unsigned int size_order, u64 type)
+		    unsigned int size_order, u64 type,
+		    struct qi_desc *batch_desc)
 {
 	u8 dw = 0, dr = 0;
-
-	struct qi_desc desc;
+	struct qi_desc desc = {0};
+	struct qi_desc *pdesc = batch_desc ? batch_desc : &desc;
 	int ih = 0;
 
 	if (cap_write_drain(iommu->cap))
@@ -1531,20 +1532,21 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	if (cap_read_drain(iommu->cap))
 		dr = 1;
 
-	desc.qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
+	pdesc->qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
 		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
-	desc.qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
+	pdesc->qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
 		| QI_IOTLB_AM(size_order);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	if (!batch_desc)
+		qi_submit_sync(iommu, pdesc, 1, 0);
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
+			u16 qdep, u64 addr, unsigned int mask,
+			struct qi_desc *batch_desc)
 {
-	struct qi_desc desc;
+	struct qi_desc desc = {0};
+	struct qi_desc *pdesc = batch_desc ? batch_desc : &desc;
 
 	/*
 	 * VT-d spec, section 4.3:
@@ -1557,26 +1559,27 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 
 	if (mask) {
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
-	} else
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
+		pdesc->qw1 |= QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+	} else {
+		pdesc->qw1 |= QI_DEV_IOTLB_ADDR(addr);
+	}
 
 	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
 		qdep = 0;
 
-	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
+	pdesc->qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
 		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	if (!batch_desc)
+		qi_submit_sync(iommu, pdesc, 1, 0);
 }
 
 /* PASID-based IOTLB invalidation */
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih)
+		     unsigned long npages, bool ih, struct qi_desc *batch_desc)
 {
 	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+	struct qi_desc *pdesc = batch_desc ? batch_desc : &desc;
 
 	/*
 	 * npages == -1 means a PASID-selective invalidation, otherwise,
@@ -1589,11 +1592,11 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 	}
 
 	if (npages == -1) {
-		desc.qw0 = QI_EIOTLB_PASID(pasid) |
+		pdesc->qw0 = QI_EIOTLB_PASID(pasid) |
 				QI_EIOTLB_DID(did) |
 				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
 				QI_EIOTLB_TYPE;
-		desc.qw1 = 0;
+		pdesc->qw1 = 0;
 	} else {
 		int mask = ilog2(__roundup_pow_of_two(npages));
 		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
@@ -1601,24 +1604,27 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
 			addr = ALIGN_DOWN(addr, align);
 
-		desc.qw0 = QI_EIOTLB_PASID(pasid) |
+		pdesc->qw0 = QI_EIOTLB_PASID(pasid) |
 				QI_EIOTLB_DID(did) |
 				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
 				QI_EIOTLB_TYPE;
-		desc.qw1 = QI_EIOTLB_ADDR(addr) |
+		pdesc->qw1 = QI_EIOTLB_ADDR(addr) |
 				QI_EIOTLB_IH(ih) |
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	if (!batch_desc)
+		qi_submit_sync(iommu, pdesc, 1, 0);
 }
 
 /* PASID-based device IOTLB Invalidate */
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
+			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order,
+			      struct qi_desc *batch_desc)
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+	struct qi_desc *pdesc = batch_desc ? batch_desc : &desc;
 
 	/*
 	 * VT-d spec, section 4.3:
@@ -1629,7 +1635,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	if (!(iommu->gcmd & DMA_GCMD_TE))
 		return;
 
-	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+	pdesc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
 
@@ -1647,7 +1653,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 				    addr, size_order);
 
 	/* Take page address */
-	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
+	pdesc->qw1 = QI_DEV_EIOTLB_ADDR(addr);
 
 	if (size_order) {
 		/*
@@ -1655,15 +1661,16 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 		 * significant bit, we must set them to 1s to avoid having
 		 * smaller size than desired.
 		 */
-		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
+		pdesc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
 					VTD_PAGE_SHIFT);
 		/* Clear size_order bit to indicate size */
-		desc.qw1 &= ~mask;
+		pdesc->qw1 &= ~mask;
 		/* Set the S bit to indicate flushing more than 1 page */
-		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
+		pdesc->qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	if (!batch_desc)
+		qi_submit_sync(iommu, pdesc, 1, 0);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bbc47b3c603c..ff7d168d5673 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1157,7 +1157,7 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 	if (sm_supported(iommu))
 		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
-	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH, NULL);
 }
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu)
@@ -1216,7 +1216,8 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 
 /* return value determine if we need a write buffer flush */
 static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
-				u64 addr, unsigned int size_order, u64 type)
+				u64 addr, unsigned int size_order, u64 type,
+				struct qi_desc *batch_desc)
 {
 	int tlb_offset = ecap_iotlb_offset(iommu->ecap);
 	u64 val = 0, val_iva = 0;
@@ -1385,8 +1386,8 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-			   qdep, addr, mask);
-	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
+			   qdep, addr, mask, NULL);
+	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep, NULL);
 }
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
@@ -1711,7 +1712,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 						   DMA_CCMD_MASK_NOBIT,
 						   DMA_CCMD_DEVICE_INVL);
 			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
+						 DMA_TLB_DSI_FLUSH, NULL);
 		}
 
 		clear_context_copied(iommu, bus, devfn);
@@ -1765,7 +1766,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					   (((u16)bus) << 8) | devfn,
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, NULL);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
@@ -1998,7 +1999,8 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 				 did_old,
 				 0,
 				 0,
-				 DMA_TLB_DSI_FLUSH);
+				 DMA_TLB_DSI_FLUSH,
+				 NULL);
 
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
@@ -2655,7 +2657,8 @@ static void iommu_flush_all(void)
 		iommu->flush.flush_context(iommu, 0, 0, 0,
 					   DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
-					 DMA_TLB_GLOBAL_FLUSH);
+					 DMA_TLB_GLOBAL_FLUSH,
+					 NULL);
 	}
 }
 
@@ -4859,7 +4862,8 @@ static void __init check_tylersburg_isoch(void)
  */
 void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 			       unsigned long address, unsigned long mask,
-			       u32 pasid, u16 qdep)
+			       u32 pasid, u16 qdep,
+			       struct qi_desc *batch_desc)
 {
 	u16 sid;
 
@@ -4869,10 +4873,11 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 	sid = PCI_DEVID(info->bus, info->devfn);
 	if (pasid == IOMMU_NO_PASID) {
 		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, address, mask);
+				   qdep, address, mask, batch_desc);
 	} else {
 		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
-					 pasid, qdep, address, mask);
+					 pasid, qdep, address, mask,
+					 batch_desc);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e1fb94acf0be..4c5c93e22a37 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -524,7 +524,8 @@ struct iommu_flush {
 	void (*flush_context)(struct intel_iommu *iommu, u16 did, u16 sid,
 			      u8 fm, u64 type);
 	void (*flush_iotlb)(struct intel_iommu *iommu, u16 did, u64 addr,
-			    unsigned int size_order, u64 type);
+			    unsigned int size_order, u64 type,
+			    struct qi_desc *batch_desc);
 };
 
 enum {
@@ -1074,19 +1075,27 @@ void qi_global_iec(struct intel_iommu *iommu);
 void qi_flush_context(struct intel_iommu *iommu, u16 did,
 		      u16 sid, u8 fm, u64 type);
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-		    unsigned int size_order, u64 type);
+		    unsigned int size_order, u64 type,
+		    struct qi_desc *batch_desc);
+
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
+			u16 qdep, u64 addr, unsigned int mask,
+			struct qi_desc *batch_desc);
 
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih);
+		     unsigned long npages, bool ih,
+		     struct qi_desc *batch_desc);
 
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order);
+			      unsigned int size_order,
+			      struct qi_desc *batch_desc);
+
 void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 			       unsigned long address, unsigned long pages,
-			       u32 pasid, u16 qdep);
+			       u32 pasid, u16 qdep,
+			       struct qi_desc *batch_desc);
+
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 11f0b856d74c..4fa935bf487d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -228,9 +228,11 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	 * efficient to flush devTLB specific to the PASID.
 	 */
 	if (pasid == IOMMU_NO_PASID)
-		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0,
+				   64 - VTD_PAGE_SHIFT, NULL);
 	else
-		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0,
+					 64 - VTD_PAGE_SHIFT, NULL);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
@@ -257,9 +259,9 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 
 	if (pgtt == PASID_ENTRY_PGTT_PT || pgtt == PASID_ENTRY_PGTT_FL_ONLY)
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 	else
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, NULL);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
@@ -279,7 +281,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 	if (cap_caching_mode(iommu->cap)) {
 		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
@@ -489,7 +491,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 	 */
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 
-	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, NULL);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
@@ -568,7 +570,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
 	 */
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
@@ -816,7 +818,7 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH, NULL);
 		devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
 
 		/*
@@ -841,7 +843,7 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 					   PCI_DEVID(bus, devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_DSI_FLUSH, NULL);
 	}
 
 	return 0;
-- 
2.39.3

