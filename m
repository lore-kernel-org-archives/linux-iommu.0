Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E7182D4
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585447; x=1723121447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoot58iZi4D+nuF4+mBQY+JTYodvcOohwejKW6VG6nI=;
  b=Av+2AlbNF7ARVsjLRcp+WdPH6iQSD0g7Ee6HlCXR8rqSeuHH7hsusXKM
   BWujgSqMIBtJ1DN/Qmge7T/PgUlrepQ0RYVn+ii0JehuEv4LEDwla7Cz3
   5MZyJr+wFcm76ZOKXyE0IwLCfMpOXIu7qm09H9VD1aq0i5IpGtTCEQs2x
   HuDOv8VegAmci5cVKjymk6y/JHMHmYPm64SuMoUUjRdyNlORANQ7yOx7T
   z2fWNpVxi3v8oXViM4XqKJySFWaz1JVNojCRaw9R+qVOMpQqvXjUMM4ky
   0I0pnx+EzpBO91nr9RbW5htogie0gOwxlwDu4/Q0BI3qhOP/vHc/JeH9q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821773"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821773"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521878"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521878"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>,
	Yanfei Xu <yanfei.xu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] iommu/vt-d: Fix to convert mm pfn to dma pfn
Date: Wed,  9 Aug 2023 20:48:05 +0800
Message-Id: <20230809124806.45516-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yanfei Xu <yanfei.xu@intel.com>

For the case that VT-d page is smaller than mm page, converting dma pfn
should be handled in two cases which are for start pfn and for end pfn.
Currently the calculation of end dma pfn is incorrect and the result is
less than real page frame number which is causing the mapping of iova
always misses some page frames.

Rename the mm_to_dma_pfn() to mm_to_dma_pfn_start() and add a new helper
for converting end dma pfn named mm_to_dma_pfn_end().

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230625082046.979742-1-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1f89714ca462..dd8ff358867d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -113,13 +113,17 @@ static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 
 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
    are never going to work. */
-static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
+static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
 {
 	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
 }
+static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
+{
+	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
+}
 static inline unsigned long page_to_dma_pfn(struct page *pg)
 {
-	return mm_to_dma_pfn(page_to_pfn(pg));
+	return mm_to_dma_pfn_start(page_to_pfn(pg));
 }
 static inline unsigned long virt_to_dma_pfn(void *p)
 {
@@ -2403,8 +2407,8 @@ static int __init si_domain_init(int hw)
 
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start_pfn),
-					mm_to_dma_pfn(end_pfn));
+					mm_to_dma_pfn_start(start_pfn),
+					mm_to_dma_pfn_end(end_pfn));
 			if (ret)
 				return ret;
 		}
@@ -2425,8 +2429,8 @@ static int __init si_domain_init(int hw)
 				continue;
 
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start >> PAGE_SHIFT),
-					mm_to_dma_pfn(end >> PAGE_SHIFT));
+					mm_to_dma_pfn_start(start >> PAGE_SHIFT),
+					mm_to_dma_pfn_end(end >> PAGE_SHIFT));
 			if (ret)
 				return ret;
 		}
@@ -3549,8 +3553,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
 	struct memory_notify *mhp = v;
-	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
-	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
+	unsigned long start_vpfn = mm_to_dma_pfn_start(mhp->start_pfn);
+	unsigned long last_vpfn = mm_to_dma_pfn_end(mhp->start_pfn +
 			mhp->nr_pages - 1);
 
 	switch (val) {
@@ -4247,7 +4251,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	unsigned long i;
 
 	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
+	start_pfn = mm_to_dma_pfn_start(iova_pfn);
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-- 
2.34.1

