Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A67642
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710900; x=1718246900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WrDuSdB9iYumVVBXtypeizwCzmEr0vrCm5Dy+N+kwxM=;
  b=lgqSQ/Nq5pVoN7RZymWTRPB3e6GlTrC65cBoX81IJlXvgQbYKxSS1+Sn
   7BCapw+C+o0ICOsvSJnN7MKRU/GtmvzMvA3vKCjEeUgaeyrHzuZ+8jHIN
   M8/xMgwy2BOfKQPDfUNjHQruTbLfY9H7cOblWrDvirDWdK6TZXekw3M22
   N3k/jHpvEpZ7N3tbrzYkTkHFTDZ1Rw2vqFxlp/y7Io9jrRjE4FoH3fgU9
   KdSho4jdRciYB33hx4EGLp3fb0GeA9spqa0EKrZ1UIzfSY+LgFc0ez9AC
   VugGJcNmnTuUPMn4s/1AolL3m7FkHHnhWmQCGOMGY+2w/5qexVx0X4Xed
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164465"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884211"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884211"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yanfei Xu <yanfei.xu@intel.com>,
	Suhui <suhui@nfschina.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()
Date: Wed, 14 Jun 2023 10:47:04 +0800
Message-Id: <20230614024705.88878-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yanfei Xu <yanfei.xu@intel.com>

Remove the WARN_ON(did == 0) as the domain id 0 is reserved and
set once the domain_ids is allocated. So iommu_init_domains will
never return 0.

Remove the WARN_ON(!table) as this pointer will be accessed in
the following code, if empty "table" really happens, the kernel
will report a NULL pointer reference warning at the first place.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230605112659.308981-3-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e83fe243680b..4c0b7424c45e 100644
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

