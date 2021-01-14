Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E4C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:12:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CBB23A02
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CBB23A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 565BB2E11C;
	Thu, 14 Jan 2021 09:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsKwvqu0-bpG; Thu, 14 Jan 2021 09:12:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 308122047B;
	Thu, 14 Jan 2021 09:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFF5C088B;
	Thu, 14 Jan 2021 09:12:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A5EDC013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 380C886AC7
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmSbjVH2CY02 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 09:12:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8029186A89
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:26 +0000 (UTC)
IronPort-SDR: uSuLD/TMNORs6jjN0Tq11BgE5HWaOCQvla+AIB1CpWs21++9keXawb6F5G5MAcm8NFT1qd23gv
 0KMazaHq3JYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="158109205"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="158109205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 01:12:25 -0800
IronPort-SDR: gEEbcp93x6S9GWz3wMSCRHA4+GfNELOpQvByPK2fHON94GrmT7df6kM5BzKhRvaeS7l5pszYkX
 NSYIVxwiljdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="465192041"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 01:12:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Add qi_submit trace event
Date: Thu, 14 Jan 2021 17:04:00 +0800
Message-Id: <20210114090400.736104-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

This adds a new trace event to track the submissions of requests to the
invalidation queue. This event will provide the information like:
- IOMMU name
- Invalidation type
- Descriptor raw data

A sample output like:
| qi_submit: iotlb_inv dmar1: 0x100e2 0x0 0x0 0x0
| qi_submit: dev_tlb_inv dmar1: 0x1000000003 0x7ffffffffffff001 0x0 0x0
| qi_submit: iotlb_inv dmar2: 0x800f2 0xf9a00005 0x0 0x0

This will be helpful for queued invalidation related debugging.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c         |  3 +++
 include/trace/events/intel_iommu.h | 37 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 004feaed3c72..bd51f33642e0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -31,6 +31,7 @@
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
+#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 
@@ -1307,6 +1308,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		offset = ((index + i) % QI_LENGTH) << shift;
 		memcpy(qi->desc + offset, &desc[i], 1 << shift);
 		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
+		trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
+				desc[i].qw2, desc[i].qw3);
 	}
 	qi->desc_status[wait_index] = QI_IN_USE;
 
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 112bd06487bf..aad2ff0c1e2e 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -135,6 +135,43 @@ DEFINE_EVENT(dma_map_sg, bounce_map_sg,
 		 struct scatterlist *sg),
 	TP_ARGS(dev, index, total, sg)
 );
+
+TRACE_EVENT(qi_submit,
+	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
+
+	TP_ARGS(iommu, qw0, qw1, qw2, qw3),
+
+	TP_STRUCT__entry(
+		__field(u64, qw0)
+		__field(u64, qw1)
+		__field(u64, qw2)
+		__field(u64, qw3)
+		__string(iommu, iommu->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(iommu, iommu->name);
+		__entry->qw0 = qw0;
+		__entry->qw1 = qw1;
+		__entry->qw2 = qw2;
+		__entry->qw3 = qw3;
+	),
+
+	TP_printk("%s %s: 0x%llx 0x%llx 0x%llx 0x%llx",
+		  __print_symbolic(__entry->qw0 & 0xf,
+				   { QI_CC_TYPE,	"cc_inv" },
+				   { QI_IOTLB_TYPE,	"iotlb_inv" },
+				   { QI_DIOTLB_TYPE,	"dev_tlb_inv" },
+				   { QI_IEC_TYPE,	"iec_inv" },
+				   { QI_IWD_TYPE,	"inv_wait" },
+				   { QI_EIOTLB_TYPE,	"p_iotlb_inv" },
+				   { QI_PC_TYPE,	"pc_inv" },
+				   { QI_DEIOTLB_TYPE,	"p_dev_tlb_inv" },
+				   { QI_PGRP_RESP_TYPE,	"page_grp_resp" }),
+		__get_str(iommu),
+		__entry->qw0, __entry->qw1, __entry->qw2, __entry->qw3
+	)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
