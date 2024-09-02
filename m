Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1C13AD27
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244302; cv=none; b=B04NePba4hnj2u2drWFVqQqXzNiKhhNgzjoG7cH5i/c3AIYgY6YSbY4NqLLqw9Ripe7Npnnje6tBBeKA1YpT1/wDER+Q4eRAqeKZf1P3KW5UjZ0Qa+CHHq8IIYkxsooG/qFDaMcFe/9hYCs3SKITkyJRU6/nZSNfY18MLUkTbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244302; c=relaxed/simple;
	bh=riBmFPcSBAvJB1OHstBgDS/COM/8vG7xHt/eORYl5DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kq2lpyMIa//oGnsnHCuhHECBJqKg0LZnuz09lfWTQLWYLGrpl0s+fK5sVPJef9VHvRW6HkCpF9Lfvdev45ReKg50WPrdKxIjaLyFKjsN9ZlPJffpGadTIfPJLhAM+RuVrZJZYC4UvHA9d5ewf5tTRQpVF6qBUA1xC64t4f3sdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxO9fAiP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxO9fAiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244301; x=1756780301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riBmFPcSBAvJB1OHstBgDS/COM/8vG7xHt/eORYl5DI=;
  b=BxO9fAiPwu/Lh6jzl5MQBRu7gIZnIcB9RFR8u0wLe4S3hIH+yp5Gqah+
   fqnFA29LfOFli3Wy/VUqaGXSJ6SPEHuZ+GoB9l+RzUWEeQBIMCAatcZvI
   f6Fx0A6jgUqKwK5PvMO1keE/ryi1uOETtDf4E1PhOl/oF0QN6Sfxl0fgP
   1HB0UPtEpu+FbwLCcx2XVJRYBW5rNicJM3vyfl/EUP6uz+XvSiPcuw9ux
   71/HDap7cWgP+WiagDeSfE9KbJAj5DXEV+2iv44rHBYjMELKmsVQjen8s
   uo8SvEDhDNkUqChkFMzpUgjevp/wM5DfJxM0GSd2vuUFKvSzKJGiVehTx
   A==;
X-CSE-ConnectionGUID: 8kjlEFiiTM22eG/XTSc9qg==
X-CSE-MsgGUID: REgZYn2LTK2k/yVFTJr3Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994341"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994341"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:40 -0700
X-CSE-ConnectionGUID: 5cVuQdV5SB+sboLY+Ig78Q==
X-CSE-MsgGUID: xcO0tSt0S5yqWn80oEy7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359348"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] iommu/vt-d: Factor out invalidation descriptor composition
Date: Mon,  2 Sep 2024 10:27:21 +0800
Message-Id: <20240902022724.67059-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

Separate the logic for constructing IOTLB and device TLB invalidation
descriptors from the qi_flush interfaces. New helpers, qi_desc(), are
introduced to encapsulate this common functionality.

Moving descriptor composition code to new helpers enables its reuse in
the upcoming qi_batch interfaces.

No functional changes are intended.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240815065221.50328-2-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 109 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c  |  93 ++----------------------------
 2 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b3b295e60626..8884aae56ca7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1066,6 +1066,115 @@ static inline unsigned long nrpages_to_size(unsigned long npages)
 	return npages << VTD_PAGE_SHIFT;
 }
 
+static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+				 unsigned int size_order, u64 type,
+				 struct qi_desc *desc)
+{
+	u8 dw = 0, dr = 0;
+	int ih = 0;
+
+	if (cap_write_drain(iommu->cap))
+		dw = 1;
+
+	if (cap_read_drain(iommu->cap))
+		dr = 1;
+
+	desc->qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
+		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
+	desc->qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
+		| QI_IOTLB_AM(size_order);
+	desc->qw2 = 0;
+	desc->qw3 = 0;
+}
+
+static inline void qi_desc_dev_iotlb(u16 sid, u16 pfsid, u16 qdep, u64 addr,
+				     unsigned int mask, struct qi_desc *desc)
+{
+	if (mask) {
+		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
+		desc->qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+	} else {
+		desc->qw1 = QI_DEV_IOTLB_ADDR(addr);
+	}
+
+	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
+		qdep = 0;
+
+	desc->qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
+	desc->qw2 = 0;
+	desc->qw3 = 0;
+}
+
+static inline void qi_desc_piotlb(u16 did, u32 pasid, u64 addr,
+				  unsigned long npages, bool ih,
+				  struct qi_desc *desc)
+{
+	if (npages == -1) {
+		desc->qw0 = QI_EIOTLB_PASID(pasid) |
+				QI_EIOTLB_DID(did) |
+				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+				QI_EIOTLB_TYPE;
+		desc->qw1 = 0;
+	} else {
+		int mask = ilog2(__roundup_pow_of_two(npages));
+		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
+
+		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
+			addr = ALIGN_DOWN(addr, align);
+
+		desc->qw0 = QI_EIOTLB_PASID(pasid) |
+				QI_EIOTLB_DID(did) |
+				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
+				QI_EIOTLB_TYPE;
+		desc->qw1 = QI_EIOTLB_ADDR(addr) |
+				QI_EIOTLB_IH(ih) |
+				QI_EIOTLB_AM(mask);
+	}
+}
+
+static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
+					   u16 qdep, u64 addr,
+					   unsigned int size_order,
+					   struct qi_desc *desc)
+{
+	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
+
+	desc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
+		QI_DEV_IOTLB_PFSID(pfsid);
+
+	/*
+	 * If S bit is 0, we only flush a single page. If S bit is set,
+	 * The least significant zero bit indicates the invalidation address
+	 * range. VT-d spec 6.5.2.6.
+	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
+	 * size order = 0 is PAGE_SIZE 4KB
+	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
+	 * ECAP.
+	 */
+	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
+		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
+				    addr, size_order);
+
+	/* Take page address */
+	desc->qw1 = QI_DEV_EIOTLB_ADDR(addr);
+
+	if (size_order) {
+		/*
+		 * Existing 0s in address below size_order may be the least
+		 * significant bit, we must set them to 1s to avoid having
+		 * smaller size than desired.
+		 */
+		desc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
+					VTD_PAGE_SHIFT);
+		/* Clear size_order bit to indicate size */
+		desc->qw1 &= ~mask;
+		/* Set the S bit to indicate flushing more than 1 page */
+		desc->qw1 |= QI_DEV_EIOTLB_SIZE;
+	}
+}
+
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 01e157d89a16..eaf862e8dea1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1526,24 +1526,9 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 		    unsigned int size_order, u64 type)
 {
-	u8 dw = 0, dr = 0;
-
 	struct qi_desc desc;
-	int ih = 0;
-
-	if (cap_write_drain(iommu->cap))
-		dw = 1;
-
-	if (cap_read_drain(iommu->cap))
-		dr = 1;
-
-	desc.qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
-		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
-	desc.qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
-		| QI_IOTLB_AM(size_order);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
 
+	qi_desc_iotlb(iommu, did, addr, size_order, type, &desc);
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
@@ -1561,20 +1546,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	if (!(iommu->gcmd & DMA_GCMD_TE))
 		return;
 
-	if (mask) {
-		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
-	} else
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
-
-	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
-		qdep = 0;
-
-	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
+	qi_desc_dev_iotlb(sid, pfsid, qdep, addr, mask, &desc);
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
@@ -1594,28 +1566,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		return;
 	}
 
-	if (npages == -1) {
-		desc.qw0 = QI_EIOTLB_PASID(pasid) |
-				QI_EIOTLB_DID(did) |
-				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-				QI_EIOTLB_TYPE;
-		desc.qw1 = 0;
-	} else {
-		int mask = ilog2(__roundup_pow_of_two(npages));
-		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
-
-		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
-			addr = ALIGN_DOWN(addr, align);
-
-		desc.qw0 = QI_EIOTLB_PASID(pasid) |
-				QI_EIOTLB_DID(did) |
-				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
-				QI_EIOTLB_TYPE;
-		desc.qw1 = QI_EIOTLB_ADDR(addr) |
-				QI_EIOTLB_IH(ih) |
-				QI_EIOTLB_AM(mask);
-	}
-
+	qi_desc_piotlb(did, pasid, addr, npages, ih, &desc);
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
@@ -1623,7 +1574,6 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
 {
-	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
 	/*
@@ -1635,40 +1585,9 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	if (!(iommu->gcmd & DMA_GCMD_TE))
 		return;
 
-	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
-		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
-		QI_DEV_IOTLB_PFSID(pfsid);
-
-	/*
-	 * If S bit is 0, we only flush a single page. If S bit is set,
-	 * The least significant zero bit indicates the invalidation address
-	 * range. VT-d spec 6.5.2.6.
-	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
-	 * size order = 0 is PAGE_SIZE 4KB
-	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
-	 * ECAP.
-	 */
-	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
-		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
-				    addr, size_order);
-
-	/* Take page address */
-	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
-
-	if (size_order) {
-		/*
-		 * Existing 0s in address below size_order may be the least
-		 * significant bit, we must set them to 1s to avoid having
-		 * smaller size than desired.
-		 */
-		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
-					VTD_PAGE_SHIFT);
-		/* Clear size_order bit to indicate size */
-		desc.qw1 &= ~mask;
-		/* Set the S bit to indicate flushing more than 1 page */
-		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
-	}
-
+	qi_desc_dev_iotlb_pasid(sid, pfsid, pasid,
+				qdep, addr, size_order,
+				&desc);
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-- 
2.34.1

