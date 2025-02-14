Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44F1FC7FE
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513482; cv=none; b=OGYBZMBPrqtHfMdJZH1AZjKw8s+Gdla2c51FMYrTf0IfJxzYVI3NuVrjbhIby/XM3hMnKlPTF7mBKysORMF/johkwEXJ0ZjHEWtPvhvXd+wgTChRVyYQyqV/vh0qY4YWKefHGuvw7Y58o/WIjmHEsgTXsJ0eBBJiK7n8LLBMjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513482; c=relaxed/simple;
	bh=7BqROg7flfKZSHF40dyhcy1MLUmAqDfo6NpaN5vQ7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6k/D2T/0uOFD9MU6emyKQo8f+nn/CydrT08ph91VT5SJpx5oRquaI7eNJoDOXht368o6S2gjdjHACfnIjgUhhIa+TC8R2lt6JU5632n5cJByfbROKNdrN5hQveOhr4lNYK4YxYkyMxJxomhbvmh8l+nvMctl+lIsfkk6M+J4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVmc11d0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVmc11d0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513481; x=1771049481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BqROg7flfKZSHF40dyhcy1MLUmAqDfo6NpaN5vQ7/A=;
  b=HVmc11d02GO7JrNcSJcR6a+lgPjDmyZBjTnPdwWNyQofpD7gLZrN1Ku1
   z26gujQ1zU4cUBgNoye8NaQkzxKSEas/4bax81R7f/TdTKhcVo8wR0UCR
   tRknT8VeITDeHIThf7YAKnjIu4SNxuFckJ0KE1wtYboREhQrZb9E8Ei4c
   Ev1yI8l8hBdHxtmkcTfs/msBZwKVkHM9cErPdrBPWTDYbci7aGaUVbP05
   a8ZEBts/xDAhP6NthujP8TvrB+3El3GiogtYB0C1fzyE/j2slTk6UrGrr
   5YJV9MKldq74GkBBiLV/uUE3CHJkwxlNJ6LAAnYLYwyWUhnrrCXQ+bZNP
   A==;
X-CSE-ConnectionGUID: Q5bOrH1cR0G6xt44VfdNnQ==
X-CSE-MsgGUID: daZj0DUYQ2GL7c1VvHd35g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124536"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124536"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:21 -0800
X-CSE-ConnectionGUID: hSuWg8klTF+8fEuDyydc0Q==
X-CSE-MsgGUID: 4Z/ib09KQYCj29HP7sNq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268126"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 06/12] iommu/vt-d: Cleanup intel_context_flush_present()
Date: Fri, 14 Feb 2025 14:10:58 +0800
Message-ID: <20250214061104.1959525-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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

