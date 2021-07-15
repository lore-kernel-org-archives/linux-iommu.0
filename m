Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C260C47E48
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:32:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B9E61360
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9E61360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEBD260B30;
	Thu, 15 Jul 2021 07:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2b7bzV-J6nZ; Thu, 15 Jul 2021 07:32:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2DD160B22;
	Thu, 15 Jul 2021 07:32:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B69BC0023;
	Thu, 15 Jul 2021 07:32:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CF5C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 350F34159A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mailerdienst.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsSKniHaZPXu for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 07:30:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de
 [IPv6:2a03:2900:1:1::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2E1D415A3
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:30:07 +0000 (UTC)
Received: from mxout4.routing.net (unknown [192.168.10.112])
 by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 97BDD2C55D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:12:09 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
 by mxout4.routing.net (Postfix) with ESMTP id CFAD11008A2;
 Thu, 15 Jul 2021 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1626333124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bHCbwCI5MpbahEdZ+ZAHQEIG0Qqobtp7he3SCKGjng4=;
 b=UZUcYAROrcxiZ4qtTYQi8LA4YUQLgFnIF9U7QtMoI6bCOudaAFgjKITsbnZAIgaTV/JdPb
 7AG/U/I8x8rYv7Aiu3iRaFl4yFrXbjRerIQiiv/GyG6VCUAQgaS2+NQUS2epxEChEEbMfg
 M/uPVC4nbhNRnOoWQ3Dy/MyF30X37RA=
Received: from localhost.localdomain (fttx-pool-80.245.79.66.bambit.de
 [80.245.79.66])
 by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 9C17B3606AA;
 Thu, 15 Jul 2021 07:12:01 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: check if group is NULL before remove device
Date: Thu, 15 Jul 2021 09:11:50 +0200
Message-Id: <20210715071150.82157-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mail-ID: c6a9bf0f-a649-438f-8b8f-4f345d6069d2
X-Mailman-Approved-At: Thu, 15 Jul 2021 07:31:59 +0000
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Frank Wunderlich <frank-w@public-files.de>
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

From: Frank Wunderlich <frank-w@public-files.de>

if probe is failing, iommu_group may be not initialized,
so freeing it will result in NULL pointer access

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..63f0af10c403 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -924,6 +924,9 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
+	if (!group)
+		return;
+
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
