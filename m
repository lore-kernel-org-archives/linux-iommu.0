Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA4C2BB84
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9837E2074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJgMpx43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9837E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AC5387576;
	Fri,  4 Sep 2020 15:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIwf5vzQ5Jih; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA1B987573;
	Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8283C0052;
	Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C74C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 33E3487574
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqJoiPjPIe7J for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 15:55:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D41D87571
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:18 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id d20so6739127qka.5
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cqOydC4P7PfDdkAhN3VGNKHPJJ431uRaailmt1kgaeU=;
 b=CJgMpx43qvc9byFhCZEm4/SvL1LvLGr9/CsL3bEH8cddixy5T8h5M48QlyKChSENHN
 1Mp4gnVrKUsEcY+Zvd2qjlsVZf5YkEaRHfnHyTzeSSLlrwG/PHrSyTzkQQFCpAsQpUHH
 /ga6s7nNWwtc9MCgLx8cJ7JuWU4DbMfgJn9Mcny+8PrcdQyid92MSarw3ah/r+aWD8y9
 Y2C4R/Mwos3AkmPQRDcED2x0vbj5V8mG5GcXZRDagt429AEGnzV4BNtAdc2oyPy/jYtW
 vmK2oXorZkRIx4xxxPzHCfn9x00d/5y08meh8VAM0QgWNkEs3yCi4wO/QgFASYWDo4sO
 fqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cqOydC4P7PfDdkAhN3VGNKHPJJ431uRaailmt1kgaeU=;
 b=oBX0V3UFe0iii+7y4wvDTzMGyhGnC4zUfyB9twgsJUeNb/okACDH1d5xdTxO2t2nET
 +BmielOftHKwHNTBaxR/SMAIQA85i9QK5hlP10W+4V6oYiT7KXQpfA5jbKkBBJ5Zjwxt
 uB+DT/8fn/Jt4OKBIkgTmCpQ/+ODAZd7r2N2Ma1uzfrNMoihqzC3PuJpQO4E1YgflA5Z
 AfDhmW6iQe745s8FRrTR9EK58/x4R1/RoIoMezInW68kRRMY1cDzYd5rYygwFwSiketU
 TcV3VbhcJ3C4fZyC4XsXGhpXRTYiLKkB1p4Dx3ER1bt3o1pOvo4yakSE3h7kCepoteNN
 qljw==
X-Gm-Message-State: AOAM531hRdGgG11NfzA8XrcFkrz4S2l3FNSjrQqq7FWo8JOSl/Ibd+eA
 enb0YtAQBtU8FFWMC5fCVXneAg==
X-Google-Smtp-Source: ABdhPJwHcjVR8gvpVo5cc8Zutt5nJd/mELZ/BVmZZWe+VuF+L6dgLXd87rsYat09jN3kKHXviyEKTA==
X-Received: by 2002:a05:620a:211c:: with SMTP id
 l28mr8189345qkl.395.1599234917217; 
 Fri, 04 Sep 2020 08:55:17 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:16 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 2/8] iommu/arm-smmu: Delay modifying domain during init
Date: Fri,  4 Sep 2020 15:55:07 +0000
Message-Id: <20200904155513.282067-3-bjorn.andersson@linaro.org>
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

Delay modifications to the domain during arm_smmu_init_domain_context()
until we've allocated a context bank. This will allow us to postpone the
special handling of identity domains until the platform specific context
bank allocator has been executed, in a later patch.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch to allow us to rely on the impl specific alloc_context_bank().

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 40 +++++++++++++++------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index e19d7bdc7674..add2e1807e21 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -645,6 +645,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	irqreturn_t (*context_fault)(int irq, void *dev);
+	struct arm_smmu_cfg new_cfg = *cfg;
+	enum arm_smmu_domain_stage new_stage = smmu_domain->stage;
+	const struct iommu_flush_ops *flush_ops;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -675,9 +678,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * Note that you can't actually request stage-2 mappings.
 	 */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
-		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+		new_stage = ARM_SMMU_DOMAIN_S2;
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
-		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+		new_stage = ARM_SMMU_DOMAIN_S1;
 
 	/*
 	 * Choosing a suitable context format is even more fiddly. Until we
@@ -688,32 +691,32 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * support to be a superset of AArch32 support...
 	 */
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_L)
-		cfg->fmt = ARM_SMMU_CTX_FMT_AARCH32_L;
+		new_cfg.fmt = ARM_SMMU_CTX_FMT_AARCH32_L;
 	if (IS_ENABLED(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) &&
 	    !IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_ARM_LPAE) &&
 	    (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S) &&
-	    (smmu_domain->stage == ARM_SMMU_DOMAIN_S1))
-		cfg->fmt = ARM_SMMU_CTX_FMT_AARCH32_S;
-	if ((IS_ENABLED(CONFIG_64BIT) || cfg->fmt == ARM_SMMU_CTX_FMT_NONE) &&
+	    (new_stage == ARM_SMMU_DOMAIN_S1))
+		new_cfg.fmt = ARM_SMMU_CTX_FMT_AARCH32_S;
+	if ((IS_ENABLED(CONFIG_64BIT) || new_cfg.fmt == ARM_SMMU_CTX_FMT_NONE) &&
 	    (smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_64K |
 			       ARM_SMMU_FEAT_FMT_AARCH64_16K |
 			       ARM_SMMU_FEAT_FMT_AARCH64_4K)))
-		cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
+		new_cfg.fmt = ARM_SMMU_CTX_FMT_AARCH64;
 
-	if (cfg->fmt == ARM_SMMU_CTX_FMT_NONE) {
+	if (new_cfg.fmt == ARM_SMMU_CTX_FMT_NONE) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
 
-	switch (smmu_domain->stage) {
+	switch (new_stage) {
 	case ARM_SMMU_DOMAIN_S1:
-		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		new_cfg.cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
 		ias = smmu->va_size;
 		oas = smmu->ipa_size;
-		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
+		if (new_cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64) {
 			fmt = ARM_64_LPAE_S1;
-		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
+		} else if (new_cfg.fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
 			fmt = ARM_32_LPAE_S1;
 			ias = min(ias, 32UL);
 			oas = min(oas, 40UL);
@@ -722,7 +725,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
+		flush_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -730,11 +733,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		 * involved.
 		 */
 	case ARM_SMMU_DOMAIN_S2:
-		cfg->cbar = CBAR_TYPE_S2_TRANS;
+		new_cfg.cbar = CBAR_TYPE_S2_TRANS;
 		start = 0;
 		ias = smmu->ipa_size;
 		oas = smmu->pa_size;
-		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
+		if (new_cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64) {
 			fmt = ARM_64_LPAE_S2;
 		} else {
 			fmt = ARM_32_LPAE_S2;
@@ -742,9 +745,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			oas = min(oas, 40UL);
 		}
 		if (smmu->version == ARM_SMMU_V2)
-			smmu_domain->flush_ops = &arm_smmu_s2_tlb_ops_v2;
+			flush_ops = &arm_smmu_s2_tlb_ops_v2;
 		else
-			smmu_domain->flush_ops = &arm_smmu_s2_tlb_ops_v1;
+			flush_ops = &arm_smmu_s2_tlb_ops_v1;
 		break;
 	default:
 		ret = -EINVAL;
@@ -757,6 +760,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}
 
 	smmu_domain->smmu = smmu;
+	smmu_domain->cfg = new_cfg;
+	smmu_domain->stage = new_stage;
+	smmu_domain->flush_ops = flush_ops;
 
 	cfg->cbndx = ret;
 	if (smmu->version < ARM_SMMU_V2) {
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
