Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7948C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 08:16:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7DD22B3B
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 08:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7DD22B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0097520034;
	Tue, 26 Jan 2021 08:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrCi3Gq2QaLH; Tue, 26 Jan 2021 08:15:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 46A14203F1;
	Tue, 26 Jan 2021 08:15:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2258FC1DA9;
	Tue, 26 Jan 2021 08:15:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCF8AC0FA7
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B9C6C8511B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzYbYyCie2YS for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF14D85166
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:53 +0000 (UTC)
IronPort-SDR: QV85bKNZ5FdYNQ5WUuF/YwvHpyn6LoOw1jGMquDhreo6lcYNCz/SHWwNZStqeya7v0RbQlXrJc
 tCiOwMuGP2qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177297770"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="177297770"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:15:52 -0800
IronPort-SDR: RyXTL8a39rMcJII30OSQ7JLgYTMXws0K6NW/SnkAdeFm/Eq4q0GvY6UvHmA0IGL8IoQkA7xETY
 pglZrRdtAJSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="577725450"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2021 00:15:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/2] iommu/vt-d: Clear PRQ overflow only when PRQ is empty
Date: Tue, 26 Jan 2021 16:07:29 +0800
Message-Id: <20210126080730.2232859-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
References: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
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

It is incorrect to always clear PRO when it's set w/o first checking
whether the overflow condition has been cleared. Current code assumes
that if an overflow condition occurs it must have been cleared by earlier
loop. However since the code runs in a threaded context, the overflow
condition could occur even after setting the head to the tail under some
extreme condition. To be sane, we should read both head/tail again when
seeing a pending PRO and only clear PRO after all pending PRs have been
handled.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/linux-iommu/MWHPR11MB18862D2EA5BD432BF22D99A48CA09@MWHPR11MB1886.namprd11.prod.outlook.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 033b25886e57..d7c98c5fa4e7 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1042,8 +1042,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	 * Clear the page request overflow bit and wake up all threads that
 	 * are waiting for the completion of this handling.
 	 */
-	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
-		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
+				    iommu->name);
+		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+		if (head == tail) {
+			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
+					    iommu->name);
+		}
+	}
 
 	if (!completion_done(&iommu->prq_complete))
 		complete(&iommu->prq_complete);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
