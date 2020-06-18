Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B3C433E2
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F29B2070A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDbtc15F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BFD788A0A;
	Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F41SWXRiUanV; Thu, 18 Jun 2020 15:52:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9DC388A25;
	Thu, 18 Jun 2020 15:52:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97317C088C;
	Thu, 18 Jun 2020 15:52:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3193BC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2136187BB5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWtYxCq7g5Xy for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:52:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4A12287BF9
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:50 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id l27so6978363ejc.1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MNKD6Dmbg1TaE6fvYxzmdVGqFWuaOjJYtMjLhWmnIvo=;
 b=fDbtc15FP1PMKFiVJC1xPK+dnPneh4gHR5Z5pyZz6iDbXrnrg7Gai4MJxSBwm5mM9v
 NGRaKISThUuuwgRt+TMw/RfEMNNwRvvCO988/Cysnqn3CIqtZE78iqHHATKrUvig9huz
 5bDTNN+8IoMVQimN2851pvQMREQWtJ9Y/CFGobZqLvRXU5qzw9C9YZmBwdZ6YbFi5CLN
 2ELl6LeunpXJFw9N3rafo00si6+tSLlbAoJPAInGGLozdmWbUReNSH6gjn+rshCdWJcQ
 PeYvdxW62Le2lQd7JDTWKinVvZq+ztbeM4jyLNX8bNHJB3Q3vj6RoJT4QVMe457y1ZGE
 erhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MNKD6Dmbg1TaE6fvYxzmdVGqFWuaOjJYtMjLhWmnIvo=;
 b=oaW9AabxCzBHRazcYjJJWBRB3VlUURseQiS2d1SdNvCvqbMgf0E78jRHdFCXnG9285
 ShYs+1+RVxmlOnh+qh3FPTNhxJMwFY2pxTMorTTqS4vNNNhp/r9413g06/jUxGjA2dfe
 gd2pbY01INu+Gf8EviGqAGfTn4IMGyT0zXRbEu2I6LPcGRkPtr29jL0+J5FKfkEcsI1j
 Bn/R8saMBVs3X+7w/qwU9RSREzcfNl8DG/faP51cTcQ/9PNC359BJ7TPvB/j8wFcEQpm
 /7TfydNb9OPEcK1fDamZ95vSul2YtK8Jfgfgub7fL4Nm8iNEwvswhb4AtiA8XqHVeZmn
 nVfA==
X-Gm-Message-State: AOAM533/DoA/kGL1UfWhrD8PKjDuX5cqvgk+k6EgHAss6y0o+kav7zEW
 Qv0RzHRh+Ip6n+RWies9HMWqFN1h9nLRzg==
X-Google-Smtp-Source: ABdhPJztByorObtVQlxC6WShKEAqlvU9oXK33GgelOz6P5sV8o7rZktu08Gnv9xaL32FeH+u69sT9A==
X-Received: by 2002:a17:906:4e59:: with SMTP id
 g25mr4478633ejw.60.1592495568467; 
 Thu, 18 Jun 2020 08:52:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 63sm2402267edy.8.2020.06.18.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:52:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v8 09/12] iommu/arm-smmu-v3: Check for SVA features
Date: Thu, 18 Jun 2020 17:51:22 +0200
Message-Id: <20200618155125.1548969-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618155125.1548969-1-jean-philippe@linaro.org>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
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
v7->v8: Use id_aa64mmfr0_parange_to_phys_shift()
---
 drivers/iommu/arm-smmu-v3.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5506add42c9c8..e2d5171bfb7b9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -654,6 +654,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
+#define ARM_SMMU_FEAT_BTM		(1 << 16)
+#define ARM_SMMU_FEAT_SVA		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3894,6 +3896,49 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
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
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -4093,6 +4138,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if (arm_smmu_supports_sva(smmu))
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
