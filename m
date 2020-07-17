Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A052C433EB
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D90F207EA
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGrAw2FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D90F207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44A5388086;
	Fri, 17 Jul 2020 00:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3W2I+8p4lMB; Fri, 17 Jul 2020 00:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2E2E88069;
	Fri, 17 Jul 2020 00:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABBF2C07FF;
	Fri, 17 Jul 2020 00:16:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31242C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1D0F788271
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRpTqqHSVYUz for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C9A688262
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id a24so4502372pfc.10
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iuuJuMaKgUlLRcc6gFCZ7HFqvJc6qzprtp/8FUZq9U4=;
 b=oGrAw2FWu08q1/KU6m+pJhAwavDgdIcPCeC2VO0HBZ36u6jVuMdY/1nf8t3PfztDxd
 UrUWUVv0AnWLdoKgefsdSYVgpZ4NShv34c7RawVdolP1zjCL4B7AapAXY3oXguBRoRCk
 PF7+1abGWRfMifqD+JULmyLXmWqVVqxxGalfipSqKUxJKGVGQ7TKDI8yZKyevy5YgWxZ
 hSf2uxu+JjBVs9go3Z0QmwRI8M8NXaIWEXiYdzEZdGq9x0D7Fe6x5rpTci8Z2TXY5VGF
 jHPoBeSe8mZhLDOeSB3SGkZLm4ZnuqsBMDyArUSRqy5ww1GBBGt/gDcd4aeLhToTI/hF
 JDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iuuJuMaKgUlLRcc6gFCZ7HFqvJc6qzprtp/8FUZq9U4=;
 b=fNAspKiZljGcUevsKzh0lwiqmGjOZIRdm7DZ8uiROPJ+Z9mm+veN3ukpXrk5EsZGSo
 tfjgxT1XA7OdJxO3L5BlCYWvO5ehkC+YDUJZLQt86kH943SWGJinrAaZ6ZtIYYyCNMUr
 +acJuvQYxWn1daTYDRNQW+oNUcCuMqhEFyucLK5ZiitNUUhOiPl3dSxdwQbHy16ef77w
 c2i9np2w4e+jfWCrAT6sv8C7Lh7YPUqLTFfCNIJaoFn5eyTHScqPddD7xKmhCrZGu4ms
 qB/2ZwX9oHpHcWsncFT3bQqQs4SSjpVBKSYcZSBhtBheLIAdMwPH5MTwtW9C9x1cfqp+
 R1Xg==
X-Gm-Message-State: AOAM532EiVlawUZcNH2ClJJUYj2N8jOZ9bjrPqRgwYA3G+j6GL+pc0of
 aR9WomeFP5/8ljjsLM4I1QblGQ==
X-Google-Smtp-Source: ABdhPJwSZZ9bKl9IV9ztWA8mR2McxctG8Dmv5bJM8VuXAimbsGQd1EoPEyeJ0iHJ6beRLFNWkuNlnA==
X-Received: by 2002:a63:1e4d:: with SMTP id p13mr6161160pgm.387.1594944987760; 
 Thu, 16 Jul 2020 17:16:27 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 17:16:27 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 4/5] iommu/arm-smmu-qcom: Consistently initialize stream
 mappings
Date: Thu, 16 Jul 2020 17:16:18 -0700
Message-Id: <20200717001619.325317-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 linux-arm-kernel@lists.infradead.org
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

Firmware that traps writes to S2CR to translate BYPASS into FAULT also
ignores writes of type FAULT. As such booting with "disable_bypass" set
will result in all S2CR registers left as configured by the bootloader.

This has been seen to result in indeterministic results, as these
mappings might linger and reference context banks that Linux is
reconfiguring.

Use the fact that BYPASS writes result in FAULT type to force all stream
mappings to FAULT.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed subject spelling mistake
- Picked up tested-by

 drivers/iommu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index d95a5ee8c83c..10eb024981d1 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -27,6 +27,7 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	u32 reg;
+	int i;
 
 	/*
 	 * With some firmware writes to S2CR of type FAULT are ignored, and
@@ -37,9 +38,24 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 					    FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
 					    FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
 	reg = arm_smmu_gr0_read(smmu, last_s2cr);
-	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		smmu->qcom_bypass_quirk = true;
 
+		/*
+		 * With firmware ignoring writes of type FAULT, booting the
+		 * Linux kernel with disable_bypass disabled (i.e. "enable
+		 * bypass") the initialization during probe will leave mappings
+		 * in an inconsistent state. Avoid this by configuring all
+		 * S2CRs to BYPASS.
+		 */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count = 0;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
