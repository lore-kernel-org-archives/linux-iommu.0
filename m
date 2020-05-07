Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9BC54E49
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:18:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CC62083B
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CC62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70620888AB;
	Thu,  7 May 2020 16:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CeXdec4z8kaO; Thu,  7 May 2020 16:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15497888DA;
	Thu,  7 May 2020 16:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0241EC0890;
	Thu,  7 May 2020 16:18:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E271C0865
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 10889890D5
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajYm422yLXml for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 16:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 50C3988049
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:09 +0000 (UTC)
IronPort-SDR: 7LeScyuxN0x0Idajh6KlT/KoozE4SEsN4WV4klr9WSBiF5wOFcOrWeeySJtBW7U+qxRTDaatyZ
 HRqeUI97FDWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 09:18:08 -0700
IronPort-SDR: MEFham7AI39U+N2/UgsE/Ompa2TkOGA2PVmQdPo0iNSjOmlA7maxg8KAX8fVOLJXhfQN/D44nR
 VIewiSsOhAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="260576207"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 07 May 2020 09:18:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 25C4E119; Thu,  7 May 2020 19:18:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: [PATCH v1 1/3] iommu/vt-d: Unify format of the printed messages
Date: Thu,  7 May 2020 19:18:02 +0300
Message-Id: <20200507161804.13275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Unify format of the printed messages, i.e. replace printk(LEVEL ... )
with pr_level(...).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0182cff2c7ac7..624831e5a583c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -480,8 +480,7 @@ static int __init intel_iommu_setup(char *str)
 			pr_info("Intel-IOMMU: scalable mode supported\n");
 			intel_iommu_sm = 1;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
+			pr_info("Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
 		} else if (!strncmp(str, "nobounce", 8)) {
 			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
