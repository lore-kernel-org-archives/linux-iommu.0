Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36ABC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 01:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92474825BF;
	Mon,  2 May 2022 01:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnZwKE3Zzlqz; Mon,  2 May 2022 01:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C7F1826B4;
	Mon,  2 May 2022 01:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36C6FC0039;
	Mon,  2 May 2022 01:52:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D370CC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAF24409D4
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fToH2XPvYg2I for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 01:52:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9A464006B
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651456352; x=1682992352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L2xHERiylaiTDlUR4lezZOcQBNvCoVsS7mrNAF79b3M=;
 b=EKUtNqmNerVuHG3dMAu52xhd18lVrl4+xSvY9Ipq8va8O3QgwnO2A1qg
 nmjA5mLQ+115KsqMQEx4MtmznJ5veCa0OfWpcQW+DniK8GYBM1+60znjv
 AoTP5QvgPLBd7P9t2AKdJXAp+vx2G4q1fm76MRPuvYdPw49EFheEtvqXX
 zAb3EzxIxQfhzjsgXbedjzjKykbXXxPZ/NROqEn2Wh6WmDFd2HNpnBcFS
 8oso1js7HSIZ9whKLFSHdPqM+szXIjQA/JXqr9QAtdFYk/at1BHo0dIw6
 hTH65aM0c+1ctMXDXqY3EbceEiqLIcTlfV1+uyDVYIDbQ2/Ex1S42gx4P w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254535356"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="254535356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 18:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="707406532"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 18:52:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 12/12] iommu: Rename iommu-sva-lib.{c,h}
Date: Mon,  2 May 2022 09:48:42 +0800
Message-Id: <20220502014842.991097-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502014842.991097-1-baolu.lu@linux.intel.com>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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
---
 drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 0
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
 drivers/iommu/intel/iommu.c                     | 2 +-
 drivers/iommu/intel/svm.c                       | 2 +-
 drivers/iommu/io-pgfault.c                      | 2 +-
 drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
 drivers/iommu/Makefile                          | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
 rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)

diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
similarity index 100%
rename from drivers/iommu/iommu-sva-lib.h
rename to drivers/iommu/iommu-sva.h
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0ace04b27d4b..73a336e17dc8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 #include "../../io-pgtable-arm.h"
 
 struct arm_smmu_mmu_notifier {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 543d3ef1c102..ca2bd17eec41 100644
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
index 46e2eb15197b..b38f50810459 100644
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
index 6084f960ba27..38c33cde177e 100644
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
index 8a2bb56e1474..a9ecf6bf5500 100644
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
index ae3595d60f38..b631765fa8c0 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
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
