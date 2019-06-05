Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7307EC28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C07F2075B
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxvqG2PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C07F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 705DED89;
	Wed,  5 Jun 2019 21:09:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B7C25D7A
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:09:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 67FDA19B
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:09:02 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id h17so39440pgv.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 05 Jun 2019 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ry1vQBxsMbP00vdiIcPrZlm4iIMXw6h5SGLwwG/iVbM=;
	b=VxvqG2PW0+5pSp9t5XCA4qowHutScYDHRE+nsLAcjwkD761a4tLnjjrKTbCLu5r/P5
	A3y9IdCB35zNuT4KlIhFtfr2gqIzPm2q3CCscrHUC3ttodvJI6lc4/l75psvQbELxPZ9
	8lOrONhJe4mXYue0Zaz8Kg413VqyaC+RFEeOZlZGYLCoNaDjIsK0rZ0+crw5uSHC9hqD
	Y0AR7672VjKnZlm44qEvrfmPKN/h8zW9V/htrWXI1cYQq5fj3cKiM3pjv7BsD1YpDNSp
	Cz7mECl9WTz15xhD74clwsWi0Da3MuyOIETFx9YDnaBM07TcGGiaGunskRGqq5O0X7Mw
	8BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ry1vQBxsMbP00vdiIcPrZlm4iIMXw6h5SGLwwG/iVbM=;
	b=X5VllkqLksWhvXj/gdfsItFuYHYXzP2XLUzeR+MrZN9RoXYNKFqyGyJa7Axl3D6GPN
	h4cvIQegqyQKfJQOO7VLmH5Gc/r/WaMBp9pSt/yqbbRHW+pWCfue9TUlAsu+hgMc8oyO
	N2ezIcmf/RrnMeT3kdmNuer0yG6rFHl/vpirrdhpFBMl1tTgPNQ7D8aSEiy84CxcT8Ei
	7FYqp1rk8roMxqhNQkGMf76taDuq24dfVcicFZCQIY70YHZ+dkeUqEId362aLqwGTnes
	437daCwR1ZK+1aoLUEjyQpmJnT0sfF+eiDgbEHZUCc2NApq+aWAifxb5Mo6uHiTanRkW
	F09Q==
X-Gm-Message-State: APjAAAWZ3S4zMRfZXAerfy5lzOYFfoq/WvVtg+1LGeOoB109bYWHP7Tn
	OCT3Kupq/kSF7A5Tu89S718aaQ==
X-Google-Smtp-Source: APXvYqwLjPbJRcoaAugB6k9b8sqHmGnHrT4H05jhzViLueVW5rfhjOYyfkZm+C2OANbT62nCKvlMNA==
X-Received: by 2002:a17:90a:b30a:: with SMTP id
	d10mr22253135pjr.8.1559768941840; 
	Wed, 05 Jun 2019 14:09:01 -0700 (PDT)
Received: from localhost.localdomain
	(104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
	by smtp.gmail.com with ESMTPSA id
	z68sm5093374pfb.37.2019.06.05.14.09.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 14:09:01 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC 2/2] iommu: arm-smmu: Don't blindly use first SMR to calculate
	mask
Date: Wed,  5 Jun 2019 14:08:56 -0700
Message-Id: <20190605210856.20677-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190605210856.20677-1-bjorn.andersson@linaro.org>
References: <20190605210856.20677-1-bjorn.andersson@linaro.org>
Cc: Patrick Daly <pdaly@codeaurora.org>, Jeffrey Hugo <jhugo@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

With the SMRs inherited from the bootloader the first SMR might actually
be valid and in use. As such probing the SMR mask using the first SMR
might break a stream in use. Search for an unused stream and use this to
probe the SMR mask.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c8629a656b42..0c6f5fe6f382 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1084,23 +1084,35 @@ static void arm_smmu_test_smr_masks(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 smr;
+	int idx;
 
 	if (!smmu->smrs)
 		return;
 
+	for (idx = 0; idx < smmu->num_mapping_groups; idx++) {
+		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
+		if (!(smr & SMR_VALID))
+			break;
+	}
+
+	if (idx == smmu->num_mapping_groups) {
+		dev_err(smmu->dev, "Unable to compute streamid_mask\n");
+		return;
+	}
+
 	/*
 	 * SMR.ID bits may not be preserved if the corresponding MASK
 	 * bits are set, so check each one separately. We can reject
 	 * masters later if they try to claim IDs outside these masks.
 	 */
 	smr = smmu->streamid_mask << SMR_ID_SHIFT;
-	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
-	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
+	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
 	smmu->streamid_mask = smr >> SMR_ID_SHIFT;
 
 	smr = smmu->streamid_mask << SMR_MASK_SHIFT;
-	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
-	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
+	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
 	smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
