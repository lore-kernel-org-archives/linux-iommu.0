Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254519F499
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925889; cv=none; b=NuOb1I3sX/214lJrrevsMVMxVkm3QU3Enso237ch4yQaycquW2MTv1PsEcvR/jojd0cud0VfVo3qvL5GMln0/WEEmfQTZgkpQLEw7brUUnqW5zMCwWx3sKNT5XyGiDbPOqWgY4YOCgm2ycsDIAeHWZglOkUQdRinV2mwzAvq0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925889; c=relaxed/simple;
	bh=FYr95xHGLyR8gxK+4isyHcMbebbiTUqWfj8JkY18UaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNderpBWXAdX8RaQq06dD0r5ZAapQ0b92nn/UmkzVBgMCJJzSc4CmmL2+o8sH02z/C6go53r5WeW6wI1oMqogsBSv59byln6ob7xS9fxk+6fre2HmQmdeSkG9GaVyTq7EP05Iv4GBkozRnvBlfU8sepd9ZAy1wfx+/UW94YLaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grrw+dCw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grrw+dCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925889; x=1751461889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYr95xHGLyR8gxK+4isyHcMbebbiTUqWfj8JkY18UaI=;
  b=Grrw+dCw1fiYhgKdDdCS1Jfs5OEXkolUpREcmozvTmgnecQ6cfqYtjUy
   fYzU+D1QZwReM4f10JQLqryo0+9g3zJzZLd/RbW2hVfIvzpj/ma5paPwE
   Lrc91h8FZmcSpDtWvUqvQ8z5qwMYxIGZcGCa18wkU7vg+2e2KaEq0O+31
   udm0VpzkKR0pyGE36SLxMkDFwUwkiZmHP+L9ZMIxDZM+KDszauiDx5GOh
   nXFdkv9b10LXyJqJSPNyj7MbtIW6HuW+nhIHeUb+1U96asg61FJ97Z41D
   9oXjIcQbwQuDsGbsdBZmL8mittqoEGpEt8lumCt6qGolcSLOYy2q3C7lr
   g==;
X-CSE-ConnectionGUID: jQAJAYDjTVa3xziGBtURQA==
X-CSE-MsgGUID: 8K3CVaXeSrSVeq7jpic7yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700017"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:28 -0700
X-CSE-ConnectionGUID: JssnfPapTwymgI/vKRSGLw==
X-CSE-MsgGUID: OtleRZBiT+6RnFPyeLh3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250844"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iommu/vt-d: Remove control over Execute-Requested requests
Date: Tue,  2 Jul 2024 21:08:35 +0800
Message-Id: <20240702130839.108139-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VT-d specification has removed architectural support of the requests
with pasid with a value of 1 for Execute-Requested (ER). And the NXE bit
in the pasid table entry and XD bit in the first-stage paging Entries are
deprecated accordingly.

Remove the programming of these bits to make it consistent with the spec.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240624032351.249858-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  6 ++----
 drivers/iommu/intel/pasid.h | 10 ----------
 drivers/iommu/intel/iommu.c |  4 ++--
 drivers/iommu/intel/pasid.c |  1 -
 4 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eaf015b4353b..9a3b064126de 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -49,7 +49,6 @@
 #define DMA_FL_PTE_US		BIT_ULL(2)
 #define DMA_FL_PTE_ACCESS	BIT_ULL(5)
 #define DMA_FL_PTE_DIRTY	BIT_ULL(6)
-#define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define DMA_SL_PTE_DIRTY_BIT	9
 #define DMA_SL_PTE_DIRTY	BIT_ULL(DMA_SL_PTE_DIRTY_BIT)
@@ -831,11 +830,10 @@ static inline void dma_clear_pte(struct dma_pte *pte)
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
+	return pte->val & VTD_PAGE_MASK;
 #else
 	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) &
-			VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
 #endif
 }
 
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index da9978fef7ac..dde6d3ba5ae0 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -247,16 +247,6 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
-/*
- * Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
- * entry. It is required when XD bit of the first level page table
- * entry is about to be set.
- */
-static inline void pasid_set_nxe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 5, 1 << 5);
-}
-
 /*
  * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
  * PASID entry.
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index abf0097f899d..1b5519dfa085 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -854,7 +854,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain->use_first_level)
-				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
+				pteval |= DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
 			tmp = 0ULL;
 			if (!try_cmpxchg64(&pte->val, &tmp, pteval))
@@ -1872,7 +1872,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
-		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
+		attr |= DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 		if (prot & DMA_PTE_WRITE)
 			attr |= DMA_FL_PTE_DIRTY;
 	}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index abce19e2ad6f..aabcdf756581 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -333,7 +333,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-	pasid_set_nxe(pte);
 
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
-- 
2.34.1

