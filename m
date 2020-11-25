Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B0C56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:11:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6A1208B8
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6nUj0KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6A1208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7056E86E20;
	Wed, 25 Nov 2020 10:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W031mmdGNGPE; Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90E4686E04;
	Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74715C0052;
	Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CEEAC0891
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 76EC786E0C
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OyQystrHDgva for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:11:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C7ABF86E04
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:50 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id q10so1878448pfn.0
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 02:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZwD1ohCfAW402dFGnNEhoT+UZSg/Ym6HaUWM7XjPb6E=;
 b=b6nUj0KM55Y0PVBvob1TXOFsayKdQ6c2UoMg//1VHDUIkcyBQB5iKg8uMrUTBhx38t
 MEYFrzymL6aeb5hNEihOquS2P8aXpGy/AwQwVg1MKuqOTxORVZXaIk1A/3E3QIoL8lHC
 ziwT2GhsZdWVKiKXOKaxF5pYou0afT4ThyhjXpt43mvPLpBMFL/so7v4ci0hV9IrIbr8
 Q9kD2BvbxdEmCJmhgTymRNgi/4ft+Z2KOqqs6/G2QI6SpEvJdNI22WtQd2AKg5iEVO/n
 Kr71Qh/WKWk/FKlFRmgEgW/dhKFfY4wzsb44zi+Lvltvtd9GeB8NkddrGnk75FLpEefL
 q7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZwD1ohCfAW402dFGnNEhoT+UZSg/Ym6HaUWM7XjPb6E=;
 b=JYFSYKWSInSnN65DtxZUzvHaiFdb9y7TJh6imidJApJ/KFjgOre5BXBPJCF5zXzqNf
 daAs/uOZ1sgBn9yVF6c/mfu7KkNuCtPi6d+RqEGU2ZFtgInzOx12Xgre/dJO4CwfBUQ2
 bBZHjpCtdgxLlCX4OgJL3UWMEwXv6zeNKgFzOZuDLZbnp3GcAV+Myb3Nanuz97YkV5tU
 Z9pFhcWF5e37GdyYiiDLFk3kbfcmPIgqIX0vTgY9Dqw8Sc6/moysDUpk5hDY2IjTb5xR
 vBfmlXSfWnrr/1HFhprNiA2erdkLonVtluR8uUCu4dgPIzsY+RnKbB1zNcKWijcfWkhp
 IuQw==
X-Gm-Message-State: AOAM532Q3NzjNih6unz4KDlswLoO3yV+Doqxcd2VgDfTpKIayPzhFLhM
 hCYWH5wQNhHLpYkTPAvkr9ZbFAuFnOuxtg==
X-Google-Smtp-Source: ABdhPJzXq9plSmgdN0gkNTqyIlIJeAiNGmi+jhJigzBpoKf/a6q9hsHbjDMmyGkoPqsJhmVvDq95oQ==
X-Received: by 2002:a65:404b:: with SMTP id h11mr2437208pgp.379.1606299110454; 
 Wed, 25 Nov 2020 02:11:50 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r130sm1599496pfc.41.2020.11.25.02.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 02:11:50 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: will@kernel.org
Subject: [PATCH RESEND v2 1/5] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
Date: Wed, 25 Nov 2020 02:10:09 -0800
Message-Id: <20201125101013.14953-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125101013.14953-1-nicoleotsuka@gmail.com>
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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

The tegra_smmu_group_get was added to group devices in different
SWGROUPs and it'd return a NULL group pointer upon a mismatch at
tegra_smmu_find_group(), so for most of clients/devices, it very
likely would mismatch and need a fallback generic_device_group().

But now tegra_smmu_group_get handles devices in same SWGROUP too,
which means that it would allocate a group for every new SWGROUP
or would directly return an existing one upon matching a SWGROUP,
i.e. any device will go through this function.

So possibility of having a NULL group pointer in device_group()
is upon failure of either devm_kzalloc() or iommu_group_alloc().
In either case, calling generic_device_group() no longer makes a
sense. Especially for devm_kzalloc() failing case, it'd cause a
problem if it fails at devm_kzalloc() yet succeeds at a fallback
generic_device_group(), because it does not create a group->list
for other devices to match.

This patch simply unwraps the function to clean it up.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0becdbfea306..ec4c9dafff95 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -903,10 +903,12 @@ static void tegra_smmu_group_release(void *iommu_data)
 	mutex_unlock(&smmu->lock);
 }
 
-static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
-						unsigned int swgroup)
+static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	const struct tegra_smmu_group_soc *soc;
+	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
@@ -950,19 +952,6 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	return group->group;
 }
 
-static struct iommu_group *tegra_smmu_device_group(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
-	struct iommu_group *group;
-
-	group = tegra_smmu_group_get(smmu, fwspec->ids[0]);
-	if (!group)
-		group = generic_device_group(dev);
-
-	return group;
-}
-
 static int tegra_smmu_of_xlate(struct device *dev,
 			       struct of_phandle_args *args)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
