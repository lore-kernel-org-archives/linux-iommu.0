Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A01334374
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566760; cv=none; b=GR6auf+UunPO8ODOpUamQPAONwlkU754reTYdZRmqDAqBkSbjtcAaMyol8EboTYuUwh68hwdb/nP0fbthW9NzzQMzFizAH15ERL5MMTgBTJ+Mz8iwBmz1kweiDpKmRpLBcPiUWul0H6is6A8O2q6P8bSOcrUJ4qu40wg+ZCIseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566760; c=relaxed/simple;
	bh=rs2NGru4ydtPfw6Z5Uhz/AHzASmXVpZ6sK+5hms8cMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHvzisyxbJoNzKX3hgyCsL/6hty08+Tjkl0JUL2HNF0J9IlOBixL0kKUWxO9E34N+6Tq3Xn2rAP4+HvFBYJNeyygtD2ByiK16ZSaQZHiHIHmytWbrPazOiPPNkhfI50XmkbbewRgv4JZIYaPd8Y4ykKs9M5Sn+peY4f6AErP3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtqPdKxt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtqPdKxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566759; x=1822102759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rs2NGru4ydtPfw6Z5Uhz/AHzASmXVpZ6sK+5hms8cMs=;
  b=mtqPdKxtdVtxYPhOYvh09336jfW4k6a8NZV6NUFAVji4wCXjjb2LAeYH
   Rv79SYjhkEmysVDjnp0J4tvvb+j4iL+cRsMdVOo5yoK9QltBE23RIQI4W
   mDYJgFRk5/LF/1cleNG428PFKkXs5wGVStkvWYstWqtYFXuZBTpk/Y2ar
   NGZpqBrW6gKyvCfrSY09BiWqTHiZy/DHEIPzZrQ5lKqICFtDJIVrZCylA
   FZJO6XPct3RGe4bp7ZgQ9eQrZJ/ycSx0BE8AaAREVu7q2czts1D2gdqPo
   7PewguudQrBtjx1/KtuT8Zyqrszxj5mTXL/p5HiV3b5/zge1+dbjLfGfL
   Q==;
X-CSE-ConnectionGUID: 9wJF6b7/QfSrcEDCL4Yvjw==
X-CSE-MsgGUID: wQgKYzNYTP2Mvx3uc6nDqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917192"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:19 -0700
X-CSE-ConnectionGUID: Az9Jb5XqTnm8034eNqH61Q==
X-CSE-MsgGUID: qkklc6BLTGaOyQBjMPLFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004084"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
Date: Mon, 28 Sep 2026 11:27:15 +0800
Message-ID: <20260928032722.2868623-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers request a full Device-TLB flush by passing MAX_AGAW_PFN_WIDTH
(64 - VTD_PAGE_SHIFT == 52) as @size_order.  Two expressions in
qi_desc_dev_iotlb_pasid() are not prepared for a value that large:

  unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
  ...
  if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))

The second evaluates to 1UL << 64, which is undefined on all
architectures.  On x86_64 the shift count masks to zero, IS_ALIGNED(addr,
1) is trivially true, and the alignment sanity check silently degrades
into a no-op.

The first evaluates to 1UL << 63.  That is well defined on 64-bit builds,
where unsigned long is 64 bits wide, but is undefined on 32-bit ones.  In
practice x86 masks the shift count to five bits, so the expression yields
1UL << 31 and ~mask becomes 0x7fffffff.  That value is zero-extended when
applied to the 64-bit descriptor, so

  desc->qw1 &= ~mask;

clears qw1[63:32] as well as bit 31, collapsing the ADDR field that had
just been filled with ones.  Reaching that requires a scalable-mode PASID
configuration on 32-bit x86, which is not a realistic deployment, but the
construct is wrong regardless.

Compute the mask with BIT_ULL() so that it is 64-bit on every
architecture, and skip the alignment check for a full flush, where it is
both meaningless and the source of the out-of-range shift.

Note that @size_order must not be clamped below 64 - VTD_PAGE_SHIFT.  With
S set, hardware derives the invalidation range from the least significant
zero bit N of ADDR and matches bits [63:N+1] of the incoming address.  For
size_order 52 the descriptor sets ADDR[63:12] and clears bit 63, making
N = 63 and the comparison range empty, so everything is invalidated.
Reducing @size_order to 51 would instead leave N = 62 and cause hardware
to compare address bit 63; since callers pass an address of 0, only the
lower half of the address space would be invalidated.  Bound @size_order
at 64 - VTD_PAGE_SHIFT so that a bogus caller cannot reintroduce an
out-of-range shift, without altering the full-flush encoding.

The non-PASID variant qi_desc_dev_iotlb() already uses 1ULL and is
unaffected.

Fixes: f701c9f36bcb7 ("iommu/vt-d: Factor out invalidation descriptor composition")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260623060122.3796325-1-guanghuifeng%40linux.alibaba.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 23dbe6c24439..5b3d234ae265 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1105,12 +1105,20 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 					   unsigned int size_order,
 					   struct qi_desc *desc)
 {
-	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
-
 	desc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
 
+	/*
+	 * The widest range the descriptor can express is a full flush, encoded
+	 * by making bit 63 the least significant zero bit of ADDR, that is
+	 * @size_order == 64 - VTD_PAGE_SHIFT.  Bound @size_order there so that
+	 * a caller passing something larger cannot produce an out-of-range
+	 * shift below.
+	 */
+	if (size_order > 64 - VTD_PAGE_SHIFT)
+		size_order = 64 - VTD_PAGE_SHIFT;
+
 	/*
 	 * If S bit is 0, we only flush a single page. If S bit is set,
 	 * The least significant zero bit indicates the invalidation address
@@ -1120,7 +1128,8 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
+	if (size_order < 64 - VTD_PAGE_SHIFT &&
+	    !IS_ALIGNED(addr, BIT_ULL(VTD_PAGE_SHIFT + size_order)))
 		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
 				    addr, size_order);
 
@@ -1136,7 +1145,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
 		desc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
 					VTD_PAGE_SHIFT);
 		/* Clear size_order bit to indicate size */
-		desc->qw1 &= ~mask;
+		desc->qw1 &= ~BIT_ULL(VTD_PAGE_SHIFT + size_order - 1);
 		/* Set the S bit to indicate flushing more than 1 page */
 		desc->qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
-- 
2.43.0

