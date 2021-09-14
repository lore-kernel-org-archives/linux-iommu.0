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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A8C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E65861163
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E65861163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D29FC402EB;
	Tue, 14 Sep 2021 01:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDqlrJNpUaau; Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 62000402E3;
	Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D10C001C;
	Tue, 14 Sep 2021 01:47:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 019D1C0020
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8B0D60625
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVZF85sxH2vH for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EF106060F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id v1so7099020plo.10
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xhb7cG3FXLCm4Z4ICTIF/90XZZ6Iro0K8KQdd4HxIGM=;
 b=oyvnmQsT6ijC+1swiq+sqhrVa5AexA4umH9CBR38uH4E/+jZZwyQo2toADpiASMjuu
 dhN8yI365m8nZQrWEgr4jlc710taZgYjho0HvXjQy73XjmDVNHtNNbO7SkUWHlSBUsVO
 rnmDRcBU75l2+ZhCVvceWxV39vP0vBXCiNBu4vijxZFWTUA3zHQsoGnWPh7V9xB4/BR6
 Y6b3yAEWpE/EWnRzF99ATWgPbvK3HXvzVr7CZSRiGcr9rlC/z168tqDvjlEqcs2b0wrN
 j0vYkXceL8Yp2sm0fhx22f1nml2u1oqipq69MRWGcTHjtSr0yPx5sYtmAMFy+sdxAIpQ
 +ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xhb7cG3FXLCm4Z4ICTIF/90XZZ6Iro0K8KQdd4HxIGM=;
 b=ku2Zxb0on60wpL3c0w4FKd52dxcd90kr+5QscFGDv08FYTEa4SAaGHfGw9hlm7rJSn
 Un4nMgBsq0uzAcY84Ok5wjPB8+VtiywzHKJZbP5tuq3AHyuaBNtWVBXXhBB5T29m5cCh
 zCivLLfENVmRQpZpH0oy0SY9c8prQXClE6t0LGHBfhQ70F8/Wudjzo1wy7BdoGIK/b+C
 V5iYMsfu0AYxrnY+v51m3r01F7wp5mIUXElvGkPK0LI3nxNlIOW3HwE2VjZKBkz+yznK
 jN+iHIqQYdfNvLBsqhmoortuW4cvaPFVES8G1Zn58dXk49mP4tM05OKBc0bBbojb4xiU
 zqxw==
X-Gm-Message-State: AOAM532xgXAiB50tWO8CU+5RShi8TY3ln3kx1qedyT4Ra14sgug5xIsP
 P+9EFOFcmwkUJQWHCW7QJYk=
X-Google-Smtp-Source: ABdhPJy94W1uW8sDKMd+DL+UWEzsAJK+kPnDL/7sqvbVJu0v/fitkXT3dDLg0zdzMQXvpqOdFhB+1w==
X-Received: by 2002:a17:90a:8817:: with SMTP id
 s23mr2663594pjn.181.1631584054659; 
 Mon, 13 Sep 2021 18:47:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:34 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 3/6] iommu/tegra-smmu: Rename struct tegra_smmu_swgroup
 *group to *swgrp
Date: Mon, 13 Sep 2021 18:38:55 -0700
Message-Id: <20210914013858.31192-4-nicoleotsuka@gmail.com>
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

There are both tegra_smmu_swgroup and tegra_smmu_group structs
using "group" for their pointer instances. This gets confusing
to read the driver sometimes.

So this patch renames "group" of struct tegra_smmu_swgroup to
"swgrp" as a cleanup. Also renames its "find" function.

Note that we already have "swgroup" being used for an unsigned
int type variable that is inside struct tegra_smmu_swgroup, so
it's not able to use "swgroup" but only something like "swgrp".

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index a32ed347e25d..0f3883045ffa 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -334,35 +334,35 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static const struct tegra_smmu_swgroup *
-tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
 {
-	const struct tegra_smmu_swgroup *group = NULL;
+	const struct tegra_smmu_swgroup *swgrp = NULL;
 	unsigned int i;
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
 		if (smmu->soc->swgroups[i].swgroup == swgroup) {
-			group = &smmu->soc->swgroups[i];
+			swgrp = &smmu->soc->swgroups[i];
 			break;
 		}
 	}
 
-	return group;
+	return swgrp;
 }
 
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 			      unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -385,17 +385,17 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 			       unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value &= ~SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	}
 
 	for (i = 0; i < smmu->soc->num_clients; i++) {
@@ -1008,11 +1008,11 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 	seq_printf(s, "------------------------\n");
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
-		const struct tegra_smmu_swgroup *group = &smmu->soc->swgroups[i];
+		const struct tegra_smmu_swgroup *swgrp = &smmu->soc->swgroups[i];
 		const char *status;
 		unsigned int asid;
 
-		value = smmu_readl(smmu, group->reg);
+		value = smmu_readl(smmu, swgrp->reg);
 
 		if (value & SMMU_ASID_ENABLE)
 			status = "yes";
@@ -1021,7 +1021,7 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 
 		asid = value & SMMU_ASID_MASK;
 
-		seq_printf(s, "%-9s  %-7s  %#04x\n", group->name, status,
+		seq_printf(s, "%-9s  %-7s  %#04x\n", swgrp->name, status,
 			   asid);
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
