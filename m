Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D140C43219
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D995061163
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D995061163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B182780C3D;
	Tue, 14 Sep 2021 01:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXt1oxrUYAvN; Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 881D680C47;
	Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65DF9C000F;
	Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35348C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 142FB60625
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yUQBvPSkP6ax for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E4DA607BC
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:36 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id n18so7099444plp.7
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=02zpobwAZVhWVn00LMms1NVtUxIVvNcwQuQFmSxJIqI=;
 b=M8/sQJUs7N0OzKAY2DCxmlR3GBYs564L5za5zK+jgohVNjpkEz9fDPK98ZlYo+HNz6
 MRFzbV6KIn/tabOHKL731eSAmF+AIfk4kDVz9a0PaNG55aoaM/uCDVrx8qur3BNHAbzZ
 153EIoC1tpGwBa0H/xUdaDcJfzRA3L7Z59xGcExZuvbwtPSufqn0e9JGcNWv7jCkHwjw
 Z46rBci5kjqQWgI2zDxu5X/o43eX242FIz2McM4E1ERCWeHiFZgWOySfBZzL8LMGdXz+
 jMomLaTp64UjH/PuxjrnfpU8xDaawmyktizjG/8BhybHRFPuWNYqwQZX6gG4EROCnsEk
 XAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=02zpobwAZVhWVn00LMms1NVtUxIVvNcwQuQFmSxJIqI=;
 b=kOqmFE61MnGkoZRSJO6t1on3HPgnpaFFD9208G7VKJKXpYyvYMO0XhFbox7bIjglDu
 UuvNCAYoob9mk2jyr9JibDcT3YOig+a7mZImwS5AwWdEZB7Xt64a4vLRLmDSzFNtsVn7
 1uzUhmMf1eDAN5na9TxOBnHaeUWWdvgpT1Z1ZN1Jx1YFD9R4tw+pwnSLn1T5nvjrkP0P
 LyZKlJAvk0RIlW6+bxrCRNtzRDlONm0+Ova5ioJTEQcK3S/PwGjzQgfQM/8VVoRFDQ4S
 4Rug2h/oifC62gScRACVXdLYGFlz19H6vzqRg6djLHXaM3ZzTZXn9GOBJ4jgJG/frMCc
 4yYQ==
X-Gm-Message-State: AOAM533LDibB7K+aTvJWuSheL0BgTIlHjZzPBcDJVdZcU+B6UY08db1R
 ormOAfKK5y0Y1V16Bb80kYQ=
X-Google-Smtp-Source: ABdhPJz9jZlUnUZZrh3YG7ZA9O9HOg258enmoLZYvhKmRZNv133D2M10B9pFlaaXalDO9KLxJ8TdmQ==
X-Received: by 2002:a17:90a:9706:: with SMTP id
 x6mr2664790pjo.81.1631584055880; 
 Mon, 13 Sep 2021 18:47:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:35 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 4/6] iommu/tegra-smmu: Use swgrp pointer instead of swgroup
 id
Date: Mon, 13 Sep 2021 18:38:56 -0700
Message-Id: <20210914013858.31192-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914013858.31192-1-nicoleotsuka@gmail.com>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

This patch changes in struct tegra_smmu_group to use swgrp
pointer instead of swgroup, as a preparational change for
the "mappings" debugfs feature.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0f3883045ffa..8fd4985ac91e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -23,8 +23,8 @@ struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *group_soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	struct iommu_group *grp;
-	unsigned int swgroup;
 };
 
 struct tegra_smmu {
@@ -897,18 +897,22 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	const struct tegra_smmu_group_soc *group_soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+
 	/* Find group_soc associating with swgroup */
 	group_soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
-	/* Find existing iommu_group associating with swgroup or group_soc */
+	/* Find existing iommu_group associating with swgrp or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if ((group->swgroup == swgroup) ||
+		if ((swgrp && group->swgrp == swgrp) ||
 		    (group_soc && group->group_soc == group_soc)) {
 			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
@@ -923,7 +927,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 
 	INIT_LIST_HEAD(&group->list);
 	group->group_soc = group_soc;
-	group->swgroup = swgroup;
+	group->swgrp = swgrp;
 	group->smmu = smmu;
 
 	if (dev_is_pci(dev))
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
