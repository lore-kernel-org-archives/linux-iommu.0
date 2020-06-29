Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4330CC433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:53:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FB6254C3
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OLAsIVlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FB6254C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1376887C0;
	Mon, 29 Jun 2020 15:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ynOtQ7-0pKlM; Mon, 29 Jun 2020 15:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12267886D2;
	Mon, 29 Jun 2020 15:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F364AC07FF;
	Mon, 29 Jun 2020 15:53:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9012FC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 77F32204F2
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1AyWOy7quE3C for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 15:53:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by silver.osuosl.org (Postfix) with ESMTPS id 78AA3203F6
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593446016; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ky6EgIpsLXuCQ1ZyQQj8TAObCq/x3v8ZEUf9hqB0i5U=;
 b=OLAsIVlqfOvA1O0dEOem7MuLTFwQ2wJiBRkizbZBm3iQSO54fPUVgHTrfkelkNB3MsdpIQl+
 PP4p3GZgMxbCn0nTDbKTRnA6XOdH4QWhxsQl4Fs8uPiqqjy4jr4lVoiAHUlyACvvnNmCQ82L
 PTMTbVoUIeFBA8v4YQlkUBI0Ecc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5efa0e78e144dd5115022c1f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 15:53:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7264EC433C6; Mon, 29 Jun 2020 15:53:28 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 36CB3C433C8;
 Mon, 29 Jun 2020 15:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36CB3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv3 1/7] iommu/arm-smmu: Add a init_context_bank implementation
 hook
Date: Mon, 29 Jun 2020 21:22:44 +0530
Message-Id: <cdcc6a1c95a84e774790389dc8b3b7feeee490dc.1593344119.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, iommu@lists.linux-foundation.org,
 Matthias Kaehlcke <mka@chromium.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Emil Velikov <emil.velikov@collabora.com>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Add a new implementation hook to allow the implementation specific code
to tweek the context bank configuration just before it gets written.
The first user will be the Adreno GPU implementation to turn on
SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
transactions. Doing so could hang the GPU if one of the terminated
transactions is a CP read.

This depends on the arm-smmu adreno SMMU implementation [1].

[1] https://lore.kernel.org/patchwork/patch/1264452/

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
 drivers/iommu/arm-smmu.c      | 29 +++++++++++++----------------
 drivers/iommu/arm-smmu.h      | 12 ++++++++++++
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index cb2acb6b19dd..6462fb00f493 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -17,6 +17,18 @@ static bool qcom_adreno_smmu_is_gpu_device(struct arm_smmu_domain *smmu_domain)
 	return of_device_is_compatible(smmu_domain->dev->of_node, "qcom,adreno");
 }
 
+static void qcom_adreno_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
+		struct arm_smmu_cb *cb)
+{
+	/*
+	 * On the GPU device we want to process subsequent transactions after a
+	 * fault to keep the GPU from hanging
+	 */
+
+	if (qcom_adreno_smmu_is_gpu_device(smmu_domain))
+		cb->sctlr |= ARM_SMMU_SCTLR_HUPCF;
+}
+
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -92,6 +104,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
+	.init_context_bank = qcom_adreno_smmu_init_context_bank,
 };
 
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4bd247dfd703..b2564f93d685 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -86,14 +86,6 @@ struct arm_smmu_smr {
 	bool				valid;
 };
 
-struct arm_smmu_cb {
-	u64				ttbr[2];
-	u32				tcr[2];
-	u32				mair[2];
-	struct arm_smmu_cfg		*cfg;
-	atomic_t			aux;
-};
-
 struct arm_smmu_master_cfg {
 	struct arm_smmu_device		*smmu;
 	s16				smendx[];
@@ -580,6 +572,18 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
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
 
 static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
@@ -658,14 +662,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
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
 
 /*
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 79d441024043..4a335ef3d97a 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -142,6 +142,7 @@ enum arm_smmu_cbar_type {
 
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
+#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
 #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
 #define ARM_SMMU_SCTLR_CFIE		BIT(6)
 #define ARM_SMMU_SCTLR_CFRE		BIT(5)
@@ -349,6 +350,15 @@ struct arm_smmu_domain {
 	bool				aux;
 };
 
+struct arm_smmu_cb {
+	u64			ttbr[2];
+	u32			tcr[2];
+	u32			mair[2];
+	u32			sctlr;
+	struct arm_smmu_cfg	*cfg;
+	atomic_t		aux;
+};
+
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 {
 	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
@@ -403,6 +413,8 @@ struct arm_smmu_impl {
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 	int (*def_domain_type)(struct device *dev);
+	void (*init_context_bank)(struct arm_smmu_domain *smmu_domain,
+			struct arm_smmu_cb *cb);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
