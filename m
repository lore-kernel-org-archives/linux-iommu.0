Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC82C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940692075A
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inevjptb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940692075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F7D886DA1;
	Fri, 11 Sep 2020 07:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIMZTfb0XDoj; Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DF4A86AAA;
	Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C82C0052;
	Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CFB5C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47CB38770E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id htEgoH2uJfXj for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7CD6987740
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:01 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id d6so6601342pfn.9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SS7jLbqMqo7oAIExIEmTdCQZIIujYEeMEKPzckwgOOc=;
 b=InevjptbbgvQ9h7Iyupif311WbVVYkJoovS5NtNBAZUpv+hJ+zfqvCsdzptDDDruor
 6IDBuQHCA7/TgfTD5CDBKJ3O0kqDVHJb9tApHoScRDHil3iMCL/Hns2vP1HOZk3mf45A
 hcx3d7tI3fITed6XgZdYLMuMj/An3/OK2jriLAqsYq8/zdun2109NEluu0z0wB2gPC3k
 lV8g/q9/jn3dRqkNk5DA8lnEVnqzqDJBoX6psH8H3nOMYmhcSa3/spdhunDwws5NYG19
 XuDDrRtvNnnXpKSW4p/9B+x8+/Eo7M2R+f8Wqwtar5JQGNh7q3Mcs1xpDHF8A0kMDyc3
 oBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SS7jLbqMqo7oAIExIEmTdCQZIIujYEeMEKPzckwgOOc=;
 b=bklHyZ2D3TAmBLMbDvQQAc2V0yQfrgRYbJ+Qg7SkdyBM1xIB51CnuPV5DjipUAycKu
 dSntBPk+ua9R2eSODIXvLyqyIfMy89Tx4WdSErmqfba+2uqtuCzpFmjvNrYNwR3qxLEP
 HQMhK9JdZDMSc/A8yaxpPC68F48wWVYwKGD6D9vftjfZ3+KzFD9T9PhJfe7WOH1Pivx5
 0Om+1Xp3c6G2Ow5vh63zSuqTyP0S3U9o3zmn7ddkc0rGUmRAJldcZ6NfcxBkgSaWEygR
 nbB0AImNH8XTIkhyBVt1keXij6ImrjYgtEK3WTYHnMpav3ceOUeWQqSWvX5d7/QNCcfW
 vbeg==
X-Gm-Message-State: AOAM531ggAJ1izfBWJR3qYgaYcL0z55eL1uT0e4NGp8+A156oj4rDSn6
 FHSDLVCq/u1ExkDPR5oHJtk=
X-Google-Smtp-Source: ABdhPJxDnur/DWFdvxSNIUQJ+nJ1mk1yUkPO5xqZL5sS/HV+nD5vZh/pEnxJKHg5E+09d+0dPkUbxQ==
X-Received: by 2002:a17:902:bccb:b029:d1:9bf7:22f4 with SMTP id
 o11-20020a170902bccbb02900d19bf722f4mr1066840pls.27.1599808741034; 
 Fri, 11 Sep 2020 00:19:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com
Subject: [PATCH 3/3] iommu/tegra-smmu: Allow to group clients in same swgroup
Date: Fri, 11 Sep 2020 00:16:43 -0700
Message-Id: <20200911071643.17212-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

There can be clients using the same swgroup in DT, for example i2c0
and i2c1. The current driver will add them to separate IOMMU groups,
though it has implemented device_group() callback which is to group
devices using different swgroups like DC and DCB.

All clients having the same swgroup should be also added to the same
IOMMU group so as to share an asid. Otherwise, the asid register may
get overwritten every time a new device is attached.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 50b962b0647e..84fdee473873 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -23,6 +23,7 @@ struct tegra_smmu_group {
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
 	struct iommu_group *group;
+	unsigned int swgroup;
 };
 
 struct tegra_smmu {
@@ -909,14 +910,14 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	/* Find group_soc associating with swgroup */
 	soc = tegra_smmu_find_group(smmu, swgroup);
-	if (!soc)
-		return NULL;
 
 	mutex_lock(&smmu->lock);
 
+	/* Find existing iommu_group associating with swgroup or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if (group->soc == soc) {
+		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
 			grp = iommu_group_ref_get(group->group);
 			mutex_unlock(&smmu->lock);
 			return grp;
@@ -929,6 +930,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	}
 
 	INIT_LIST_HEAD(&group->list);
+	group->swgroup = swgroup;
 	group->smmu = smmu;
 	group->soc = soc;
 
@@ -940,7 +942,8 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	}
 
 	iommu_group_set_iommudata(group->group, group, tegra_smmu_group_release);
-	iommu_group_set_name(group->group, soc->name);
+	if (soc)
+		iommu_group_set_name(group->group, soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
