Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D4CC433FE
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 05:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8F5841737;
	Thu, 14 Apr 2022 05:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xXvu5JANI3m; Thu, 14 Apr 2022 05:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 892F441733;
	Thu, 14 Apr 2022 05:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA8BC0033;
	Thu, 14 Apr 2022 05:08:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11767C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 05:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE21F40588
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 05:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VtDE8tPs16B for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 05:08:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EDAE40104
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 05:08:49 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id q12so3792910pgj.13
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 22:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=BXdefmByfbS7iadyHNuWA+1dWRCSn9oFrWGYl5Fm5mk=;
 b=QC4YhFn1wllW1lC8gGSTmQFcF7BKiGku0fd0KEfKjckRUB1fOizADvm++YKwNJFLc6
 +p3eYn++B8ekg9AlERZxlEGP4EGWCW45H3Bh0NIKjNlicWv3ADwMzRdciFPgkUxy7TdQ
 MyvYxZSnGgTqL7PvRoNpEbyabTi2MfWPgu764RWig9VQDiYv19sPLGNZKNOxurugG7YF
 AFSaTnD3n21Zot+8WlvXif9ut80zGJ6kaZJiHH5Toc+jTNzMkEMZwCaxnQDvT2RVDOtN
 bxxfEe9q4xMbuhbDRm1KRN3eMUJa2yHoxSJKU84eH5BkDlP232pGpxWaO6+1UgaIeHu1
 p2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BXdefmByfbS7iadyHNuWA+1dWRCSn9oFrWGYl5Fm5mk=;
 b=ZQqhslRSAGacl8h9Bzglxx46ui1QUGon2KIJ2K9wOPgqZLPiR8MBcnb/R8AGKu64Zt
 Y21BCjoeXeBdJ3ut/r4rfcFs9O8I6ciGKibnTewCYub0iPWXDPDz27T9nwXYHeO6GVYF
 jAH4WMXRCvOcJbEDTHwSzy4lOvhdikTsfQ5yusHFBMbc27imQXkC481r+6zCcjwThYfY
 X4p+QuX+RpuBz5bTRPuRIqAse5844yzIehG8FXH6d2njuRT+IWJ0jqYpYoUKO1sHAvIK
 Zfn4tWryyAP9cAtAOu5CbBOb4F9vO4etu8oqgIz2D9WZXI1lgbK6ysulGh3ULTb4s3tN
 qs/Q==
X-Gm-Message-State: AOAM531uWEceLJR1U1zh/MEuW414vOICG1oxfJL3VvjdAEQh8ODS5K1x
 ivU9ktUvQjP4uchU9Scm0qY=
X-Google-Smtp-Source: ABdhPJw2MWj6GujCGgHKVad2Vx8MRhaCT+wPaYACtZPvQZoVgZALyIcPZCbAatA+aPcL59Ad7T7eBA==
X-Received: by 2002:a63:78f:0:b0:39e:11d0:daa4 with SMTP id
 137-20020a63078f000000b0039e11d0daa4mr942690pgh.36.1649912928665; 
 Wed, 13 Apr 2022 22:08:48 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a056a000a8200b004e1414f0bb1sm763936pfl.135.2022.04.13.22.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 22:08:48 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 will@kernel.org, sricharan@codeaurora.org
Subject: [RESEND][PATCH] iommu: fix an incorrect NULL check on list iterator
Date: Thu, 14 Apr 2022 13:08:40 +0800
Message-Id: <20220414050840.5691-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

The bug is here:
	if (!iommu || iommu->dev->of_node != spec->np) {

The list iterator value 'iommu' will *always* be set and non-NULL by
list_for_each_entry(), so it is incorrect to assume that the iterator
value will be NULL if the list is empty or no element is found (in fact,
it will point to a invalid structure object containing HEAD).

To fix the bug, run insert_iommu_master(dev, &iommu, spec); unlock and
return 0 when found, otherwise unlock and return -ENODEV.

Cc: stable@vger.kernel.org
Fixes: f78ebca8ff3d6 ("iommu/msm: Add support for generic master bindings")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/iommu/msm_iommu.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..1dbb8b0695ec 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -617,23 +617,17 @@ static int qcom_iommu_of_xlate(struct device *dev,
 {
 	struct msm_iommu_dev *iommu;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
-			break;
-
-	if (!iommu || iommu->dev->of_node != spec->np) {
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	insert_iommu_master(dev, &iommu, spec);
-fail:
+		if (iommu->dev->of_node == spec->np) {
+			insert_iommu_master(dev, &iommu, spec);
+			spin_unlock_irqrestore(&msm_iommu_lock, flags);
+			return 0;
+		}
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
-	return ret;
+	return -ENODEV;
 }
 
 irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
