Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6438DC352AA
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 15:57:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C7A2053B
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgHSlTJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C7A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 105491D1D;
	Tue,  1 Oct 2019 15:57:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 339D21A27
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 15:56:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AFF94A3
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 15:56:53 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id 5so3999484wmg.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 01 Oct 2019 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6cgkBIqWvnVkQ9N/MHRrfLaa6SBKNUc7qvNtHetLnKc=;
	b=LgHSlTJtM6cK49Al1Z12BQ+7Ier1q5prnBaqn1S3RLrKU/T3qh6vHmdePSmc3lGQtf
	Goah4jYL7Tg1wDAUGk+I7aVapLc5so3swNqB2NEkMK5hWUt+Surd4uDMTzMKtvn9UqTp
	8y0DSIh/gAb95dD/RSzAQ2eOPE/6gPTElFbYnn0h9uCSu8bo1TJrS6lBmUip524qCSWU
	4pRL6aRUPspYO1HojLppoVIASv3O7fXSWuXMH/sPJ8Ag2/MJZEgpm7bbzbutR1GwVZlt
	t7Ca2zAM4RlfWRqxTKEHXvfHp8FWhVL1t/TMq5hrDOdGtKfbIi+370Iu8GHa7ifnF7Nu
	XUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6cgkBIqWvnVkQ9N/MHRrfLaa6SBKNUc7qvNtHetLnKc=;
	b=Nm/OHyRRKxKOIM4N2Tz8py2fTpRynFAyeSycG38LVBIRInvpuwvzVitVUVazfhQyNs
	rrvT37Y5m+ToYlGIDh9X8Jnh0Lc+T1U26/3ajtBh7/ZkGcQqBwxH3r2G22Ux6hJu0+D9
	7MZtlMMzXIROsKctN5jrT8ZEhZNUbcYFAZthO6mbIn0d9tAkRDkWJc0vTNHM5RzuEaVx
	Z7yAUrRRwGFOcDQRUYsRx5N/0kkygUSW6hgeXVw8HpsAcXSPVDaB22ebpMUjDV1UKHEQ
	ObBCsai7qZYfBDbwIx5UzqEuK7t9XP8cKy/pMEYMjGPQLD/nezV4bNO82GCgCI59vzxU
	tBPw==
X-Gm-Message-State: APjAAAWZSuNVCBLBti68Al02XXrJbIvSJwA6AAY7c9iqMAzImNHvrjRm
	ji4iggi4nUu1HJZhvEToWE8=
X-Google-Smtp-Source: APXvYqw9YakoyUGtMa2OVJLxprPkitOKXvxCKUMc+ka7ce13jXusaTSuhmRvS+qox3IhiSpWQdFHMA==
X-Received: by 2002:a05:600c:238a:: with SMTP id
	m10mr4675523wma.51.1569945412138; 
	Tue, 01 Oct 2019 08:56:52 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	h63sm6209136wmf.15.2019.10.01.08.56.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Oct 2019 08:56:51 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 4/7] iommu/qcom: Properly reset the IOMMU context
Date: Tue,  1 Oct 2019 17:56:38 +0200
Message-Id: <20191001155641.37117-5-kholk11@gmail.com>
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

To avoid context faults reset the context entirely on detach and
to ensure a fresh clean start also do a complete reset before
programming the context for domain initialization.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/iommu/qcom_iommu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c8957ec83b92..b4a38ef129e3 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -220,6 +220,23 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void qcom_iommu_reset_ctx(struct qcom_iommu_ctx *ctx)
+{
+	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_FSR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_PAR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_TCR2, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_TCR, 0);
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, 0);
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
+
+	/* Should we issue a TLBSYNC there instead? */
+	mb();
+}
+
 static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				  struct qcom_iommu_dev *qcom_iommu,
 				  struct iommu_fwspec *fwspec)
@@ -267,6 +284,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		qcom_iommu_reset_ctx(ctx);
+
 		/* TCR */
 		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
 				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
@@ -412,8 +431,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
 
-		/* Disable the context bank: */
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+		/* Disable and reset the context bank */
+		qcom_iommu_reset_ctx(ctx);
 
 		ctx->domain = NULL;
 	}
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
