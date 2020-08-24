Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FEC433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F9C2074D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiFL1Ay9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F9C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A4AB32155B;
	Mon, 24 Aug 2020 18:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uA36JoSChP3u; Mon, 24 Aug 2020 18:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D48D32094B;
	Mon, 24 Aug 2020 18:43:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1FB9C016F;
	Mon, 24 Aug 2020 18:43:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29E92C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 18FB485D40
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvPMIfXfYPjq for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:43:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8E87C85CFE
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:43:10 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id o13so5006164pgf.0
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORHfJz2e9TNUi11ClButtEprelkWs9RC+Iw7WuZZvQo=;
 b=QiFL1Ay9VZ+o7FljpSkk11RnZQkof5/enbgvZ9/7pqco8XN9U1Hp4Elf8D9nIZRA8C
 nGD5FCRG+OzA+aDgKTU0oOJMz4fa3mXl7u0lD7n28ZSbHqCti/Zt9QxkqsHpaM4NLC3o
 enFNf1XQmCmKZJIaP6vQYsb6HzRH3aKXBN4KuqFyPm4ANqDduI5Ao/TPi5ukL0LW4gBC
 5Uctli6acz1d1aIAAnhKPO5aVrIgSAIZBf3VtqRMv/BoPdq5cT0VOvc+6VYRRTGd2uh/
 5F8EkZDgWqrbkgaT3QhaajydJj2zkeaBerdXPu5aXqu0i6rs20/nOHeGwvzMmO/X3iAP
 0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ORHfJz2e9TNUi11ClButtEprelkWs9RC+Iw7WuZZvQo=;
 b=QJb9NDKUV6eSbp4czunWrwZJouu7BHDHzHBOvk1RNBLSohn/x/DyzdEnYMVpzRHNFP
 vzsRVpCYgz6fv/GdfJWCobDrak2x85R2MGSy9bf3Ul59TJp8LYMIZxn4ywx9xFAKuPsn
 qCfJqIaxJrczOI9cVSrj5v9BhVBcdrv/SqFKp0Prwoe/+oFufOGaidUeaG5nr+SYGkj8
 0jztpEADIpJiPoLuETdY5vmbbfOU8BJ0czwQyaGctJSRtt87GK8SHn7hJubzi1nJQy0t
 rAHs2Xxi7bhWFk/AzGMr5PoRLTZUrpu8FE9vsFxt0nj1BpMp0KvJ0lM1XS6BUTfdtBwx
 R88Q==
X-Gm-Message-State: AOAM53361r0RLvC6X0T9/1bRaUDgIB0WRGCZsM70OHIuITvbytOt96xV
 m07beu1b+DSAcB5byH9Mo6L901Ep2KBkDI/X
X-Google-Smtp-Source: ABdhPJwn5FgCJ9VyPOqih4HSDVzsr7XdR6VCZfi5iJqTQOJt7mF0wpqzXVZYMoaHoEoWg8tPnsqkYA==
X-Received: by 2002:a17:902:7b82:: with SMTP id
 w2mr4753119pll.39.1598294590126; 
 Mon, 24 Aug 2020 11:43:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id l5sm3347202pga.43.2020.08.24.11.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:43:08 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 19/20] iommu/arm-smmu: add a way for implementations to
 influence SCTLR
Date: Mon, 24 Aug 2020 11:37:53 -0700
Message-Id: <20200824183825.1778810-20-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Sibi Sankar <sibis@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Brian Masney <masneyb@onstation.org>,
 freedreno@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>,
 Stephen Boyd <swboyd@chromium.org>, John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

From: Rob Clark <robdclark@chromium.org>

For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
pending translations are not terminated on iova fault.  Otherwise
a terminated CP read could hang the GPU by returning invalid
command-stream data.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 5640d9960610..2aa6249050ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -127,6 +127,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
 		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
 
+	/*
+	 * On the GPU device we want to process subsequent transactions after a
+	 * fault to keep the GPU from hanging
+	 */
+	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
+
 	/*
 	 * Initialize private interface with GPU:
 	 */
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index e63a480d7f71..bbec5793faf8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= ARM_SMMU_SCTLR_E;
 
+	reg |= cfg->sctlr_set;
+	reg &= ~cfg->sctlr_clr;
+
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index cd75a33967bb..2df3a70a8a41 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
 #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
+#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
 #define ARM_SMMU_SCTLR_CFIE		BIT(6)
 #define ARM_SMMU_SCTLR_CFRE		BIT(5)
 #define ARM_SMMU_SCTLR_E		BIT(4)
@@ -341,6 +342,8 @@ struct arm_smmu_cfg {
 		u16			asid;
 		u16			vmid;
 	};
+	u32				sctlr_set;    /* extra bits to set in SCTLR */
+	u32				sctlr_clr;    /* bits to mask in SCTLR */
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
 };
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
