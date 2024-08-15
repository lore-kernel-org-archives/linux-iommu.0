Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C917A595
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704809; cv=none; b=ZmZ57cLeM6mdSXc1BeJ95eByxtYROGTFy5sBR7zgiEUbYaHBOm+5exG4bCVfvX7UboAJnUQw+ZdRgSN3ixgNRmORfc7JkZX5Tzew4iY6Oq0N8TAvw687wGFGE5a+9zaNFNm2s1iVzBUSgtkTw5W8LwIFiOkXLFK1JIev5bEMinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704809; c=relaxed/simple;
	bh=XSYlWOtrIMf6in1bhc/ncpYlAxPLTtwq8F8Ok0DkSF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4vBnRK8TkquPS/q1sRQzNv2Jc1m1ntOchnJkm7GE8AseOGG8aXO5pwPLOW4BcjSWv61bM7fDc7HXu2CvRZr62CsnTQR2dcqgXVCn4PWuKYUd8DKZKFk/TO+pd1c1W4Cr3QeIIUe2xjoCcr0j6lC/8EA/j6f84fTtu6W490mQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dr62RS/N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dr62RS/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704807; x=1755240807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XSYlWOtrIMf6in1bhc/ncpYlAxPLTtwq8F8Ok0DkSF8=;
  b=Dr62RS/NfM2npBJNHtXRYGqaBu2U4xAy2DlrAjFzHMh/4QTVHzdSD4pr
   GMXv9WBTbr8y1l9ZW3JPKO7KKTcHwmV5uUpDxFoLwybles6SleZQ1W2bR
   slNrby0F1auewq74G1zHdnvkdEz3mUY40Y1XBkojdrZhbBUFKL419aFza
   Rm/qYaUetUs825bGJ2OKk1jzgMaLnIHnrocRZTtzxp5ocgZeLRF+tg0nI
   Mz3HnMADB7ARGCaaUuu1C/+BnlQ4DcoaPswa/oromeOfZ3c4ZjvORG2th
   c8oVyLfHVbK7jxDQOvYWPQHtjw2yJy7+FVdtpl3Vlxz22NpFLAEZ37it+
   Q==;
X-CSE-ConnectionGUID: YHr0TinhQnyvLp301+/L/w==
X-CSE-MsgGUID: 3IVyPJCuTsu5eOvJfcO6vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32528285"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32528285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:53:27 -0700
X-CSE-ConnectionGUID: x1Wp0EwjR+SFWWVICeFLUw==
X-CSE-MsgGUID: LMCe578xRySs4UZHvJojvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82471528"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2024 23:53:25 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 1/4] iommu/vt-d: Factor out invalidation descriptor composition
Date: Thu, 15 Aug 2024 14:52:18 +0800
Message-Id: <20240815065221.50328-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815065221.50328-1-tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the logic for constructing IOTLB and device TLB invalidation
descriptors from the qi_flush interfaces. New helpers, qi_desc(), are
introduced to encapsulate this common functionality.

Moving descriptor composition code to new helpers enables its reuse in
the upcoming qi_batch interfaces.

No functional changes are intended.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c  |  93 ++----------------------------
 drivers/iommu/intel/iommu.h | 109 ++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 01e157d89a163..eaf862e8dea1a 100644
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
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 01002ae2a091a..e297a322ba2d9 100644
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
 
-- 
2.34.1

