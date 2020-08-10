Return-Path: <SRS0=AIGO=BU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D05C433DF
	for <iommu@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850CD2087C
	for <iommu@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SMccE2uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850CD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6248C8772A;
	Mon, 10 Aug 2020 22:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tf+Mj14QP-y3; Mon, 10 Aug 2020 22:27:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B544387730;
	Mon, 10 Aug 2020 22:27:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A37D2C013C;
	Mon, 10 Aug 2020 22:27:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED27C004D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 22:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B41F87730
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 22:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bz-hV2slEMBe for <iommu@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 22:27:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F3E1D8772A
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 22:27:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1597098475; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=luFjlnOjyWOq8Y2pNHotM6G2poKKOZibPxqXcVoTZhI=;
 b=SMccE2uJDA0uf1C2mSSiDMn4gk4nTcO1K3cLKNBAEIldw7vfN7ONwFHC4hfFMDzoy1WDpBcU
 OQ4GekbFI2ieK728gPEr+lbODz2A6bLuuU7D8qhhyU8uDaH14TJYAE7Rlv1VRZ0Ax03OM9Jm
 GEgihp7Qzt8lTT7ECpZJ4hZrfw8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f31c9e746ed996674d1ad89 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 22:27:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DBA31C43391; Mon, 10 Aug 2020 22:27:46 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 38B0EC4345B;
 Mon, 10 Aug 2020 22:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38B0EC4345B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [RFC v12 13/13] iommu/arm-smmu: Add a init_context_bank
 implementation hook
Date: Mon, 10 Aug 2020 16:26:57 -0600
Message-Id: <20200810222657.1841322-14-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
 Stephen Boyd <swboyd@chromium.org>, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

Add a new implementation hook to allow the implementation specific code
to tweek the context bank configuration just before it gets written.
The first user will be the Adreno GPU implementation to turn on
SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
transactions. Doing so could hang the GPU if one of the terminated
transactions is a CP read.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 ++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 21 +++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 3be10145bf57..baa026ddca1c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -34,6 +34,19 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	return false;
 }
 
+#define QCOM_ADRENO_SMMU_GPU 1
+
+static void qcom_adreno_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
+		struct arm_smmu_cb *cb)
+{
+	/*
+	 * On the GPU device we want to process subsequent transactions after a
+	 * fault to keep the GPU from hanging
+	 */
+	if (cb->cfg->priv == QCOM_ADRENO_SMMU_GPU)
+		cb->sctlr |= ARM_SMMU_SCTLR_HUPCF;
+}
+
 /*
  * Local implementation to configure TTBR0 with the specified pagetable config.
  * The GPU driver will call this to enable TTBR0 when per-instance pagetables
@@ -120,6 +133,7 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 		count = 1;
 	} else {
 		start = 1;
+		smmu_domain->cfg.priv = QCOM_ADRENO_SMMU_GPU;
 	}
 
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
@@ -141,6 +155,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
 		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
 
+
 	return 0;
 }
 
@@ -204,6 +219,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.domain_set_attr = qcom_adreno_smmu_domain_set_attr,
 	.domain_get_attr = qcom_adreno_smmu_domain_get_attr,
+	.init_context_bank = qcom_adreno_smmu_init_context_bank,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index e0a3e0da885b..6225649bbfef 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -532,6 +532,18 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			cb->mair[1] = pgtbl_cfg->arm_lpae_s1_cfg.mair >> 32;
 		}
 	}
+
+	cb->sctlr = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
+		ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
+
+	if (stage1)
+		cb->sctlr |= ARM_SMMU_SCTLR_S1_ASIDPNE;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		cb->sctlr |= ARM_SMMU_SCTLR_E;
+
+	/* Give the implementation a chance to adjust the configuration */
+	if (smmu_domain->smmu->impl && smmu_domain->smmu->impl->init_context_bank)
+		smmu_domain->smmu->impl->init_context_bank(smmu_domain, cb);
 }
 
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
@@ -610,14 +622,7 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	}
 
 	/* SCTLR */
-	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
-	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
-	if (stage1)
-		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
-	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
-		reg |= ARM_SMMU_SCTLR_E;
-
-	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, cb->sctlr);
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 870f0fd060a5..e84b8da8b93b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -143,6 +143,7 @@ enum arm_smmu_cbar_type {
 
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
+#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
 #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
 #define ARM_SMMU_SCTLR_CFIE		BIT(6)
 #define ARM_SMMU_SCTLR_CFRE		BIT(5)
@@ -343,6 +344,7 @@ struct arm_smmu_cfg {
 	};
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
+	unsigned long			priv;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
@@ -350,6 +352,7 @@ struct arm_smmu_cb {
 	u64				ttbr[2];
 	u32				tcr[2];
 	u32				mair[2];
+	u32				sctlr;
 	struct arm_smmu_cfg		*cfg;
 };
 
@@ -439,6 +442,8 @@ struct arm_smmu_impl {
 			enum iommu_attr attr, void *data);
 	int (*domain_set_attr)(struct arm_smmu_domain *smmu_domain,
 			enum iommu_attr attr, void *data);
+	void (*init_context_bank)(struct arm_smmu_domain *smmu_domain,
+			struct arm_smmu_cb *cb);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
