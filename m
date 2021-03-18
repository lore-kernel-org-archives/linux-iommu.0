Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD36C433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 01:03:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A696A64EF2
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 01:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A696A64EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CAB26FA1E;
	Thu, 18 Mar 2021 01:03:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8ygJJ22PKFk; Thu, 18 Mar 2021 01:03:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD3AA6F9F8;
	Thu, 18 Mar 2021 01:03:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABD2AC000D;
	Thu, 18 Mar 2021 01:03:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EFBFC000B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 01:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E898841A2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 01:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q21lL-a3lb6d for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 01:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84CD484140
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 01:03:01 +0000 (UTC)
IronPort-SDR: q3jeQVpzvr5A1owSO7RmyTMXDI5FI186QEluS+R1Fjb+QnEGWf/J0HyTgI0K8g2lGE3H1/N/nW
 i8HALxSwwjUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="250933586"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="250933586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 18:03:00 -0700
IronPort-SDR: y4Z6Tm6N5tJ/EywPAX9K3WS0oeqz/xnz6cDJ3oijPsrc+n5o4cJ4Qdlx8+0zcGHkXQ6TtqGdxE
 /UXzSnoCniDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="411680283"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga007.jf.intel.com with ESMTP; 17 Mar 2021 18:02:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Report more information about invalidation
 errors
Date: Thu, 18 Mar 2021 08:53:40 +0800
Message-Id: <20210318005340.187311-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Guo Kaijie <Kaijie.Guo@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

When the invalidation queue errors are encountered, dump the information
logged by the VT-d hardware together with the pending queue invalidation
descriptors.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 68 ++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  6 ++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d5c51b5c20af..6971397805f3 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1205,6 +1205,63 @@ static inline void reclaim_free_desc(struct q_inval *qi)
 	}
 }
 
+static const char *qi_type_string(u8 type)
+{
+	switch (type) {
+	case QI_CC_TYPE:
+		return "Context-cache Invalidation";
+	case QI_IOTLB_TYPE:
+		return "IOTLB Invalidation";
+	case QI_DIOTLB_TYPE:
+		return "Device-TLB Invalidation";
+	case QI_IEC_TYPE:
+		return "Interrupt Entry Cache Invalidation";
+	case QI_IWD_TYPE:
+		return "Invalidation Wait";
+	case QI_EIOTLB_TYPE:
+		return "PASID-based IOTLB Invalidation";
+	case QI_PC_TYPE:
+		return "PASID-cache Invalidation";
+	case QI_DEIOTLB_TYPE:
+		return "PASID-based Device-TLB Invalidation";
+	case QI_PGRP_RESP_TYPE:
+		return "Page Group Response";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
+{
+	unsigned int head = dmar_readl(iommu->reg + DMAR_IQH_REG);
+	u64 iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+	struct qi_desc *desc = iommu->qi->desc + head;
+
+	if (fault & DMA_FSTS_IQE)
+		pr_err("VT-d detected Invalidation Queue Error: Reason %llx",
+		       DMAR_IQER_REG_IQEI(iqe_err));
+	if (fault & DMA_FSTS_ITE)
+		pr_err("VT-d detected Invalidation Time-out Error: SID %llx",
+		       DMAR_IQER_REG_ITESID(iqe_err));
+	if (fault & DMA_FSTS_ICE)
+		pr_err("VT-d detected Invalidation Completion Error: SID %llx",
+		       DMAR_IQER_REG_ICESID(iqe_err));
+
+	pr_err("QI HEAD: %s qw0 = 0x%llx, qw1 = 0x%llx\n",
+	       qi_type_string(desc->qw0 & 0xf),
+	       (unsigned long long)desc->qw0,
+	       (unsigned long long)desc->qw1);
+
+	head = ((head >> qi_shift(iommu)) + QI_LENGTH - 1) % QI_LENGTH;
+	head <<= qi_shift(iommu);
+	desc = iommu->qi->desc + head;
+
+	pr_err("QI PRIOR: %s qw0 = 0x%llx, qw1 = 0x%llx\n",
+	       qi_type_string(desc->qw0 & 0xf),
+	       (unsigned long long)desc->qw0,
+	       (unsigned long long)desc->qw1);
+}
+
 static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
@@ -1216,6 +1273,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		return -EAGAIN;
 
 	fault = readl(iommu->reg + DMAR_FSTS_REG);
+	if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
+		qi_dump_fault(iommu, fault);
 
 	/*
 	 * If IQE happens, the head points to the descriptor associated
@@ -1232,12 +1291,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			 * used by software as private data. We won't print
 			 * out these two qw's for security consideration.
 			 */
-			pr_err("VT-d detected invalid descriptor: qw0 = %llx, qw1 = %llx\n",
-			       (unsigned long long)desc->qw0,
-			       (unsigned long long)desc->qw1);
 			memcpy(desc, qi->desc + (wait_index << shift),
 			       1 << shift);
 			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
+			pr_info("Invalidation Queue Error (IQE) cleared\n");
 			return -EINVAL;
 		}
 	}
@@ -1254,6 +1311,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
+		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
@@ -1265,8 +1323,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			return -EAGAIN;
 	}
 
-	if (fault & DMA_FSTS_ICE)
+	if (fault & DMA_FSTS_ICE) {
 		writel(DMA_FSTS_ICE, iommu->reg + DMAR_FSTS_REG);
+		pr_info("Invalidation Completion Error (ICE) cleared\n");
+	}
 
 	return 0;
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d1f32b33415a..76f974da8ca4 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -20,6 +20,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
 #include <linux/ioasid.h>
+#include <linux/bitfield.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -80,6 +81,7 @@
 #define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
 #define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
 #define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
+#define DMAR_IQER_REG	0xb0	/* Invalidation queue error record register */
 #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
 #define DMAR_PQH_REG	0xc0	/* Page request queue head register */
 #define DMAR_PQT_REG	0xc8	/* Page request queue tail register */
@@ -126,6 +128,10 @@
 #define DMAR_VCMD_REG		0xe10 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
 
+#define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
+#define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
+#define DMAR_IQER_REG_ICESID(reg)	FIELD_GET(GENMASK_ULL(63, 48), reg)
+
 #define OFFSET_STRIDE		(9)
 
 #define dmar_readq(a) readq(a)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
