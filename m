Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F94C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BF260FDA
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19BF260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A99480C52;
	Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srviycQ4Zs7T; Tue, 14 Sep 2021 01:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 721D580C43;
	Tue, 14 Sep 2021 01:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 035F0C0021;
	Tue, 14 Sep 2021 01:47:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB2AC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F7AF403A9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AjRC3VTluEKY for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F23C403A7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:33 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 me5-20020a17090b17c500b0019af76b7bb4so223869pjb.2
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ew5xnrmFyu+fk66c1OetwqTjwKScTVybyCHV7UWwEpc=;
 b=YcKo+sUe+EYHZIUMHNG7ZJI7GBkp0MTRQfxFZdB0AC1JwnMTR0Sr1bJpkqLpTKAbDK
 wz2cZJ1a1RA/4LJE6bVb4Ixu05pAa9il4QBoVc7+NlQkMxYHW98JEgMneaEwyfbxZTco
 MNeQMpWYYnP76+jbWrFWGjssmC8P+qmLARFU1ryZnSglplkND0bn8s8gYOZ1ZcbPcZlE
 Y7GbJrq12e2MCnLarQgYEhdytygBKtEnS3ZNJ7zP4cZr9VVCugP6vdF7smv900OOwYsf
 7YPVGDLtZeFCWTd+XfH+7Ivz9Ac07TGKWxtZ4emGi/KGW1EbydMllzJeDcds0MOUAoFI
 YlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ew5xnrmFyu+fk66c1OetwqTjwKScTVybyCHV7UWwEpc=;
 b=1sC/lFvQNSrpM6xxlwFO6SjayDp7M8B+ZGU6jpxI/5Vxa/jbaxJa09hxUA9umOSxGI
 KWvEpfK0fz5bNUF3AYY1mCx0bhOoUqiej4VdzDLvK/ByPm3ZjB92EEs0CzsqdW6Qowi9
 bQEAa2HzO2qIZuCH894MbrKTgRTsThNwUA5mRYIUCsNE/ErdCLMVXvcpUHRDb/PLNAzM
 UH8Uq7cKLxE1TvTSCfK/+emGhJGdnDJp6e0BBFn90KE/owGQ5tqaiOKEMVquuSnX6Cni
 6VTydAEqTAbH6uA5MyTvthPx/DsXww4KYOpuECBwOjTtgE7hsnRWDVGUXeqkWR8TBd3y
 YhUA==
X-Gm-Message-State: AOAM533RlQzlGhqjs4O9fElSGbTUayrN5LzUh6S9ShoF/c+DYbZhYs7R
 l9RdiBv/YLhbT0ZRPmFBXMk=
X-Google-Smtp-Source: ABdhPJz7BqdhfAZPs7FKLDYKdrJbKTyffDe+Klcpi+4VxK3njmKpExDvslcVyriST0b3DKxShE71sA==
X-Received: by 2002:a17:90a:53:: with SMTP id 19mr2680037pjb.159.1631584053481; 
 Mon, 13 Sep 2021 18:47:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:33 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 2/6] iommu/tegra-smmu: Rename struct tegra_smmu_group_soc
 *soc to *group_soc
Date: Mon, 13 Sep 2021 18:38:54 -0700
Message-Id: <20210914013858.31192-3-nicoleotsuka@gmail.com>
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

There are both tegra_smmu_soc and tegra_smmu_group_soc using "soc"
for their pointer instances. This patch renames the one of struct
tegra_smmu_group_soc from "soc" to "group_soc" to distinguish it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6ebae635d3aa..a32ed347e25d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -22,7 +22,7 @@
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
-	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_group_soc *group_soc;
 	struct iommu_group *grp;
 	unsigned int swgroup;
 };
@@ -870,7 +870,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 static void tegra_smmu_release_device(struct device *dev) {}
 
 static const struct tegra_smmu_group_soc *
-tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
 {
 	unsigned int i, j;
 
@@ -896,19 +896,20 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
-	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_group_soc *group_soc;
 	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
 	/* Find group_soc associating with swgroup */
-	soc = tegra_smmu_find_group(smmu, swgroup);
+	group_soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
 	/* Find existing iommu_group associating with swgroup or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
+		if ((group->swgroup == swgroup) ||
+		    (group_soc && group->group_soc == group_soc)) {
 			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
 			return grp;
@@ -921,9 +922,9 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	}
 
 	INIT_LIST_HEAD(&group->list);
+	group->group_soc = group_soc;
 	group->swgroup = swgroup;
 	group->smmu = smmu;
-	group->soc = soc;
 
 	if (dev_is_pci(dev))
 		group->grp = pci_device_group(dev);
@@ -937,8 +938,8 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	}
 
 	iommu_group_set_iommudata(group->grp, group, tegra_smmu_group_release);
-	if (soc)
-		iommu_group_set_name(group->grp, soc->name);
+	if (group_soc)
+		iommu_group_set_name(group->grp, group_soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
