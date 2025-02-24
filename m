Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987851E5B94
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374202; cv=none; b=tMeWQebpAFkmyVEFNC5UYyT9tUh6Uk1DhiQ4MaZetYMXl/WI+Z1cyKa1g2R7CrVRWw/t6tk0tpiZzvCieD94N1IZc4/3/U5EgDesHRu+7chPXecQcvT+YoBu56Vq41HH/uLRXAMU8xzp/FISd+CB4uLNbqPWyLWZ52Rc89RKvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374202; c=relaxed/simple;
	bh=7BqROg7flfKZSHF40dyhcy1MLUmAqDfo6NpaN5vQ7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djISenignjEGjXxFiEyNj6AoCEc+8ENfkASgXxajUOSbPerWF7DCdIU9Z5MX6UXlrMW8kGd8vxvFt6rQ/qoPzJRoKC7BgIi8UnQ0JENkArkN118obvAkvXkUSuNoJ2Nde058Z/4CQJXDWI97yl/7AX5hfYMG24sZgNFMR45ynGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6iN6HYg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6iN6HYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374200; x=1771910200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BqROg7flfKZSHF40dyhcy1MLUmAqDfo6NpaN5vQ7/A=;
  b=Z6iN6HYgmA3VGacNiw5u1/BxJ3do332ACTRCuHo4P6Ktc/yBgmHuJFwa
   /MgADDHRDNDXLIXOXsXFy/vK12YEg/JLfUnFqDOOyEAhZwHJPOb0a+1Bw
   9eu+UCsyU+x5F8TIFuWPGAJapQs7Oq+onEq1dsa2d2P5wlKty7WHAqpNe
   V4zL+u+i4ttnop3J5H1BRLoaNakK3Dh7/C2NYqmBU7iJl+reimoIf4UOP
   HvxvxgYNQ5qjSRL3R0bTh3R5ZHRIWjjGaFz4k8UShtTuze+tRkhzzmPSa
   58hnVYmcmTVhTQc8YOADaGfyr2f0ZHJOh+DeMIKrZ1/3cG6SS3lynMnec
   Q==;
X-CSE-ConnectionGUID: 0SEpTPFuTnCHpVbePdymHA==
X-CSE-MsgGUID: sXtoT0DhTIOnD2sjvwjSBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024237"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024237"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:39 -0800
X-CSE-ConnectionGUID: dLmlLoIZTT63hiDeUeWETg==
X-CSE-MsgGUID: azYWJ8wGTZSpxfyrbepajA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143408"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:36 -0800
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
Subject: [PATCH v2 06/12] iommu/vt-d: Cleanup intel_context_flush_present()
Date: Mon, 24 Feb 2025 13:16:20 +0800
Message-ID: <20250224051627.2956304-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h |  3 +--
 drivers/iommu/intel/pasid.c | 39 ++++++-------------------------------
 3 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 91d49e2cea34..1d564240c977 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1730,7 +1730,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, true);
+	intel_context_flush_present(info, context, did);
 }
 
 int __domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f7d78cf0778c..754f6d7ade26 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1306,8 +1306,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
 void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool affect_domains);
+				 struct context_entry *context, u16 did);
 
 int intel_iommu_enable_prq(struct intel_iommu *iommu);
 int intel_iommu_finish_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c2742e256552..a2c6be624dbf 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -932,7 +932,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, false);
+	intel_context_flush_present(info, context, did);
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
 void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool flush_domains)
+				 struct context_entry *context, u16 did)
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

