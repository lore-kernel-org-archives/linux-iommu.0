Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546523803C7
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113227; cv=none; b=SegCArOl+dSbJTg2dMcvQ7fsLTzObnrdDiTfDcDVxyXnuouBS+5ptZqefhO2XtIljNQBgKx3v2JApErXj/mhsNObFr7FyYkazIBRohYNA5bzq++OKkl7P+J/cT/KfuAnbQvjLGgnASv4+O+EP+zwSTXJmoV8dTr2XaJx95JM4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113227; c=relaxed/simple;
	bh=yRFnE8moetnPMcdJVGduldHRDRbg3T7wjDxla15vrSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz9qZjO5sGuvlIHixWH756Q44zAV19TmpmCrpndQ2Zn5BF/fOTAvE8notdjptGG1h3ljP4N4RU4NPPEaanqPGwkyLb5zbDRXCJ4rgt12r7fgJwH/IM7DK77OP1PVi4eEAuQMq83etn5jFQ8wwxEdRsIwCxyYKnNcDxMsZrn4Q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKzQl/FO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKzQl/FO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113226; x=1806649226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRFnE8moetnPMcdJVGduldHRDRbg3T7wjDxla15vrSY=;
  b=WKzQl/FOXrV69KNaddBtNObUPNUbl0VosvPGa2rx67a2dJqlKxdz6/1p
   8hnYsJ2JIfotyLsrqHMsH4ZkPHrQd/zQGQosW47w6Y1wmfBOdp8KR7iX6
   LizxEEFf1NOyxI08JDNVNTOdHGwbivolYNXkF8I+w2tufyAiky8WJmHNd
   fNLR6F7kwvgT5rDuoy1JFjR1ChRDvhib6opVrzf8JDhgPktfnFJ25NNcm
   P17ivZnw9TF6u2mu5mDlwcbtceZzOIr5SnvkvUWw2OKaSTLxtz8Ocn0kY
   e9lFt1VfDJYZC0pwzsPb99vsByHlFBvrDHUBcf3B2HLLsv9FXWMZp9cW1
   A==;
X-CSE-ConnectionGUID: UAMxFGB2RWqMAk5xc8ovRA==
X-CSE-MsgGUID: gKF5YTpNSEWxGPdy39uTAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053658"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:26 -0700
X-CSE-ConnectionGUID: iIXsLdPBRqq6cSnPEvdrpQ==
X-CSE-MsgGUID: 4kHoOkBeQTqMThF+a/HHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847883"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] iommu/vt-d: Split piotlb invalidation into range and all
Date: Thu,  2 Apr 2026 14:57:30 +0800
Message-ID: <20260402065734.1687476-8-baolu.lu@linux.intel.com>
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

Currently these call chains are muddled up by using npages=-1, but only
one caller has the possibility to do both options.

Simplify qi_flush_piotlb() to qi_flush_piotlb_all() since all callers
pass npages=-1.

Split qi_batch_add_piotlb() into qi_batch_add_piotlb_all() and related
helpers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/1-v1-f175e27af136+11647-iommupt_inv_vtd_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 39 +++++++++++++++++--------------------
 drivers/iommu/intel/cache.c | 20 ++++++++++++-------
 drivers/iommu/intel/dmar.c  | 19 ++++--------------
 drivers/iommu/intel/pasid.c |  6 +++---
 drivers/iommu/intel/prq.c   |  2 +-
 5 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 10331364c0ef..9b193bbcfd58 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1077,31 +1077,29 @@ static inline void qi_desc_dev_iotlb(u16 sid, u16 pfsid, u16 qdep, u64 addr,
 	desc->qw3 = 0;
 }
 
+/* PASID-selective IOTLB invalidation */
+static inline void qi_desc_piotlb_all(u16 did, u32 pasid, struct qi_desc *desc)
+{
+	desc->qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		    QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
+	desc->qw1 = 0;
+}
+
+/* Page-selective-within-PASID IOTLB invalidation */
 static inline void qi_desc_piotlb(u16 did, u32 pasid, u64 addr,
 				  unsigned long npages, bool ih,
 				  struct qi_desc *desc)
 {
-	if (npages == -1) {
-		desc->qw0 = QI_EIOTLB_PASID(pasid) |
-				QI_EIOTLB_DID(did) |
-				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-				QI_EIOTLB_TYPE;
-		desc->qw1 = 0;
-	} else {
-		int mask = ilog2(__roundup_pow_of_two(npages));
-		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
+	int mask = ilog2(__roundup_pow_of_two(npages));
+	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
 
-		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
-			addr = ALIGN_DOWN(addr, align);
+	if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
+		addr = ALIGN_DOWN(addr, align);
 
-		desc->qw0 = QI_EIOTLB_PASID(pasid) |
-				QI_EIOTLB_DID(did) |
-				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
-				QI_EIOTLB_TYPE;
-		desc->qw1 = QI_EIOTLB_ADDR(addr) |
-				QI_EIOTLB_IH(ih) |
-				QI_EIOTLB_AM(mask);
-	}
+	desc->qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		    QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) | QI_EIOTLB_TYPE;
+	desc->qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
+		    QI_EIOTLB_AM(mask);
 }
 
 static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
@@ -1163,8 +1161,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
 
-void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih);
+void qi_flush_piotlb_all(struct intel_iommu *iommu, u16 did, u32 pasid);
 
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 249ab5886c73..3ae0d21ecb9f 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -330,15 +330,17 @@ static void qi_batch_add_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid
 	qi_batch_increment_index(iommu, batch);
 }
 
+static void qi_batch_add_piotlb_all(struct intel_iommu *iommu, u16 did,
+				    u32 pasid, struct qi_batch *batch)
+{
+	qi_desc_piotlb_all(did, pasid, &batch->descs[batch->index]);
+	qi_batch_increment_index(iommu, batch);
+}
+
 static void qi_batch_add_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid,
 				u64 addr, unsigned long npages, bool ih,
 				struct qi_batch *batch)
 {
-	/*
-	 * npages == -1 means a PASID-selective invalidation, otherwise,
-	 * a positive value for Page-selective-within-PASID invalidation.
-	 * 0 is not a valid input.
-	 */
 	if (!npages)
 		return;
 
@@ -378,8 +380,12 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	u64 type = DMA_TLB_PSI_FLUSH;
 
 	if (intel_domain_use_piotlb(domain)) {
-		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
-				    pages, ih, domain->qi_batch);
+		if (pages == -1)
+			qi_batch_add_piotlb_all(iommu, tag->domain_id,
+						tag->pasid, domain->qi_batch);
+		else
+			qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid,
+					    addr, pages, ih, domain->qi_batch);
 		return;
 	}
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index cd04c3f56eec..d33c119a935e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1550,23 +1550,12 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-/* PASID-based IOTLB invalidation */
-void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih)
+/* PASID-selective IOTLB invalidation */
+void qi_flush_piotlb_all(struct intel_iommu *iommu, u16 did, u32 pasid)
 {
-	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+	struct qi_desc desc = {};
 
-	/*
-	 * npages == -1 means a PASID-selective invalidation, otherwise,
-	 * a positive value for Page-selective-within-PASID invalidation.
-	 * 0 is not a valid input.
-	 */
-	if (WARN_ON(!npages)) {
-		pr_err("Invalid input npages = %ld\n", npages);
-		return;
-	}
-
-	qi_desc_piotlb(did, pasid, addr, npages, ih, &desc);
+	qi_desc_piotlb_all(did, pasid, &desc);
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 9d30015b8940..89541b74ab8c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -282,7 +282,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 
 	if (pgtt == PASID_ENTRY_PGTT_PT || pgtt == PASID_ENTRY_PGTT_FL_ONLY)
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb_all(iommu, did, pasid);
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
@@ -308,7 +308,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 	if (cap_caching_mode(iommu->cap)) {
 		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb_all(iommu, did, pasid);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
@@ -342,7 +342,7 @@ static void intel_pasid_flush_present(struct intel_iommu *iommu,
 	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
 	 */
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+	qi_flush_piotlb_all(iommu, did, pasid);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 1460b57db129..586055e51bb2 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -113,7 +113,7 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 		qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
 				  MAX_AGAW_PFN_WIDTH, &desc[2]);
 	} else {
-		qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
+		qi_desc_piotlb_all(did, pasid, &desc[1]);
 		qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
 					0, MAX_AGAW_PFN_WIDTH, &desc[2]);
 	}
-- 
2.43.0

