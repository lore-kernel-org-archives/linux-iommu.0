Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC8FC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:17:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F621611AB
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F621611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69F2B60893;
	Thu, 20 May 2021 03:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CqNWIXe-yhR; Thu, 20 May 2021 03:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 483E06088F;
	Thu, 20 May 2021 03:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB144C0022;
	Thu, 20 May 2021 03:17:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 711F3C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60F3640179
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLQo4HJ6a-Xn for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 03:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3C1740155
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:17:10 +0000 (UTC)
IronPort-SDR: 7YnYutUEK7HPHEhpnBkYkSmbXNsU7RMNK3AcEi7Uz+aYnkGHsmWDFC0O9dfouz4/JkH3Q7tuh9
 vHH140cZ3DcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659670"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286659670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 20:17:10 -0700
IronPort-SDR: wYzHUtD07xpb/Z5tvwmKVEb0jJVyC9FFZqjJk9AmnEw5Ivrtykt3SdQSNtM9b7+5FXWPv++7av
 eAKB5YCWEGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395527334"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:17:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/11] iommu/vt-d: Add PRQ handling latency sampling
Date: Thu, 20 May 2021 11:15:31 +0800
Message-Id: <20210520031531.712333-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

The execution time for page fault request handling is performance critical
and needs to be monitored. This adds code to sample the execution time of
page fault request handling.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d3d028c6a727..6bff9a7f9133 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -24,6 +24,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
+#include "perf.h"
 #include "../iommu-sva-lib.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
@@ -838,8 +839,8 @@ static int prq_to_iommu_prot(struct page_req_dsc *req)
 	return prot;
 }
 
-static int
-intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
+static int intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
+				struct page_req_dsc *desc)
 {
 	struct iommu_fault_event event;
 
@@ -871,6 +872,12 @@ intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 		memcpy(event.fault.prm.private_data, desc->priv_data,
 		       sizeof(desc->priv_data));
+	} else if (dmar_latency_enabled(iommu, DMAR_LATENCY_PRQ)) {
+		/*
+		 * If the private data fields are not used by hardware, use it
+		 * to monitor the prq handle latency.
+		 */
+		event.fault.prm.private_data[0] = ktime_to_ns(ktime_get());
 	}
 
 	return iommu_report_device_fault(dev, &event);
@@ -983,7 +990,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (intel_svm_prq_report(sdev->dev, req))
+		if (intel_svm_prq_report(iommu, sdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 
 		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
@@ -1172,6 +1179,9 @@ int intel_svm_page_response(struct device *dev,
 		if (private_present)
 			memcpy(&desc.qw2, prm->private_data,
 			       sizeof(prm->private_data));
+		else if (prm->private_data[0])
+			dmar_latency_update(iommu, DMAR_LATENCY_PRQ,
+				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
