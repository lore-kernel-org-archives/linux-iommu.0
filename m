Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BF9C43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 14:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9DB760D62;
	Tue, 21 Jun 2022 14:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9DB760D62
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PTcXHWe/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQ52bq7Bn4Ur; Tue, 21 Jun 2022 14:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96B7960B5B;
	Tue, 21 Jun 2022 14:48:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B7960B5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC6CC007C;
	Tue, 21 Jun 2022 14:48:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EC8C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5063A60D87
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5063A60D87
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xKIiqKJdNUmQ for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 14:48:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EF3560B5B
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EF3560B5B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655822928; x=1687358928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mqB8pQgt9RAipQYZNMdWoTB07E+OECu1rLgsuYn/qO4=;
 b=PTcXHWe/aYFpAfzXdydfmWweP4fubQ8RkauLZDWEodOTK7hOHobGTHUy
 SwyMbFxEKfk/9x1eQX+SzE74rupG1hb+mzCPlOWZJ2dMwUd+dMLrHNb7E
 hRZDf+WJgxdW6/b5oSpHbG1gFlF+ZYYc1JcDnp061hnA7HTLlCoQFD4sb
 EE941+FfKd43pQGFQvJDbpfwdPb8GLxsiFnVf8E3ZgyM+HuA3EvPyV3CJ
 FSZB7gtRaeM2ZYo6ghLki0p9z83PEawQq+bZKtS8LCf1R5011rX7LgvxX
 EfYzeLQ5VEDwFJ5b/PvuOY9l119yYtuAg6W3ynrqXj5e0amCWKCtSKo1J A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280867256"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="280867256"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 07:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="643659778"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 11/11] iommu: Rename iommu-sva-lib.{c,h}
Date: Tue, 21 Jun 2022 22:43:53 +0800
Message-Id: <20220621144353.17547-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
for SVA implementation in iommu core.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
 drivers/iommu/intel/iommu.c                     | 2 +-
 drivers/iommu/intel/svm.c                       | 2 +-
 drivers/iommu/io-pgfault.c                      | 2 +-
 drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
 drivers/iommu/iommu.c                           | 2 +-
 drivers/iommu/Makefile                          | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (95%)
 rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)

diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
similarity index 95%
rename from drivers/iommu/iommu-sva-lib.h
rename to drivers/iommu/iommu-sva.h
index 1b3ace4b5863..7215a761b962 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva.h
@@ -2,8 +2,8 @@
 /*
  * SVA library for IOMMU drivers
  */
-#ifndef _IOMMU_SVA_LIB_H
-#define _IOMMU_SVA_LIB_H
+#ifndef _IOMMU_SVA_H
+#define _IOMMU_SVA_H
 
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
@@ -72,4 +72,4 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 	return IOMMU_PAGE_RESP_INVALID;
 }
 #endif /* CONFIG_IOMMU_SVA */
-#endif /* _IOMMU_SVA_LIB_H */
+#endif /* _IOMMU_SVA_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e36c689f56c5..b33bc592ccfa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 #include "../../io-pgtable-arm.h"
 
 struct arm_smmu_mmu_notifier {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8b9b78c7a67d..79e8991e9181 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -31,7 +31,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 37d68eda1889..d16ab6d1cc05 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -27,7 +27,7 @@
 #include <linux/tboot.h>
 
 #include "../irq_remapping.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index db55b06cafdf..58656a93b201 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -25,7 +25,7 @@
 
 #include "pasid.h"
 #include "perf.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 4f24ec703479..91b1c6bd01d4 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 /**
  * struct iopf_queue - IO Page Fault queue
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva.c
similarity index 99%
rename from drivers/iommu/iommu-sva-lib.c
rename to drivers/iommu/iommu-sva.c
index dee8e2e42e06..1a4897a5697b 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva.c
@@ -6,7 +6,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a0e3d8083943..c766c852b647 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,7 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 44475a9b3eea..c1763476162b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
