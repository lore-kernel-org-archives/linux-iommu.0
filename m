Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256A23AA
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 05:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576163; x=1700112163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDY8xPbW8+5NMdIMihDaV4kTFmqX2Fw1zHiN3MINvwY=;
  b=IlfglLanttdKf1rQzFcERCTbVgNjfGBNV53vCZu3rr9RhDaiWsG9sETm
   hv0cdcvm4t32n3GQFeai5LOIAEzXP+cHRyoVfiuf4AJ+dmjFuRXoow4Y7
   jtTD4PUS73Of90o1hLafm5MYwLmXIDjnpmeIfS7N3276wr9DsJfq5xTXZ
   FDvkM/idQWyNFUFH8/7LUritNQS7ZrLneh5dCIhI1nrLz205xmCIcl3Wd
   f+emhyYYjBcqsTTq+HY73Hhyc2GaV9g8p+leeLpodnq4PtVEgpyowk+rC
   elM7zhU6bIjfyQJVIT4WUEbRaywa4qgTFGJTosLFVV+GhcNCTKQyRnn7w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295820136"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295820136"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702724777"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702724777"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 21:22:41 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
Date: Wed, 16 Nov 2022 13:15:43 +0800
Message-Id: <20221116051544.26540-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116051544.26540-1-baolu.lu@linux.intel.com>
References: <20221116051544.26540-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

The A/D bits are preseted for IOVA over first level(FL) usage for both
kernel DMA (i.e, domain typs is IOMMU_DOMAIN_DMA) and user space DMA
usage (i.e., domain type is IOMMU_DOMAIN_UNMANAGED).

Presetting A bit in FL requires to preset the bit in every related paging
entries, including the non-leaf ones. Otherwise, hardware may treat this
as an error. For example, in a case of ECAP_REG.SMPWC==0, DMA faults might
occur with below DMAR fault messages (wrapped for line length) dumped.

 DMAR: DRHD: handling fault status reg 2
 DMAR: [DMA Read NO_PASID] Request device [aa:00.0] fault addr 0x10c3a6000
    [fault reason 0x90]
    SM: A/D bit update needed in first-level entry when set up in no snoop

Fixes: 289b3b005cb9 ("iommu/vt-d: Preset A/D bits for user space DMA usage")
Cc: stable@vger.kernel.org
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20221113010324.1094483-1-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
2.34.1

