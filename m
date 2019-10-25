Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71005CA9EA0
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB86205F4
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB86205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C7B14DDD;
	Fri, 25 Oct 2019 18:08:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7744AE1A
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DCCF187E
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F749492;
	Fri, 25 Oct 2019 11:08:49 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCE923F6C4; 
	Fri, 25 Oct 2019 11:08:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 07/10] iommu/io-pgtable-arm: Rationalise MAIR handling
Date: Fri, 25 Oct 2019 19:08:36 +0100
Message-Id: <c6bee9e6de5e7f4aa2293ee5385ffa2dd95600d3.1572024120.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1572024119.git.robin.murphy@arm.com>
References: <cover.1572024119.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Between VMSAv8-64 and the various 32-bit formats, there is either one
64-bit MAIR or a pair of 32-bit MAIR0/MAIR1 or NMRR/PMRR registers.
As such, keeping two 64-bit values in io_pgtable_cfg has always been
overkill.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c    | 2 +-
 drivers/iommu/arm-smmu.c       | 4 ++--
 drivers/iommu/io-pgtable-arm.c | 3 +--
 drivers/iommu/ipmmu-vmsa.c     | 2 +-
 drivers/iommu/qcom_iommu.c     | 4 ++--
 include/linux/io-pgtable.h     | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..3f20e548f1ec 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2172,7 +2172,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
-	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
+	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 	return 0;
 
 out_free_asid:
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 080af0326816..2bc3e93b11e6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -552,8 +552,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			cb->mair[0] = pgtbl_cfg->arm_v7s_cfg.prrr;
 			cb->mair[1] = pgtbl_cfg->arm_v7s_cfg.nmrr;
 		} else {
-			cb->mair[0] = pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
-			cb->mair[1] = pgtbl_cfg->arm_lpae_s1_cfg.mair[1];
+			cb->mair[0] = pgtbl_cfg->arm_lpae_s1_cfg.mair;
+			cb->mair[1] = pgtbl_cfg->arm_lpae_s1_cfg.mair >> 32;
 		}
 	}
 }
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 15b4927ce36b..1795df8f7a51 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -861,8 +861,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	      (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
 	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE));
 
-	cfg->arm_lpae_s1_cfg.mair[0] = reg;
-	cfg->arm_lpae_s1_cfg.mair[1] = 0;
+	cfg->arm_lpae_s1_cfg.mair = reg;
 
 	/* Looking good; allocate a pgd */
 	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9da8309f7170..e4da6efbda49 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -438,7 +438,7 @@ static void ipmmu_domain_setup_context(struct ipmmu_vmsa_domain *domain)
 
 	/* MAIR0 */
 	ipmmu_ctx_write_root(domain, IMMAIR0,
-			     domain->cfg.arm_lpae_s1_cfg.mair[0]);
+			     domain->cfg.arm_lpae_s1_cfg.mair);
 
 	/* IMBUSCR */
 	if (domain->mmu->features->setup_imbuscr)
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c31e7bc4ccbe..66e9b40e9275 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -284,9 +284,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		/* MAIRs (stage-1 only) */
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair[0]);
+				pgtbl_cfg.arm_lpae_s1_cfg.mair);
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair[1]);
+				pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32);
 
 		/* SCTLR */
 		reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE |
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ec7a13405f10..ee21eedafe98 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -102,7 +102,7 @@ struct io_pgtable_cfg {
 		struct {
 			u64	ttbr[2];
 			u64	tcr;
-			u64	mair[2];
+			u64	mair;
 		} arm_lpae_s1_cfg;
 
 		struct {
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
