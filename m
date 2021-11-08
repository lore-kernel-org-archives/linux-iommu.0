Return-Path: <SRS0=5Ucf=P3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEECC433EF
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BAE6109E
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3BAE6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8835A40195;
	Mon,  8 Nov 2021 17:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0IBZAUTaIub; Mon,  8 Nov 2021 17:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48FB240150;
	Mon,  8 Nov 2021 17:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22273C0012;
	Mon,  8 Nov 2021 17:12:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9A2C000E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2816640271
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vT7oJBI0P5W for <iommu@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:12:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7C09402EC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:12:28 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id b4so15706790pgh.10
 for <iommu@lists.linux-foundation.org>; Mon, 08 Nov 2021 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hGvO+FT4c2EJbxVYCDLmWLN/y9tCrxnSNXxEMsXuwNQ=;
 b=PEXo9EJ8iyOs6JYtLc/77yuf3gv2+qmOaRxZ/t9gKovlJPftYz0nG0N+vgAMQrzQ4i
 kNkOdJBlkeE/hZ6MODTHJLLrwXgvJnT/K6EX0chnqcK2yGVtopLE3UZg2leAGvZbl3LN
 64kttVS3G4UKARK1dMYKiUjOGmY8M4KlUB4uGdl56x8atLwBvciap3B2qM5Ve4ah0rbR
 JHeHvQRBp6QyA02S3Ok6G2ObBMX0tOjwcBU/elZbj5iChuMAeeb29F1iO9YXCuDr0WmS
 3dA5OVsnzNLM6MuM5kv8tGGk+wI0/n1LaF7IdCi20tMea79itbKo6koYALO1VLXF6R48
 n96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hGvO+FT4c2EJbxVYCDLmWLN/y9tCrxnSNXxEMsXuwNQ=;
 b=mUS4NJ+9MstPf9o54dFCksqKYhhbyk4BsqtazKa8KAjCZ7mxD73UJ8OdxVEOtwAKFx
 F0eqWPWA/1aijGXPj9geBOgAN1mRx2uW33CA6SdXnYtKyQtrQZR0zEg1aKZePuZfhySP
 0SspZ8KmKfMBhF4DjbBZIY0kA/yWuEVco50MozfyWen01CuJ33tavsVv/rIa3n9mBfj3
 AnQrOTK2sJsN3udRgenayt6g1wi8kyT5w4ZLdsfejwNmpWhbWc+gCzZlNBZnX5KxXz5x
 FT8GqdElmKVzJkbaUHlO2uEzvN6j+Ob6ecuJm6/JAdea4DXw56d2g1D5ITB1/R7zIRd5
 nYgQ==
X-Gm-Message-State: AOAM530dFaZGGIYV/p5fZLFduR6IaeAznDy+PaqKgfQyZRlpx0rdtFXt
 WxeK8mKxD+54P0akJkAIjmZJUFQtkBI=
X-Google-Smtp-Source: ABdhPJzliYBpPaMk022dk/QMrNH7Vg6W2agrDSJIDzTqNmxTzHAPQJOF1S2MqpYK5Ecosi0pxfxalA==
X-Received: by 2002:a62:5ec2:0:b0:44d:47e2:4b3b with SMTP id
 s185-20020a625ec2000000b0044d47e24b3bmr82851281pfb.38.1636391547336; 
 Mon, 08 Nov 2021 09:12:27 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 p16sm12810610pgd.78.2021.11.08.09.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 09:12:26 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu-qcom: Fix TTBR0 read
Date: Mon,  8 Nov 2021 09:17:23 -0800
Message-Id: <20211108171724.470973-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Shawn Guo <shawn.guo@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 Will Deacon <will@kernel.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

From: Rob Clark <robdclark@chromium.org>

It is a 64b register, lets not lose the upper bits.

Fixes: ab5df7b953d8 ("iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault info")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 55690af1b25d..c998960495b4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -51,7 +51,7 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
 	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
 	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
-	info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
+	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
 	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
 }
 
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
