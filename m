Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB715C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232455; x=1711768455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/caAYn9v+lM3DuSYoZaXs3trhDZuCDPC1n99gqV7Chk=;
  b=QjUtmXsEW7kmQvOOkOZbtw2J71/8DQdUEpzPyTNwJ6SQhvsGFmy0W2ys
   OvZKEQ85v9zTH5d+Wtuhr5TB48vLRgmOVDq4+iO9W79E3lfnd1B4CUcZ7
   JTZEntLXsJTCYdT6Z/kT0TekRWRRkxItJ1Ucof/lvQwCPywgsv+N6H10L
   F8zB2CbZ8meqlpc1uTN/s5EtMqqenN/GSzjlG1HWZbxlh4o3hvvAnQ6TT
   NXiWtLw/LNj/wWZWNNRp8f3dbQdiRLiYaV+gZFMig7v7wPlqC6bYXETqy
   dQnP+FtwB+Nh9AmtSkd4IF8F42b8FMnuqKeOxfWBl/6c4OWyzUP2Q0GXj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991737"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991737"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144761"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144761"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:54 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 5/7] iommu/vt-d: Remove BUG_ON in map/unmap()
Date: Thu, 30 Mar 2023 22:42:34 -0400
Message-Id: <20230331024236.2716001-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331024236.2716001-1-tina.zhang@intel.com>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Domain map/unmap with invalid parameters shouldn't crash the kernel.
Therefore, using if() replaces the BUG_ON.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e1881d48c2aa..61166b6b992d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2186,7 +2186,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	phys_addr_t pteval;
 	u64 attr;
 
-	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
+	if (unlikely(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1)))
+		return -EINVAL;
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
@@ -4343,8 +4344,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
-	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
-			       GFP_ATOMIC));
+	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
+					 &level, GFP_ATOMIC)))
+		return 0;
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
-- 
2.34.1

