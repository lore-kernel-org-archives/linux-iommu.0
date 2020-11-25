Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE3C5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:11:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A266E21D7F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTmPpz/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6899986E0D;
	Wed, 25 Nov 2020 10:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kn6-vyLjgfEC; Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C884286E0C;
	Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A73FAC1D9F;
	Wed, 25 Nov 2020 10:11:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E5DAC0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7CDA086BA1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WnNYsXjpdlKI for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3E3986B89
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:51 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id w187so1853927pfd.5
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=toapRqQqRGs9x7o2KwSF6rY51ZrkrSfT/AsrgzJ6gOM=;
 b=QTmPpz/TMCBzqxaF/voXER8FjZCtSFUVivXTnfgYi4MuRvCBjP/nhjlgWyN2d3A/F6
 fhkRcchaEkr6jjawBJYTedi2nIeT0mgad5RfGMjV8xOu/5P2KDKylbo1WENBm2BPd/+R
 aPJbF2hqCPQc/c+hvYIb/bzi4lLhN9hr2mdo+HlIIbjOeoip55jDTgkqjunT3Z1cDGi1
 T1Z5eKRbUrbgF/7p6J/cnd86/f8TAFZdTBtJnju2LHQxMRNdxxk6wCFpqEZUxeKFqwYY
 CXKBMx0X4kU57H94XvVYPja7m6U2eunRphYMeP+/PUAg/4yMSL54LVexvZyAOBH7D9Og
 2HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=toapRqQqRGs9x7o2KwSF6rY51ZrkrSfT/AsrgzJ6gOM=;
 b=ZJva54M1kpEeIZpRxivqZgnglBJEG5BXyluex4KtM3QG9dGxELFkWa+d0+8MM6CZ0x
 zWDZQHQzVSpxqTPk8L94HJlC/AoRmOo8J4YQK3ui7v+yHD3kjRQEOD7JXQIdqdEyrWal
 RWpQSXG33subopHaN2SsrDgryiQEkd1C2uPRrbUffBTR/WgxU9DjOXw6oXFRpZzVbD2k
 fRMB404hAtHvWksLOKWWTNsbDxsCP0aIlrQtgnczN/hiDl2vs+mVDwXcoJ9P0P+BplH+
 auHxDAbGMH3rA9CuQGi86TSrR6Nra/AOw43nz5K73JCJwjWus3L/tFrX5+W5U2rsnmuK
 rwJQ==
X-Gm-Message-State: AOAM5337W9cz+doXeRXeT+EUNdm+Fg9YT6Yom8nyuSzEd88j5E+nZ4Ib
 lojDY7GWtWBNV/2D2uu0pL0=
X-Google-Smtp-Source: ABdhPJz+kgK1SKaSlG/GMd9ykGwk9JVNcMAReP3VoDPyzikb8KWLjFhUjCowmXvV+MgomXLlOPfcMw==
X-Received: by 2002:a63:5864:: with SMTP id i36mr2541877pgm.68.1606299111623; 
 Wed, 25 Nov 2020 02:11:51 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r130sm1599496pfc.41.2020.11.25.02.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 02:11:51 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: will@kernel.org
Subject: [PATCH RESEND v2 2/5] iommu/tegra-smmu: Expand mutex protection range
Date: Wed, 25 Nov 2020 02:10:10 -0800
Message-Id: <20201125101013.14953-3-nicoleotsuka@gmail.com>
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

This is used to protect potential race condition at use_count.
since probes of client drivers, calling attach_dev(), may run
concurrently.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ec4c9dafff95..6a3ecc334481 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -256,26 +256,19 @@ static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
 {
 	unsigned long id;
 
-	mutex_lock(&smmu->lock);
-
 	id = find_first_zero_bit(smmu->asids, smmu->soc->num_asids);
-	if (id >= smmu->soc->num_asids) {
-		mutex_unlock(&smmu->lock);
+	if (id >= smmu->soc->num_asids)
 		return -ENOSPC;
-	}
 
 	set_bit(id, smmu->asids);
 	*idp = id;
 
-	mutex_unlock(&smmu->lock);
 	return 0;
 }
 
 static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 {
-	mutex_lock(&smmu->lock);
 	clear_bit(id, smmu->asids);
-	mutex_unlock(&smmu->lock);
 }
 
 static bool tegra_smmu_capable(enum iommu_cap cap)
@@ -420,17 +413,21 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as)
 {
 	u32 value;
-	int err;
+	int err = 0;
+
+	mutex_lock(&smmu->lock);
 
 	if (as->use_count > 0) {
 		as->use_count++;
-		return 0;
+		goto unlock;
 	}
 
 	as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
 				  DMA_TO_DEVICE);
-	if (dma_mapping_error(smmu->dev, as->pd_dma))
-		return -ENOMEM;
+	if (dma_mapping_error(smmu->dev, as->pd_dma)) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	/* We can't handle 64-bit DMA addresses */
 	if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
@@ -453,24 +450,35 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	as->smmu = smmu;
 	as->use_count++;
 
+	mutex_unlock(&smmu->lock);
+
 	return 0;
 
 err_unmap:
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+unlock:
+	mutex_unlock(&smmu->lock);
+
 	return err;
 }
 
 static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 				    struct tegra_smmu_as *as)
 {
-	if (--as->use_count > 0)
+	mutex_lock(&smmu->lock);
+
+	if (--as->use_count > 0) {
+		mutex_unlock(&smmu->lock);
 		return;
+	}
 
 	tegra_smmu_free_asid(smmu, as->id);
 
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
 
 	as->smmu = NULL;
+
+	mutex_unlock(&smmu->lock);
 }
 
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
