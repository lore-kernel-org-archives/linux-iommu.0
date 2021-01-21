Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7999C433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 01:53:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8874123788
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 01:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8874123788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03F672050F;
	Thu, 21 Jan 2021 01:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2V4snDvSw+I; Thu, 21 Jan 2021 01:53:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7FDA2050D;
	Thu, 21 Jan 2021 01:53:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A748C088B;
	Thu, 21 Jan 2021 01:53:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC075C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A503C2050D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONI6BYmnI1lY for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 01:53:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 8E52820512
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:53:39 +0000 (UTC)
IronPort-SDR: s6a04KdLdnp9dcVAEF+tuvROGg6XNUT1Mj4NMDCVJCAMhYhF6hhqZCZXZqtfMEH42mrb86+C1O
 aeC1W9ZAReyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="197938370"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="197938370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 17:53:39 -0800
IronPort-SDR: QNr0O4qpQMTHS7ga7fh2HdCPLX6cLjIEWA7Dfi+bY5r8+391q/1SYFco6bS6gXkO6Ym3Cn9XNe
 gYyS8ZtGQc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="391762270"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 17:53:37 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/3] iommu/vt-d: Use INVALID response code instead of FAILURE
Date: Thu, 21 Jan 2021 09:45:05 +0800
Message-Id: <20210121014505.1659166-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

The VT-d IOMMU response RESPONSE_FAILURE for a page request in below
cases:

- When it gets a Page_Request with no PASID;
- When it gets a Page_Request with PASID that is not in use for this
  device.

This is allowed by the spec, but IOMMU driver doesn't support such cases
today. When the device receives RESPONSE_FAILURE, it sends the device
state machine to HALT state. Now if we try to unload the driver, it hangs
since the device doesn't send any outbound transactions to host when the
driver is trying to clear things up. The only possible responses would be
for invalidation requests.

Let's use RESPONSE_INVALID instead for now, so that the device state
machine doesn't enter HALT state.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 77509a0a863e..021f58899c16 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -907,10 +907,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		u64 address;
 
 		handled = 1;
-
 		req = &iommu->prq[head / sizeof(*req)];
-
-		result = QI_RESP_FAILURE;
+		result = QI_RESP_INVALID;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 		if (!req->pasid_present) {
 			pr_err("%s: Page request without PASID: %08llx %08llx\n",
@@ -948,7 +946,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			rcu_read_unlock();
 		}
 
-		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
