Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956C4412
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtX+Jh61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699924499; x=1731460499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPJ/SLDwJYKPDkQ1iJxTWHTim10vG9a1tPWCCWLgwN8=;
  b=LtX+Jh61OBgX1cV/Wf/2DVPXX8Z6UXSOihEh5Yny5VNsaR40IdfaXwRz
   dqVyCw0mch3Xgf77njipaAvlazioZwjuQxf5BIu3MecxHlAaiMjD3lAHt
   yRwhlUN9dkjcfzb5zJ57JB7iKisoy2roeNw8ibsynq/TMe6gmcgRILCqk
   uSvKPNMMvlVxenNzgCZ8kDd1jJNYM2rp4za3J9qk+qqdlckHWcJBpSFJR
   ahWt8Draop+OOD+70ByW3ehZG3Q8rBk1dX25TlbYkdoYmohfKy0j2rh4v
   QV/PNi34YLSjUWRuxXBQI5rn3DPCLDq70OlxfduoI4gWe9UpKbeJM+vc/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454833572"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="454833572"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 17:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="740928118"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740928118"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2023 17:14:57 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough mode
Date: Tue, 14 Nov 2023 09:10:35 +0800
Message-Id: <20231114011036.70142-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114011036.70142-1-baolu.lu@linux.intel.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When IOMMU hardware operates in legacy mode, the TT field of the context
entry determines the translation type, with three supported types (Section
9.3 Context Entry):

- DMA translation without device TLB support
- DMA translation with device TLB support
- Passthrough mode with translated and translation requests blocked

Device TLB support is absent when hardware is configured in passthrough
mode.

Disable the PCI ATS feature when IOMMU is configured for passthrough
translation type in legacy (non-scalable) mode.

Fixes: 0faa19a1515f ("iommu/vt-d: Decouple PASID & PRI enabling from SVA")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 11670cd812a3..c3ec09118ab1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1413,6 +1413,10 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	if (!dev_is_pci(info->dev))
 		return;
 
+	if (!sm_supported(info->iommu) && info->domain &&
+	    domain_type_is_si(info->domain))
+		return;
+
 	pdev = to_pci_dev(info->dev);
 
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
-- 
2.34.1

