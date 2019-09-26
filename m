Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D47C4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AEE207FF
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGy6tD1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AEE207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C12BC128B;
	Thu, 26 Sep 2019 12:28:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2ED7C1189
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9FCF18A
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:22 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id q17so2151024wrx.10
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gVA/w0d2QWMzk0mJERhCeM6+8qnZiMPqI0NO/jhQ/j0=;
	b=cGy6tD1MRdVovih9rp/bCfOWWw14MpAMrP+XkmaHkV5XpsCX1VKcnoFuwLurkZkgqo
	mLI1DjGIq0yLEppfJPl5VsRuFPWP0JRNgXWA5YSKzrMphho4+Vt/Vnogl/bm6FLFX21e
	VMCk0VbY28C68hJLyqlmiqVtQjOpx6gQZvp33b/79YvORwxhU07ZpUxM79qMI5wlGzTH
	3x1ffVMm9Xzt1K8cySaIYJZOCWsyo0+Lnv8JT5HEUA4yFmf8oa7ueJSsAED3czogD83P
	Z1u7QyB0TNOM4yGNntYvv3ptx5cvynog6CXrjxwlq1UT9xd+dHvcT3TDVCkrqr2x/mDC
	4SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gVA/w0d2QWMzk0mJERhCeM6+8qnZiMPqI0NO/jhQ/j0=;
	b=V915QKCjwQpogBo8whO90YAMgbx+oYovxml9RIpPgeFf9nijmY4QaE8bfeE2meU+Er
	ac5DTLimqyoM/rmFH45Jx+IOCD/JAwXVdF8dJEKC0ZDWA3zX1TMZ9BRY+kJYS1GKgytv
	vqo0tzFL/Dz8NwhkwxyZhcXH6cBuG34CpBQjcfwADSg6ArI7WVZtNEoNxzdyCj4MVvQ9
	cghQXNrsTbTja8+K9VeyV8iTM0WkckhPK1OzZf/eJzX8vqs2jZTd4LZS9AArHQjxiY9Q
	qVWzO+zGLQGKIEU1+Y/i4l/xgTbmtLJdmOcKKpxh14j7HxbOXesZ9iNDb//uX0qQxzr/
	LT9g==
X-Gm-Message-State: APjAAAUTxCECLb2OQS3qeZvLqHSOJN0XNwaWwtlEtstlUfXz4GGnUgdq
	68YoWrZCKI8/PVXxdqoj7AY=
X-Google-Smtp-Source: APXvYqxdeIvz1c0FbYOZg6KWon1O1Msr3Uir5+wivy4bKJ4u8iKLs+/H/e0udgdoUCQIpIGHeRpvdg==
X-Received: by 2002:adf:e292:: with SMTP id v18mr2942943wri.232.1569499521180; 
	Thu, 26 Sep 2019 05:05:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	d193sm5289584wmd.0.2019.09.26.05.05.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 05:05:20 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
	behavior
Date: Thu, 26 Sep 2019 14:05:12 +0200
Message-Id: <20190926120516.4981-3-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926120516.4981-1-kholk11@gmail.com>
References: <20190926120516.4981-1-kholk11@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Sep 2019 12:28:08 +0000
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
