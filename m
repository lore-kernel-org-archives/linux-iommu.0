Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B58C8E9
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455647; cv=none; b=c70DRbnuEi/1eA4LHeOimnnJFCbwnQ/FIerOewgXpPARxLis2rpqc/P4op+bchsN8VTdJM/p1a1phXEWD8hWrs+mE8FnMnfMxTHhgBvbVnpVwYC6Nqp8KyaTPZsxVwNnOkEMBZxzgmcuIsocrwtrQpUTqN57emge6tj1XDwA/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455647; c=relaxed/simple;
	bh=m1KfPaWzhvEHbH4/FQ084EzsffkVfRltEWpMb92l3OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIKuiRK1vsq28/85zxh8IDfw3hGYry4i5YeXRZJ3Mee69KssKaDzJ9J6Y24SOSWQmXJ0k3D2aeZW1jsA4OZZGRakduc8UCqt3Kx1vHoL0i3SJgqA6IKKNDspMgvZD4QxPK1JO5cySnMmFSE3AIPignL59Xi0e+w2ukoCzoYmq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acxe/rvO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acxe/rvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455646; x=1750991646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1KfPaWzhvEHbH4/FQ084EzsffkVfRltEWpMb92l3OM=;
  b=acxe/rvOZdiwWR3nQ+bbEtIOvIHcFoOmK/EfBCCWyY0H8g7DpMQ+ZSPE
   ci8s1FZzDvYAIUJh/CNXZa+vP9EqC3gsQsORmVWQXGsHpczkT980CXc84
   PO6cOAHU7y9m8deQnAkkwv1FsL2iZtpeQb2zBqkuAzKmWX9UO5sEet4An
   hsm5q51FWgrP8ffA3maqdthGDFu4McWFS7+lev+p1tfveRFyD+dH/BLIl
   RRev7m4FcpcK1Y+pMmsqfJ5qmHP7+prOkyVqkpQw3UkQsqfhOWvw7fiHR
   Rf02/ghW1p+0IjfcZ4Xgfo62sZpHXSZl/TAGesxVy+NjMgviJ5y+Cqeqf
   g==;
X-CSE-ConnectionGUID: UJIwOYzTRbKfC3igIzjvkw==
X-CSE-MsgGUID: S8S8VwhqSEuHTc1wwBIksw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16786013"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16786013"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:34:06 -0700
X-CSE-ConnectionGUID: 01HdCtTyQVCQKkkJXeulJg==
X-CSE-MsgGUID: Y2jdWdBiTbCzVRRu7pwadw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49385429"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 19:34:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context change
Date: Thu, 27 Jun 2024 10:31:20 +0800
Message-Id: <20240627023121.50166-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627023121.50166-1-baolu.lu@linux.intel.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper is used to flush the related caches following a change in a
context table entry that was previously present. The VT-d specification
provides guidance for such invalidations in section 6.5.3.3.

This helper replaces the existing open code in the code paths where a
present context entry is being torn down.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |   4 ++
 drivers/iommu/intel/iommu.c |  32 +-----------
 drivers/iommu/intel/pasid.c | 101 +++++++++++++++++++++++++++++-------
 3 files changed, 87 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9a3b064126de..63eb3306c025 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1143,6 +1143,10 @@ void cache_tag_flush_all(struct dmar_domain *domain);
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
+void intel_context_flush_present(struct device_domain_info *info,
+				 struct context_entry *context,
+				 bool affect_domains);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 int intel_svm_enable_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6c682c9defee..89f489372138 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1359,21 +1359,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
-				    u64 addr, unsigned int mask)
-{
-	u16 sid, qdep;
-
-	if (!info || !info->ats_enabled)
-		return;
-
-	sid = info->bus << 8 | info->devfn;
-	qdep = info->ats_qdep;
-	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-			   qdep, addr, mask);
-	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
-}
-
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -1959,7 +1944,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 {
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
-	u16 did_old;
 
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
@@ -1968,24 +1952,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	did_old = context_domain_id(context);
-
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
+	intel_context_flush_present(info, context, true);
 	spin_unlock(&iommu->lock);
-	iommu->flush.flush_context(iommu,
-				   did_old,
-				   (((u16)bus) << 8) | devfn,
-				   DMA_CCMD_MASK_NOBIT,
-				   DMA_CCMD_DEVICE_INVL);
-
-	iommu->flush.flush_iotlb(iommu,
-				 did_old,
-				 0,
-				 0,
-				 DMA_TLB_DSI_FLUSH);
-
-	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index aabcdf756581..aef4b4afb873 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -690,26 +690,8 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
+	intel_context_flush_present(info, context, false);
 	spin_unlock(&iommu->lock);
-
-	/*
-	 * Cache invalidation for changes to a scalable-mode context table
-	 * entry.
-	 *
-	 * Section 6.5.3.3 of the VT-d spec:
-	 * - Device-selective context-cache invalidation;
-	 * - Domain-selective PASID-cache invalidation to affected domains
-	 *   (can be skipped if all PASID entries were not-present);
-	 * - Domain-selective IOTLB invalidation to affected domains;
-	 * - Global Device-TLB invalidation to affected functions.
-	 *
-	 * The iommu has been parked in the blocking state. All domains have
-	 * been detached from the device or PASID. The PASID and IOTLB caches
-	 * have been invalidated during the domain detach path.
-	 */
-	iommu->flush.flush_context(iommu, 0, PCI_DEVID(bus, devfn),
-				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
-	devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
@@ -871,3 +853,84 @@ int intel_pasid_setup_sm_context(struct device *dev)
 
 	return pci_for_each_dma_alias(to_pci_dev(dev), pci_pasid_table_setup, dev);
 }
+
+/*
+ * Global Device-TLB invalidation following changes in a context entry which
+ * was present.
+ */
+static void __context_flush_dev_iotlb(struct device_domain_info *info)
+{
+	if (!info->ats_enabled)
+		return;
+
+	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
+			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
+
+	/*
+	 * There is no guarantee that the device DMA is stopped when it reaches
+	 * here. Therefore, always attempt the extra device TLB invalidation
+	 * quirk. The impact on performance is acceptable since this is not a
+	 * performance-critical path.
+	 */
+	quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH, IOMMU_NO_PASID,
+				  info->ats_qdep);
+}
+
+/*
+ * Cache invalidations after change in a context table entry that was present
+ * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations). If
+ * IOMMU is in scalable mode and all PASID table entries of the device were
+ * non-present, set affect_domains to true. Otherwise, false.
+ */
+void intel_context_flush_present(struct device_domain_info *info,
+				 struct context_entry *context,
+				 bool affect_domains)
+{
+	struct intel_iommu *iommu = info->iommu;
+	u16 did = context_domain_id(context);
+	struct pasid_entry *pte;
+	int i;
+
+	assert_spin_locked(&iommu->lock);
+
+	/*
+	 * Device-selective context-cache invalidation. The Domain-ID field
+	 * of the Context-cache Invalidate Descriptor is ignored by hardware
+	 * when operating in scalable mode. Therefore the @did value doesn't
+	 * matter in scalable mode.
+	 */
+	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info->devfn),
+				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
+
+	/*
+	 * For legacy mode:
+	 * - Domain-selective IOTLB invalidation
+	 * - Global Device-TLB invalidation to all affected functions
+	 */
+	if (!sm_supported(iommu)) {
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		__context_flush_dev_iotlb(info);
+
+		return;
+	}
+
+	/*
+	 * For scalable mode:
+	 * - Domain-selective PASID-cache invalidation to affected domains
+	 * - Domain-selective IOTLB invalidation to affected domains
+	 * - Global Device-TLB invalidation to affected functions
+	 */
+	if (affect_domains) {
+		for (i = 0; i < info->pasid_table->max_pasid; i++) {
+			pte = intel_pasid_get_entry(info->dev, i);
+			if (!pte || !pasid_pte_is_present(pte))
+				continue;
+
+			did = pasid_get_domain_id(pte);
+			qi_flush_pasid_cache(iommu, did, QI_PC_ALL_PASIDS, 0);
+			iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		}
+	}
+
+	__context_flush_dev_iotlb(info);
+}
-- 
2.34.1

