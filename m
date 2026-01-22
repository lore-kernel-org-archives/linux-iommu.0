Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285536AB53
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046698; cv=none; b=lQHNyQIR8eovxCLqC9xZ81i7ZU/gX/1iqiyEQCxeL1KsVViit1wursqg43oHoOjefLhk4NXXn3J7dbSc5pptyjPMc77LIVTRmv0edAqa/w/z9dz1BHVdw+pn+j5ePBFciBaSh9IY4cGRpsUXPse9+hAeMcKIsartdmOGJRqpzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046698; c=relaxed/simple;
	bh=feve70lOzZ7CiXg4b8hjR+SRMNJSTVjOQ4VpPQj1shc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlrXZ7mmgmpZbSrcKZeqXVIcjmitTeqD37+Ji00qnIc17lXkaqaZ/I1S/tUsSUOkWy7beqvAE8aN6UMJ8SqvspS213qbH4KiQ2fb/z/fBphMgpYPHXV0cxtIYStqvVn8dpUiyZJTfD3lhnB7xoAXSQdLnKvIm4dyDg42nyYRskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/jbfwir; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/jbfwir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769046695; x=1800582695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feve70lOzZ7CiXg4b8hjR+SRMNJSTVjOQ4VpPQj1shc=;
  b=U/jbfwirS0bXPUlFigGdLBbLVU8C84RgbPA1GuJwgDvgm1dHqTUExn/x
   AJiQE1bEZtB1eYTzny4cA1SlJRA3sEsEAnnLyEV24Tt4KhZacfmSlHzLe
   zRUMtwIcOwGfU8YZEaJCc6DlS+Y1r6SRQkPqeeJ3uIbTbGDBYRpf/lp+0
   oUd6bepE8XLW6SlBifOf7B6uz5HKXWFNjqkZWZ/p0BZ+VU4Ae8R9dsojm
   JYDMfftUYlnFHWWFjXXWxvJ1Um+vhcrTTF2vTOm8ojSsP03/emTsRcAW5
   8dRhOwUDYkgP4qfYY+0NTIRGJB/5p1NKe5PxNWjDwcxPjzno68+MG3nnw
   Q==;
X-CSE-ConnectionGUID: 25FwBhg4SquLpZoyX32oxA==
X-CSE-MsgGUID: wlbh0ylqQki/wpSoF8zxSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81393063"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81393063"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:51:34 -0800
X-CSE-ConnectionGUID: /4ejGBJ+R5aSTbk409CQDg==
X-CSE-MsgGUID: 8YO/urzPRCKW4h3CARzhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211455651"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2026 17:51:33 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iommu/vt-d: Clear Present bit before tearing down context entry
Date: Thu, 22 Jan 2026 09:48:55 +0800
Message-ID: <20260122014856.2457052-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
References: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When tearing down a context entry, the current implementation zeros the
entire 128-bit entry using multiple 64-bit writes. This creates a window
where the hardware can fetch a "torn" entry — where some fields are
already zeroed while the 'Present' bit is still set — leading to
unpredictable behavior or spurious faults.

While x86 provides strong write ordering, the compiler may reorder writes
to the two 64-bit halves of the context entry. Even without compiler
reordering, the hardware fetch is not guaranteed to be atomic with
respect to multiple CPU writes.

Align with the "Guidance to Software for Invalidations" in the VT-d spec
(Section 6.5.3.3) by implementing the recommended ownership handshake:

1. Clear only the 'Present' (P) bit of the context entry first to
   signal the transition of ownership from hardware to software.
2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
3. Perform the required cache and context-cache invalidation to ensure
   hardware no longer has cached references to the entry.
4. Fully zero out the entry only after the invalidation is complete.

Also, add a dma_wmb() to context_set_present() to ensure the entry
is fully initialized before the 'Present' bit becomes visible.

Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
Reported-by: Dmytro Maluka <dmaluka@chromium.org>
Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260120061816.2132558-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 21 ++++++++++++++++++++-
 drivers/iommu/intel/iommu.c |  4 +++-
 drivers/iommu/intel/pasid.c |  5 ++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25c5e22096d4..599913fb65d5 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -900,7 +900,26 @@ static inline int pfn_level_offset(u64 pfn, int level)
 
 static inline void context_set_present(struct context_entry *context)
 {
-	context->lo |= 1;
+	u64 val;
+
+	dma_wmb();
+	val = READ_ONCE(context->lo) | 1;
+	WRITE_ONCE(context->lo, val);
+}
+
+/*
+ * Clear the Present (P) bit (bit 0) of a context table entry. This initiates
+ * the transition of the entry's ownership from hardware to software. The
+ * caller is responsible for fulfilling the invalidation handshake recommended
+ * by the VT-d spec, Section 6.5.3.3 (Guidance to Software for Invalidations).
+ */
+static inline void context_clear_present(struct context_entry *context)
+{
+	u64 val;
+
+	val = READ_ONCE(context->lo) & GENMASK_ULL(63, 1);
+	WRITE_ONCE(context->lo, val);
+	dma_wmb();
 }
 
 static inline void context_set_fault_enable(struct context_entry *context)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..c66cc51f9e51 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1240,10 +1240,12 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	}
 
 	did = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
 	intel_context_flush_no_pasid(info, context, did);
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
 int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 07e056b24605..f5dfa9b9eb3e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -1024,7 +1024,7 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 	}
 
 	if (context_copied(iommu, bus, devfn)) {
-		context_clear_entry(context);
+		context_clear_present(context);
 		__iommu_flush_cache(iommu, context, sizeof(*context));
 
 		/*
@@ -1044,6 +1044,9 @@ static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 		devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
 
+		context_clear_entry(context);
+		__iommu_flush_cache(iommu, context, sizeof(*context));
+
 		/*
 		 * At this point, the device is supposed to finish reset at
 		 * its driver probe stage, so no in-flight DMA will exist,
-- 
2.43.0

