Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B5C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:39:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674622083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674622083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F39B10AF;
	Thu, 15 Aug 2019 18:38:09 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C35F5109B
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp2.linuxfoundation.org (Postfix) with ESMTP id 3375D1DDC8
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:38:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD47E1570;
	Thu, 15 Aug 2019 11:38:05 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 695D83F694; 
	Thu, 15 Aug 2019 11:38:04 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 15/17] iommu/arm-smmu: Add configuration implementation hook
Date: Thu, 15 Aug 2019 19:37:35 +0100
Message-Id: <73f4b0bf9cf6478917c618011363b6cf06566a65.1565892337.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565892337.git.robin.murphy@arm.com>
References: <cover.1565892337.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Probing the ID registers and setting up the SMMU configuration is an
area where overrides and workarounds may well be needed. Indeed, the
Cavium workaround detection lives there at the moment, so let's break
that out.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-impl.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 17 +++--------------
 drivers/iommu/arm-smmu.h      |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 0657c85580cb..696417908793 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -47,8 +47,42 @@ const struct arm_smmu_impl calxeda_impl = {
 };
 
 
+static int cavium_cfg_probe(struct arm_smmu_device *smmu)
+{
+	static atomic_t context_count = ATOMIC_INIT(0);
+	/*
+	 * Cavium CN88xx erratum #27704.
+	 * Ensure ASID and VMID allocation is unique across all SMMUs in
+	 * the system.
+	 */
+	smmu->cavium_id_base = atomic_fetch_add(smmu->num_context_banks,
+						   &context_count);
+	dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
+
+	return 0;
+}
+
+const struct arm_smmu_impl cavium_impl = {
+	.cfg_probe = cavium_cfg_probe,
+};
+
+
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
+	/*
+	 * We will inevitably have to combine model-specific implementation
+	 * quirks with platform-specific integration quirks, but everything
+	 * we currently support happens to work out as straightforward
+	 * mutually-exclusive assignments.
+	 */
+	switch (smmu->model) {
+	case CAVIUM_SMMUV2:
+		smmu->impl = &cavium_impl;
+		break;
+	default:
+		break;
+	}
+
 	if (of_property_read_bool(smmu->dev->of_node,
 				  "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 432d781f05f3..362b6b5a28ee 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -155,8 +155,6 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
-static atomic_t cavium_smmu_context_count = ATOMIC_INIT(0);
-
 static bool using_legacy_binding, using_generic_binding;
 
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
@@ -1804,18 +1802,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	}
 	dev_notice(smmu->dev, "\t%u context banks (%u stage-2 only)\n",
 		   smmu->num_context_banks, smmu->num_s2_context_banks);
-	/*
-	 * Cavium CN88xx erratum #27704.
-	 * Ensure ASID and VMID allocation is unique across all SMMUs in
-	 * the system.
-	 */
-	if (smmu->model == CAVIUM_SMMUV2) {
-		smmu->cavium_id_base =
-			atomic_add_return(smmu->num_context_banks,
-					  &cavium_smmu_context_count);
-		smmu->cavium_id_base -= smmu->num_context_banks;
-		dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
-	}
 	smmu->cbs = devm_kcalloc(smmu->dev, smmu->num_context_banks,
 				 sizeof(*smmu->cbs), GFP_KERNEL);
 	if (!smmu->cbs)
@@ -1884,6 +1870,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
 			   smmu->ipa_size, smmu->pa_size);
 
+	if (smmu->impl && smmu->impl->cfg_probe)
+		return smmu->impl->cfg_probe(smmu);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d4fd29d70705..f4e90f33fce2 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -287,6 +287,7 @@ struct arm_smmu_impl {
 	u64 (*read_reg64)(struct arm_smmu_device *smmu, int page, int offset);
 	void (*write_reg64)(struct arm_smmu_device *smmu, int page, int offset,
 			    u64 val);
+	int (*cfg_probe)(struct arm_smmu_device *smmu);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
