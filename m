Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9903C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775A32083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775A32083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B53FE10B6;
	Thu, 15 Aug 2019 18:37:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A78C107D
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0DF46CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C90344;
	Thu, 15 Aug 2019 11:37:51 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 629A23F694; 
	Thu, 15 Aug 2019 11:37:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 06/17] iommu/arm-smmu: Rework cb_base handling
Date: Thu, 15 Aug 2019 19:37:26 +0100
Message-Id: <8856992662ff638e01fa7227cffb73fcff7bc5bb.1565892337.git.robin.murphy@arm.com>
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

To keep register-access quirks manageable, we want to structure things
to avoid needing too many individual overrides. It seems fairly clean to
have a single interface which handles both global and context registers
in terms of the architectural pages, so the first preparatory step is to
rework cb_base into a page number rather than an absolute address.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a877de006d02..19126230c780 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -95,7 +95,7 @@
 #endif
 
 /* Translation context bank */
-#define ARM_SMMU_CB(smmu, n)	((smmu)->cb_base + ((n) << (smmu)->pgshift))
+#define ARM_SMMU_CB(smmu, n)	((smmu)->base + (((smmu)->numpage + (n)) << (smmu)->pgshift))
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -168,8 +168,8 @@ struct arm_smmu_device {
 	struct device			*dev;
 
 	void __iomem			*base;
-	void __iomem			*cb_base;
-	unsigned long			pgshift;
+	unsigned int			numpage;
+	unsigned int			pgshift;
 
 #define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
 #define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
@@ -1815,7 +1815,7 @@ static int arm_smmu_id_size_to_bits(int size)
 
 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned long size;
+	unsigned int size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
 	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
@@ -1899,7 +1899,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			return -ENOMEM;
 
 		dev_notice(smmu->dev,
-			   "\tstream matching with %lu register groups", size);
+			   "\tstream matching with %u register groups", size);
 	}
 	/* s2cr->type == 0 means translation, so initialise explicitly */
 	smmu->s2crs = devm_kmalloc_array(smmu->dev, size, sizeof(*smmu->s2crs),
@@ -1925,11 +1925,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 << (FIELD_GET(ID1_NUMPAGENDXB, id) + 1);
-	size <<= smmu->pgshift;
-	if (smmu->cb_base != gr0_base + size)
+	if (smmu->numpage != 2 * size << smmu->pgshift)
 		dev_warn(smmu->dev,
-			"SMMU address space size (0x%lx) differs from mapped region size (0x%tx)!\n",
-			size * 2, (smmu->cb_base - gr0_base) * 2);
+			"SMMU address space size (0x%x) differs from mapped region size (0x%x)!\n",
+			2 * size << smmu->pgshift, smmu->numpage);
+	/* Now properly encode NUMPAGE to subsequently derive SMMU_CB_BASE */
+	smmu->numpage = size;
 
 	smmu->num_s2_context_banks = FIELD_GET(ID1_NUMS2CB, id);
 	smmu->num_context_banks = FIELD_GET(ID1_NUMCB, id);
@@ -2200,7 +2201,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
-	smmu->cb_base = smmu->base + resource_size(res) / 2;
+	/*
+	 * The resource size should effectively match the value of SMMU_TOP;
+	 * stash that temporarily until we know PAGESIZE to validate it with.
+	 */
+	smmu->numpage = resource_size(res);
 
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
