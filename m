Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4663EC28CBC
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 20:03:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B062070B
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iFZPlTn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B062070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C69D988291;
	Wed,  6 May 2020 20:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1onJ+MHgXS5; Wed,  6 May 2020 20:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34D298828F;
	Wed,  6 May 2020 20:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C70C088B;
	Wed,  6 May 2020 20:03:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B8FC0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 20:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5C6CF2578F
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 20:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQTW2y0GshoJ for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 20:03:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id 33FBC203CF
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 20:03:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588795402; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0qIdTUUATMq8n20RL86MZF5csAq5w4nM1wfS8+2VTvs=;
 b=iFZPlTn0zfUTR2TWzZaDrfRXQWnDzGWjmzhE7JObfk8FZJTVH+wvsF+ivdpZw45tOtFW2ZMk
 8eL4wMaoMzb8h+lps3R28zovAyVrgSj4zawZD0BWA4zoP1sC/JMq7ZHOEGohQJLi3Ot2/BFJ
 bFJy0wnf2MMbTgbXAAp2riDd9Rw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb317f5.7f0f9389e2d0-smtp-out-n01;
 Wed, 06 May 2020 20:03:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 9342AC4478F; Wed,  6 May 2020 20:03:00 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DE3C8C433BA;
 Wed,  6 May 2020 20:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE3C8C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
From: vjitta@codeaurora.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/iova: Retry from last rb tree node if iova search fails
Date: Thu,  7 May 2020 01:31:57 +0530
Message-Id: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Cc: vjitta@codeaurora.org, vinmenon@codeaurora.org, kernel-team@android.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever a new iova alloc request comes iova is always searched
from the cached node and the nodes which are previous to cached
node. So, even if there is free iova space available in the nodes
which are next to the cached node iova allocation can still fail
because of this approach.

Consider the following sequence of iova alloc and frees on
1GB of iova space

1) alloc - 500MB
2) alloc - 12MB
3) alloc - 499MB
4) free -  12MB which was allocated in step 2
5) alloc - 13MB

After the above sequence we will have 12MB of free iova space and
cached node will be pointing to the iova pfn of last alloc of 13MB
which will be the lowest iova pfn of that iova space. Now if we get an
alloc request of 2MB we just search from cached node and then look
for lower iova pfn's for free iova and as they aren't any, iova alloc
fails though there is 12MB of free iova space.

To avoid such iova search failures do a retry from the last rb tree node
when iova search fails, this will search the entire tree and get an iova
if its available

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a953..2985222 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long flags;
 	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
+	bool retry = false;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -198,6 +199,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
+
+retry_search:
 	do {
 		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
 		new_pfn = (limit_pfn - size) & align_mask;
@@ -207,6 +210,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
 	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		if (!retry) {
+			curr = rb_last(&iovad->rbroot);
+			curr_iova = rb_entry(curr, struct iova, node);
+			limit_pfn = curr_iova->pfn_lo;
+			retry = true;
+			goto retry_search;
+		}
+
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
