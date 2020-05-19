Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D822C433F7
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673F920826
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVRPa4zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673F920826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4857086D5D;
	Tue, 19 May 2020 18:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZKQZZCUo4Pl; Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B031C86D2E;
	Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8131C0890;
	Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC0CAC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CB1FF86D59
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DL9vo6oLuAlI for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF3A486D2A
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:58 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id 50so367733wrc.11
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MElXxFUU4SmUEJg24asfPA/yzXG4FEYdFM842ev0uCE=;
 b=CVRPa4zD/VPnA7aSmXfjFudzYbQzAkt2fDPLVKyp+6lkKXjtkMxOo9eKi63QXyKhsR
 idydtFvzsoUMqwomO1K3gnLoko0DRoGb4XjFwFYeNrJ0UnnDf760n4L7Z3iZK2nNjqKc
 qzEDw7iJt229mzJLqo33oKuUwmUMxFLk7qLzrj/R1ZAUDRNXQUeyYewC12f9znuOrbd1
 mESDGceVEL7Eb24fn6dF4WJYPiJtmj8zMhlIHnQk4EyANomkIVzoEIi95nuy6wyFyDyV
 2dRxdWZIZL5mseHHVRWCg9eco6IoWkDjQ/BDlsAwgvFkwfRZONYUigvNvwFVmhXBmXIl
 Ko3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MElXxFUU4SmUEJg24asfPA/yzXG4FEYdFM842ev0uCE=;
 b=h3Vwz4z1Fgl3sTp2F44FDlrSQ4dlvtzMzSkTrF9WAjLf5ZiGG/41BojgbNHVe1LNro
 c3TJBefYdraLZPx9PLdvhGfnnUpXGwOjqcuiY28D6bfHdcHgMkr88xR3XDRoYgVcK65z
 ZqfkosiDUAmtj/a+QE2YvYvLeS1kHtf0kIVMREWo1toI0BC9A0HZ48RCs+OYl7EElzNk
 urE1FWOsJtJFlO8ZhR/Z65HwGrqwJvusrYqyDleUWgKDNLQuKeYAs/yJRXN+Fjn4gEbW
 TafuiLWKiPgNxuG1I+5NpxlJRsYMo6rkWepZe16bZ8YHU3wSzEZL/VvKUwEOLhRtaVYG
 BrVQ==
X-Gm-Message-State: AOAM530BsVSe1ewLxdyiynULYS8JyCqYnpuNOsluX/tGkQtDMQpItPVs
 BbSAfP1jeTBlOWxFtjIruMJct8BRRSu2pA==
X-Google-Smtp-Source: ABdhPJyUX7XmnpA8DeuBDVrI8G0XF2iDcX0m67gXquuRRNHmvZchB0Xi1muHbYRZPMsVS4WxVUNdhw==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr90184wrv.155.1589911317146;
 Tue, 19 May 2020 11:01:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB maintenance
Date: Tue, 19 May 2020 19:54:51 +0200
Message-Id: <20200519175502.2504091-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

The SMMUv3 can handle invalidation targeted at TLB entries with shared
ASIDs. If the implementation supports broadcast TLB maintenance, enable it
and keep track of it in a feature bit. The SMMU will then be affected by
inner-shareable TLB invalidations from other agents.

A major side-effect of this change is that stage-2 translation contexts
are now affected by all invalidations by VMID. VMIDs are all shared and
the only ways to prevent over-invalidation, since the stage-2 page tables
are not shared between CPU and SMMU, are to either disable BTM or allocate
different VMIDs. This patch does not address the problem.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7e1933e7e35f..9332253e3608 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -56,6 +56,7 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -658,6 +659,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
 #define ARM_SMMU_FEAT_E2H		(1 << 16)
+#define ARM_SMMU_FEAT_BTM		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3819,11 +3821,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-	reg = CR2_PTM | CR2_RECINVSID;
+	reg = CR2_RECINVSID;
 
 	if (smmu->features & ARM_SMMU_FEAT_E2H)
 		reg |= CR2_E2H;
 
+	if (!(smmu->features & ARM_SMMU_FEAT_BTM))
+		reg |= CR2_PTM;
+
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
 
 	/* Stream table */
@@ -3934,6 +3939,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	bool vhe = cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN);
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -3983,10 +3989,19 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_HYP) {
 		smmu->features |= ARM_SMMU_FEAT_HYP;
-		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		if (vhe)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	/*
+	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
+	 * will create TLB entries for NH-EL1 world and will miss the
+	 * broadcasted TLB invalidations that target EL2-E2H world. Don't enable
+	 * BTM in that case.
+	 */
+	if (reg & IDR0_BTM && (!vhe || reg & IDR0_HYP))
+		smmu->features |= ARM_SMMU_FEAT_BTM;
+
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
