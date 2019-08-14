Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF02C433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:05:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C7F2084F
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C7F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A5934E39;
	Wed, 14 Aug 2019 18:04:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A43D1DD6
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DC49A8D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6001596;
	Wed, 14 Aug 2019 10:56:48 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A4DF3F694; 
	Wed, 14 Aug 2019 10:56:45 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 03/13] iommu/io-pgtable: Rename iommu_gather_ops to
	iommu_flush_ops
Date: Wed, 14 Aug 2019 18:56:24 +0100
Message-Id: <20190814175634.21081-4-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814175634.21081-1-will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

In preparation for TLB flush gathering in the IOMMU API, rename the
iommu_gather_ops structure in io-pgtable to iommu_flush_ops, which
better describes its purpose and avoids the potential for confusion
between different levels of the API.

$ find linux/ -type f -name '*.[ch]' | xargs sed -i 's/gather_ops/flush_ops/g'

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 drivers/iommu/arm-smmu-v3.c             | 4 ++--
 drivers/iommu/arm-smmu.c                | 8 ++++----
 drivers/iommu/io-pgtable-arm-v7s.c      | 2 +-
 drivers/iommu/io-pgtable-arm.c          | 2 +-
 drivers/iommu/ipmmu-vmsa.c              | 4 ++--
 drivers/iommu/msm_iommu.c               | 4 ++--
 drivers/iommu/mtk_iommu.c               | 4 ++--
 drivers/iommu/qcom_iommu.c              | 4 ++--
 include/linux/io-pgtable.h              | 6 +++---
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 92ac995dd9c6..17bceb11e708 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -257,7 +257,7 @@ static void mmu_tlb_sync_context(void *cookie)
 	// TODO: Wait 1000 GPU cycles for HW_ISSUE_6367/T60X
 }
 
-static const struct iommu_gather_ops mmu_tlb_ops = {
+static const struct iommu_flush_ops mmu_tlb_ops = {
 	.tlb_flush_all	= mmu_tlb_inv_context_s1,
 	.tlb_add_flush	= mmu_tlb_inv_range_nosync,
 	.tlb_sync	= mmu_tlb_sync_context,
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9a9fabd3968..7e137e1e28f1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1603,7 +1603,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
-static const struct iommu_gather_ops arm_smmu_gather_ops = {
+static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
@@ -1796,7 +1796,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.ias		= ias,
 		.oas		= oas,
 		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
-		.tlb		= &arm_smmu_gather_ops,
+		.tlb		= &arm_smmu_flush_ops,
 		.iommu_dev	= smmu->dev,
 	};
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 64977c131ee6..dc08db347ef3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -251,7 +251,7 @@ enum arm_smmu_domain_stage {
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
-	const struct iommu_gather_ops	*tlb_ops;
+	const struct iommu_flush_ops	*tlb_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	bool				non_strict;
@@ -547,19 +547,19 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 
-static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
+static const struct iommu_flush_ops arm_smmu_s1_tlb_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
-static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
+static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
-static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
+static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index a62733c6a632..116f97ee991e 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -817,7 +817,7 @@ static void dummy_tlb_sync(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static const struct iommu_gather_ops dummy_tlb_ops = {
+static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0d6633921c1e..402f913b6f6d 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1081,7 +1081,7 @@ static void dummy_tlb_sync(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static const struct iommu_gather_ops dummy_tlb_ops __initconst = {
+static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ad0098c0c87c..2c14a2c65b22 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -367,7 +367,7 @@ static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
 	/* The hardware doesn't support selective TLB flush. */
 }
 
-static const struct iommu_gather_ops ipmmu_gather_ops = {
+static const struct iommu_flush_ops ipmmu_flush_ops = {
 	.tlb_flush_all = ipmmu_tlb_flush_all,
 	.tlb_add_flush = ipmmu_tlb_add_flush,
 	.tlb_sync = ipmmu_tlb_flush_all,
@@ -480,7 +480,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
 	domain->cfg.ias = 32;
 	domain->cfg.oas = 40;
-	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->cfg.tlb = &ipmmu_flush_ops;
 	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	domain->io_domain.geometry.force_aperture = true;
 	/*
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b25e2eb9e038..8b602384a385 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -178,7 +178,7 @@ static void __flush_iotlb_sync(void *cookie)
 	 */
 }
 
-static const struct iommu_gather_ops msm_iommu_gather_ops = {
+static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_flush_all = __flush_iotlb,
 	.tlb_add_flush = __flush_iotlb_range,
 	.tlb_sync = __flush_iotlb_sync,
@@ -345,7 +345,7 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 		.pgsize_bitmap = msm_iommu_ops.pgsize_bitmap,
 		.ias = 32,
 		.oas = 32,
-		.tlb = &msm_iommu_gather_ops,
+		.tlb = &msm_iommu_flush_ops,
 		.iommu_dev = priv->dev,
 	};
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 82e4be4dfdaf..fed77658d67e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -188,7 +188,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
 	}
 }
 
-static const struct iommu_gather_ops mtk_iommu_gather_ops = {
+static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
 	.tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
 	.tlb_sync = mtk_iommu_tlb_sync,
@@ -267,7 +267,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = 32,
 		.oas = 32,
-		.tlb = &mtk_iommu_gather_ops,
+		.tlb = &mtk_iommu_flush_ops,
 		.iommu_dev = data->dev,
 	};
 
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 34d0b9783b3e..fd9d9f4da735 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -164,7 +164,7 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	}
 }
 
-static const struct iommu_gather_ops qcom_gather_ops = {
+static const struct iommu_flush_ops qcom_flush_ops = {
 	.tlb_flush_all	= qcom_iommu_tlb_inv_context,
 	.tlb_add_flush	= qcom_iommu_tlb_inv_range_nosync,
 	.tlb_sync	= qcom_iommu_tlb_sync,
@@ -215,7 +215,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
 		.ias		= 32,
 		.oas		= 40,
-		.tlb		= &qcom_gather_ops,
+		.tlb		= &qcom_flush_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b5a450a3bb47..6292ea15d674 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -17,7 +17,7 @@ enum io_pgtable_fmt {
 };
 
 /**
- * struct iommu_gather_ops - IOMMU callbacks for TLB and page table management.
+ * struct iommu_flush_ops - IOMMU callbacks for TLB and page table management.
  *
  * @tlb_flush_all: Synchronously invalidate the entire TLB context.
  * @tlb_add_flush: Queue up a TLB invalidation for a virtual address range.
@@ -28,7 +28,7 @@ enum io_pgtable_fmt {
  * Note that these can all be called in atomic context and must therefore
  * not block.
  */
-struct iommu_gather_ops {
+struct iommu_flush_ops {
 	void (*tlb_flush_all)(void *cookie);
 	void (*tlb_add_flush)(unsigned long iova, size_t size, size_t granule,
 			      bool leaf, void *cookie);
@@ -84,7 +84,7 @@ struct io_pgtable_cfg {
 	unsigned int			ias;
 	unsigned int			oas;
 	bool				coherent_walk;
-	const struct iommu_gather_ops	*tlb;
+	const struct iommu_flush_ops	*tlb;
 	struct device			*iommu_dev;
 
 	/* Low-level data specific to the table format */
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
