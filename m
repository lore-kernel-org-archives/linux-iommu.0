Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188ED17BBE
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172194; cv=none; b=Sm3I1CGCzHsMzxU28KaVbyYLdvxfuEq3qcNpxvluG96KFk9mgAx86yJat2n7uVCNqJOU9GRIJUwUIh1wQjji8UyIQJOuyCyX0vD55JUdVmCIQCGTgLy3JSCUmo8hOwrfA41DN9u5MusJdJTifQBJj8G1kXrSP4UGWy0rwZfaY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172194; c=relaxed/simple;
	bh=1ql59GPNLQi3WjGEBGQSQ0824+BH6uuhZxVOIMX4z8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4IqzVfFGrpWR8e7W+Y0IrR+fJGGgZORw1bM4Mjowgk/jMEM0p4wXm6/9/6oc5XjPjakkhAIJXTu1KUAwo1o+m5PGRFWn2hika+1E0Jb1uH8T48sd3ToQH1xt8Q5dDyu2zGKL0VftUZtAwP/Dq+sALlpleCSylnQIEwrxYrBiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6rYRErl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6rYRErl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172192; x=1754708192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ql59GPNLQi3WjGEBGQSQ0824+BH6uuhZxVOIMX4z8w=;
  b=T6rYRErlhpApmsPycHAPw3Sf5O/AKsgJ2tPBLw7ewu/XJjeyValBrRy9
   5yxmXCZXvlT7mG7bCzTK57dgA+JxgQfhl0nD0UzFy7oQMaHNgB5z9PETC
   0jbhuB0FnTw0TAOgjGXkKx7dKY/GGOjnEPPm5UelbJwcjoGHEn5lsIs1r
   9mf2aRaMVxcwJyAD7XL8pXFkupkwaI7r7eRVausD/l+ZR3fePFH547LH1
   XScCiESK8LiOvJkuYk0unE3pTIdCdNf2T+oMaBKjh3ZZZ20K4gaBeqJTk
   AbkMbW39pP+yzRCCusTh/ZUTCg3X9aJnz7FB3Lkv4skslxD0uKYcRtuO4
   Q==;
X-CSE-ConnectionGUID: j3XJGS15StOtjPvBflkmOQ==
X-CSE-MsgGUID: s0KLSGPeRCW5HXMlJxRoFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239351"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239351"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:30 -0700
X-CSE-ConnectionGUID: KOmL/coXRP+DrBF/G1U74Q==
X-CSE-MsgGUID: eVbQj0BySNaEbS+Q4ll4lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072644"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:28 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 1/5] iommu/vt-d: Refactor IOTLB/Dev-IOTLB invalidation command logic
Date: Fri,  9 Aug 2024 10:54:27 +0800
Message-Id: <20240809025431.14605-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809025431.14605-1-tina.zhang@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate assembling IOTLB/dev-IOTLB invalidation command logic from
qi_flush interfaces. New qi_desc() functions are introduced for this
purpose. The goal is to facilitate the reuse of these qi_desc()
functions in the qi_batch interfaces which will be introduced in a
subsequent patch.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c | 203 +++++++++++++++++++++----------------
 1 file changed, 116 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1c8d3141cb55..64724af1a618 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1360,6 +1360,116 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	return 0;
 }
 
+static void qi_desc_iotlb(struct intel_iommu *iommu, u16 did,
+			  u64 addr, unsigned int size_order,
+			  u64 type, struct qi_desc *desc)
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
+static void qi_desc_dev_iotlb(u16 sid, u16 pfsid,
+			      u16 qdep, u64 addr,
+			      unsigned int mask,
+			      struct qi_desc *desc)
+{
+	if (mask) {
+		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
+		desc->qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+	} else
+		desc->qw1 = QI_DEV_IOTLB_ADDR(addr);
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
+static void qi_desc_piotlb(u16 did, u32 pasid, u64 addr,
+			   unsigned long npages, bool ih,
+			   struct qi_desc *desc)
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
+static void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid,
+				    u32 pasid,  u16 qdep, u64 addr,
+				    unsigned int size_order,
+				    struct qi_desc *desc)
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
 /*
  * Function to submit invalidation descriptors of all types to the queued
  * invalidation interface(QI). Multiple descriptors can be submitted at a
@@ -1520,24 +1630,9 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
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
 
@@ -1555,20 +1650,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
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
 
@@ -1588,28 +1670,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
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
 
@@ -1617,7 +1678,6 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
 {
-	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
 	/*
@@ -1629,40 +1689,9 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
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
2.43.0

