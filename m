Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF2ED4
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766273; x=1712302273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QDBCElJV6IinriaFJTBiGEJzrk57pr+rW1Lb4ep4XGE=;
  b=HIqCLiZ2RzKJfJVmJ5igYlHX/mjpJlZxAKgwnT5yLDZ6YmB82udgKWL0
   T69Qtu6RABFzi8JAP9Lf+WSj7y94uSBc8n6sRX2yY5/j0MwkqpgRngjhk
   DQflVQ+5rfyePvPdL8vca5rA25XwTp8l56AbxGCbDcOx6G+h6FqR94Yxf
   ihxbWiW47wpd1CrLitgyfSA9BTQpyPWcKYPf5RPDo9tvbJwOqAPutIOip
   1vSQzFU6We41WUF3KuZlW0oVWh7xSGTPd/ZdjutLGWT8MI1onQm2m67KJ
   m95r5/U5b0pGljzhJnE5WxUhkOA+M52VcNBd/G9GJN8qGda7YknQ2UtB+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956742"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956742"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033970"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033970"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:11 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 2/7] iommu/vt-d: Remove BUG_ON on checking valid pfn range
Date: Thu,  6 Apr 2023 02:59:39 -0400
Message-Id: <20230406065944.2773296-3-tina.zhang@intel.com>
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

When encountering an unexpected invalid pfn range, the kernel should
attempt recovery and proceed with execution. Therefore, using WARN_ON to
replace BUG_ON to avoid halting the machine.

Besides, one redundant checking is reduced.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5d6018b819590..1426df19e7607 100644
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

