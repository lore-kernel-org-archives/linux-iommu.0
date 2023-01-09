Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4215C7
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229482; x=1704765482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=er1mwQFmjpqAn37x8zwY2h6Q9EPKtK229QoVf7N6fXA=;
  b=jnojU11TntAvFz3g1phbfqXGMtpYyltpTLVsakC/FLaUC0k46CNiYUiS
   XKi2+yo3OYm5BCzp8pVTqzRjqJmyqMIxgqklFeKtriiAdFkmMSTXza7Gr
   DO72Y5K0qybiNTSHXtHRb3mAQIbJH2clX9snwiq7IYfl6UcYkDtbRInBz
   DaTXeI0V+sCbboPu+1Z2ONyMX6Wwz0eO+m6JnrdBDVd5QBmAFFg5USsR7
   JRqDo840ozqCzdU73bfh78cheYn5d/uxk1zhi96tVrcVqtX4jbKzeIof4
   vFvS5f+CKhfK/Ay+wzEO/0VFemAgdPLp7VapFRyCerXTXVgNZ6TSghmEy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848722"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848722"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867413"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867413"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:47 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/4] iommu/vt-d: Remove include/linux/intel-svm.h
Date: Mon,  9 Jan 2023 09:49:52 +0800
Message-Id: <20230109014955.147068-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index a36df9ed283d..43fd97f0e1df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10459,7 +10459,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-svm.h
 
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
-- 
2.34.1

