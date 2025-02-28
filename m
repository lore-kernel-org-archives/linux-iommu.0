Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119F25A642
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734802; cv=none; b=COTYjJ2q4TUMktSuMOTW9OzjCpSykufjlDb3e8xRJjvhbSyxrU9Grck9bVk+1EHC8szikCoYdfzhg4XkRRbjTiiP1Zi7njEu1CRqnm0m6twjY7bHdRCObvXjLhDWMsKBFzvNvxwdrSpiVh6iTLRTWA0LoFfNVvQhqy8EQ4XUcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734802; c=relaxed/simple;
	bh=J+XQajzFnyNluc6+X9Ez5w2K909Fjg4Nm4XCdTefwqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFUB5R0EdMQMIdNCOxUcDYasbkun3+Ob7usfX5qgsl10ojbMy9da+OPRFGwpEcTzZNDMAmyW3HhWBdWvzgFzm9IJ/DpcjftTEbgEYVrmdFp0qvUN3Kte2gZORUFVqDGafWpSceWaCtd+ConpnwRnOiNucDW4tHJ1xYbdZ5hwpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cl+lnZbi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cl+lnZbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734801; x=1772270801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J+XQajzFnyNluc6+X9Ez5w2K909Fjg4Nm4XCdTefwqw=;
  b=cl+lnZbi981jRQilDCm/F/098j9+43ryp7WHbQAVCyHMV7Z7m0+7jGJV
   X4/zugkX33gbW7jF1vZW9YssuTJZ+Eiq3KAOg3bEO4cg3grB+9Mb4evwv
   MflqWpDgphsvZ0PgylfuMS7kBbdgPK/KIBBEnllwl+qAK/D2udAwi1bcl
   jFupK2ZFlOfAbQYEpuJI0/3TBQ/BN7tT5QTk+aPKmUEdH5/w4tG7VPy7W
   7SDSULMd06HzTiJST3Sm8irs+buT5WTIZI7FejcKLACeqZ/3dW3G2oAj2
   zHIjMi0UPvvVt8U4bkNvfyaBIpGoWofKLOscQjBtiIMqem2z0Bw5pBhLx
   Q==;
X-CSE-ConnectionGUID: oAEdS2QWTCO/bB2fL2NnrQ==
X-CSE-MsgGUID: 48bCVILLRqKfJYYa+RL3Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438354"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:41 -0800
X-CSE-ConnectionGUID: etTe/fR8QFGnoFJhI7O3Iw==
X-CSE-MsgGUID: LYjhKLiyQge4ms6ysDsbsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148212988"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 06/12] iommu/vt-d: Cleanup intel_context_flush_present()
Date: Fri, 28 Feb 2025 17:26:25 +0800
Message-ID: <20250228092631.3425464-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_context_flush_present() is called in places where either the
scalable mode is disabled, or scalable mode is enabled but all PASID
entries are known to be non-present. In these cases, the flush_domains
path within intel_context_flush_present() will never execute. This dead
code is therefore removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h |  5 ++---
 drivers/iommu/intel/pasid.c | 41 +++++++------------------------------
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 35acb6438ea4..2d577ebc41ba 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1782,7 +1782,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, true);
+	intel_context_flush_no_pasid(info, context, did);
 }
 
 int __domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f7d78cf0778c..4d3fcd5fcf22 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1305,9 +1305,8 @@ void cache_tag_flush_all(struct dmar_domain *domain);
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
-void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool affect_domains);
+void intel_context_flush_no_pasid(struct device_domain_info *info,
+				  struct context_entry *context, u16 did);
 
 int intel_iommu_enable_prq(struct intel_iommu *iommu);
 int intel_iommu_finish_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c2742e256552..7ee18bb48bd4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -932,7 +932,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, false);
+	intel_context_flush_no_pasid(info, context, did);
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
@@ -1119,17 +1119,15 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
 
 /*
  * Cache invalidations after change in a context table entry that was present
- * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations). If
- * IOMMU is in scalable mode and all PASID table entries of the device were
- * non-present, set flush_domains to false. Otherwise, true.
+ * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations).
+ * This helper can only be used when IOMMU is working in the legacy mode or
+ * IOMMU is in scalable mode but all PASID table entries of the device are
+ * non-present.
  */
-void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool flush_domains)
+void intel_context_flush_no_pasid(struct device_domain_info *info,
+				  struct context_entry *context, u16 did)
 {
 	struct intel_iommu *iommu = info->iommu;
-	struct pasid_entry *pte;
-	int i;
 
 	/*
 	 * Device-selective context-cache invalidation. The Domain-ID field
@@ -1152,30 +1150,5 @@ void intel_context_flush_present(struct device_domain_info *info,
 		return;
 	}
 
-	/*
-	 * For scalable mode:
-	 * - Domain-selective PASID-cache invalidation to affected domains
-	 * - Domain-selective IOTLB invalidation to affected domains
-	 * - Global Device-TLB invalidation to affected functions
-	 */
-	if (flush_domains) {
-		/*
-		 * If the IOMMU is running in scalable mode and there might
-		 * be potential PASID translations, the caller should hold
-		 * the lock to ensure that context changes and cache flushes
-		 * are atomic.
-		 */
-		assert_spin_locked(&iommu->lock);
-		for (i = 0; i < info->pasid_table->max_pasid; i++) {
-			pte = intel_pasid_get_entry(info->dev, i);
-			if (!pte || !pasid_pte_is_present(pte))
-				continue;
-
-			did = pasid_get_domain_id(pte);
-			qi_flush_pasid_cache(iommu, did, QI_PC_ALL_PASIDS, 0);
-			iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-		}
-	}
-
 	__context_flush_dev_iotlb(info);
 }
-- 
2.43.0

