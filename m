Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89FA2A
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668303066; x=1699839066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MdiwzTf4bj+LtzfJOcBJdorEjOlFO2ySLLfJKX3B5TM=;
  b=jNzcIJh8uwTQ+soE1zHTxF8Zxuod3kxBpwxErZg0NkOS12m5oVaFlP49
   HKEB5IUh7wDIDF2EDABYRclUtf0oc75kATkq8yq4Pk121FyGMBMAKIkFx
   zwojSsAxthW/QjEzhuqe5I+ZrHjppv0toI4/9GmCPIYYQGAPfBGesPXRg
   zNbRVGnSPhKfy5ozNlt7V/PslUhtroKBk2/xoaJG82SVfKxoMeAwVFIAB
   SF+eOmij2xKI3s9Gk2Z1OlP1NNnomMVo6Xp4p/ewaHodPa5J4BnqoQkjU
   ZSYlEE7sGhvt3vO2MnYlVPUKBEGGvPZX5O7eqpwKm9KBxNUdl21s8tIxN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="311775777"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="311775777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 17:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="669167481"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="669167481"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2022 17:31:04 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH] iommu/vt-d: Present Access bit for IOVA in FL non-leaf paging entries
Date: Sat, 12 Nov 2022 20:03:24 -0500
Message-Id: <20221113010324.1094483-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A/D bits are presented for IOVA over first level(FL) usage for both
kernel DMA (i.e, domain typs is IOMMU_DOMAIN_DMA) and user space DMA
usage (i.e., domain type is IOMMU_DOMAIN_UNMANAGED).

Preseting A bit in FL requires to present the bit in very related paging
entries, including the non-leaf ones. Otherwise, DMA fault may come out.
For example, in a case of ECAP_REG.SMPWC==0, the DMA fault would be
"SM: A/D bit update needed in first-level entry when set up in no
snoop".

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 48cdcd0a5cf3..996a8b5ee5ee 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -959,11 +959,9 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
-			if (domain_use_first_level(domain)) {
-				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
-				if (iommu_is_dma_domain(&domain->domain))
-					pteval |= DMA_FL_PTE_ACCESS;
-			}
+			if (domain_use_first_level(domain))
+				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
+
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
-- 
2.25.1

