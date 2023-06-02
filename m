Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B51365
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685671714; x=1717207714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXDHEebrmcG8OAsrT6tWlvpRC2d/E9PoJjmv8khoEmE=;
  b=G+AAtrJhMrZmNxeXsqp7Getwo2LUeMDAgRuX0/dAeeeHorPC/1IadgpH
   vwVcsslvJ/fVoPWUh0vAtcYjNT/QYSai/qPPhnWZA3h3IQeI4UQkpDP0H
   mneHwyTd3DSJ3JIkPpfNG+j+2ITtNYmWqBjXEtZ0anqy4eToWuns2k8V5
   a2cYRdI5+zmXHY4JRqdlBqxksivWGtKNhM+a/QIxLR5UfEG9NgoOYaNZo
   IMz/AP5g6fEcDy16a9fTCi7d4UNnWyzoQWjrqRkAzz29XOupoe/3zonZp
   2LJxutZznY0WTOHrdEg9bv4Ata3rXmyOJXNdYu3LUAV4t3UpY1UoqSyFw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="359039386"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="359039386"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777457827"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="777457827"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:24 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH v2 2/2] iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()
Date: Fri,  2 Jun 2023 10:05:20 +0800
Message-Id: <20230602020520.224465-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602020520.224465-1-yanfei.xu@intel.com>
References: <20230602020520.224465-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the WARN_ON(did == 0) as the domain id 0 is reserved and
set once the domain_ids is allocated. So iommu_init_domains will
never return 0.

Remvoe the WARN_ON(!table) as this pointer will be accessed in
the following code, if empty "table" really happens, the kernel
will report a NULL pointer reference warning at the first place.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9188d045609..3953dd69200d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1897,8 +1897,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int ret;
 
-	WARN_ON(did == 0);
-
 	if (hw_pass_through && domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
 
@@ -1944,8 +1942,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (sm_supported(iommu)) {
 		unsigned long pds;
 
-		WARN_ON(!table);
-
 		/* Setup the PASID DIR pointer: */
 		pds = context_get_sm_pds(table);
 		context->lo = (u64)virt_to_phys(table->table) |
-- 
2.34.1

