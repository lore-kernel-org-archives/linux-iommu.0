Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62298C352AA
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 15:57:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3161E2053B
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCo4q3Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A4C31A8C;
	Tue,  1 Oct 2019 15:57:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 410B91A27
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 15:56:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7E81E8AC
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 15:56:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id l3so16175527wru.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 01 Oct 2019 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZWSfHME9EykpkSiHCNCJB/NwhqPlKPFe6uMd6py2CPE=;
	b=NCo4q3Yj8QLR8nmKX81BQNGieIKyAzcdACoeiFB3UHaGZvQ5T/vnnE53kLXRfCmTfR
	iqU3kkvQJ2ZgpQz9efLyiNvp4uJotj/mbXFezLUomfURJiwZuD4rx7+oQkjGtg10KtBz
	QlQxR9G9XmG/7hP3/N9s/EvBrOuZQlh9e4+XttXkqVeFnA13VuYjARQSTlqI1HhBWjhu
	tBoOJ4rA8m8gBlvBf2eLKPB5hk8Lz3S97i5/DlfGxI34wUOpu+3dT69imUX/s0sozO1I
	tYpMG7Qy0TquWn7eABxwBxymR7tdxqh/IA5J0DEX87oNEo65uUCBsncCJm1LO4gLxC7A
	tZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZWSfHME9EykpkSiHCNCJB/NwhqPlKPFe6uMd6py2CPE=;
	b=VWWjWqZ2YOozkcsz/lcB5zyl0hiyA0CvMgz4ILx7kTvc28INJdiPfArnwzvByT9jZk
	PiejHMC9p9ceFgXzo1Gi6IHan/fB99BlNEaQREkTotJLa7otKGVomksmhoYoDbXgi7vh
	1mqOlG6ae+SFmOceC7AcLkWY4GD01sGGa2P4uCr/eIq76WbgR+3djzlIEWOcUF4Qe/Pk
	Wub5/hl3oV9yNaqR1PQ9mzkAtJmxhnhwcD2QXjeBY1crFRpt79PE5WU63Y30urkzjrCz
	7eLFZ8mcpaEZ/2hYKEkXHAPv5j/gWLVLwIRFkL2b3BGrl6sUAoVI7BtEg6Zk2kGGoTTD
	ftxg==
X-Gm-Message-State: APjAAAU4hZmD8SAl01nm58DDhaz/zGFCMsmWD98uHHCRJN8fxlAcW8ZH
	tt9HCs7QlGM2/Ckccl0ZX7Q=
X-Google-Smtp-Source: APXvYqyd3Xi3KLE97kpVPM+DoKJEFygDlOB1uTxQHVZ92EpOpcHON9Ot92PWS4jnNfAQP3SychwDPg==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr18856063wrp.69.1569945413036; 
	Tue, 01 Oct 2019 08:56:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	h63sm6209136wmf.15.2019.10.01.08.56.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Oct 2019 08:56:52 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 5/7] iommu/qcom: Add support for AArch64 IOMMU pagetables
Date: Tue,  1 Oct 2019 17:56:39 +0200
Message-Id: <20191001155641.37117-6-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001155641.37117-1-kholk11@gmail.com>
References: <20191001155641.37117-1-kholk11@gmail.com>
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	kholk11@gmail.com
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
index b4a38ef129e3..dac77dbec0f0 100644
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
 
-		iova = (iova >> 12) << 12;
-		iova |= ctx->asid;
+		if (qcom_iommu->use_aarch64_pt) {
+			iova >>= 12;
+			iova |= (u64)ctx->asid << 48;
+		} else {
+			iova = (iova >> 12) << 12;
+			iova |= ctx->asid;
+		}
 		do {
 			iommu_writel(ctx, reg, iova);
 			iova += granule;
@@ -244,6 +251,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt pgtbl_fmt;
+	unsigned long ias, oas;
 	int i, ret = 0;
 	u32 reg;
 
@@ -251,16 +260,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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
 		.tlb		= &qcom_flush_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
 
 	qcom_domain->iommu = qcom_iommu;
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, fwspec);
+	pgtbl_ops = alloc_io_pgtable_ops(pgtbl_fmt, &pgtbl_cfg, fwspec);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -274,6 +292,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
+		u32 tcr[2];
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -286,12 +305,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
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
@@ -869,6 +901,9 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
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
