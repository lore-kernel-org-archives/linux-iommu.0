Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774441C92
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244290; cv=none; b=RjFGNWTc0YMLFpHaAya0hL8o18jPrrJuhXfGUsL6hq6C9eiz432Modj/rZfwI/VqW+5dh6irEFFbYwVv8gM+PhNZ7TfDZ4DFxOTh/N4m+t1bm7i7TXilAA2YBkXrY/ZPY4zi3usz3fiHOSGSSzyFNTFHNDxZ+R8dxgTTmxVtE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244290; c=relaxed/simple;
	bh=3HzOKvzO9pY4piCmz7QwkmYFBvAbH4HKR8epidlTfh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdUs8zyikuecc4Ne7SZIvp38+CjmZCBsVjwPxTQ2twO3h+UUtwJAGYM/GUN10ty9XicIWFQ+QvC81rAnTFwF7cgn9zEubZfJ1vWQ+8NUK2RydwwT+gc4+AxI/ZWj9NJArMgOBP7yliLAsUq8kWSzcwb80lu6D14r+Jid/shvhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUzQLRdb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUzQLRdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244289; x=1756780289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3HzOKvzO9pY4piCmz7QwkmYFBvAbH4HKR8epidlTfh4=;
  b=bUzQLRdbjTHRCsuPJmUbrQBiwmoGBvsNjQFGK1IyI63m3qol4gegXqXH
   O0aIezCaNRQ4UP0rDDAVrzXSWYNChtwPnncWnv9ldGZ2JIct1wwUMiiyU
   N+86pyTnnZCqNR1oyu9FGFYK6y/5gHRJZxOTcan2Rbq3aTUqNbrX5CZZe
   DfETNMK5T7hnXC9nJsM4Nb/SZv/fJhICNJjTJpaFuyMjDhze4Rya+ezlA
   +BevX9ni//TH7UP/uVmajT/1KUCqw/Q7I2Bby6tq2UjK7ppvcA9tfJ0Mq
   ZDCafTXCNROWv4SxQ7A8nDD3BbIZ/YDJ9x0haa2FVULjaqn0Oc9BKy5zc
   g==;
X-CSE-ConnectionGUID: dswAT3dHRAGEHQZK9HL2Qg==
X-CSE-MsgGUID: PMnmRL8MQg2UKcaY/zK62A==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994297"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994297"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:29 -0700
X-CSE-ConnectionGUID: ShBLQgMMTjuv53qus+FYLA==
X-CSE-MsgGUID: hh7nf8p0TgSZ2uDpnpzAww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359299"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] iommu/vt-d: Factor out helpers from domain_context_mapping_one()
Date: Mon,  2 Sep 2024 10:27:15 +0800
Message-Id: <20240902022724.67059-6-baolu.lu@linux.intel.com>
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

Extract common code from domain_context_mapping_one() into new helpers,
making it reusable by other functions such as the upcoming identity domain
implementation. No intentional functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b58137ecaf87..41c47410736b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1597,6 +1597,61 @@ static void domain_exit(struct dmar_domain *domain)
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
@@ -1625,31 +1680,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
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
@@ -1685,23 +1718,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
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

