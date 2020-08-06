Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E097DC433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD1E23138
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EanimBfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD1E23138
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 820168831D;
	Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0G2WeFcStFOV; Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 184A588257;
	Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0628CC0050;
	Thu,  6 Aug 2020 15:54:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A19A1C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89B268814A
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hZYgAGY6Uaoi for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:54:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 99F0E882C5
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:15 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id g19so37041179ejc.9
 for <iommu@lists.linux-foundation.org>; Thu, 06 Aug 2020 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UHM7NrOeh2iQ0mr8lE8C+H1rDTyZhW846howQnzmmso=;
 b=EanimBfT/WgajAIB3u1A3iBG9JEfttCiNI4/b2mLS3LDpcOHaoEzg5NwcDZjwy3F/4
 2+8hqioyGVh8kPTtan451m+cp/w7HVWAJyFkATdglqDptfIe0noU9vsmxbhE0XQs4Xgq
 YmPniWhdRSYWx5q9UCbFxpkshPhhCmCPmbZQgTSlgOIrkGk8D0VeEAzu/BNVng2Yi/nm
 f6jh5Q+BS0E6exQaFrJPQSjTdk6N6WLlbzbSn/nQgLAPcoBByx/xymqjgDHVdRVtPWao
 KcsFRWzqK4IF+gLWeddZlORJsrz578WHCBcSAZkW6b/rnDiGLMPfRTdXpgFg8jTGPSJB
 ipRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UHM7NrOeh2iQ0mr8lE8C+H1rDTyZhW846howQnzmmso=;
 b=HqS3g2OkWgt4ze1PvMqEQM3A6YDc3HAGlD3m6HGHpXYXNY3yMxwBrme+4pfBI1D7tM
 T8v+FE8nWQ1MR/9UzXAU5g2EhmKmb0UZ+1dAoh9481NAAU9cD+aVq0qpRV62mXWVfi2P
 DU5MoySBUVrd073QPpmcd7zYSqJEFbAPKv0+zlUM+vFkWhAiPxsVqGtpCDkyOLY0MovA
 xjsbgvLLjg/U9oJE/OTFznvQcDakL/eSzgNY9N08JEvO8knvnrKnkwbGc0VVgZifjjt3
 DLaUBRF2gfhW9Fh8yY4fEkTZCQGESMs3I9Cdfcx+f2SLVi0cLSyCBnnuk5cIwRrZawCe
 xQUA==
X-Gm-Message-State: AOAM533B67zhggkMeQzoLukm3MCUKUUAqTdJ6+4JpwEgPCg4Uklr0TFT
 bnAbqGTXQuSaJQQzzegOv8c=
X-Google-Smtp-Source: ABdhPJyS5VFo4rwNX3VlJZqao9YiV3jX+fDzIHN5dP0+0vpr5zAZ6By09k6fuYjcdV0RfC2TVc5ZHg==
X-Received: by 2002:a17:906:3756:: with SMTP id
 e22mr5204598ejc.487.1596729254164; 
 Thu, 06 Aug 2020 08:54:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id g25sm3955136ejh.110.2020.08.06.08.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:54:13 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] iommu/tegra-smmu: Prune IOMMU group when it is released
Date: Thu,  6 Aug 2020 17:54:04 +0200
Message-Id: <20200806155404.3936074-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806155404.3936074-1-thierry.reding@gmail.com>
References: <20200806155404.3936074-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>
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

From: Thierry Reding <treding@nvidia.com>

In order to share groups between multiple devices we keep track of them
in a per-SMMU list. When an IOMMU group is released, a dangling pointer
to it stays around in that list. Fix this by implementing an IOMMU data
release callback for groups where the dangling pointer can be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c439c0929ef8..2574e716086b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -19,6 +19,7 @@
 
 struct tegra_smmu_group {
 	struct list_head list;
+	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
 	struct iommu_group *group;
 };
@@ -813,6 +814,16 @@ tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
 	return NULL;
 }
 
+static void tegra_smmu_group_release(void *iommu_data)
+{
+	struct tegra_smmu_group *group = iommu_data;
+	struct tegra_smmu *smmu = group->smmu;
+
+	mutex_lock(&smmu->lock);
+	list_del(&group->list);
+	mutex_unlock(&smmu->lock);
+}
+
 static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 						unsigned int swgroup)
 {
@@ -840,6 +851,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	}
 
 	INIT_LIST_HEAD(&group->list);
+	group->smmu = smmu;
 	group->soc = soc;
 
 	group->group = iommu_group_alloc();
@@ -849,6 +861,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 		return NULL;
 	}
 
+	iommu_group_set_iommudata(group->group, group, tegra_smmu_group_release);
 	iommu_group_set_name(group->group, soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
