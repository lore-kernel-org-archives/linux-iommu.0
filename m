Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066177489
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 20:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936275; x=1706472275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/6p+lUBUIA2oZrnZvhOAPE95Uoj/IOijy7wsmhLAB0=;
  b=j7zBffKR0i7WkH+kADi/lOMN55glLQdqxvKQFADLg82mqBTlR49J/zSe
   lUEJAU42OeqqBnJGljT5e+wLyqi5hbhETJdrupWzuwAWGgY7j/TsSCyzl
   KDTHzM0wz5NM35IFSnUW10YC7EWSl/WDEPO5orcL5I+LBcCBkfkIHop4K
   wgYPvu7kZjPPsiI/AzsT+TcC64Fyb3l3QfFi8xKw7DbMndIL8CtPS0q4k
   6MrA7GxhW11D7wj7GeXRs5eFIZ5rl6K2jiRZMXqIyU9HmMBmkfmF7rg+X
   +QBZgNewfiSO8bll+lmOeI82s5xBitjhXJghkzOe0vTbnGWTLyrdjJcBW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022532"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022532"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038382"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038382"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:31 -0800
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
Cc: yu-cheng.yu@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 7/7] iommu/vt-d: Enable IOMMU perfmon support
Date: Sat, 28 Jan 2023 12:04:28 -0800
Message-Id: <20230128200428.1459118-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
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
index 43db6ebe8b57..6acfe879589c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1144,6 +1144,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 		if (err)
 			goto err_sysfs;
+
+		iommu_pmu_register(iommu);
 	}
 
 	drhd->iommu = iommu;
@@ -1166,6 +1168,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 static void free_iommu(struct intel_iommu *iommu)
 {
 	if (intel_iommu_enabled && !iommu->drhd->ignored) {
+		iommu_pmu_unregister(iommu);
 		iommu_device_unregister(&iommu->iommu);
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9221960e310..6a80d3848626 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -29,6 +29,7 @@
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

