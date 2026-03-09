Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8C350A08
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036596; cv=none; b=O6LqoeENnk7fsjz/TjiagClgeM0RmExTAJe4mInld/uzXIMMLm7XLYFGlMOt8LoPOM0uJWDy+xppJx6qcsEpBmU9BjRCPGM7Q40bn4yF6euE1D77xqsGDkSo26AdBlT4QKvFiWhy6WroM/jhHGzhFibs03c7PAy8w/Y6eE3nK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036596; c=relaxed/simple;
	bh=deio4nPCsVkZq6SwU0doaBbEpKvzGPXhSnPfuCmiHQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltIunQ4NH+154NGbuWxF8//6aP5e3YAzQzMDBwohF592amFMnUdQY2dVqvMEg35UuKKGRIYuMxbZQ9JvgJDx5gVYqDn/lNhoOK54bjnWEpNQrUAyJJWMsJQihVCFTSlDUa+hryxLtkoTWL1yc+rASlOaPLkbFoXbvBxcNJtFZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0DxM+Tq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0DxM+Tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036593; x=1804572593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deio4nPCsVkZq6SwU0doaBbEpKvzGPXhSnPfuCmiHQk=;
  b=T0DxM+TqxcdoihhjbZB/9Vbuz2MUCRQ2xt5JiiqhsHnSxU4NWiHHIR7A
   r2pjHvC2s5d43nF78ni8w+TrJmnlvjTetqW/+GAFhlcaR49+yb2VTeJbk
   FtctDkrNq83SDvn6E2luYayT786WK1b/IfV0VGTuU4AtcKD38ttr90SxO
   JwsOWAKJZMUTUilhCDKOc8cW4FpGYy3gfnIJbW1MMgLaepnv7wD3ZzOeP
   55/sOkfMKrzUdiFDA74CoX8knELjXaV4AhX9yVRSOcTBhrcRnaj/2WeOJ
   vh53PpKyZu3rLZK/mFITYnfI68TB55LPfTwJW5kMBWO0O0IwhNBrABp0f
   Q==;
X-CSE-ConnectionGUID: gN6ro0WmTYyG322Oq+WZDQ==
X-CSE-MsgGUID: h7Ij771vQnq8mM3gy6uQ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248278"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248278"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:52 -0700
X-CSE-ConnectionGUID: y21i49Q6Q26Gu6J3fPlI/g==
X-CSE-MsgGUID: XVlFIbhRStyDmU43My1MFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669168"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/8] iommu/vt-d: Add trace events for PASID entry sync updates
Date: Mon,  9 Mar 2026 14:06:44 +0800
Message-ID: <20260309060648.276762-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entry_sync library introduces a more complex, multi-step update
process for PASID table entries to enable hitless transitions. Add a
set of trace events specifically for the Intel PASID sync plumbing.

The implemented trace events introduce:

- entry_write_start / entry_write_complete: Captures the state of the
  512-bit PASID entry before and after the entry_sync library performs
  its update logic. This allows verification of the final output compared
  to the target.

- entry_get_used: Logs the current entry alongside the calculated "used
  bits" mask. This is critical for debugging the library's decision-making
  process regarding whether an update can be hitless or must be disruptive.

- entry_sync: Tracks the state transitions (was_present vs. is_present)
  within the entry_sync callback. This helps verify that the correct cache
  invalidations and IOTLB flushes are being triggered for specific
  transitions (e.g., P=1 to P=1 hitless vs. P=1 to P=0 disruptive).

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/trace.h | 107 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c |  11 +++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 6311ba3f1691..b0ccda6f8dc5 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -181,6 +181,113 @@ DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range_np,
 		 unsigned long addr, unsigned long pages, unsigned long mask),
 	TP_ARGS(tag, start, end, addr, pages, mask)
 );
+
+DECLARE_EVENT_CLASS(entry_write,
+	TP_PROTO(struct device *dev, u32 pasid, u128 *target, u128 *curr),
+	TP_ARGS(dev, pasid, target, curr),
+
+	TP_STRUCT__entry(
+		__string(dev, dev_name(dev))
+		__field(u32, pasid)
+		__field(u64, t_w3)
+		__field(u64, t_w2)
+		__field(u64, t_w1)
+		__field(u64, t_w0)
+		__field(u64, c_w3)
+		__field(u64, c_w2)
+		__field(u64, c_w1)
+		__field(u64, c_w0)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev);
+		__entry->pasid = pasid;
+		/* Target Entry */
+		__entry->t_w0 = (u64)target[0];
+		__entry->t_w1 = (u64)(target[0] >> 64);
+		__entry->t_w2 = (u64)target[1];
+		__entry->t_w3 = (u64)(target[1] >> 64);
+		/* Current Entry */
+		__entry->c_w0 = (u64)curr[0];
+		__entry->c_w1 = (u64)(curr[0] >> 64);
+		__entry->c_w2 = (u64)curr[1];
+		__entry->c_w3 = (u64)(curr[1] >> 64);
+	),
+
+	TP_printk("%s[%u] target %016llx:%016llx:%016llx:%016llx, current %016llx:%016llx:%016llx:%016llx",
+		  __get_str(dev), __entry->pasid,
+		  __entry->t_w3, __entry->t_w2, __entry->t_w1, __entry->t_w0,
+		  __entry->c_w3, __entry->c_w2, __entry->c_w1, __entry->c_w0
+	)
+);
+
+DEFINE_EVENT(entry_write, entry_write_start,
+	TP_PROTO(struct device *dev, u32 pasid, u128 *target, u128 *curr),
+	TP_ARGS(dev, pasid, target, curr)
+);
+
+DEFINE_EVENT(entry_write, entry_write_complete,
+	TP_PROTO(struct device *dev, u32 pasid, u128 *target, u128 *curr),
+	TP_ARGS(dev, pasid, target, curr)
+);
+
+TRACE_EVENT(entry_get_used,
+	TP_PROTO(const u128 *pe, u128 *used),
+	TP_ARGS(pe, used),
+
+	TP_STRUCT__entry(
+		__field(u64, e_w3)
+		__field(u64, e_w2)
+		__field(u64, e_w1)
+		__field(u64, e_w0)
+		__field(u64, u_w3)
+		__field(u64, u_w2)
+		__field(u64, u_w1)
+		__field(u64, u_w0)
+	),
+
+	TP_fast_assign(
+		__entry->e_w0 = (u64)pe[0];
+		__entry->e_w1 = (u64)(pe[0] >> 64);
+		__entry->e_w2 = (u64)pe[1];
+		__entry->e_w3 = (u64)(pe[1] >> 64);
+
+		__entry->u_w0 = (u64)used[0];
+		__entry->u_w1 = (u64)(used[0] >> 64);
+		__entry->u_w2 = (u64)used[1];
+		__entry->u_w3 = (u64)(used[1] >> 64);
+	),
+
+	TP_printk("entry %016llx:%016llx:%016llx:%016llx, used %016llx:%016llx:%016llx:%016llx",
+		  __entry->e_w3, __entry->e_w2, __entry->e_w1, __entry->e_w0,
+		  __entry->u_w3, __entry->u_w2, __entry->u_w1, __entry->u_w0
+	)
+);
+
+TRACE_EVENT(entry_sync,
+	TP_PROTO(struct device *dev, u32 pasid, bool was_present, bool is_present),
+	TP_ARGS(dev, pasid, was_present, is_present),
+
+	TP_STRUCT__entry(
+		__string(dev, dev_name(dev))
+		__field(u32, pasid)
+		__field(bool, was_present)
+		__field(bool, is_present)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev);
+		__entry->pasid = pasid;
+		__entry->was_present = was_present;
+		__entry->is_present = is_present;
+	),
+
+	TP_printk("%s[%u] was %s, is now %s",
+		  __get_str(dev), __entry->pasid,
+		  __entry->was_present ? "present" : "non-present",
+		  __entry->is_present ? "present" : "non-present"
+	)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5b9eb5c8f42d..b7c8888afaef 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -20,6 +20,7 @@
 
 #include "iommu.h"
 #include "pasid.h"
+#include "trace.h"
 #include "../iommu-pages.h"
 #include "../entry_sync.h"
 
@@ -68,8 +69,10 @@ static void intel_pasid_get_used(const u128 *entry, u128 *used)
 	ue->val[0] |= PASID_PTE_PRESENT;
 
 	/* Nothing more for non-present entries. */
-	if (!(pe->val[0] & PASID_PTE_PRESENT))
+	if (!(pe->val[0] & PASID_PTE_PRESENT)) {
+		trace_entry_get_used(entry, used);
 		return;
+	}
 
 	pgtt = pasid_pte_get_pgtt(pe);
 	switch (pgtt) {
@@ -107,6 +110,8 @@ static void intel_pasid_get_used(const u128 *entry, u128 *used)
 	default:
 		WARN_ON(true);
 	}
+
+	trace_entry_get_used(entry, used);
 }
 
 static void intel_pasid_sync(struct entry_sync_writer128 *writer)
@@ -132,6 +137,8 @@ static void intel_pasid_sync(struct entry_sync_writer128 *writer)
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
 
+	trace_entry_sync(dev, pasid, was_present, is_present);
+
 	/* Sync for "P=0" to "P=1": */
 	if (!was_present) {
 		if (is_present)
@@ -195,7 +202,9 @@ static int __maybe_unused intel_pasid_write(struct intel_iommu *iommu,
 	 * 1. Checks if it can do a 1-quanta hitless flip.
 	 * 2. If not, it does a 3-step V=0 (disruptive) update.
 	 */
+	trace_entry_write_start(dev, pasid, target, (u128 *)pte);
 	entry_sync_write128(&p_writer.writer, (u128 *)pte, target, memory, sizeof(memory));
+	trace_entry_write_complete(dev, pasid, target, (u128 *)pte);
 
 	return 0;
 }
-- 
2.43.0

