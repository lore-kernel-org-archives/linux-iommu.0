Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D4C31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B64220820
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 48F46DA7;
	Fri,  9 Aug 2019 17:08:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27275DA7
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9F35567F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3226B15AB;
	Fri,  9 Aug 2019 10:08:23 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE2553F575; 
	Fri,  9 Aug 2019 10:08:21 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 07/15] iommu/arm-smmu: Abstract GR1 accesses
Date: Fri,  9 Aug 2019 18:07:44 +0100
Message-Id: <d7a11cc69061effe3de8de640a5a1ddcd30284fe.1565369764.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
References: <cover.1565369764.git.robin.murphy@arm.com>
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

Introduce some register access abstractions which we will later use to
encapsulate various quirks. GR1 is the easiest page to start with.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 544c992cf586..72505647b77d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -71,7 +71,6 @@
 
 /* SMMU global address space */
 #define ARM_SMMU_GR0(smmu)		((smmu)->base)
-#define ARM_SMMU_GR1(smmu)		((smmu)->base + (1 << (smmu)->pgshift))
 
 /*
  * SMMU global address space with conditional offset to access secure
@@ -250,6 +249,25 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+static void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
+{
+	return smmu->base + (n << smmu->pgshift);
+}
+
+static u32 arm_smmu_readl(struct arm_smmu_device *smmu, int page, int offset)
+{
+	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
+}
+
+static void arm_smmu_writel(struct arm_smmu_device *smmu, int page, int offset,
+			    u32 val)
+{
+	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
+}
+
+#define arm_smmu_read_gr1(s, r)		arm_smmu_readl((s), 1, (r))
+#define arm_smmu_write_gr1(s, r, v)	arm_smmu_writel((s), 1, (r), (v))
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -574,7 +592,6 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
 	void __iomem *cb_base;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
@@ -585,7 +602,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
-	cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
+	cbfrsynra = arm_smmu_read_gr1(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 
 	dev_err_ratelimited(smmu->dev,
 	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
@@ -676,7 +693,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	bool stage1;
 	struct arm_smmu_cb *cb = &smmu->cbs[idx];
 	struct arm_smmu_cfg *cfg = cb->cfg;
-	void __iomem *cb_base, *gr1_base;
+	void __iomem *cb_base;
 
 	cb_base = ARM_SMMU_CB(smmu, idx);
 
@@ -686,7 +703,6 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		return;
 	}
 
-	gr1_base = ARM_SMMU_GR1(smmu);
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 
 	/* CBA2R */
@@ -699,7 +715,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		if (smmu->features & ARM_SMMU_FEAT_VMID16)
 			reg |= FIELD_PREP(CBA2R_VMID16, cfg->vmid);
 
-		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(idx));
+		arm_smmu_write_gr1(smmu, ARM_SMMU_GR1_CBA2R(idx), reg);
 	}
 
 	/* CBAR */
@@ -718,7 +734,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		/* 8-bit VMIDs live in CBAR */
 		reg |= FIELD_PREP(CBAR_VMID, cfg->vmid);
 	}
-	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
+	arm_smmu_write_gr1(smmu, ARM_SMMU_GR1_CBAR(idx), reg);
 
 	/*
 	 * TCR
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
