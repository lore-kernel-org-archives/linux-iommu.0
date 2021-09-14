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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988DC4332F
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B8761163
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39B8761163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15115607B5;
	Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zog5f8ERStxD; Tue, 14 Sep 2021 01:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7FC7607BC;
	Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB44C0020;
	Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7917CC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68731607B5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTy3vYOC5TEG for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6B47607BC
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so907696pjr.1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FAqoKbYCswJVkOTch12PwlqXExdb3kYI3vk6OlVyx9g=;
 b=gYBEGwhEWqK0u1Ir4IzJ5vtfdG6eyqheL1fWG7eZhyXjzYaRJuljD+x6xfVdsAcLy9
 w1nwv5KBwT13wTATYjeDWdrEnty6t1LzqTQXBPrWabwZOod9P3Zx4QnSSoWWez3kT4HN
 +dJXJ29R34Xr+qFuYOe5UxbVHWgqOOBrEaCb/qaACvNjZr3kHba+g3RsJPeiwdmRRV7r
 I7hJL8cz8fUphVmj6yqnXQNBMZC83hWrMxZXwLbwW1O13DUcTHt2T0ktb5Eh5CYEcl9T
 kVRkqNc0cFsKMq0UuUPUAEWzbfBhEX7y7/cCTaNExkd6lSjBGEjNmWsuq8BztNmvvtYm
 d6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FAqoKbYCswJVkOTch12PwlqXExdb3kYI3vk6OlVyx9g=;
 b=umaLKTZ3Ps5Zej3XnA2WwpBmtZelGfF+EMTfPR4UX+bN1npkl44xY2x/wtMQtCJJIg
 e+q/hTgKq7MQMSTgL2ttURA/u183McdVPxFjKFcJ2qyH81ndmwWZL+bNrl2trwuBlXaV
 WBdOtKq3CaPuaKFSIRnBpmBT4UGj/h+WHwQMw+sNjSEtLernRCfUBed5FJ4oGQAXsDXD
 WiC2hP8qeLKsRGHr7R8VMrLQnWQNNaeGLB1T7JIh9DM52ZOyDZEePJZLcunosOsPnUo2
 SbTxZujsyNaV8CUxqJ8KV5oOUjqrZWHhnxSWTjQORHzYuKQ2rNekRjopTWex0wjMEp/f
 viSA==
X-Gm-Message-State: AOAM531FinN1F/q3sJHYDy71Mjc+i25MLj7BdFQbR1aKm5DKmny71prq
 7VQRBfUGCcoVNnDUPLicbek=
X-Google-Smtp-Source: ABdhPJxT9Q+LrhFrM6LWf6ayAIEMVlks/2A/wH0cYC/M+Mdw1wQmAKPaZufoduY9WxdWoEVFb1jshg==
X-Received: by 2002:a17:902:a3cf:b0:13a:70c6:f911 with SMTP id
 q15-20020a170902a3cf00b0013a70c6f911mr12895659plb.42.1631584057258; 
 Mon, 13 Sep 2021 18:47:37 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:36 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 5/6] iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
Date: Mon, 13 Sep 2021 18:38:57 -0700
Message-Id: <20210914013858.31192-6-nicoleotsuka@gmail.com>
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

This could ease driver to access corresponding as pointer
when having tegra_smmu_group pointer only, which can help
new mappings debugfs nodes.

Also moving tegra_smmu_find_group_soc() upward, for using
it in new tegra_smmu_attach_as(); and it's better to have
all tegra_smmu_find_* functions together.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 94 +++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8fd4985ac91e..68c34a4a0ecc 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -24,6 +24,7 @@ struct tegra_smmu_group {
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *group_soc;
 	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_as *as;
 	struct iommu_group *grp;
 };
 
@@ -349,6 +350,19 @@ tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
 	return swgrp;
 }
 
+static const struct tegra_smmu_group_soc *
+tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < smmu->soc->num_groups; i++)
+		for (j = 0; j < smmu->soc->groups[i].num_swgroups; j++)
+			if (smmu->soc->groups[i].swgroups[j] == swgroup)
+				return &smmu->soc->groups[i];
+
+	return NULL;
+}
+
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 			      unsigned int asid)
 {
@@ -482,6 +496,57 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	mutex_unlock(&smmu->lock);
 }
 
+static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
+				 struct tegra_smmu_as *as,
+				 unsigned int swgroup)
+{
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_group *group;
+
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (!swgrp)
+		return;
+
+	mutex_lock(&smmu->lock);
+
+	list_for_each_entry(group, &smmu->groups, list) {
+		if (group->swgrp != swgrp)
+			continue;
+		if (group->as)
+			dev_warn(smmu->dev,
+				 "overwriting group->as for swgroup: %s\n", swgrp->name);
+		group->as = as;
+		break;
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+
+static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
+				 unsigned int swgroup)
+{
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_group *group;
+	struct dentry *d;
+
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (!swgrp)
+		return;
+
+	mutex_lock(&smmu->lock);
+
+	list_for_each_entry(group, &smmu->groups, list) {
+		if (group->swgrp != swgrp)
+			continue;
+		group->as = NULL;
+		break;
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -495,11 +560,15 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 		return -ENOENT;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
+		unsigned int swgroup = fwspec->ids[index];
+
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
 			goto disable;
 
-		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_attach_as(smmu, as, swgroup);
+
+		tegra_smmu_enable(smmu, swgroup, as->id);
 	}
 
 	if (index == 0)
@@ -509,7 +578,10 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 disable:
 	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		unsigned int swgroup = fwspec->ids[index];
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_detach_as(smmu, swgroup);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 
@@ -527,7 +599,10 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
 		return;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		unsigned int swgroup = fwspec->ids[index];
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_detach_as(smmu, swgroup);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 }
@@ -869,19 +944,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 
 static void tegra_smmu_release_device(struct device *dev) {}
 
-static const struct tegra_smmu_group_soc *
-tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
-{
-	unsigned int i, j;
-
-	for (i = 0; i < smmu->soc->num_groups; i++)
-		for (j = 0; j < smmu->soc->groups[i].num_swgroups; j++)
-			if (smmu->soc->groups[i].swgroups[j] == swgroup)
-				return &smmu->soc->groups[i];
-
-	return NULL;
-}
-
 static void tegra_smmu_group_release(void *iommu_data)
 {
 	struct tegra_smmu_group *group = iommu_data;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
