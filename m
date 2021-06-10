Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D06C48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1898613BC
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1898613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACBFA40599;
	Thu, 10 Jun 2021 02:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryHKi6HPOpfk; Thu, 10 Jun 2021 02:03:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 68E8F40526;
	Thu, 10 Jun 2021 02:03:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 547D3C000E;
	Thu, 10 Jun 2021 02:03:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 168C5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECCBF83404
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mlta6fDA1ksu for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27D6F8331B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
IronPort-SDR: kW/Lws7QvJYmWQB/VHODn3q6GtlKiWLVXzixL1oyTC0vqy56qUj5iE4EcPykYM9OLous9r4QeR
 9ANSxVJHIPVg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184270"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:43 -0700
IronPort-SDR: hXqzloBd66UMBFNq4i4ExXwqUpHplmxcLBlkjv2frIWpp8gGhk9RL8LfJDymcUJke4eFcfTOv7
 bP1MvFNniCqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500470"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 15/23] iommu/vt-d: Add cache invalidation latency sampling
Date: Thu, 10 Jun 2021 10:01:07 +0800
Message-Id: <20210610020115.1637656-16-baolu.lu@linux.intel.com>
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

Queued invalidation execution time is performance critical and needs
to be monitored. This adds code to sample the execution time of IOTLB/
devTLB/ICE cache invalidation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index cae1078cbfec..d66f79acd14d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -34,6 +34,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
+#include "perf.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
@@ -1342,15 +1343,33 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options)
 {
 	struct q_inval *qi = iommu->qi;
+	s64 devtlb_start_ktime = 0;
+	s64 iotlb_start_ktime = 0;
+	s64 iec_start_ktime = 0;
 	struct qi_desc wait_desc;
 	int wait_index, index;
 	unsigned long flags;
 	int offset, shift;
 	int rc, i;
+	u64 type;
 
 	if (!qi)
 		return 0;
 
+	type = desc->qw0 & GENMASK_ULL(3, 0);
+
+	if ((type == QI_IOTLB_TYPE || type == QI_EIOTLB_TYPE) &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_IOTLB))
+		iotlb_start_ktime = ktime_to_ns(ktime_get());
+
+	if ((type == QI_DIOTLB_TYPE || type == QI_DEIOTLB_TYPE) &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_DEVTLB))
+		devtlb_start_ktime = ktime_to_ns(ktime_get());
+
+	if (type == QI_IEC_TYPE &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_IEC))
+		iec_start_ktime = ktime_to_ns(ktime_get());
+
 restart:
 	rc = 0;
 
@@ -1425,6 +1444,18 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	if (rc == -EAGAIN)
 		goto restart;
 
+	if (iotlb_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_IOTLB,
+				ktime_to_ns(ktime_get()) - iotlb_start_ktime);
+
+	if (devtlb_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_DEVTLB,
+				ktime_to_ns(ktime_get()) - devtlb_start_ktime);
+
+	if (iec_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_IEC,
+				ktime_to_ns(ktime_get()) - iec_start_ktime);
+
 	return rc;
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
