Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A87648
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358830; x=1712894830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INsqM7kHCgplauDTVYgaDtYvmiBKWDtVPT9hnQCqHlE=;
  b=S4PB5ndPaQIamEW4aN9miAzxRAhwazSJaMfxVcm65lahJahcLGRQc+mx
   7lMuLvGq1AR8qDhtaQh0yfRxhEy9ouZonsbGxpxmh8dvs/sSKyl8NhiBc
   Qb6TJoZOmkWayvBerpEiBjV4GUkrZhvajWnX/9tObqUtNBenCOywS+Lq2
   w24kr6g6YSJb/kheWPQGQg1lQBJwTDzehFCeCkRUhIPE87t2B59F4kwlA
   3mmNZlTaVZ9MMQP23J4VNUKAOo0wn2OMNXBzsDcRcI+PPZM+FyiAVAs19
   auBuUPf3SH6NwYtTM8swKBYqC7K3lfm2YFTtHItc6+Rnu0jcR+0N1qtIF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786662"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361108"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361108"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] iommu/vt-d: Remove BUG_ON in map/unmap()
Date: Thu, 13 Apr 2023 12:06:43 +0800
Message-Id: <20230413040645.46157-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
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

