Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA747C54FD2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ED120787
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGA3KLMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ED120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AAFD785D40;
	Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3_M81nIZXqo; Tue, 14 Apr 2020 17:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F52885DF6;
	Tue, 14 Apr 2020 17:04:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 845F9C1D8D;
	Tue, 14 Apr 2020 17:04:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8B11C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA4B485D7D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IASMh-J0YOGo for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CE95685D41
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:42 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id z6so14956867wml.2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kX7S6lLPtPxuthnaqmJScAqBjqH/apZcE9CXTwQeOvU=;
 b=UGA3KLMwsLNY89811V7EK3id91XIRFmER1PcDwpN6xrw1GtsOaQizxrRHRtGEE4TX3
 do1n0AFiqJF6QCTHbjBBQVWUHDTYjRFS4XwOivdCaMdJVcZ+EpuQGdACDtk5jJ/ALrk9
 QWkfPd8rxSd35yJXezznRHoO4af8sVb2YJHI6dIC9yyRjSbGXaAgyzJpjh5J52Jc+RGL
 hLOrTCp1qBgro6BphrKqLYQaG6dLMZ31qsFfaosesRKQkqeQP5unheE0t4aNORXh1gBn
 VVxXwA1j6xT4GQQP6HFNo1G8EqTDEoncXmNvd+5q+FMzHAwz4AFOArEfPYMYNEYf/6yH
 eumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kX7S6lLPtPxuthnaqmJScAqBjqH/apZcE9CXTwQeOvU=;
 b=B3HVkF33uMvvJbNrc+v8k0xRIVoa88tw6OxKYQ4y310LSELVBcE0LDikL0E92/ImKy
 ft5SfyQgjdAKupUy/S/ilYWn2iBa4kgD8g7oz005i7vASB9OyIA9oWXl08YjHNy324C2
 Tz7rWZT+DkH3+fM0FfoVEKIFlKUilQV7q/leRfBdEDyxNB7bPbvNSP1WKJd5jk56iuvd
 NL4qY3LbdrEZiC3jjD3kU4k6SCBXH/IOZwAS+dUeA/KdYW0zw1QYAeOv0MoIihdtjQRE
 GHF+YT7zsde9ZksIjwrF7xrKbJqyxY8K7nX2s7o0WFQl5VMcDGVLwQzcMAg98NjTC/Jv
 Bodw==
X-Gm-Message-State: AGi0PuZnj2azIHgdcvFVoM0vaIQNHAHVj68S7hYD251C51IQ48QDAA66
 42fEJCMUACPX4xarbw+gBv0seF9Um6bj5w==
X-Google-Smtp-Source: APiQypL0sw4GI3orm6Mwz7O2HA+cidMWHFaRPNOxNBIJlp7Uv38brpt7BnSl5ju9KFU9AbCgedQXVw==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr752667wmd.135.1586883880974; 
 Tue, 14 Apr 2020 10:04:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:40 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 16/25] iommu/arm-smmu-v3: Add SVA feature checking
Date: Tue, 14 Apr 2020 19:02:44 +0200
Message-Id: <20200414170252.714402-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, jgg@ziepe.ca, zhangfei.gao@linaro.org, will@kernel.org,
 christian.koenig@amd.com
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

Aggregate all sanity-checks for sharing CPU page tables with the SMMU
under a single ARM_SMMU_FEAT_SVA bit. For PCIe SVA, users also need to
check FEAT_ATS and FEAT_PRI. For platform SVA, they will most likely have
to check FEAT_STALLS.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: bump feature bit
---
 drivers/iommu/arm-smmu-v3.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e7de8a7459fa4..d209d85402a83 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -657,6 +657,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
 #define ARM_SMMU_FEAT_E2H		(1 << 16)
 #define ARM_SMMU_FEAT_BTM		(1 << 17)
+#define ARM_SMMU_FEAT_SVA		(1 << 18)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3930,6 +3931,74 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+static bool arm_smmu_supports_sva(struct arm_smmu_device *smmu)
+{
+	unsigned long reg, fld;
+	unsigned long oas;
+	unsigned long asid_bits;
+
+	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
+
+	if ((smmu->features & feat_mask) != feat_mask)
+		return false;
+
+	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
+		return false;
+
+	/*
+	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
+	 * not even pretending to support AArch32 here.
+	 */
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	switch (fld) {
+	case 0x0:
+		oas = 32;
+		break;
+	case 0x1:
+		oas = 36;
+		break;
+	case 0x2:
+		oas = 40;
+		break;
+	case 0x3:
+		oas = 42;
+		break;
+	case 0x4:
+		oas = 44;
+		break;
+	case 0x5:
+		oas = 48;
+		break;
+	case 0x6:
+		oas = 52;
+		break;
+	default:
+		return false;
+	}
+
+	/* abort if MMU outputs addresses greater than what we support. */
+	if (smmu->oas < oas)
+		return false;
+
+	/* We can support bigger ASIDs than the CPU, but not smaller */
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_ASID_SHIFT);
+	asid_bits = fld ? 16 : 8;
+	if (smmu->asid_bits < asid_bits)
+		return false;
+
+	/*
+	 * See max_pinned_asids in arch/arm64/mm/context.c. The following is
+	 * generally the maximum number of bindable processes.
+	 */
+	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		asid_bits--;
+	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -
+		num_possible_cpus() - 2);
+
+	return true;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -4142,6 +4211,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if (arm_smmu_supports_sva(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
