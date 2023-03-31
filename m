Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0715B8
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232448; x=1711768448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GrVO1+VAMZI1lR7L5YWagegKjJqFOkZUihRF66zeABI=;
  b=C7nBfKEDxkVejuLzhrO9PMZZPWnfb0inq1Kb4DGwJTP+dxbw2eBsOBLi
   6agWIJjWuAE0f+qcJzL5bcDeynxn+vADpNmmnKpYxNJR4uMwH9sfjb2Hy
   O4Lradiu/Lv3Jh7TNC4awKyVT3JkpIIVrYUvSqCHtO1cKa2BysA4dD8tf
   BZUGgVH/RZ//7fUe7o9vFXGx6MHIqtoBjeqXsTmgRQps9vX1XWbwmqbOu
   a0Y0HGEwmUFbyvxk73jOxdFSdjs+8y/mUP9o1K2dGlOxfGWRkV9fq5T8u
   Cnjp0biLX292HlPEriR3ExANUYJpK1ZzRXiGzHzkle8eLobpG9MG9K4no
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991726"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144739"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144739"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:50 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 2/7] iommu/vt-d: Remove BUG_ON on checking valid pfn range
Date: Thu, 30 Mar 2023 22:42:31 -0400
Message-Id: <20230331024236.2716001-3-tina.zhang@intel.com>
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

When encountering an unexpected invalid pfn range, the kernel should
attempt recovery and proceed with execution. Therefore, using WARN_ON to
replace BUG_ON to avoid halting the machine.

Besides, one redundant checking is reduced.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5d6018b81959..1426df19e760 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1005,9 +1005,9 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 	unsigned int large_page;
 	struct dma_pte *first_pte, *pte;
 
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	do {
@@ -1166,9 +1166,9 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 			 unsigned long last_pfn, struct list_head *freelist)
 {
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-- 
2.34.1

