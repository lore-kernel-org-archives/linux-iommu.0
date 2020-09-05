Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40013C2D0A7
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09DA2074D
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8jgMxll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09DA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F98785F75;
	Sat,  5 Sep 2020 20:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvBScV3MQP5e; Sat,  5 Sep 2020 20:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C405A85F8B;
	Sat,  5 Sep 2020 20:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0E12C07FF;
	Sat,  5 Sep 2020 20:04:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AF9C0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1BDC48626D
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HkqpzQ9sZGKK for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 20:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3878085F8B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:28 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 67so6055820pgd.12
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nv0NB+4QKtoM6jAPeQvhvbaLuTfjjxZvGCIP8sMMMgk=;
 b=f8jgMxllP2ZhgGqg89bgtt8ZyUJhkMwLlHRMKbccobZzftlPpGbHnCV+Azd45nGZyi
 ust7FDQKJp1QB5Y+cJQ0iu2dJp5MH8vorVkcc/S4Ie6Tpc8fWCmXTOtPZU2kIOUwOJHz
 GzhwNHXk3Rd6qMIq3VMtYoUn/m6nQU3sxluz7i/S+yevS40lwJreR7rSeFL0lXZRbNQQ
 8kXeukGW6G8fwuvBU00qnMT9hevhOPmhXH2QANA3cEj/frKrntyhPvyFdUAdDkj+M2qZ
 BpaIummG75mBAHKb1H5kZtDV6tzBTMly3h8q9S7SLurz5Ns92HD4OWAe5pZQZwEMG5Z1
 cMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nv0NB+4QKtoM6jAPeQvhvbaLuTfjjxZvGCIP8sMMMgk=;
 b=aGLuyXuYttaC5xeLws4PR8QRenJ6/2qh4f9MnCGdtVLcgbBU4ldDKUhDCQrWJyxbap
 P++R/SVn5ysENUTGDkLzMKgTDHmZnl66aJB4rl2j/7AkC+wS/JeUcUXbaCXWQA/IFDIZ
 ItJDgR8Tc3QFdci6sjEAFYAvbr3cMWFn3XsISSrd/ERcZXDGYP51oacAKWhnX2b107T0
 WCiHuxO8mNS8rpW75IlbrsIf0DE/MCp1ewa0Lu8dDKW1Ci5oAIIMFPwW1GbOmL+XEUhc
 2CgvkkrWukSx0Gta7vAvXEFlxpb/wbzyS788cwBEPwud3gbgV2uVexn84mYR1yRAT5A+
 b9fg==
X-Gm-Message-State: AOAM5302Eyh6BKJmqRwKb+W0ihnEhyfdr/VsUGoFLyjw0a69P9fZ9UCl
 4GDlYCDdGWHh+cCZ8TZZ6EcoRnaCwOvLns+cqSM=
X-Google-Smtp-Source: ABdhPJwAuA2HNXcVlwfVFfpq4juLWYioWTISVISa1sNhGs+f4u4OXcvGiOMrt2RZ2RQEjzHPfCeBSA==
X-Received: by 2002:a63:f546:: with SMTP id e6mr11430161pgk.7.1599336266922;
 Sat, 05 Sep 2020 13:04:26 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 x9sm5193620pfj.96.2020.09.05.13.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:04:25 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v17 08/20] drm/msm: Add support to create a local pagetable
Date: Sat,  5 Sep 2020 13:04:14 -0700
Message-Id: <20200905200454.240929-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Add support to create a io-pgtable for use by targets that support
per-instance pagetables. In order to support per-instance pagetables the
GPU SMMU device needs to have the qcom,adreno-smmu compatible string and
split pagetables enabled.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/Kconfig      |   1 +
 drivers/gpu/drm/msm/msm_gpummu.c |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c  | 199 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h    |  16 ++-
 4 files changed, 215 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 6deaa7d01654..5102a58830b9 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -8,6 +8,7 @@ config DRM_MSM
 	depends on MMU
 	depends on INTERCONNECT || !INTERCONNECT
 	depends on QCOM_OCMEM || QCOM_OCMEM=n
+	select IOMMU_IO_PGTABLE
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 310a31b05faa..aab121f4beb7 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -102,7 +102,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
 	}
 
 	gpummu->gpu = gpu;
-	msm_mmu_init(&gpummu->base, dev, &funcs);
+	msm_mmu_init(&gpummu->base, dev, &funcs, MSM_MMU_GPUMMU);
 
 	return &gpummu->base;
 }
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 1b6635504069..697cc0a059d6 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -4,15 +4,210 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/adreno-smmu-priv.h>
+#include <linux/io-pgtable.h>
 #include "msm_drv.h"
 #include "msm_mmu.h"
 
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
+	atomic_t pagetables;
 };
+
 #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
 
+struct msm_iommu_pagetable {
+	struct msm_mmu base;
+	struct msm_mmu *parent;
+	struct io_pgtable_ops *pgtbl_ops;
+	phys_addr_t ttbr;
+	u32 asid;
+};
+static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
+{
+	return container_of(mmu, struct msm_iommu_pagetable, base);
+}
+
+static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
+		size_t size)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	size_t unmapped = 0;
+
+	/* Unmap the block one page at a time */
+	while (size) {
+		unmapped += ops->unmap(ops, iova, 4096, NULL);
+		iova += 4096;
+		size -= 4096;
+	}
+
+	iommu_flush_tlb_all(to_msm_iommu(pagetable->parent)->domain);
+
+	return (unmapped == size) ? 0 : -EINVAL;
+}
+
+static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
+		struct sg_table *sgt, size_t len, int prot)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	struct scatterlist *sg;
+	size_t mapped = 0;
+	u64 addr = iova;
+	unsigned int i;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		size_t size = sg->length;
+		phys_addr_t phys = sg_phys(sg);
+
+		/* Map the block one page at a time */
+		while (size) {
+			if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
+				msm_iommu_pagetable_unmap(mmu, iova, mapped);
+				return -EINVAL;
+			}
+
+			phys += 4096;
+			addr += 4096;
+			size -= 4096;
+			mapped += 4096;
+		}
+	}
+
+	return 0;
+}
+
+static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
+	struct adreno_smmu_priv *adreno_smmu =
+		dev_get_drvdata(pagetable->parent->dev);
+
+	/*
+	 * If this is the last attached pagetable for the parent,
+	 * disable TTBR0 in the arm-smmu driver
+	 */
+	if (atomic_dec_return(&iommu->pagetables) == 0)
+		adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL);
+
+	free_io_pgtable_ops(pagetable->pgtbl_ops);
+	kfree(pagetable);
+}
+
+int msm_iommu_pagetable_params(struct msm_mmu *mmu,
+		phys_addr_t *ttbr, int *asid)
+{
+	struct msm_iommu_pagetable *pagetable;
+
+	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
+		return -EINVAL;
+
+	pagetable = to_pagetable(mmu);
+
+	if (ttbr)
+		*ttbr = pagetable->ttbr;
+
+	if (asid)
+		*asid = pagetable->asid;
+
+	return 0;
+}
+
+static const struct msm_mmu_funcs pagetable_funcs = {
+		.map = msm_iommu_pagetable_map,
+		.unmap = msm_iommu_pagetable_unmap,
+		.destroy = msm_iommu_pagetable_destroy,
+};
+
+static void msm_iommu_tlb_flush_all(void *cookie)
+{
+}
+
+static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
+		size_t granule, void *cookie)
+{
+}
+
+static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
+		unsigned long iova, size_t granule, void *cookie)
+{
+}
+
+static const struct iommu_flush_ops null_tlb_ops = {
+	.tlb_flush_all = msm_iommu_tlb_flush_all,
+	.tlb_flush_walk = msm_iommu_tlb_flush_walk,
+	.tlb_flush_leaf = msm_iommu_tlb_flush_walk,
+	.tlb_add_page = msm_iommu_tlb_add_page,
+};
+
+struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
+{
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(parent->dev);
+	struct msm_iommu *iommu = to_msm_iommu(parent);
+	struct msm_iommu_pagetable *pagetable;
+	const struct io_pgtable_cfg *ttbr1_cfg = NULL;
+	struct io_pgtable_cfg ttbr0_cfg;
+	int ret;
+
+	/* Get the pagetable configuration from the domain */
+	if (adreno_smmu->cookie)
+		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
+	if (!ttbr1_cfg)
+		return ERR_PTR(-ENODEV);
+
+	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
+	if (!pagetable)
+		return ERR_PTR(-ENOMEM);
+
+	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
+		MSM_MMU_IOMMU_PAGETABLE);
+
+	/* Clone the TTBR1 cfg as starting point for TTBR0 cfg: */
+	ttbr0_cfg = *ttbr1_cfg;
+
+	/* The incoming cfg will have the TTBR1 quirk enabled */
+	ttbr0_cfg.quirks &= ~IO_PGTABLE_QUIRK_ARM_TTBR1;
+	ttbr0_cfg.tlb = &null_tlb_ops;
+
+	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
+		&ttbr0_cfg, iommu->domain);
+
+	if (!pagetable->pgtbl_ops) {
+		kfree(pagetable);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * If this is the first pagetable that we've allocated, send it back to
+	 * the arm-smmu driver as a trigger to set up TTBR0
+	 */
+	if (atomic_inc_return(&iommu->pagetables) == 1) {
+		ret = adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, &ttbr0_cfg);
+		if (ret) {
+			free_io_pgtable_ops(pagetable->pgtbl_ops);
+			kfree(pagetable);
+			return ERR_PTR(ret);
+		}
+	}
+
+	/* Needed later for TLB flush */
+	pagetable->parent = parent;
+	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
+
+	/*
+	 * TODO we would like each set of page tables to have a unique ASID
+	 * to optimize TLB invalidation.  But iommu_flush_tlb_all() will
+	 * end up flushing the ASID used for TTBR1 pagetables, which is not
+	 * what we want.  So for now just use the same ASID as TTBR1.
+	 */
+	pagetable->asid = 0;
+
+	return &pagetable->base;
+}
+
 static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
@@ -85,9 +280,11 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 		return ERR_PTR(-ENOMEM);
 
 	iommu->domain = domain;
-	msm_mmu_init(&iommu->base, dev, &funcs);
+	msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
 	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
 
+	atomic_set(&iommu->pagetables, 0);
+
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
 		kfree(iommu);
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 3a534ee59bf6..61ade89d9e48 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -17,18 +17,26 @@ struct msm_mmu_funcs {
 	void (*destroy)(struct msm_mmu *mmu);
 };
 
+enum msm_mmu_type {
+	MSM_MMU_GPUMMU,
+	MSM_MMU_IOMMU,
+	MSM_MMU_IOMMU_PAGETABLE,
+};
+
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
 	struct device *dev;
 	int (*handler)(void *arg, unsigned long iova, int flags);
 	void *arg;
+	enum msm_mmu_type type;
 };
 
 static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
-		const struct msm_mmu_funcs *funcs)
+		const struct msm_mmu_funcs *funcs, enum msm_mmu_type type)
 {
 	mmu->dev = dev;
 	mmu->funcs = funcs;
+	mmu->type = type;
 }
 
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
@@ -41,7 +49,13 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 	mmu->handler = handler;
 }
 
+struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
+
 void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
 		dma_addr_t *tran_error);
 
+
+int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
+		int *asid);
+
 #endif /* __MSM_MMU_H__ */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
