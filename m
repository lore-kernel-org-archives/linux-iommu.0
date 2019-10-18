Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA5CA9EA9
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870AE222C2
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NpCxPfSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870AE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C28ACDD1;
	Fri, 18 Oct 2019 23:31:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81985DD1
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 23:31:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7A1A970D
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 23:31:23 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5daa4b560000>; Fri, 18 Oct 2019 16:31:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate102.nvidia.com (PGP Universal service);
	Fri, 18 Oct 2019 16:31:23 -0700
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Fri, 18 Oct 2019 16:31:23 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Fri, 18 Oct 2019 23:31:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
	(172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Fri, 18 Oct 2019 23:31:22 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5daa4b4a0003>; Fri, 18 Oct 2019 16:31:22 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v3 1/7] iommu/arm-smmu: prepare arm_smmu_flush_ops for override
Date: Fri, 18 Oct 2019 16:31:26 -0700
Message-ID: <1571441492-21919-2-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1571441494; bh=hMkE9ZACb4SbwMYn549vbE/y19Mk47U2KnAgbKeRx6c=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	Content-Type;
	b=NpCxPfSmbNRVMHyo8bhyoYuE3elFGxOnLaSNYVxZR3UN7ZKbLp7UXsgMBMdOfMycq
	00J3awjjfInoDH9Ca6nbt9y2Qcl8XlnKri2F/ZmcVi9WtYj8qgDgxYKd/NvDs2xQwP
	nDzd3bqWokJ7pVRGsGT9sqBY49NQ9F5LDMNzQeles3YYc1CHJwugXN4zdQt2c9UCLj
	FU6zsHRfCsFwvdHkgrPdgYWE70ul8nYAgLx/lKr/+qW+H4iRc9VnOQ01Z0HEZ9uBW8
	TTJPOBnM0V7+Rn09W8XBCkjhNvyu82XEP1LXD6yZtchgmDLGTGoh8shBkBuv/JVB70
	vhuIrQBNyXFVA==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, will@kernel.org,
	linux-kernel@vger.kernel.org, praithatha@nvidia.com,
	talho@nvidia.com, iommu@lists.linux-foundation.org,
	nicolinc@nvidia.com, linux-tegra@vger.kernel.org,
	yhsu@nvidia.com, treding@nvidia.com, robin.murphy@arm.com,
	avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
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

Remove const keyword for arm_smmu_flush_ops in arm_smmu_domain
and replace direct references to arm_smmu_tlb_sync* functions with
arm_smmu_flush_ops->tlb_sync().
This is necessary for vendor specific implementations that
need to override arm_smmu_flush_ops in part or full.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++--------
 drivers/iommu/arm-smmu.h |  4 +++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 91af695..fc0b27d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,9 +52,6 @@
  */
 #define QCOM_DUMMY_VAL -1
 
-#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
-#define TLB_SPIN_COUNT			10
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -290,6 +287,8 @@ static void arm_smmu_tlb_sync_vmid(void *cookie)
 static void arm_smmu_tlb_inv_context_s1(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
+
 	/*
 	 * The TLBI write may be relaxed, so ensure that PTEs cleared by the
 	 * current CPU are visible beforehand.
@@ -297,18 +296,19 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
 	wmb();
 	arm_smmu_cb_write(smmu_domain->smmu, smmu_domain->cfg.cbndx,
 			  ARM_SMMU_CB_S1_TLBIASID, smmu_domain->cfg.asid);
-	arm_smmu_tlb_sync_context(cookie);
+	ops->tlb_sync(cookie);
 }
 
 static void arm_smmu_tlb_inv_context_s2(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
 
 	/* See above */
 	wmb();
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_TLBIVMID, smmu_domain->cfg.vmid);
-	arm_smmu_tlb_sync_global(smmu);
+	ops->tlb_sync(cookie);
 }
 
 static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
@@ -410,7 +410,7 @@ static void arm_smmu_tlb_add_page(struct iommu_iotlb_gather *gather,
 	ops->tlb_inv_range(iova, granule, granule, true, cookie);
 }
 
-static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
+static struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
@@ -421,7 +421,7 @@ static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
 	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
-static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
+static struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
@@ -432,7 +432,7 @@ static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
-static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
+static struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index b19b6ca..b2d6c7f 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -207,6 +207,8 @@ enum arm_smmu_cbar_type {
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
 
+#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
 
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
@@ -314,7 +316,7 @@ struct arm_smmu_flush_ops {
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
-	const struct arm_smmu_flush_ops	*flush_ops;
+	struct arm_smmu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	bool				non_strict;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
