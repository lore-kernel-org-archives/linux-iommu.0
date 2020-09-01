Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9BC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8A12067C
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0HjAU+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8A12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC31D86AB6;
	Tue,  1 Sep 2020 16:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqyjqw2t3wjI; Tue,  1 Sep 2020 16:47:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E6DC866AF;
	Tue,  1 Sep 2020 16:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF83C0052;
	Tue,  1 Sep 2020 16:47:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4AFC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0EC0F862C1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ixc9E2ID6NwU for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 41FEA86360
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:07 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id np15so873509pjb.0
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FYkuDdKfZnq0C2m032hzkvhRzd15B2Kmt9oLbZcU5c=;
 b=o0HjAU+eO0eVEW69ynSmkWf0X28KnBPwmaRZJNBxYK2FEwYPSfbXtrDRKMWcPYxJ8x
 z9/ceSjNKIk+9TMYg4tdnV5uE80khfkGQpxt4TXLf7+jywEoZKkbdUcDn98xWEAq5oZx
 xHbRFRzuM4ttZOAx4WwnL7+brWiaLq8WTd0SmFO8/ey2Hp2fyi2cGgmyp6lOtFxkb13c
 qNic/o+FL5IF9rYTAjBb62NQ11vRZTzoMYBMNYmAgK6lq8j81VGgj+yaO7RWZwmL99QZ
 ws5tpHaiuawCLWD0uk5Garqc1CcmVxEcO4rrvh0/ubax51wtSEdZVWk/oNufULl4ATbt
 qjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2FYkuDdKfZnq0C2m032hzkvhRzd15B2Kmt9oLbZcU5c=;
 b=lE7zMv/dCXoMdTvIjaZ9cHZ7mRIwtIkp30rv54JXg920srieTXc2sFIKJWKAiDsCAN
 WiSOoeZO2lt5rehSR08N15m7CID7UPoawKLDnTjIhBCFqhTqs1TQJjXUvgJkO5DEMrl8
 Wbg/R3ziOHyHQx7Csx62mGJcfb0Ek/LrqpA48pmDru7R7A1i3gRZpfJcwnTkcljaxLNU
 o455qKSA2/cT8NSfDgJTm2SndLZ5IpPNKF7kAjxb2J6YXfr7XQwbZKczpYu1e1Rk6z72
 qKw/rLndiFj9KHq2MqJHH3qpxBGw9cgoKtFLfsetj3yiZ4Ma+Aiwab3mYC2KoCoCxMtz
 21WA==
X-Gm-Message-State: AOAM531W7/sKIoG1CL2TVwm6Z1ic1Pk/khwsMmFIxec2MF2xdnp1gBhf
 KFmnHl9EzJpv/vttY7Urcgg=
X-Google-Smtp-Source: ABdhPJyZrrMMvdwtDYnjzNN0ZavE7E4JxesijLNi3COZopUMe83ivyVwsBJpkaFA/L4BrcggzGwCYQ==
X-Received: by 2002:a17:90b:384d:: with SMTP id
 nl13mr2412923pjb.227.1598978826758; 
 Tue, 01 Sep 2020 09:47:06 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id bx18sm2062725pjb.6.2020.09.01.09.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:47:05 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 12/20] iommu/arm-smmu: Pass io-pgtable config to
 implementation specific function
Date: Tue,  1 Sep 2020 09:46:29 -0700
Message-Id: <20200901164707.2645413-13-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Hanna Hawa <hannah@marvell.com>,
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Construct the io-pgtable config before calling the implementation specific
init_context function and pass it so the implementation specific function
can get a chance to change it before the io-pgtable is created.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 11 ++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index f4ff124a1967..a9861dcd0884 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
+static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg)
 {
 	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
 					      struct cavium_smmu, smmu);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 09c42af9f31e..37d8d49299b4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -795,11 +795,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->asid = cfg->cbndx;
 
 	smmu_domain->smmu = smmu;
-	if (smmu->impl && smmu->impl->init_context) {
-		ret = smmu->impl->init_context(smmu_domain);
-		if (ret)
-			goto out_unlock;
-	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
@@ -810,6 +805,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
+	if (smmu->impl && smmu->impl->init_context) {
+		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
+		if (ret)
+			goto out_clear_smmu;
+	}
+
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index d890a4a968e8..83294516ac08 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -386,7 +386,8 @@ struct arm_smmu_impl {
 			    u64 val);
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
-	int (*init_context)(struct arm_smmu_domain *smmu_domain);
+	int (*init_context)(struct arm_smmu_domain *smmu_domain,
+			struct io_pgtable_cfg *cfg);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 	int (*def_domain_type)(struct device *dev);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
