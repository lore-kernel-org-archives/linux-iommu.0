Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DB1DDC21
	for <iommu@lists.linux.dev>; Tue, 13 May 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105620; cv=none; b=JM7lqbl0pg9sY+DbgQAdgy/+XsUiOMPOHr8x5ZUTUrkiHD6mDJxPslwyiqBb2BrFtKFH9u4i+VNwQmUz3J9yt+sckPims4yRlVGgAoxXng2Ez4U0ImzzeCHhfFodrzjH1UA0xAznSp31dz1+ajhdih2IpIEuY14cKSMlWMGw+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105620; c=relaxed/simple;
	bh=dkEzf3fERGNelIlwIbaM/aGOYl9K+/v/DBApTCPauF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiCkrhG3FZpEgMPwyiCLD+m2l/utSSJHnCjpaWRJpa1aR6E2gA1pxlZcyFOsCHFVvjbRULjI73drbIVmayIs9TIMJ+hafC8cNKEH2CvggiAXoH9YSBI1/XWOg1FLRog9bTqHOLUh84mPAbAjQA+p6o85AlqyhF91cVZOxfVPJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WC7yq1Vv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WC7yq1Vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105618; x=1778641618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkEzf3fERGNelIlwIbaM/aGOYl9K+/v/DBApTCPauF8=;
  b=WC7yq1VvclIcJh+qjZ55kGfqHT9kJh7qhdNC3ePiWmChCgLNO4r4sSwJ
   aFb70lLibzv9YFe1FfJhckcj48os0Ev0m3eG1r2/R4tYz0yp/wva9JqPP
   wSZpx0OQ382w8fiDcF15x11eX8a5t7Pi1BCoxpA5UxRxcVX0XtRzotdcV
   Vs6xwy6X8fw8kEVKPrip4cQPeyVT5+/RAWXq4jQx6iH3Qd3O3CZlpjRF2
   26v4h/7qqDqTLc9NvFwpbRn9IkTSv2mMXS6Scd4PWd6jkV38uKRdfTcjp
   kvoxg7H1FwP2irPWSeF7MZ4PhjBTR2sE8UhQFktqQq9b2/8yI7EmBAdLf
   A==;
X-CSE-ConnectionGUID: 6cCWeX4hRKmT5r04pZeA7w==
X-CSE-MsgGUID: g5eFsmSHSLeYJbnTg7s/pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52735275"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52735275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:06:57 -0700
X-CSE-ConnectionGUID: Pw5tydATR82L6wqop+5lhg==
X-CSE-MsgGUID: ylizIxMRTCC+mvAibLR/Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138522216"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 20:06:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iommu/vt-d: Restore WO permissions on second-level paging entries
Date: Tue, 13 May 2025 11:07:35 +0800
Message-ID: <20250513030739.2718555-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
References: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

VT-D HW can do WO permissions on the second-stage but not the first-stage
page table formats. The commit eea53c581688 ("iommu/vt-d: Remove WO
permissions on second-level paging entries") wanted to make this uniform
for VT-D by disabling the support for WO permissions in the second-stage.

This isn't consistent with how other drivers are working. Instead if the
underlying HW can support WO, it should. For instance AMD already supports
WO on its second stage (v1) format and not its first (v2).

If WO support needs to be discoverable it should be done through an
iommu_domain capability flag.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..67c6ea1d8d44 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1681,9 +1681,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	}
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
-	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
-		attr |= DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
+		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 		if (prot & DMA_PTE_WRITE)
 			attr |= DMA_FL_PTE_DIRTY;
 	}
-- 
2.43.0

