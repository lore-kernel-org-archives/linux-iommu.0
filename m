Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B95CC433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 14:24:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB2D2068D
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 14:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB2D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2256520428;
	Mon,  1 Jun 2020 14:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOFzqUr4kCgF; Mon,  1 Jun 2020 14:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6EAF7203BA;
	Mon,  1 Jun 2020 14:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 539CFC0178;
	Mon,  1 Jun 2020 14:24:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2C2C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 08:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3A4C489484
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 08:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AcFf9oQ1AAxn for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 08:11:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 523CD8777B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 08:11:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01358;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0U-BjZZW_1590999096; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U-BjZZW_1590999096) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 01 Jun 2020 16:11:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: joro@8bytes.org
Subject: [PATCH] iommu: Optimize the error handling when allocating an iommu
 group
Date: Mon,  1 Jun 2020 16:11:06 +0800
Message-Id: <1590999066-92237-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Mon, 01 Jun 2020 14:24:47 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 baolin.wang@linux.alibaba.com
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

Optimize the error handling to free the resources correctly when
failed to allocate an iommu group.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 03d6a26..ac91024 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -529,12 +529,18 @@ struct iommu_group *iommu_group_alloc(void)
 
 	ret = iommu_group_create_file(group,
 				      &iommu_group_attr_reserved_regions);
-	if (ret)
+	if (ret) {
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	ret = iommu_group_create_file(group, &iommu_group_attr_type);
-	if (ret)
+	if (ret) {
+		iommu_group_remove_file(group,
+					&iommu_group_attr_reserved_regions);
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	pr_debug("Allocated group %d\n", group->id);
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
