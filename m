Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF0BC433EF
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 13:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60613827C6;
	Sun,  1 May 2022 13:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8NNVeJVzhYM; Sun,  1 May 2022 13:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 53189827A5;
	Sun,  1 May 2022 13:28:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09590C0039;
	Sun,  1 May 2022 13:28:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F36C002D
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 391B8827A5
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0ZQLXtN02IX for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 13:28:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21860827A1
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:28:31 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id z21so9928066pgj.1
 for <iommu@lists.linux-foundation.org>; Sun, 01 May 2022 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=x+vci/WgeFLOKqYpeTUy1SURtAS8ymBmeID88rAjgkc=;
 b=bM8iqxP4M9Z194v2N+8fzrKbhIUmYbFhD5PD/psBUU4LAYGEduO+ctl5Vq5fmJn3tL
 GKZzVDz+toPsKUYHhtTL6PCtbsDSEgmc4L9HQxSBTd0muq8GOwjCktlcdvB19nN9vYt3
 azAKSdiMTYT7vy2jZPdXkhesSJweTCbQIC8u8dtep/lbnvjAPVsW1h9ikPjxT5ZodDyj
 pBrNN6Y8NzJ9p/RY6gsAp5AjaUdklNYeuG7imrVtRIQjRjSu/TtBmNqIptBaCbxasYju
 u59C2FFF0vNYEluUavlH2QxrP14cGLsuDtB3UpT2NGjZAyUBm8RRo+ComzIci+RpDtUX
 ds+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=x+vci/WgeFLOKqYpeTUy1SURtAS8ymBmeID88rAjgkc=;
 b=NqAf8RkIGjHHmztp81ZyYY/UiLkHWhlNqWZuSflGapmSqlyrYXg6kPntGtovBXFB9Q
 815XW6PkyIEXUSVH6kPg9mSMLSqJbkFxaQa/Y3tVSAUI18AXKaiIQAZFJRAoaxiGRdXn
 TLP0gDBO69uCkzCHUOd4SewsOKfMp3Or10JGh1or4wKpjIS1pCZL/qbCk5WkHumuLiHL
 sxDtAXJUrLiPgh+ml++hom/rwH0ejH2dNbCRB+n3Q6vEe4elqbEcj3JpKNtypTk9gdbo
 Ek4yoYfdoDIJ74Y8eouCqbEUWpX9ebPDyAj0iP8IJ5jYgbjz1HZLNPMdqZiSt5E2TMRB
 ylZA==
X-Gm-Message-State: AOAM530DLehlWMgZ6HYUqI4gwR+4Uzmadislkfm5a0g1DaS8VFhtBuCi
 y7fFdE6k2JuZchr2bUU/qSs=
X-Google-Smtp-Source: ABdhPJzEhlGOrpTMwLWuERZKarhCsmpznSPi4Fgvsc3is6rS2xJrZLchrffVrkCQe5f9WqywiWcfqQ==
X-Received: by 2002:a63:1c0d:0:b0:3ab:1a76:953f with SMTP id
 c13-20020a631c0d000000b003ab1a76953fmr6142860pgc.73.1651411710432; 
 Sun, 01 May 2022 06:28:30 -0700 (PDT)
Received: from localhost.localdomain ([122.233.238.54])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a170902864500b0015e8d4eb229sm2877019plt.115.2022.05.01.06.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 May 2022 06:28:30 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 will@kernel.org, sricharan@codeaurora.org
Subject: [PATCH v2] iommu: fix an incorrect NULL check on list iterator
Date: Sun,  1 May 2022 21:28:23 +0800
Message-Id: <20220501132823.12714-1-xiam0nd.tong@gmail.com>
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

To fix the bug, use a new value 'iter' as the list iterator, while use
the old value 'iommu' as a dedicated variable to point to the found one,
and remove the unneeded check for 'iommu->dev->of_node != spec->np'
outside the loop.

Cc: stable@vger.kernel.org
Fixes: f78ebca8ff3d6 ("iommu/msm: Add support for generic master bindings")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v1:
 - add a new iter variable (suggested by Joerg Roedel)

v1: https://lore.kernel.org/all/20220327053558.2821-1-xiam0nd.tong@gmail.com/
---
 drivers/iommu/msm_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..41a3231a6d13 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -615,16 +615,17 @@ static void insert_iommu_master(struct device *dev,
 static int qcom_iommu_of_xlate(struct device *dev,
 			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_dev *iommu;
+	struct msm_iommu_dev *iommu = NULL, *iter;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
+	list_for_each_entry(iter, &qcom_iommu_devices, dev_node)
+		if (iter->dev->of_node == spec->np) {
+			iommu = iter;
 			break;
+		}
 
-	if (!iommu || iommu->dev->of_node != spec->np) {
+	if (!iommu) {
 		ret = -ENODEV;
 		goto fail;
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
