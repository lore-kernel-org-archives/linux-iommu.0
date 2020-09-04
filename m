Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E47C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C597E20770
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMAZ1OmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597E20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 977D786E41;
	Fri,  4 Sep 2020 15:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7ex6Jtn3JzL; Fri,  4 Sep 2020 15:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C69786E3C;
	Fri,  4 Sep 2020 15:55:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDFE6C0052;
	Fri,  4 Sep 2020 15:55:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB23C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A60286EC4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkNgLRxyVKou for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 907ED86EBA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id g72so6691396qke.8
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h5uFJW/6fnBFkfrDyRmkYDvlEgZwoUK08VgApDtVqc4=;
 b=EMAZ1OmDd9nFxAqWSODUqd6ceL4IsY1y8RrE5+ltjJztLmCsfdK71uf11dSoSWqOnM
 +Vf02d28fy9I9YsR1nQ7rdmtNQOhU0RUIiz0nUe1mAlTGhDTNejFezB45NW1a4VTvvMD
 8WiPfcmusc0d8CXGgs5v/AE3QiD95HlLyMUguYboj2GCrTgwWRVv4m+kMRk80d1YplUY
 iuW0wy4mPHUz+wbqG4brFkrRDerbs0AGM/WIY+6jerzDQO2wg3Io8Z3JmTbseq4TEXj2
 PIkwmPlXmcW4PDhpX2okwL9LtgyE5EHxoQlG+xJLoGcSyTuV4kTY00rRMvHJIAl04nWy
 MC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h5uFJW/6fnBFkfrDyRmkYDvlEgZwoUK08VgApDtVqc4=;
 b=l1vhaUn0InheLWUFXWJKbW/+6p9/3Q5nEhu0lY+MYBJSzECRJakYXr9uFWG1Mjh4eR
 5I2aeFue2iBAAjQBS1HMxaRJTTvH0nq71csAFx+J0J95Mxg07Jl3pAw1foOdiU7GMeiE
 UIKdQrLEndliou7Ga5ifakAeFBeXdt8gBuIIOF9mCKqFSVDE86yjkiriwRuPw9jpnObu
 rB4TLRl+P2lnMMDIOf7v3b5uiPjMviT0J84L0e+I3bA6H/4TvbOqDqBVgEo9onqdzkdH
 YPNhTIfJtS0YmQs8cJ5wWb/xZL2fdvHtl4AYYuL3QbKihatPBd8qUGw7DZtDxjQps7ff
 Rkbg==
X-Gm-Message-State: AOAM532HjOMygunR5+yFpH6DDZ0L8a0/siWNUyTHfp4xyaEXloNuPTwo
 Fxq5WoYjFRLa/0o545nx1WwbaA==
X-Google-Smtp-Source: ABdhPJxd7USRDl6Yb7MfgkAYxzICxZXDUshL8k4VKasevb5x6VcguJCsqPzZGsq59oyACgW/0jcFqg==
X-Received: by 2002:a37:e502:: with SMTP id e2mr8513643qkg.141.1599234918474; 
 Fri, 04 Sep 2020 08:55:18 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:17 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 3/8] iommu/arm-smmu: Consult context bank allocator for
 identify domains
Date: Fri,  4 Sep 2020 15:55:08 +0000
Message-Id: <20200904155513.282067-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

For implementations of the ARM SMMU where stream mappings of bypass type
are prohibited identity domains can be implemented by using context
banks with translation disabled.

Postpone the decision to skip allocating a context bank until the
implementation specific context bank allocator has been consulted and if
it decides to use a context bank for the identity map, don't enable
translation (i.e. omit ARM_SMMU_SCTLR_M).

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Tie this to alloc_context_bank rather than carrying a Qualcomm specific quirk
  in the generic code.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  4 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 23 +++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 +++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 0663d7d26908..229fc8ff8cea 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -94,8 +94,12 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 					       struct arm_smmu_device *smmu,
 					       struct device *dev, int start)
 {
+	struct iommu_domain *domain = &smmu_domain->domain;
 	int count;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return ARM_SMMU_CBNDX_BYPASS;
+
 	/*
 	 * Assign context bank 0 to the GPU device so the GPU hardware can
 	 * switch pagetables
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index add2e1807e21..eb5c6ca5c138 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -611,7 +611,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* SCTLR */
 	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
-	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
+	      ARM_SMMU_SCTLR_TRE;
+	if (cfg->m)
+		reg |= ARM_SMMU_SCTLR_M;
 	if (stage1)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
@@ -627,9 +629,14 @@ static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_device *smmu,
 				       struct device *dev, unsigned int start)
 {
+	struct iommu_domain *domain = &smmu_domain->domain;
+
 	if (smmu->impl && smmu->impl->alloc_context_bank)
 		return smmu->impl->alloc_context_bank(smmu_domain, smmu, dev, start);
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return ARM_SMMU_CBNDX_BYPASS;
+
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
 }
 
@@ -653,12 +660,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
-		smmu_domain->smmu = smmu;
-		goto out_unlock;
-	}
-
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -757,6 +758,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	ret = arm_smmu_alloc_context_bank(smmu_domain, smmu, dev, start);
 	if (ret < 0) {
 		goto out_unlock;
+	} else if (ret == ARM_SMMU_CBNDX_BYPASS) {
+		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
+		smmu_domain->smmu = smmu;
+		goto out_unlock;
 	}
 
 	smmu_domain->smmu = smmu;
@@ -813,6 +818,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	domain->geometry.force_aperture = true;
 
+	/* Enable translation for non-identity context banks */
+	if (domain->type != IOMMU_DOMAIN_IDENTITY)
+		cfg->m = true;
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 	arm_smmu_write_context_bank(smmu, cfg->cbndx);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index ddf2ca4c923d..235d9a3a6ab6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -243,6 +243,8 @@ enum arm_smmu_cbar_type {
 #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
 #define TLB_SPIN_COUNT			10
 
+#define ARM_SMMU_CBNDX_BYPASS		0xffff
+
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
 	ARM_SMMU_V1,
@@ -346,6 +348,7 @@ struct arm_smmu_cfg {
 	u32				sctlr_clr;    /* bits to mask in SCTLR */
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
+	bool				m;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
