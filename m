Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB34C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19122146E
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1A8whOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19122146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 259A4127D;
	Fri, 27 Sep 2019 09:10:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B04A41281
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6CA188B8
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:57 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id n14so1815526wrw.9
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=OGNly6Vphv4Itb2RkdK4y5BItxcdcc9y36+Z8tgTcg0=;
	b=D1A8whOxqTnPyfllVyOo5GUyHH22JDWdvQC5wS14rOykrm6oXxi/V5GFZltXKFdMHb
	VZnIkAioDjmgJftBRWcCnWqUdKMNSh4H4t+unuF5/f50AjwON9p0X0lKEt8RfMnZlfdK
	ZdgQfAvpsBuBMWGc/ynfvxSjY4RnCFi7S0TdYCa3IWeUpvYnepmdALTIVAI01eiib1Rv
	ofE/IMxfDpbg0+DmXNQR42QeoWONfkMrCtua6SHLyhhgD6CNBNX260oGlbKOYOACVR4w
	FyLNYYVhHiIBRHb1osjLLiigFbuXSmnaS4cnye84eeloC3uOkOhAgxvplY/XS9zi9pLo
	8p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=OGNly6Vphv4Itb2RkdK4y5BItxcdcc9y36+Z8tgTcg0=;
	b=J7HyaXBvKzinROCEQ/RYYIIPzG7AKxXRnx+7cmK97lg8Y+S7J1JGEtAax0NpqqvhXc
	31k2dXpQzRu51mvdVb1ax/t3Lku6HPVyK5CbMTZWgbfy15XP6gYVbSAKFIgKIyYSVuEk
	l1QiukZZGT3yYUdg0AP0tbthDZQ1IhZAmRYakdKxpEc5+mQ1jrPhukwHNXzYoMLYiGtP
	F9Fhx0sHJHPyrekF/VhZUlUOMtUigtL5GR9yrHI6EQrZRrDD6ZIimTyV4d0biIQ9cBSG
	j6fgScFFAbWPRPbE+xB50FHzPxuvyB2xjBPBV0EF96phIhEwknpIaaclnn6PG8WE23N8
	YsXw==
X-Gm-Message-State: APjAAAU4MRFSKA9nRroGBF95E13BQTwBFa8pJcs1x81ZVvaMOTJPInIc
	QaPJy56hJRoTyuWdC7LG+Hc=
X-Google-Smtp-Source: APXvYqyLUk60co2pvzNJ6RPKFw6KfagzRfLG0nZmbQ9wr6rfa33FqxbfqApVgK8/rwVUtrB+sBRw1w==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr2053286wrt.280.1569575395940; 
	Fri, 27 Sep 2019 02:09:55 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	b62sm6037791wmc.13.2019.09.27.02.09.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Sep 2019 02:09:55 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Date: Fri, 27 Sep 2019 11:09:45 +0200
Message-Id: <20190927090947.11175-5-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927090947.11175-1-kholk11@gmail.com>
References: <20190927090947.11175-1-kholk11@gmail.com>
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	AngeloGioacchino Del Regno <kholk11@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Some IOMMUs associated with some TZ firmwares may support switching
to the AArch64 pagetable format by sending a "set pagetable format"
scm command indicating the IOMMU secure ID and the context number
to switch.

Add a DT property "qcom,use-aarch64-pagetables" for this driver to
send this command to the secure world and to switch the pagetable
format to benefit of the ARM64 IOMMU pagetables, where possible.

Note that, even though the command should be valid to switch each
context, the property is made global because:
1. It doesn't make too much sense to switch only one or two
   context(s) to AA64 instead of just the entire thing
2. Some IOMMUs will go crazy and produce spectacular results when
   trying to mix up the pagetables on a per-context basis.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 +
 drivers/iommu/qcom_iommu.c                    | 55 +++++++++++++++----
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index ba0b77889f02..72ae0595efff 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -47,6 +47,8 @@ to non-secure vs secure interrupt line.
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
 - qcom,ctx-num     : The number associated to the context bank
+- qcom,use-aarch64-pagetables : Switch to AArch64 pagetable format on all
+                                contexts declared in this IOMMU
 
 
 ** Examples:
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 2f31da2e7add..233ef496af27 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -48,6 +48,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
+	bool			 use_aarch64_pt;
 	struct qcom_iommu_ctx	*ctxs[0];   /* indexed by asid-1 */
 };
 
@@ -153,11 +154,17 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
 		size_t s = size;
 
-		iova &= ~12UL;
-		iova |= ctx->asid;
+		if (qcom_iommu->use_aarch64_pt) {
+			iova >>= 12;
+			iova |= (u64)ctx->asid << 48;
+		} else {
+			iova &= ~12UL;
+			iova |= ctx->asid;
+		}
 		do {
 			iommu_writel(ctx, reg, iova);
 			iova += granule;
@@ -222,6 +229,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt pgtbl_fmt;
+	unsigned long ias, oas;
 	int i, ret = 0;
 	u32 reg;
 
@@ -229,16 +238,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	if (qcom_domain->iommu)
 		goto out_unlock;
 
+	if (qcom_iommu->use_aarch64_pt) {
+		pgtbl_fmt = ARM_64_LPAE_S1;
+		ias = oas = 48;
+	} else {
+		pgtbl_fmt = ARM_32_LPAE_S1;
+		ias = 32;
+		oas = 40;
+	}
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
-		.ias		= 32,
-		.oas		= 40,
+		.ias		= ias,
+		.oas		= oas,
 		.tlb		= &qcom_gather_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
 
 	qcom_domain->iommu = qcom_iommu;
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, fwspec);
+	pgtbl_ops = alloc_io_pgtable_ops(pgtbl_fmt, &pgtbl_cfg, fwspec);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -252,6 +270,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
+		u32 tcr[2];
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -264,12 +283,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		qcom_iommu_reset_ctx(ctx);
 
+		tcr[0] = pgtbl_cfg.arm_lpae_s1_cfg.tcr;
+		tcr[1] = pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32;
+		tcr[1] |= FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM);
+
+		if (qcom_iommu->use_aarch64_pt) {
+			/* This shall not fail, or spectacular things happen */
+			if (qcom_scm_iommu_set_pt_format(qcom_iommu->sec_id,
+							 ctx->asid, 1)) {
+				dev_warn(qcom_iommu->dev,
+					 "Cannot set AArch64 pt format\n");
+				goto out_clear_iommu;
+			}
+
+			tcr[1] |= TCR2_AS;
+		}
+
 		/* TCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
-				FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM));
-		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-				pgtbl_cfg.arm_lpae_s1_cfg.tcr);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2, tcr[1]);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR, tcr[0]);
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
@@ -844,6 +876,9 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_property_read_bool(dev->of_node, "qcom,use-aarch64-pagetables"))
+		qcom_iommu->use_aarch64_pt = true;
+
 	if (qcom_iommu_has_secure_context(qcom_iommu)) {
 		ret = qcom_iommu_sec_ptbl_init(dev);
 		if (ret) {
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
