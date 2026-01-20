Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38736C5A3
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890054; cv=none; b=lUEP7J1PO9UY7fTw+Lh01REsEtkYYFNfkOC4tzXJqx/zLMgsnISyVxdTt5ZOnax52dNhFJJ0yE2oeLexyACqR39MASSqx6zJ3v6p0s8N6+iqE4OHdvytHGCiC0ZsCzLGJfKOMANXlVwEMUJuR+buDr+YtlMtrI99lJ+naNEEJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890054; c=relaxed/simple;
	bh=nlGjv1mM5tMvlnslmN6pYf6e5Nhw0JtdAENFmV64fis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPWqa9dorkzOVL+6tXUMdhOyHrRCYmn9IzcK1XZAYxpKYABU+6X65XojQp4RjRFML+kU9VPU+8Bizij/PbX7LbS5F+LhFJT61wBbr3x81zv3O2aI+xDb3EEqob3zdR27DIr+gTULnnBX/85j+pOuz/q0Pb3bccE87XyjJlKp4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ac12WcoP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ac12WcoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768890052; x=1800426052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nlGjv1mM5tMvlnslmN6pYf6e5Nhw0JtdAENFmV64fis=;
  b=ac12WcoPENlTqnlaTm/qAW2g455bG0PtoHVFitBbOvPR0FD88DHKie4d
   TTOnp/RzDiwghN9z7pQn+dnVsC5DBr/dXSbrzBvLt3IapVU/uzOeXr5Ja
   nEmuOOR9MiNcDSyglXSo3U7a/5b/YsbuUSAxTdOd2uawQ/Tjmp/JfPUfP
   IBO4LVUXfBnHeU6RrP9fTuLbQJNzzwwh+c1/fBt0SfPRZ/9CJ8JwGC9sU
   ix2unTXKzY5IixCtuvYj7u/CKErC+FiE69rbabNGSiV5T1v9ebUX8+v8/
   28iPhjWPPIihSnzZSplw1YPMdOfb538IavXkNVAlTNqu2M1BaX+Mc8q82
   w==;
X-CSE-ConnectionGUID: Mt9woa4IR/uqRdcSz+gsjg==
X-CSE-MsgGUID: 4oJLoM7KRpC+KXEhpZAwMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69991317"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69991317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:20:52 -0800
X-CSE-ConnectionGUID: Vv0VerFIQ+CoTJlkLrTZfA==
X-CSE-MsgGUID: 8sNwlj9fRvm1AoXQ3uSiog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206464271"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jan 2026 22:20:50 -0800
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
Subject: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down context entry
Date: Tue, 20 Jan 2026 14:18:13 +0800
Message-ID: <20260120061816.2132558-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h | 21 ++++++++++++++++++++-
 drivers/iommu/intel/iommu.c |  4 +++-
 2 files changed, 23 insertions(+), 2 deletions(-)

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
-- 
2.43.0

