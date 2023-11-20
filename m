Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1119DDD0
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ML8+Na6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480059; x=1732016059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2nGnhJsGWMGRpp0Vox7JpzqGcC9rTc12DoKGBk9V+/8=;
  b=ML8+Na6jr5e5L8oyXoXCJkWsn0QvN6K2pytT2AkhTKW6GLVHFPh8CDXv
   dPy86xxHyKCqS0ky8NReVbNQ5oS7Wcl3Zf0swngjw8aciOl2RE0ESJYkx
   TmZZu+/k00gkU1ar2PceGqBkdQ2iLf1omck3zAMEFr8FS0n7AMIJWfn8y
   6Z/O0s/JXRyA5coPw2vQYMTn16WBbcs7yZJkSCtw68nsLKxrdcRRB0kS9
   mlG05aFuqYldSrqlMJJEFph/aVMSeRAfgrBdLP0t/NTl5YWrbqB1io5IF
   asSBXmHTRolOuicgg0kTCc0GKbeNORpifXQHU5CQ/wc3LchSz5Vebyemt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376635002"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376635002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856963632"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856963632"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 03:34:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Refactor domain_context_mapping_one() to be reusable
Date: Mon, 20 Nov 2023 19:29:42 +0800
Message-Id: <20231120112944.142741-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120112944.142741-1-baolu.lu@linux.intel.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract common code from domain_context_mapping_one() into new functions,
making it reusable by other functions such as the upcoming identity domain
implementation. No intentional functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 77769ad4706e..86339dc30243 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1727,6 +1727,61 @@ static void domain_exit(struct dmar_domain *domain)
 	kfree(domain);
 }
 
+/*
+ * For kdump cases, old valid entries may be cached due to the
+ * in-flight DMA and copied pgtable, but there is no unmapping
+ * behaviour for them, thus we need an explicit cache flush for
+ * the newly-mapped device. For kdump, at this point, the device
+ * is supposed to finish reset at its driver probe stage, so no
+ * in-flight DMA will exist, and we don't need to worry anymore
+ * hereafter.
+ */
+static void copied_context_tear_down(struct intel_iommu *iommu,
+				     struct context_entry *context,
+				     u8 bus, u8 devfn)
+{
+	u16 did_old;
+
+	if (!context_copied(iommu, bus, devfn))
+		return;
+
+	assert_spin_locked(&iommu->lock);
+
+	did_old = context_domain_id(context);
+	context_clear_entry(context);
+
+	if (did_old < cap_ndoms(iommu->cap)) {
+		iommu->flush.flush_context(iommu, did_old,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
+					 DMA_TLB_DSI_FLUSH);
+	}
+
+	clear_context_copied(iommu, bus, devfn);
+}
+
+/*
+ * It's a non-present to present mapping. If hardware doesn't cache
+ * non-present entry we only need to flush the write-buffer. If the
+ * _does_ cache non-present entries, then it does so in the special
+ * domain #0, which we have to flush:
+ */
+static void context_present_cache_flush(struct intel_iommu *iommu, u16 did,
+					u8 bus, u8 devfn)
+{
+	if (cap_caching_mode(iommu->cap)) {
+		iommu->flush.flush_context(iommu, 0,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+}
+
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      u8 bus, u8 devfn)
@@ -1755,31 +1810,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_present(context) && !context_copied(iommu, bus, devfn))
 		goto out_unlock;
 
-	/*
-	 * For kdump cases, old valid entries may be cached due to the
-	 * in-flight DMA and copied pgtable, but there is no unmapping
-	 * behaviour for them, thus we need an explicit cache flush for
-	 * the newly-mapped device. For kdump, at this point, the device
-	 * is supposed to finish reset at its driver probe stage, so no
-	 * in-flight DMA will exist, and we don't need to worry anymore
-	 * hereafter.
-	 */
-	if (context_copied(iommu, bus, devfn)) {
-		u16 did_old = context_domain_id(context);
-
-		if (did_old < cap_ndoms(iommu->cap)) {
-			iommu->flush.flush_context(iommu, did_old,
-						   (((u16)bus) << 8) | devfn,
-						   DMA_CCMD_MASK_NOBIT,
-						   DMA_CCMD_DEVICE_INVL);
-			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-		}
-
-		clear_context_copied(iommu, bus, devfn);
-	}
-
+	copied_context_tear_down(iommu, context, bus, devfn);
 	context_clear_entry(context);
+
 	context_set_domain_id(context, did);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
@@ -1815,23 +1848,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	context_set_present(context);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
-
-	/*
-	 * It's a non-present to present mapping. If hardware doesn't cache
-	 * non-present entry we only need to flush the write-buffer. If the
-	 * _does_ cache non-present entries, then it does so in the special
-	 * domain #0, which we have to flush:
-	 */
-	if (cap_caching_mode(iommu->cap)) {
-		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
-
+	context_present_cache_flush(iommu, did, bus, devfn);
 	ret = 0;
 
 out_unlock:
-- 
2.34.1

