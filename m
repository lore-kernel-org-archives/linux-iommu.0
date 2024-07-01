Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A113D53D
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833171; cv=none; b=TDOplJXiO5du/PHL8UGEK8rbdaN5+qjDSjL10s4sWcsvEDjFpAs/hMORB1MwJmsJPYAKqtU1AEnWiVQDXP3n9KzvIta8/7hR/sirw+sRl8kBNobRd84KM5Yw826rY0/KgTKy7hX0ByKPgxIrR7Iv9aWioiZU9XLNB/5pGG291Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833171; c=relaxed/simple;
	bh=6W/WkJb2I5XwvnoZrGo3y+VGs96lMqal8cZ7n5ZUQw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=am/opx4Wd/IvdCqZ2137D4O6hI0CxEbT8a2GB9DGG3uJH5S554q7x+Pyugg5wvKH/d7QYdGIVGK3dM5VpCqXrab/+fLrbFovVA1STYQUt00lx902D9vRFFKv8tn9aM6j2kKUZn8Kp+128BfiHWOdolPwWL9e20R7/w0sZcbNzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdZXcykx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdZXcykx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719833168; x=1751369168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6W/WkJb2I5XwvnoZrGo3y+VGs96lMqal8cZ7n5ZUQw4=;
  b=IdZXcykxkqtRRFhX8qfb+cUm1mC5sv66UYMzoQE+hWHTlvTt9s2KqWzP
   7ioIiuJR8iPRGHrSuZdj/2pVtKLUch2Lrziv4kEs2vI6Q9G0PO8xcoCxw
   DBpBcmqBscTRtrIBncsawXVxJBN3cDNSarosOqEJScV8CQ2i2gRIY0WrM
   nk/7NWHaAOIV7jBDMwWNfhMstlV7Fzclx8pneF8qayuU7ZIuk+dBhHMH4
   Hzaze8uqSMb7rLNeYJ2fi07FJDuxgNS4E8KDGgr4frEPsjNVcDvxxwMwx
   +axYwYcRZA6ayqrK2bqbcBW4z7ljauBatEyOzPpCF4zhiDq+/3Ae42x0c
   A==;
X-CSE-ConnectionGUID: RtOg1mmKR8ucqyB1rQpdYw==
X-CSE-MsgGUID: 64w7w17QSGund1yeSj3nqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17082658"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17082658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:26:07 -0700
X-CSE-ConnectionGUID: fCnnDf/2QqC+uGAqHOcZUg==
X-CSE-MsgGUID: Q1/FJnYeRfKYmwmNHDLU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45481439"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2024 04:26:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context change
Date: Mon,  1 Jul 2024 19:23:16 +0800
Message-Id: <20240701112317.94022-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701112317.94022-1-baolu.lu@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/iommu.c |  32 +----------
 drivers/iommu/intel/pasid.c | 106 +++++++++++++++++++++++++++++-------
 3 files changed, 92 insertions(+), 50 deletions(-)

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
index 1f0d6892a0b6..e84b0fdca107 100644
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
+	intel_context_flush_present(info, context, true);
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index aabcdf756581..d6623d2c2050 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -691,25 +691,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
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
+	intel_context_flush_present(info, context, false);
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
@@ -871,3 +853,89 @@ int intel_pasid_setup_sm_context(struct device *dev)
 
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
+ * non-present, set flush_domains to false. Otherwise, true.
+ */
+void intel_context_flush_present(struct device_domain_info *info,
+				 struct context_entry *context,
+				 bool flush_domains)
+{
+	struct intel_iommu *iommu = info->iommu;
+	u16 did = context_domain_id(context);
+	struct pasid_entry *pte;
+	int i;
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
+	if (flush_domains) {
+		/*
+		 * If the IOMMU is running in scalable mode and there might
+		 * be potential PASID translations, the caller should hold
+		 * the lock to ensure that context changes and cache flushes
+		 * are atomic.
+		 */
+		assert_spin_locked(&iommu->lock);
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

