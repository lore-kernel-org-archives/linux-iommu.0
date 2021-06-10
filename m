Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47482C48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130876140F
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130876140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3FDC403A1;
	Thu, 10 Jun 2021 02:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3HYYBd04LWuS; Thu, 10 Jun 2021 02:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD20240170;
	Thu, 10 Jun 2021 02:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA5A3C000E;
	Thu, 10 Jun 2021 02:03:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8665CC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F83F831AC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnSSYcS0wGnF for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 874B0831A5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:34 +0000 (UTC)
IronPort-SDR: tkcMbZmYSUT0eNMcnIU7JuhujiFEhUh7XOBrpY1d8vfoLSBXqsRejWt7zEub/jA+KJxa/G7vN4
 YS2VX2cWrkSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184248"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:34 -0700
IronPort-SDR: UMwsizS4z2JGhSYg5/59Tqqdl3FF6QPSWuqQGuB02IiPbqCaecBOBWLPJjSDRYr47f6MncxoiC
 +ss3GLbE2Rkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500415"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 12/23] iommu/vt-d: Add prq_report trace event
Date: Thu, 10 Jun 2021 10:01:04 +0800
Message-Id: <20210610020115.1637656-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
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

This adds a new trace event to track the page fault request report.
This event will provide almost all information defined in a page
request descriptor.

A sample output:
| prq_report: dmar0/0000:00:0a.0 seq# 1: rid=0x50 addr=0x559ef6f97 r---- pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 2: rid=0x50 addr=0x559ef6f9c rw--l pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 3: rid=0x50 addr=0x559ef6f98 r---- pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 4: rid=0x50 addr=0x559ef6f9d rw--l pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 5: rid=0x50 addr=0x559ef6f99 r---- pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 6: rid=0x50 addr=0x559ef6f9e rw--l pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 7: rid=0x50 addr=0x559ef6f9a r---- pasid=0x2 index=0x1
| prq_report: dmar0/0000:00:0a.0 seq# 8: rid=0x50 addr=0x559ef6f9f rw--l pasid=0x2 index=0x1

This will be helpful for I/O page fault related debugging.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h        | 29 +++++++++++++++++++++++
 include/trace/events/intel_iommu.h | 37 ++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c          |  7 ++++++
 3 files changed, 73 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 222520d149c1..98b04fa9373e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -778,6 +778,7 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
+	unsigned long prq_seq_number;
 	u32 pasid;
 	int users;
 	u16 did;
@@ -828,4 +829,32 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define intel_iommu_enabled (0)
 #endif
 
+static inline const char *decode_prq_descriptor(char *str, size_t size,
+		u64 dw0, u64 dw1, u64 dw2, u64 dw3)
+{
+	char *buf = str;
+	int bytes;
+
+	bytes = snprintf(buf, size,
+			 "rid=0x%llx addr=0x%llx %c%c%c%c%c pasid=0x%llx index=0x%llx",
+			 FIELD_GET(GENMASK_ULL(31, 16), dw0),
+			 FIELD_GET(GENMASK_ULL(63, 12), dw1),
+			 dw1 & BIT_ULL(0) ? 'r' : '-',
+			 dw1 & BIT_ULL(1) ? 'w' : '-',
+			 dw0 & BIT_ULL(52) ? 'x' : '-',
+			 dw0 & BIT_ULL(53) ? 'p' : '-',
+			 dw1 & BIT_ULL(2) ? 'l' : '-',
+			 FIELD_GET(GENMASK_ULL(51, 32), dw0),
+			 FIELD_GET(GENMASK_ULL(11, 3), dw1));
+
+	/* Private Data */
+	if (dw0 & BIT_ULL(9)) {
+		size -= bytes;
+		buf += bytes;
+		snprintf(buf, size, " private=0x%llx/0x%llx\n", dw2, dw3);
+	}
+
+	return str;
+}
+
 #endif
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index d233f2916584..e5c1ca6d16ee 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -15,6 +15,8 @@
 #include <linux/tracepoint.h>
 #include <linux/intel-iommu.h>
 
+#define MSG_MAX		256
+
 TRACE_EVENT(qi_submit,
 	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
 
@@ -51,6 +53,41 @@ TRACE_EVENT(qi_submit,
 		__entry->qw0, __entry->qw1, __entry->qw2, __entry->qw3
 	)
 );
+
+TRACE_EVENT(prq_report,
+	TP_PROTO(struct intel_iommu *iommu, struct device *dev,
+		 u64 dw0, u64 dw1, u64 dw2, u64 dw3,
+		 unsigned long seq),
+
+	TP_ARGS(iommu, dev, dw0, dw1, dw2, dw3, seq),
+
+	TP_STRUCT__entry(
+		__field(u64, dw0)
+		__field(u64, dw1)
+		__field(u64, dw2)
+		__field(u64, dw3)
+		__field(unsigned long, seq)
+		__string(iommu, iommu->name)
+		__string(dev, dev_name(dev))
+		__dynamic_array(char, buff, MSG_MAX)
+	),
+
+	TP_fast_assign(
+		__entry->dw0 = dw0;
+		__entry->dw1 = dw1;
+		__entry->dw2 = dw2;
+		__entry->dw3 = dw3;
+		__entry->seq = seq;
+		__assign_str(iommu, iommu->name);
+		__assign_str(dev, dev_name(dev));
+	),
+
+	TP_printk("%s/%s seq# %ld: %s",
+		__get_str(iommu), __get_str(dev), __entry->seq,
+		decode_prq_descriptor(__get_str(buff), MSG_MAX, __entry->dw0,
+				      __entry->dw1, __entry->dw2, __entry->dw3)
+	)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ade157b64ce7..d3d028c6a727 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,6 +21,7 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
+#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "../iommu-sva-lib.h"
@@ -976,12 +977,18 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				goto bad_req;
 		}
 
+		sdev->prq_seq_number++;
+
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
 		if (intel_svm_prq_report(sdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+
+		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
+				 req->priv_data[0], req->priv_data[1],
+				 sdev->prq_seq_number);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
