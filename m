Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7BED4
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766277; x=1712302277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4r+oXVv4S9IXzdSukYx506W0GHtooN7XWoI7nKqYEs=;
  b=j1cYurT08Sb8/aYRhKp4ObUPLEBq1urnG5Bfv0jW/eB7XMlpuK/1xTjv
   h/vTaWk7VGN8CrbAiIRst99Vu7zBjGIGElaFLXmuBnAc2SXYcfyNtR3be
   PW3Cfw/D7ZnavphTjwzwfRRQu/xQiHE/YaVPplsqidN8LQCrMfG9aAwkd
   fJu2A8vXPcTs0WlJ9gbE5hTdCmEFMAVjjYSwA8FK4J5fH3w0B9r5zNoN4
   5LOnviFDnB9k78b9y0S1r5opyR+GmKGvRa5o45ozojn2M3tQPyPVwVQOD
   yCOq1wLUfWQKMhqhH7dP49LkAsP3inXgSaCmIi0CoA65lfzh+oxeNbALN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956760"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033985"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033985"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:15 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 5/7] iommu/vt-d: Remove BUG_ON in map/unmap()
Date: Thu,  6 Apr 2023 02:59:42 -0400
Message-Id: <20230406065944.2773296-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230406065944.2773296-1-tina.zhang@intel.com>
References: <20230406065944.2773296-1-tina.zhang@intel.com>
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
index 883991bd93e7a..c5c8d19695a84 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2184,7 +2184,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	phys_addr_t pteval;
 	u64 attr;
 
-	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
+	if (unlikely(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1)))
+		return -EINVAL;
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
@@ -4341,8 +4342,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
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

