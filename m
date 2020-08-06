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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B420C433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C08823120
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs9jpI8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C08823120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A3E0C24B3A;
	Thu,  6 Aug 2020 15:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXtF6y8Y1lte; Thu,  6 Aug 2020 15:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DCF9620503;
	Thu,  6 Aug 2020 15:54:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D724FC0050;
	Thu,  6 Aug 2020 15:54:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95A0FC0050
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8331F88569
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YFXDMiSleyxG for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B49FC88557
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:13 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id c10so5803249edk.6
 for <iommu@lists.linux-foundation.org>; Thu, 06 Aug 2020 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ra7sVw9Kh8tnvSjnd2ltU1Y6A0f4SezxStS7Eqwdlew=;
 b=Fs9jpI8OHTh4O3JuPupPCNpWwqeLYfQD2fjFeknL5BDr+CNULtleTR0tWol603eVj6
 NKyM43EFuCaPg4TBGOWMMDkhUTiKmifeMRvGZGU0crlFI5VSbaMKhhAL1saOxcGBnYAh
 nxmhbDLNo/Enxwe7DP1p7cXw0JQ/iRw0c4XFEhzIkvW9D94JILDyac0EyfG3OPRwT3sL
 1AjMsQQ6T0nZoGYZOIZRqqggf7EsOe6BQPgbiwaMAowxYjl8eJ1SoKld2qm4jnfcwKhT
 WXAHNW8WklDB5zQJ1LD2MaoQST+mmigfIE8cMRas2B5KCvvpQBvrQ4B40g49IwG0xpLs
 4lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ra7sVw9Kh8tnvSjnd2ltU1Y6A0f4SezxStS7Eqwdlew=;
 b=sl/nKiQi5SJSuGXyrUwlarCS/o5y+vA9sIpjv6IRZOwSLBpPlH3XIYsePolOJrknWP
 tG34D7qj8mKmHIT7NeaqQoQQ3HoeK8hIO5bZuci5P5DgThss8X1RgSo3/Ddifc6rwm4S
 Kljnufl+2CuuI1KwHF4clsVFjjclY4o4wCzsMla1PLV6XqC9w9LMg2V4q6j/rPDXLrpF
 Jy1mP5gZv/QZK57GUlQhvXOCR85vnVfbxdsuLe0rTQ24BQEppBm/KjafY6tmgWTGiVuZ
 0Ps23FDW9NVpGpIbyKQCBGF+SZFyeAs2w4js1qjefOvS+4GF91T8dDFiEy/5do+To37l
 /8hw==
X-Gm-Message-State: AOAM530mGxx6GJt24KiXavjI9QALW+uQQmEOqKMQ1lV0ocAw/oKlURFE
 DlLVaUrJoZv6kCnEk7hK1gBRy4Bn
X-Google-Smtp-Source: ABdhPJzelerkywGQia0TyhZIDgT+LtbdW8VzQhBc+TGZg2GH9m2YlhlyWc0zGeZ8hdztDithEUrb1w==
X-Received: by 2002:a05:6402:308e:: with SMTP id
 de14mr4597139edb.344.1596729252218; 
 Thu, 06 Aug 2020 08:54:12 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id s21sm3892209ejc.16.2020.08.06.08.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:54:11 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/tegra-smmu: Balance IOMMU group reference count
Date: Thu,  6 Aug 2020 17:54:03 +0200
Message-Id: <20200806155404.3936074-3-thierry.reding@gmail.com>
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

For groups that are shared between multiple devices, care must be taken
to acquire a reference for each device, otherwise the IOMMU core ends up
dropping the last reference too early, which will cause the group to be
released while consumers may still be thinking that they're holding a
reference to it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1ffdafe892d9..c439c0929ef8 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -818,6 +818,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 {
 	const struct tegra_smmu_group_soc *soc;
 	struct tegra_smmu_group *group;
+	struct iommu_group *grp;
 
 	soc = tegra_smmu_find_group(smmu, swgroup);
 	if (!soc)
@@ -827,8 +828,9 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 
 	list_for_each_entry(group, &smmu->groups, list)
 		if (group->soc == soc) {
+			grp = iommu_group_ref_get(group->group);
 			mutex_unlock(&smmu->lock);
-			return group->group;
+			return grp;
 		}
 
 	group = devm_kzalloc(smmu->dev, sizeof(*group), GFP_KERNEL);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
