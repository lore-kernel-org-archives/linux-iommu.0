Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECABD08
	for <iommu@lists.linux.dev>; Wed, 11 Jan 2023 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673468735; x=1705004735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbKbzo0ebhNuat4Mu85n5Nyk3Ge5hASt79m3RxYgmac=;
  b=lxzrqsidbUfe5Sje6x6E/6FeEXFpUJbbfYUWIFCnmuxzgFFLXNmH1NUZ
   XXc6tQWDNR5geZsIe2YxATJCDmw36cVPPMoql/5Hhwn6E5z6lvfdwCkD8
   agEK17Zv/w77OlA7f8M7sdZDGCsTHdt7a8ky8VcrpNA53DtTbTZkLbDgL
   PnVwTSwBI0Nq7a/uUI0+3fMzOb67iL63BccU9jCtcCa6qfcydu4J2q1a9
   aG3Nf5aSX7D785BoEyJnE8a6k2pPkzXLiAxRkHCN1Pa1LsA1PrK+G8om+
   rpwVLQbSTAJxy8v5SgjJPT4qyMtCiea6EnnaJKiu0SkLyLPmgtnbMOf/q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350755021"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="350755021"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 12:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781518080"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781518080"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 12:25:28 -0800
From: kan.liang@linux.intel.com
To: joro@8bytes.org,
	will@kernel.org,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	robin.murphy@arm.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/7] iommu/vt-d: Enable IOMMU perfmon support
Date: Wed, 11 Jan 2023 12:25:04 -0800
Message-Id: <20230111202504.378258-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111202504.378258-1-kan.liang@linux.intel.com>
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Register and enable an IOMMU perfmon for each active IOMMU device.

The failure of IOMMU perfmon registration doesn't impact other
functionalities of an IOMMU device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 3 +++
 drivers/iommu/intel/iommu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 94e314320cd9..5a33df9e19ce 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1152,6 +1152,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 		if (err)
 			goto err_sysfs;
+
+		iommu_pmu_register(iommu);
 	}
 
 	drhd->iommu = iommu;
@@ -1174,6 +1176,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 static void free_iommu(struct intel_iommu *iommu)
 {
 	if (intel_iommu_enabled && !iommu->drhd->ignored) {
+		iommu_pmu_unregister(iommu);
 		iommu_device_unregister(&iommu->iommu);
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..c57e60c5f353 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -30,6 +30,7 @@
 #include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
+#include "perfmon.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -4013,6 +4014,8 @@ int __init intel_iommu_init(void)
 				       intel_iommu_groups,
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+
+		iommu_pmu_register(iommu);
 	}
 	up_read(&dmar_global_lock);
 
-- 
2.35.1

