Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE05C43468
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6932075E
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMspNNNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6932075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E693D2E202;
	Fri, 18 Sep 2020 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4-kHhWIpBam; Fri, 18 Sep 2020 10:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0DE9A20421;
	Fri, 18 Sep 2020 10:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4858C0888;
	Fri, 18 Sep 2020 10:20:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D3BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6FFA1872E7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zd43GXuAEHbR for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 79546872DD
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:08 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id o8so7339757ejb.10
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ppexd/REPulso7a/SQN5p1VFYhNreYqFPFz4NNHKguM=;
 b=RMspNNNnlrZQ8s4m1aWkDon9WpmuNnz6jsD6dV5/j4TlYlrn+HQ5O7Qg8CY9rzRyuG
 DBTxkmZ/ASg28+ovauyCuC+wE7+grdljDaRUhXsVhlecAC1J87C8Boo6jbvAJ8aDAtDV
 RoRSbDe8yU6ksKQdE54mbsxXDOZ6I2aRzMj1v2dsRUyfkqAlOt+D+pTCRpF//GFqiGY4
 CJfZ+5cugJ90wPRogcOI+0vzMO80aXVGCt49YWFJOj/CjxpU/oWddqW68WbVTQeasjji
 iUutBoWIzhe8xAu0yct1CxQlvdgBMTrsSYqAMdQKP8RjMtf0Pu5JWPB4dDQUOoosdylc
 BgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ppexd/REPulso7a/SQN5p1VFYhNreYqFPFz4NNHKguM=;
 b=YMdFjhnPSmqxNG8RSuReX542dE/a0W9T2zeJpLjIfFVMFFHnBn2HFoliXieuL616xO
 ABPidIDFptVBH66aviikCzWhEZ/ppPOZRbeZlTXMSezm/hl1Ww1Ks/cYnCTElOqd157S
 IUctbFi+igT+3oE78/SSlhU7rIeePV/a8Oo8fCo4sFKi/t2n5Q/z1Did1noGGYYbebSM
 WdxrOoXh5gWsmRIbBJ1F7JxkhLZ/g4fXIH/RPkGt2+VTFHpmw+tEhrBZvUosuUMnUYcE
 gmgSdI+0tIA6/Kjd7VQIJBFKFgGAow7E9ZF6/gYlE2W5cdXZHxn5xFJ46hvn1/7Ci5fY
 TQ4Q==
X-Gm-Message-State: AOAM5304nAxOaAjAx0+K6yCaHs6Hzeeq4d8YHO789z4+rgSZZDITttjJ
 nah4vQD1UFKNt01/CyQdV7S0zHmXPIAOrRuT
X-Google-Smtp-Source: ABdhPJwDHjw1UGkF9Pov1jbX5MrQ6n49RNZ4HI4KZ0BLu/Dky+2lK9TIhBuooRxMN9OkyrgWwwJ1+g==
X-Received: by 2002:a17:906:f90c:: with SMTP id
 lc12mr34583753ejb.104.1600424406477; 
 Fri, 18 Sep 2020 03:20:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:20:05 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Date: Fri, 18 Sep 2020 12:18:50 +0200
Message-Id: <20200918101852.582559-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 robin.murphy@arm.com, zhangfei.gao@linaro.org, will@kernel.org
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
check FEAT_ATS and FEAT_PRI. For platform SVA, they will have to check
FEAT_STALLS.

Introduce ARM_SMMU_FEAT_BTM (Broadcast TLB Maintenance), but don't
enable it at the moment. Since the entire VMID space is shared with the
CPU, enabling DVM (by clearing SMMU_CR2.PTM) could result in
over-invalidation and affect performance of stage-2 mappings.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10:
* Check that 52-bit VA is supported on the SMMU side if vabits_actual
  requires it.
* Check arm64_kernel_unmapped_at_el0() instead of
  CONFIG_UNMAP_KERNEL_AT_EL0
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 45 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 ++
 3 files changed, 58 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 90c08f156b43..7b14b48a26c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -602,6 +602,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
+#define ARM_SMMU_FEAT_BTM		(1 << 16)
+#define ARM_SMMU_FEAT_SVA		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -683,4 +685,12 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 
+#ifdef CONFIG_ARM_SMMU_V3_SVA
+bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
+#else /* CONFIG_ARM_SMMU_V3_SVA */
+static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
+{
+	return false;
+}
+#endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ef3fcfa72187..cb94c0924196 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -152,3 +152,48 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 		kfree(cd);
 	}
 }
+
+bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
+{
+	unsigned long reg, fld;
+	unsigned long oas;
+	unsigned long asid_bits;
+	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
+
+	if (vabits_actual == 52)
+		feat_mask |= ARM_SMMU_FEAT_VAX;
+
+	if ((smmu->features & feat_mask) != feat_mask)
+		return false;
+
+	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
+		return false;
+
+	/*
+	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
+	 * not even pretending to support AArch32 here. Abort if the MMU outputs
+	 * addresses larger than what we support.
+	 */
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	oas = id_aa64mmfr0_parange_to_phys_shift(fld);
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
+	if (arm64_kernel_unmapped_at_el0())
+		asid_bits--;
+	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -
+		num_possible_cpus() - 2);
+
+	return true;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e99ebdd4c841..44c57bcfe112 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3257,6 +3257,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if (arm_smmu_sva_supported(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
