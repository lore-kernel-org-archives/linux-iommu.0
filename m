Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17DC48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AD6613BC
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AD6613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13B11401F8;
	Thu, 10 Jun 2021 02:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3g5wpAtG4tp; Thu, 10 Jun 2021 02:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E767740170;
	Thu, 10 Jun 2021 02:04:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCFA7C0011;
	Thu, 10 Jun 2021 02:04:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765C2C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52FCF40599
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AxJW-DMo2WAh for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DF4340542
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:14 +0000 (UTC)
IronPort-SDR: 8iD5b7fiRXdmf4tShjpKZZhqgAqT1QHKrgOIrJ4cJ1oY4f/QKQBJoE+vq7uMcExgJBTIdbfFEP
 dV8YpKeLiXTw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184296"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:50 -0700
IronPort-SDR: C5cRGXcDfOWeNUNUVVvzA3df6ei59UmXg6MOf1GJAPptTGsO6SdDRT6jl1XWp60NDk7ugSrtpH
 jtfqKPDom0Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500506"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 17/23] iommu/vt-d: Fix out-bounds-warning in intel/svm.c
Date: Thu, 10 Jun 2021 10:01:09 +0800
Message-Id: <20210610020115.1637656-18-baolu.lu@linux.intel.com>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

Replace a couple of calls to memcpy() with simple assignments in order
to fix the following out-of-bounds warning:

drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from
    the object at 'desc' is out of the bounds of referenced subobject
    'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy(). This causes a legitimate compiler warning because memcpy()
overruns the length of &desc.qw2 and &resp.qw2, respectively.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210414201403.GA392764@embeddedor
---
 drivers/iommu/intel/svm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6bff9a7f9133..9b0f22bc0514 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -870,8 +870,8 @@ static int intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 		 */
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
-		memcpy(event.fault.prm.private_data, desc->priv_data,
-		       sizeof(desc->priv_data));
+		event.fault.prm.private_data[0] = desc->priv_data[0];
+		event.fault.prm.private_data[1] = desc->priv_data[1];
 	} else if (dmar_latency_enabled(iommu, DMAR_LATENCY_PRQ)) {
 		/*
 		 * If the private data fields are not used by hardware, use it
@@ -910,11 +910,15 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 			QI_PGRP_RESP_TYPE;
 	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
 			QI_PGRP_LPIG(req->lpig);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
 
-	if (req->priv_data_present)
-		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
+	if (req->priv_data_present) {
+		desc.qw2 = req->priv_data[0];
+		desc.qw3 = req->priv_data[1];
+	} else {
+		desc.qw2 = 0;
+		desc.qw3 = 0;
+	}
+
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
@@ -1176,12 +1180,14 @@ int intel_svm_page_response(struct device *dev,
 		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		if (private_present)
-			memcpy(&desc.qw2, prm->private_data,
-			       sizeof(prm->private_data));
-		else if (prm->private_data[0])
+
+		if (private_present) {
+			desc.qw2 = prm->private_data[0];
+			desc.qw3 = prm->private_data[1];
+		} else if (prm->private_data[0]) {
 			dmar_latency_update(iommu, DMAR_LATENCY_PRQ,
 				ktime_to_ns(ktime_get()) - prm->private_data[0]);
+		}
 
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
