Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91EC433F4
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D976B207BB
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTNtyx73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D976B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AE7388655C;
	Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id keKHn1EAJWi7; Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2BACA86932;
	Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1108CC0050;
	Thu, 23 Jul 2020 15:06:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD296C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A280A86932
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bbVZd2Lg_bfI for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C43AC8665E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:59 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id l4so6704540ejd.13
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A7i0TfeVtbmivmToJFYuNh5KNdNgY1vTU0jTEZh4S44=;
 b=DTNtyx73PEuwQyesbHMqyc9KRfKpkQLrDtcn1RgI9i4L3sTyOvObkePC3pFEX6wvt2
 MIPUw9T6dRpslzm2jPvmVSks4HcWd+hvazFQVLaoWPm4qT56MkiVBeTrDo0ymJnURpj2
 vtenI7sn7dpZj89RA0UTYa8k4TPsuWpYkHVMIPHJig94Dckhm80dkYcfoZaio9agcS3n
 xLhN7up9sW+t4vIeI5iXyj10DWuVy1aOXj157IP5Zw1Wvms2VzR7c2e//IYe0g83KWLS
 lL5EaldElZ6lyNR+eS+uTZrqidD/jtYbmwQjF5wEK/8KQOm0TvzjICgChVhbUs29LV1G
 0cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A7i0TfeVtbmivmToJFYuNh5KNdNgY1vTU0jTEZh4S44=;
 b=bi5TqDryXuY+W9vQNg12Lz6L4N0OFLBoetI17ZixQli05xLbc5qOtcIJ/M8OSg/YMy
 mBpQ6R+2O2aQVjUBKUPXxAiTCzKR+TvCy7tOHvO86qGDzSXOEYnupAf6p/XeV8zNN7Uc
 FOtKj3u4bz794a92BB/SQvYs2VLstg5u+kMHVuFYbYSFdE9u2mofUF0Kf2ZFzm3oJakg
 oi//uYGpIj1hcAGZoeKOGuLo9MvEfTecD8a8AZrwnIib4frHPjfWW7A5U+KGjhyK7O1B
 RQQ3pyzpyq5IefYK6UpIRcwXXsjBPWzMUw3TDo2SYQV5UGsXWnudWS5Bnao3Sviy7LKA
 QL+A==
X-Gm-Message-State: AOAM533ahKwXstRGTwEf3D/DDGt0+7VqAoIdpS06U4nLZofpqVJQlnS5
 bgxDbfOLIOVCEHXnZxUAm/UB/SZ3qaA=
X-Google-Smtp-Source: ABdhPJyMNuQc7O5Fnv72xrZh/TQxEiIO6uTWkERHUtAM85C0vk1UvtHsBd9/BzGHJAnoYUE3RVudEw==
X-Received: by 2002:a17:906:4e87:: with SMTP id
 v7mr4736862eju.242.1595516757878; 
 Thu, 23 Jul 2020 08:05:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:57 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 10/13] iommu/arm-smmu-v3: Check for SVA features
Date: Thu, 23 Jul 2020 16:57:22 +0200
Message-Id: <20200723145724.3014766-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 robin.murphy@arm.com, hch@infradead.org, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
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
 drivers/iommu/arm-smmu-v3.h     | 10 ++++++++
 drivers/iommu/arm-smmu-v3-sva.c | 43 +++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu-v3.c     |  3 +++
 3 files changed, 56 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.h b/drivers/iommu/arm-smmu-v3.h
index 90c08f156b43..7b14b48a26c7 100644
--- a/drivers/iommu/arm-smmu-v3.h
+++ b/drivers/iommu/arm-smmu-v3.h
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
diff --git a/drivers/iommu/arm-smmu-v3-sva.c b/drivers/iommu/arm-smmu-v3-sva.c
index d590c864bdf3..eedc6c8264f1 100644
--- a/drivers/iommu/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm-smmu-v3-sva.c
@@ -153,3 +153,46 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 		kfree(cd);
 	}
 }
+
+bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
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
+	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		asid_bits--;
+	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -
+		num_possible_cpus() - 2);
+
+	return true;
+}
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4a47b977ed01..558973e3cc1b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3258,6 +3258,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if (arm_smmu_sva_supported(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
