Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C31C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2628F2146E
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEv4Fwdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2628F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CB3FC128A;
	Fri, 27 Sep 2019 09:09:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5C10C126F
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 223658BA
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:55 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q17so1810225wrx.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gVA/w0d2QWMzk0mJERhCeM6+8qnZiMPqI0NO/jhQ/j0=;
	b=eEv4Fwdh0pKiRgTd7B+EjixtmSqNuJRkv5XvtTVqWqDQGeLn3vI6OnLxqfMGfKl++v
	SlE30ctasb7M/IB2m4PlKU3EF0gXP4nBSORk/elCm4vvpU0U8AD2rB+bdRz8ClkbIO0G
	L8WpVctLB5e42o/qE9i5gslMYR81fSV89eOzC9PRBRJJoDOoIXeb0CkkOogjbMVNkuf3
	GTUNhDzE1AKmRldtFH+AtoNAodsEmaSrCOoCCwkF9wlmAjR2kPkRXcy9Z8FGaDEjt69C
	pdXnm2lmaYT38JEmQ+UWg7takuMVaCbpVWMDoMy2b8ix81+GXOfVo+yBO4sm8NEoYizc
	T0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gVA/w0d2QWMzk0mJERhCeM6+8qnZiMPqI0NO/jhQ/j0=;
	b=DzpIRTTxqCOe6ExYaMl/8Ubq7RydDze2FNG2a7oj9n+uRXKdQcsQBJ/TEVg+dbvjwl
	z84Xs5GdWXScF7VINh9qwVkQex109eeYwxnIjJHX/ZqTlBGUz7g+ph+Xgjq+VbBiGwtH
	4omVEDQ5dLf8c6xWmRw1GOXfeQlyqf17pl7+hreHXPxUfxvQiTYKgFF6Z0WQzoAp0/96
	UhrRtwH2wRotj2xV0GqBYyIVd8Yg6KqzjeDQzaei2CTrI0RcjeNH1fAH0618dkrTTfO+
	HOBrZESxN+gzMxMx9igpNj7ZtK4t5N7+gNllQ2AVcQSAbVtFUEzFG5Fv8QRZAs7X6Dbj
	beUw==
X-Gm-Message-State: APjAAAWE6c2DLHNmzdRJG/K332i/S2nUsncfgC4i++BaLTuEuYxsmzyK
	bR6CPibJmjvlkhXFc4uw2D4=
X-Google-Smtp-Source: APXvYqxVKsiXL1Z2wTAdpcGgdahPsNpSu6ApZ18dtwjjc5bXfkSvKuV99jMnkb11JfefA9bA7MQWPw==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr2139684wrv.248.1569575393628; 
	Fri, 27 Sep 2019 02:09:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	b62sm6037791wmc.13.2019.09.27.02.09.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Sep 2019 02:09:53 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
	behavior
Date: Fri, 27 Sep 2019 11:09:43 +0200
Message-Id: <20190927090947.11175-3-kholk11@gmail.com>
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

As also stated in the arm-smmu driver, we must write the TCR before
writing the TTBRs, since the TCR determines the access behavior of
some fields.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/iommu/qcom_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 5837556af147..8431fb97a50f 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -245,6 +245,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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
@@ -253,13 +260,6 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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
