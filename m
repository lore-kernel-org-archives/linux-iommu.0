Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB17EC
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151167; x=1706687167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1MxTLdDeLeeouG952McaeDlNjDKN6G16uZN42WANIs=;
  b=Mk5mjsSWv8NYgYSPHMdV4ckQPBbRCoz1x9pkJC8P4/X7f1Purk2vj7sj
   wlyeh2FW205TW/dt0O5PvOMGzN21UNfPmaG/++5806BK56B9FGN4jQ+PS
   +Coqt9sGlQ1sOXR3WLz8IF1hyyv2SUxLahj9uaERnWtQfBk2HqQom9EHC
   NSJ1j2F4WVaLcnGljJOECpyql+s4WuPURJDrFJqToQ5IGdOSA+40kn9ej
   ZFslSwqe366K5FdGqOkqEwhAmyYSuDol0q+zdG4TigPotDWC815vvpJy5
   zOTv3iZQurdmODGWuwqnACGhwn/+O2FNudTkhN7OR69MRQA+P3pVzwJwP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736589"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775510"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775510"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:53 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] iommu/vt-d: Remove include/linux/intel-svm.h
Date: Tue, 31 Jan 2023 15:37:29 +0800
Message-Id: <20230131073740.378984-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's no need to have a public header for Intel SVA implementation.
The device driver should interact with Intel SVA implementation via
the IOMMU generic APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230109014955.147068-2-baolu.lu@linux.intel.com
---
 include/linux/intel-svm.h   | 16 ----------------
 drivers/iommu/intel/iommu.h |  5 +++++
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/svm.c   |  1 -
 MAINTAINERS                 |  1 -
 5 files changed, 5 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/intel-svm.h

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
deleted file mode 100644
index f9a0d44f6fdb..000000000000
--- a/include/linux/intel-svm.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2015 Intel Corporation.
- *
- * Authors: David Woodhouse <David.Woodhouse@intel.com>
- */
-
-#ifndef __INTEL_SVM_H__
-#define __INTEL_SVM_H__
-
-/* Page Request Queue depth */
-#define PRQ_ORDER	4
-#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
-#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
-
-#endif /* __INTEL_SVM_H__ */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..f89f63d7a72a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -438,6 +438,11 @@ struct q_inval {
 	int             free_cnt;
 };
 
+/* Page Request Queue depth */
+#define PRQ_ORDER	4
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
+#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
+
 struct dmar_pci_notify_info;
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..317af67b6098 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,7 +16,6 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
-#include <linux/intel-svm.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c76b66263467..d38a54396c23 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -9,7 +9,6 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
-#include <linux/intel-svm.h>
 #include <linux/rculist.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index f781f936ae35..dbc36fa870d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10458,7 +10458,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-svm.h
 
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
-- 
2.34.1

