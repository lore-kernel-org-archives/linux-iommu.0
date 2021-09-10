Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB69C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 12:19:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA756611C8
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 12:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA756611C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3EB1400F7;
	Fri, 10 Sep 2021 12:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0km_4ULbwtbC; Fri, 10 Sep 2021 12:19:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D79940105;
	Fri, 10 Sep 2021 12:19:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 051F0C000F;
	Fri, 10 Sep 2021 12:19:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50E27C000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3251040278
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lIeJ18uJtIlG for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 12:19:27 +0000 (UTC)
X-Greylist: delayed 00:13:25 by SQLgrey-1.8.0
Received: from h2.fbrelay.privateemail.com (h2.fbrelay.privateemail.com
 [131.153.2.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C77040257
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:19:27 +0000 (UTC)
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com
 [198.54.122.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id E9F7B80B2F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 08:06:00 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
 by mta-13.privateemail.com (Postfix) with ESMTP id D2EE2180016B;
 Fri, 10 Sep 2021 08:05:57 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.212])
 by mta-13.privateemail.com (Postfix) with ESMTPA id 0068B180015C;
 Fri, 10 Sep 2021 08:05:56 -0400 (EDT)
From: Hamza Mahfooz <someguy@effective-light.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: prevent an error message from causing runtime
 problems
Date: Fri, 10 Sep 2021 08:05:41 -0400
Message-Id: <20210910120541.39938-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 Jeremy Linton <jeremy.linton@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

For some drivers, that call add_dma_entry() from somewhere down the call
stack. If this error condition is triggered once, it causes the error
message to spam the kernel's printk buffer and bring the CPU usage up to
100%. Also, since there is at least one driver that is in the mainline
and suffers from the error condition, it is more useful to WARN_ON() here
instead of just printing the error message (in hopes that it will make it
easier for other drivers that suffer from this issue to be spotted).

Link: https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 kernel/dma/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 6c90c69e5311..d9806689666e 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -567,7 +567,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST) {
-		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
+		WARN_ONCE(1,
+			  pr_fmt("cacheline tracking EEXIST, overlapping mappings aren't supported\n"
+			 ));
 	}
 }
 
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
