Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A1C38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:18:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035E82083B
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035E82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C056A888CF;
	Thu,  7 May 2020 16:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTsr386hjpVl; Thu,  7 May 2020 16:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7478888AB;
	Thu,  7 May 2020 16:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5277C0865;
	Thu,  7 May 2020 16:18:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E144C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02181888AB
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9qxXLpdGG3Y for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 16:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7B5B8886E3
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:18:09 +0000 (UTC)
IronPort-SDR: VwM63XVGig6e4agh5QKpOowK87YXsjkJFuQDWXj3YDtnmTixBXjJd2YUyKezb08fckgl+8cpyT
 N3bxxGRBZrDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 09:18:08 -0700
IronPort-SDR: mV9JZDgF6XIriWO8RxMWOyQZXmCeOKLv0AANIBCbZjIDKTqRSIwTAOU+a31YkB3KovTWNNMJjo
 jltMiIWwxt+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="249333034"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga007.jf.intel.com with ESMTP; 07 May 2020 09:18:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 35678101; Thu,  7 May 2020 19:18:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: [PATCH v1 2/3] iommu/iova: Unify format of the printed messages
Date: Thu,  7 May 2020 19:18:03 +0300
Message-Id: <20200507161804.13275-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507161804.13275-1-andriy.shevchenko@linux.intel.com>
References: <20200507161804.13275-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iommu/iova.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a9536eca62..49fc01f2a28d4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -253,7 +253,7 @@ int iova_cache_get(void)
 			SLAB_HWCACHE_ALIGN, NULL);
 		if (!iova_cache) {
 			mutex_unlock(&iova_cache_mutex);
-			printk(KERN_ERR "Couldn't create iova cache\n");
+			pr_err("Couldn't create iova cache\n");
 			return -ENOMEM;
 		}
 	}
@@ -718,8 +718,8 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 
 		new_iova = reserve_iova(to, iova->pfn_lo, iova->pfn_hi);
 		if (!new_iova)
-			printk(KERN_ERR "Reserve iova range %lx@%lx failed\n",
-				iova->pfn_lo, iova->pfn_lo);
+			pr_err("Reserve iova range %lx@%lx failed\n",
+			       iova->pfn_lo, iova->pfn_lo);
 	}
 	spin_unlock_irqrestore(&from->iova_rbtree_lock, flags);
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
