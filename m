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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62107C352AA
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C9A21906
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t249MXs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C9A21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 237D52358;
	Tue,  1 Oct 2019 22:02:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FD8F1A88
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D31C63D0
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:12 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n14so17257646wrw.9
	for <iommu@lists.linux-foundation.org>;
	Tue, 01 Oct 2019 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xSQ3Gd/I78crTYWoKFJLF2LHykp/l0XNK/1ec4ayqbI=;
	b=t249MXs++5WyIF3X50Nkg/LnfbT6WM1mHZpRGivgeImeFlsqtd6GwDxawpSD0sFfoZ
	D2r6fOGps5fUNtZscW/c2jyOBVjUM0QdgwVaLKJu2HFRHcwyEx2SZoHgK7rkNMzaK5J9
	tRLCzMgd7b6rh3Iw49RxI7sps2fJ6nfUQtj0UFja2TrZKExyiFkyrO28b9eGORbToX96
	1iyZtGkPIpwbrohedj1RX80zf/pbAsT6HS9z8ahOuK67QUdP5rA3fVl5hy9J0Utnd0SZ
	bLKbexglc8AZFn9R/bIVREpe48hx4wLZ4D6+FPDtVieJ4Re6wHg+hDNojNVDoxd2cDLB
	84MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xSQ3Gd/I78crTYWoKFJLF2LHykp/l0XNK/1ec4ayqbI=;
	b=dtXaqGprgxWKr3XR4zQS5hMwLGLhpkIUBlTyyPzqqI23fGYwRyAl88ePmBU+PfLbnP
	Sie+jFLn6TvqdIQe60O1KLJn6ailU98InLKMlX+cprO3rWUtcllp6GewiLMpsNrtVCbL
	HHwMNqQJ4yV2rptuxi5RgWOnyb6txaFoKtoik4supZctgptPm6wv4MgexH+U5vzc6NSZ
	NE57IeKMaiiKfJfSJSUORxR850u9aagq8RUiLq/zPl8JDpYjt9N+cwfaKKfFi90r84en
	imXeIMK6VCsMT38L/ienpgI3I04ycuY2mLvJNoAha60M4ZjRSLUOncxS6n6aztV3mtDl
	xJ7w==
X-Gm-Message-State: APjAAAWphSMeO6GlAuA+IZLPpbvyl+zL3Dt3AM7BpGHbCB2/gJGjsoXU
	x146OD+TzHG2sQw/meJs9/U=
X-Google-Smtp-Source: APXvYqy1rskAcZSc9NovPC2LsJevqHjabSz0LpyN/SnQGRbcaQZj1rMNs2D0coMhRjTTbYPo3Ie7pQ==
X-Received: by 2002:adf:a415:: with SMTP id d21mr18413810wra.94.1569967331329; 
	Tue, 01 Oct 2019 15:02:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	v16sm21811219wrt.12.2019.10.01.15.02.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Oct 2019 15:02:10 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/7] iommu/qcom: Write TCR before TTBRs to fix ASID access
	behavior
Date: Wed,  2 Oct 2019 00:02:01 +0200
Message-Id: <20191001220205.6423-4-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001220205.6423-1-kholk11@gmail.com>
References: <20191001220205.6423-1-kholk11@gmail.com>
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

As also stated in the arm-smmu driver, we must write the TCR before
writing the TTBRs, since the TCR determines the access behavior of
some fields.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/iommu/qcom_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 504ca69adc5a..c8957ec83b92 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -267,6 +267,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* TCR */
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
+				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
+				FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM));
+		iommu_writel(ctx, ARM_SMMU_CB_TCR,
+				pgtbl_cfg.arm_lpae_s1_cfg.tcr);
+
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
@@ -275,13 +282,6 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
 				FIELD_PREP(TTBRn_ASID, ctx->asid));
 
-		/* TCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
-				FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM));
-		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-				pgtbl_cfg.arm_lpae_s1_cfg.tcr);
-
 		/* MAIRs (stage-1 only) */
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.mair[0]);
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
