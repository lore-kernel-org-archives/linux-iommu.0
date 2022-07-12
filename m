Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905F1854
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584822; x=1689120822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zL0sNIu0hR/7q129LGe91BkLQRpbxXeLJ8hwcGWo304=;
  b=NiMSK/Ql270yS4N4fNOalv3e+44/FuhjyOXVlMFJGf5TpmGGT2/+R95W
   Xh9hXuTpjEZEwDDaoDgDb2MCtXDHI2W56DXUC6dgyRH4wAqYGGoL7bjni
   +9G3SGYcrxiLtOEamEISt+ePzHExeniw/RHX6YMxrsJ1IYQqHXzucBmPB
   7iquO+LbSRNXESXc7toJLVQYJD6b0pGKY7wM0Dor0pJ2JeoMMI0G6Tvvu
   OUvS/ItNiQS7sngGDLa7ZSWJsty8cFsoXnAiibSYqgFkA3HsaER+6rcwf
   uUx0BmZXB5o4YuVGyQ3ExTXJvSU3JfI0tlzftCvFISYSp6YOc8kOVQLXA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589864"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445683"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] iommu/vt-d: Move trace/events/intel_iommu.h under iommu
Date: Tue, 12 Jul 2022 08:08:44 +0800
Message-Id: <20220712000908.3431936-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-2-baolu.lu@linux.intel.com
---
 .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
 drivers/iommu/intel/dmar.c                                    | 2 +-
 drivers/iommu/intel/svm.c                                     | 2 +-
 drivers/iommu/intel/trace.c                                   | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

diff --git a/include/trace/events/intel_iommu.h b/drivers/iommu/intel/trace.h
similarity index 94%
rename from include/trace/events/intel_iommu.h
rename to drivers/iommu/intel/trace.h
index e5c1ca6d16ee..25cb7f88e1a2 100644
--- a/include/trace/events/intel_iommu.h
+++ b/drivers/iommu/intel/trace.h
@@ -91,4 +91,8 @@ TRACE_EVENT(prq_report,
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/iommu/intel/
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9699ca101c62..f91b45be1d92 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -30,10 +30,10 @@
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "perf.h"
+#include "trace.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7ee37d996e15..70b40d007a52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,11 +21,11 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
-#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
+#include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/trace.c b/drivers/iommu/intel/trace.c
index bfb6a6e37a88..117e626e3ea9 100644
--- a/drivers/iommu/intel/trace.c
+++ b/drivers/iommu/intel/trace.c
@@ -11,4 +11,4 @@
 #include <linux/types.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/intel_iommu.h>
+#include "trace.h"
-- 
2.25.1

