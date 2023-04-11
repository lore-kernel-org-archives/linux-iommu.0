Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723C28EF
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195724; x=1712731724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INsqM7kHCgplauDTVYgaDtYvmiBKWDtVPT9hnQCqHlE=;
  b=TAETDMnc55N2lCXCSvfsqptxBYshZsrO7W/ueMbHxsRbX+RuJB5KWB0r
   51txpI26BJpA0JrkUnmpiY5Fi8Xbj2zRYkwk4M7Q/nWRe52j0PY4AWFyY
   Ygu64mO8awZB1tPFU0ipS2ZHEEtWiSCyq4DwTk5t2ivmi9qSNXASgHsF8
   x5+NZO8XS35hCmY/P4t8GzFHKF0wVGEZBMFxG+fjPBrgTimneH+HrG3w+
   /RN8enVs4zDYO6+IGB5esEpolqYvxB6f+d59rOy47rTQJ+jYPbxVPZzck
   Jk1zL6eF4AgAaaMhl2iXOFHzUSafZaf3yCp2Oo5ERCuJvgrh2vJ1y9WOH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028629"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028629"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256651"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256651"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:42 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] iommu/vt-d: Remove BUG_ON in map/unmap()
Date: Tue, 11 Apr 2023 14:48:13 +0800
Message-Id: <20230411064815.31456-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

Domain map/unmap with invalid parameters shouldn't crash the kernel.
Therefore, using if() replaces the BUG_ON.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-6-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f11347a590d7..ab21ef1ddb3c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2159,7 +2159,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	phys_addr_t pteval;
 	u64 attr;
 
-	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
+	if (unlikely(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1)))
+		return -EINVAL;
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
@@ -4314,8 +4315,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
-	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
-			       GFP_ATOMIC));
+	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
+				     &level, GFP_ATOMIC)))
+		return 0;
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
-- 
2.34.1

