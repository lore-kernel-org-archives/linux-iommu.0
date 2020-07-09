Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB6C433E3
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C3E2070E
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQWuQBQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C3E2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2799B87BBF;
	Thu,  9 Jul 2020 05:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esru2qgfyZWm; Thu,  9 Jul 2020 05:01:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4321987A56;
	Thu,  9 Jul 2020 05:01:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33118C0865;
	Thu,  9 Jul 2020 05:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88B3EC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8488C87A39
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8XREi2Jnhy6Y for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:01:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A4C7D87A04
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:43 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id j19so431497pgm.11
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fL1oj/82czdR0WXUznCgbOV1KIBa6gJW0wdl0Fe8bqk=;
 b=YQWuQBQH2GSEZE8K4EI/Gew9fg1AI6MpHL0uRHUylnIff9sxijznzxDBhh0+EguiC3
 nPQaHnHAyeNKdx99gIzgFq3df+1a/ehZVV2I6ySRKyX3IfkQUfRsGNWC0w/WeiKfU6oi
 yzyYjpbROlG19Zuw4csOp62AY8ifnBblwcGo4ZHdYoUriQ3cGGw8mBKSAk+zOXqPJdFV
 MLjR1dq/Yv3w3bS11+j4uGeq0PZfwU88ItxE5IY5qbW/nMGO90Mk4xQjbm7W6Y8QozWe
 E+KYwEDC4Af+CwQl+dbh/ewI/SNpahBBYVME/IKZnlzjYbjUMqBTFdzzERsOBo1iCZuJ
 p7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fL1oj/82czdR0WXUznCgbOV1KIBa6gJW0wdl0Fe8bqk=;
 b=TNvRjDsu0mNLeBDJ0sbcLD5YGvBwB+4dWTNNqBIdVgedz663OIAOMwouPF6mbg2sm7
 K+fuFZBi95e/wiVHucxGjFMIRj/mLSDmlXztCt9I9nWcxRXHpIF38AjwRDQAn4vxAFfv
 pPoS2RhKuGDWzdtHHaGuW2JM7qPR7J+robYtjkUkSsiCN5Uvlhg7s22Ehlyst+/Ijgc+
 eF5a9QrRsbqKAoC9zDKjGxxIWfbCvAX1IGmN/yD7TKa9mmCwSzycQKn1paLdGUOWF+Km
 iBfiaEKWQTQUXaaTaFsZXtrlnnYt6VlyveRmVtM7sgPh0/vHllUUySC/COoDLjb+nqLP
 qE/g==
X-Gm-Message-State: AOAM531ALPOn8LAccu5Mo+yrzT1vpHGXQi3/f37W+VfqFaUdZqoTIfCS
 KuadEHnL0xUsGUoMlTwAh3HnDQ==
X-Google-Smtp-Source: ABdhPJyCvUhg3Z54pWl5PZR4ipfWmNp9zxcFYtuOj/BIJz3aWWsj8AWlwbK8reSTeGRPCPOiYOhZpQ==
X-Received: by 2002:a05:6a00:807:: with SMTP id
 m7mr58259929pfk.246.1594270903096; 
 Wed, 08 Jul 2020 22:01:43 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:42 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
Date: Wed,  8 Jul 2020 22:01:42 -0700
Message-Id: <20200709050145.3520931-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Marek <jonathan@marek.ca>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Some firmware found on various Qualcomm platforms traps writes to S2CR
of type BYPASS and writes FAULT into the register. This prevents us from
marking the streams for the display controller as BYPASS to allow
continued scanout of the screen through the initialization of the ARM
SMMU.

This adds a Qualcomm specific cfg_probe function, which probes the
behavior of the S2CR registers and if found faulty enables the related
quirk. Based on this quirk context banks are allocated for IDENTITY
domains as well, but with ARM_SMMU_SCTLR_M omitted.

The result is valid stream mappings, without translation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu-qcom.c | 21 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
 drivers/iommu/arm-smmu.h      |  3 +++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index cf01d0215a39..e8a36054e912 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -23,6 +23,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
 	{ }
 };
 
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	u32 reg;
+
+	/*
+	 * With some firmware writes to S2CR of type FAULT are ignored, and
+	 * writing BYPASS will end up as FAULT in the register. Perform a write
+	 * to S2CR to detect if this is the case with the current firmware.
+	 */
+	arm_smmu_gr0_write(smmu, last_s2cr, FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
+					    FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
+					    FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
+	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+		smmu->qcom_bypass_quirk = true;
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -61,6 +81,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 };
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2e27cf9815ab..f33eda3117fa 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -654,7 +654,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* SCTLR */
 	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
-	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
+	      ARM_SMMU_SCTLR_TRE;
+	if (cfg->m)
+		reg |= ARM_SMMU_SCTLR_M;
 	if (stage1)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
@@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	/*
+	 * Nothing to do for IDENTITY domains,unless disabled context banks are
+	 * used to emulate bypass mappings on Qualcomm platforms.
+	 */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
 		smmu_domain->smmu = smmu;
 		goto out_unlock;
@@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
 
+	/* Enable translation for non-identity context banks */
+	if (domain->type != IOMMU_DOMAIN_IDENTITY)
+		cfg->m = true;
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 	arm_smmu_write_context_bank(smmu, cfg->cbndx);
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be61..a71d193073e4 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -305,6 +305,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	bool				qcom_bypass_quirk;
 };
 
 enum arm_smmu_context_fmt {
@@ -323,6 +325,7 @@ struct arm_smmu_cfg {
 	};
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
+	bool				m;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
