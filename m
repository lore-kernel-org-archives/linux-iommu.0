Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9871EC433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3F32078D
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm/7SGgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3F32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5236E878CD;
	Mon, 17 Aug 2020 22:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WNzrjFE2DS0I; Mon, 17 Aug 2020 22:02:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E8C9E878BB;
	Mon, 17 Aug 2020 22:02:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBE7AC088B;
	Mon, 17 Aug 2020 22:02:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 955B3C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D841878F0
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tdupC3PR5shO for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:02:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 122F4878E5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:46 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 17so8913706pfw.9
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kSk9Ml31XbJOG2f57h64F+Z+u/H7LjegKljJVlxq3/o=;
 b=nm/7SGgFRX0ihleRm7Q/XK7LVekmqJHuZ8oj9lP9CXD13fVd5gAP4NJNxTI0IaLTxZ
 6kwlK7LnBgaTtgYgQvAvN+F/TS+W036JQTWR5A95BntVFHtn1Egf507kL/nDY6eSYeiW
 S2hw4HSkdzN3br8ULMam/Io8JPcv962Y2NhD37Pge/yHTDasRg9THH5VYLxdIjds6dPu
 KAoc/Uazrql0SH+b2l4IieEO/bnVDC0zQLKK/twIMcQd9Uc3VOJ/cSZyXUzDPYlbQohr
 D2dVmTOcCWM9zWqDClw0UlKxGXIXJG2AGsnS/UUhwpVyTg3FnnmTZX+UFSp3voLU/YOW
 046w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSk9Ml31XbJOG2f57h64F+Z+u/H7LjegKljJVlxq3/o=;
 b=WAqewpO9MTjF+03BdvNn3wnZ1eaGl7ovGFoMhyDEUH18W5gOAYThMIKniaYJhHqNqW
 YCWyIdH4bgE8MCKr/t1Q/cRytw363k88DWwiBKB+IGiSW1gG0mW4eoNCAp0shg9MRUM7
 V0lZZqPsHfxTKJ9/yQmvz6esT+L4MVa5Ejl2hSyb/2LcfZM9MqgFkkVEKyQau2JpYW+I
 vhjuiIITe4RlTWJ+rFnu1mVdYRIGTGjGNKw2iak51agmwLIOqmn3YoLgYjvAtTZ7D4j+
 kGJiQhnN9gUkDHLVl9nO2vbdT3oh9necAqmr7cDG0jyh61YAOITSPjnrmZj8pYAnXCy8
 XQbw==
X-Gm-Message-State: AOAM531aARpV5Zc+2KiCFWBLCqpHLigIFA4mwmU2Ny5SqOnRFhSUGQki
 I2VdOC9+ZmlgTBtJ2r4lis8=
X-Google-Smtp-Source: ABdhPJyjHBznYe1foLjUKpz2EMXIaHb/X83JWzeO7X2OC6dD70uDdc8FCs5HAivVMepCakOji61d4Q==
X-Received: by 2002:aa7:9427:: with SMTP id y7mr12635340pfo.12.1597701765593; 
 Mon, 17 Aug 2020 15:02:45 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 g5sm21307016pfh.168.2020.08.17.15.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 15:02:44 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 08/20] iommu/arm-smmu: constify some helpers
Date: Mon, 17 Aug 2020 15:01:33 -0700
Message-Id: <20200817220238.603465-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817220238.603465-1-robdclark@gmail.com>
References: <20200817220238.603465-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
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

Sprinkle a few `const`s where helpers don't need write access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 59ff3fc5c6c8..27c83333fc50 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -377,7 +377,7 @@ struct arm_smmu_master_cfg {
 	s16				smendx[];
 };
 
-static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
 {
 	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
 		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
@@ -398,13 +398,13 @@ static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 	return tcr;
 }
 
-static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_tcr2(const struct io_pgtable_cfg *cfg)
 {
 	return FIELD_PREP(ARM_SMMU_TCR2_PASIZE, cfg->arm_lpae_s1_cfg.tcr.ips) |
 	       FIELD_PREP(ARM_SMMU_TCR2_SEP, ARM_SMMU_TCR2_SEP_UPSTREAM);
 }
 
-static inline u32 arm_smmu_lpae_vtcr(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_vtcr(const struct io_pgtable_cfg *cfg)
 {
 	return ARM_SMMU_VTCR_RES1 |
 	       FIELD_PREP(ARM_SMMU_VTCR_PS, cfg->arm_lpae_s2_cfg.vtcr.ps) |
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
