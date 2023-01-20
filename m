Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052F33C8
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674233692; x=1705769692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFhoZRe+ga3F++VLKtHLfxXrLB7Vt7EqQlS21a706ZY=;
  b=I4EAcL4YbyD4V7byIK25eyjQMmsV4qq0P2B9r347RuEznh9Ll+URmR2g
   mHzYjB7RHyczvNpdnXqZiAgi0/uFJMzZmHc5PyNdpuffi6barMteCEV6b
   6lHx+r9uJLm5+gBO04+RjSKo15hUH1Qok+F3r0IcCBqW0DGhgD51ImATW
   IvRsapQ9zUjIfexut6y24rHfurabMAsBkmUIqwD8XCy/eJAo9faZhR2ge
   yuBvSiq09LisSoe1ZKu+dkK9LuGHQ9K4TZgEgraRfrSS8c+XJ7N8xXeCN
   L0mHkYXqtirfRBhOH4l8vuf5Cs0FCbSyxofcqqhufRCcMO6CF3XCSZ99s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324315206"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324315206"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638207857"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638207857"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:54:46 -0800
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
Subject: [PATCH V3 7/7] iommu/vt-d: Enable IOMMU perfmon support
Date: Fri, 20 Jan 2023 08:54:08 -0800
Message-Id: <20230120165408.500511-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120165408.500511-1-kan.liang@linux.intel.com>
References: <20230120165408.500511-1-kan.liang@linux.intel.com>
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
index 560a54c3cbda..d39787944cc7 100644
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

