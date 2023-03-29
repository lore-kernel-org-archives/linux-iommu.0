Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E02583
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097633; x=1711633633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gnKgqRTKyghIyM4UgGaD9bRnVtsRIMSCRTLjmJOQmI=;
  b=enqCXtrTNV3E1cjnil2rBszY67bQ0yVefPvw8pbMWLuFyf+SdoAWF063
   MD3nhGiy5iPnjcdwgOE8G/JD2CAc7wprL62r8k0Mprk5BOA1WBxnKT9bF
   DskC2CqBEPW7VlIYsbj8wltrxm8IVlbgBSy925YavrmE00rdtitvHHPPe
   Nr7bWGXVHEDW/6Kx7XxPvXLUnIUzVtHyG+AvroMj2xP4QWqXsbs/xBN72
   eibo88yeUKezOu0e75mFmBTeonyXO2Z/b0kKnPRyv5WVcG9rHivdPK12Y
   TATKTmo2KwnrwsWLpLXdFvwlbl7I59W0cVi1iDnz0agOqZR1lXkc7vsx/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506242"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506242"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783384"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783384"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Allow zero SAGAW if second-stage not supported
Date: Wed, 29 Mar 2023 21:47:20 +0800
Message-Id: <20230329134721.469447-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VT-d spec states (in section 11.4.2) that hardware implementations
reporting second-stage translation support (SSTS) field as Clear also
report the SAGAW field as 0. Fix an inappropriate check in alloc_iommu().

Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230318024824.124542-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6acfe879589c..23828d189c2a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	}
 
 	err = -EINVAL;
-	if (cap_sagaw(iommu->cap) == 0) {
+	if (!cap_sagaw(iommu->cap) &&
+	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
 			iommu->name);
 		drhd->ignored = 1;
-- 
2.34.1

