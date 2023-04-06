Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D590ED2
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766276; x=1712302276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUGteq+blVAXBFxzdCq+P9brFd7UUv4MmpQXSdIt3lc=;
  b=KyivV+uENy2tfZSb5Y0Qw9ekeHrBMrOmZCQIAyLzBg6pJbIFerVbfc8T
   RP6q3QBPtkyRDrmo2LgFOCTzVo+8aj4bsIwkPFCKbjIeOQR/4mQ0xviu5
   dlGtT7PDpLJ2ow6+hDf/Xeb265G3Rbf0fK0zyI4IGUO0/PWtlBxW6U8CM
   loCjFmAmZI0+XMFPDlBYvnpQ9OUEc3QeCd2aZvnp7uAkOc6EJoWvRF8ka
   OHFNu6b8T6RbN+wSRgffWiQCadvupZ3OkiDABD/wtcU1DyUH4nJHK0kVQ
   Ktzj0NQhV0/FOQUg0AtTCcvzf+fFxfyqNagGZZmtFDtX8O8dvFPyERW+P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956752"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956752"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033976"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033976"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:13 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 4/7] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date: Thu,  6 Apr 2023 02:59:41 -0400
Message-Id: <20230406065944.2773296-5-tina.zhang@intel.com>
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

When performing domain_context_mapping or getting dma_pte of a pfn, the
availability of the domain page table directory is ensured. Therefore,
the domain->pgd checkings are unnecessary.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index de7fe7dcbc5ce..883991bd93e7a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -915,8 +915,6 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
-	BUG_ON(!domain->pgd);
-
 	if (!domain_pfn_supported(domain, pfn))
 		/* Address beyond IOMMU's addressing capabilities. */
 		return NULL;
@@ -1935,8 +1933,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	BUG_ON(!domain->pgd);
-
 	spin_lock(&iommu->lock);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
-- 
2.34.1

