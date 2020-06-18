Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC1C433E1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2220888
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3rq2hPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5AF3387B08;
	Thu, 18 Jun 2020 15:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9z3uSNG0Iot; Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4355E87C29;
	Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30136C088C;
	Thu, 18 Jun 2020 15:52:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11200C089E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EFBBB87C29
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YIcXhoCgrLF4 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:52:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A277E87C41
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:52 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id q19so6942050eja.7
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZuZSIKZP3e6lWCHyBpmCAdFcfA2fkGVm1e+K1v+Ant0=;
 b=F3rq2hPxOLLhcTkt0qXcmgkdti/SxA0Grlpb18yg1aqay3xp7saO7yaI5cJDrwNGU9
 7YzJSsMWNHBgA8tjL/TKszprqUhJZ2rxejsrejBhQXpziLn58+b6UTqLuiAYehEKmkU9
 i/Z3FzVcQRpWCmkkDlz0h0M9NhLsCLrMbDJCcyugK58ZkQzG7PYygeDXpUxg6AMOOuAT
 ElVKAq+V4tbKwK8OAuGOaK4LkH+lYtozfz0PzAt+DxmXYWvkE413Uj+2gdjl2jJTdKDJ
 YnUCvfWN1cC5XWokXC50laaYfF7W2292OEVTTaBN0HEHVpHaZErrJIg1q4mhOAiF9pHg
 BKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZuZSIKZP3e6lWCHyBpmCAdFcfA2fkGVm1e+K1v+Ant0=;
 b=DPcTNf5RH8tJKedM1nWKtV5rwtGRD01m/CMsHRuenSyja2XeIeTij6LbjBmc++b8fB
 nxdu1HNzp4w0+c3uGNBiNweUockdWzoqEdOOMQlIhnNU4woG4if9i9oX5TMYbRWEsF5p
 OG1I2qmebr6XjQZ4pvuWy9PIyFKTRs5v8as7YVErV3voa53Vd4bVwzC+muQAau3q8Xe/
 J6zdQTCZU9jHBHp14cEhJ4dvEG3Ks7m50rKrYkWGbtTvQd3yrjP7dVoVIrJFlSFWHwS/
 Mm6gHWzPuTJQnu8E+ce/gRYBwsK+D/fZXhqZEAXW6yasJD4U2GbwZAFGjGK1ZdZz0HOD
 y+Cg==
X-Gm-Message-State: AOAM530i6jKT373aQyy12omrln6yc6u7yopocr5oY4MiBd1o+BCp+Oi3
 Q+peJCyOqDYvgvLIrQzqB1THRcbybkk8OA==
X-Google-Smtp-Source: ABdhPJxCAIkVq2rLjUObspQLQB8nCyvTQOzGP/GfT0DoAcdczzKtcZexhFXO/NIEgpFwmTF2mlsfag==
X-Received: by 2002:a17:906:241b:: with SMTP id
 z27mr4457689eja.267.1592495570579; 
 Thu, 18 Jun 2020 08:52:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 63sm2402267edy.8.2020.06.18.08.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:52:50 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v8 11/12] iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
Date: Thu, 18 Jun 2020 17:51:24 +0200
Message-Id: <20200618155125.1548969-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618155125.1548969-1-jean-philippe@linaro.org>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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

The sva_bind() function allows devices to access process address spaces
using a PASID (aka SSID).

(1) bind() allocates or gets an existing MMU notifier tied to the
    (domain, mm) pair. Each mm gets one PASID.

(2) Any change to the address space calls invalidate_range() which sends
    ATC invalidations (in a subsequent patch).

(3) When the process address space dies, the release() notifier disables
    the CD to allow reclaiming the page tables. Since release() has to
    be light we do not instruct device drivers to stop DMA here, we just
    ignore incoming page faults from this point onwards.

    To avoid any event 0x0a print (C_BAD_CD) we disable translation
    without clearing CD.V. PCIe Translation Requests and Page Requests
    are silently denied. Don't clear the R bit because the S bit can't
    be cleared when STALL_MODEL==0b10 (forced), and clearing R without
    clearing S is useless. Faulting transactions will stall and will be
    aborted by the IOPF handler.

(4) After stopping DMA, the device driver releases the bond by calling
    unbind(). We release the MMU notifier, free the PASID and the bond.

Three structures keep track of bonds:
* arm_smmu_bond: one per {device, mm} pair, the handle returned to the
  device driver for a bind() request.
* arm_smmu_mmu_notifier: one per {domain, mm} pair, deals with ATS/TLB
  invalidations and clearing the context descriptor on mm exit.
* arm_smmu_ctx_desc: one per mm, holds the pinned ASID and pgd.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig       |   2 +
 drivers/iommu/arm-smmu-v3.c | 263 +++++++++++++++++++++++++++++++++++-
 2 files changed, 260 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 74a10e7a8d082..d1ad6f63d2d42 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -437,8 +437,10 @@ config ARM_SMMU_V3
 	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
 	select IOMMU_API
+	select IOMMU_SVA_LIB
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
+	select MMU_NOTIFIER
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  version 3 providing translation support to a PCIe root complex.
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d357c9f77bf7f..af551f3c78a78 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -23,6 +23,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -35,6 +36,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-sva-lib.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -729,8 +731,32 @@ struct arm_smmu_domain {
 
 	struct list_head		devices;
 	spinlock_t			devices_lock;
+
+	struct list_head		mmu_notifiers;
+};
+
+struct arm_smmu_mmu_notifier {
+	struct mmu_notifier		mn;
+	struct arm_smmu_ctx_desc	*cd;
+	bool				cleared;
+	refcount_t			refs;
+	struct list_head		list;
+	struct arm_smmu_domain		*domain;
 };
 
+#define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
+
+struct arm_smmu_bond {
+	struct iommu_sva		sva;
+	struct mm_struct		*mm;
+	struct arm_smmu_mmu_notifier	*smmu_mn;
+	struct list_head		list;
+	refcount_t			refs;
+};
+
+#define sva_to_bond(handle) \
+	container_of(handle, struct arm_smmu_bond, sva)
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -740,6 +766,13 @@ static DEFINE_XARRAY_ALLOC1(asid_xa);
 static DEFINE_MUTEX(asid_lock);
 static DEFINE_MUTEX(sva_lock);
 
+/*
+ * When a process dies, DMA is still running but we need to clear the pgd. If we
+ * simply cleared the valid bit from the context descriptor, we'd get event 0x0a
+ * which are not recoverable.
+ */
+static struct arm_smmu_ctx_desc invalid_cd = { 0 };
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -1643,7 +1676,9 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	 * (2) Install a secondary CD, for SID+SSID traffic.
 	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
 	 *     CD, then invalidate the old entry and mappings.
-	 * (4) Remove a secondary CD.
+	 * (4) Quiesce the context without clearing the valid bit. Disable
+	 *     translation, and ignore any translation fault.
+	 * (5) Remove a secondary CD.
 	 */
 	u64 val;
 	bool cd_live;
@@ -1660,8 +1695,10 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
-	if (!cd) { /* (4) */
+	if (!cd) { /* (5) */
 		val = 0;
+	} else if (cd == &invalid_cd) { /* (4) */
+		val |= CTXDESC_CD_0_TCR_EPD0;
 	} else if (cd_live) { /* (3) */
 		val &= ~CTXDESC_CD_0_ASID;
 		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
@@ -1861,7 +1898,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 	return NULL;
 }
 
-__maybe_unused
 static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 {
 	u16 asid;
@@ -1958,7 +1994,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	return ERR_PTR(ret);
 }
 
-__maybe_unused
 static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 {
 	lockdep_assert_held(&sva_lock);
@@ -2591,6 +2626,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops;
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2618,6 +2655,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
 }
@@ -3114,6 +3152,207 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ops->iova_to_phys(ops, iova);
 }
 
+static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+
+	mutex_lock(&sva_lock);
+	if (smmu_mn->cleared) {
+		mutex_unlock(&sva_lock);
+		return;
+	}
+
+	/*
+	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
+	 * but disable translation.
+	 */
+	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
+
+	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+
+	smmu_mn->cleared = true;
+	mutex_unlock(&sva_lock);
+}
+
+static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
+{
+	kfree(mn_to_smmu(mn));
+}
+
+static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+	.release		= arm_smmu_mm_release,
+	.free_notifier		= arm_smmu_mmu_notifier_free,
+};
+
+/* Allocate or get existing MMU notifier for this {domain, mm} pair */
+static struct arm_smmu_mmu_notifier *
+arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
+			  struct mm_struct *mm)
+{
+	int ret;
+	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_mmu_notifier *smmu_mn;
+
+	lockdep_assert_held(&sva_lock);
+
+	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
+		if (smmu_mn->mn.mm == mm) {
+			refcount_inc(&smmu_mn->refs);
+			return smmu_mn;
+		}
+	}
+
+	cd = arm_smmu_alloc_shared_cd(mm);
+	if (IS_ERR(cd))
+		return ERR_CAST(cd);
+
+	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
+	if (!smmu_mn) {
+		ret = -ENOMEM;
+		goto err_free_cd;
+	}
+
+	refcount_set(&smmu_mn->refs, 1);
+	smmu_mn->cd = cd;
+	smmu_mn->domain = smmu_domain;
+	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
+
+	ret = mmu_notifier_register(&smmu_mn->mn, mm);
+	if (ret) {
+		kfree(smmu_mn);
+		goto err_free_cd;
+	}
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	if (ret)
+		goto err_put_notifier;
+
+	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
+	return smmu_mn;
+
+err_put_notifier:
+	/* Frees smmu_mn */
+	mmu_notifier_put(&smmu_mn->mn);
+err_free_cd:
+	arm_smmu_free_shared_cd(cd);
+	return ERR_PTR(ret);
+}
+
+static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
+{
+	struct mm_struct *mm = smmu_mn->mn.mm;
+	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
+	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+
+	lockdep_assert_held(&sva_lock);
+
+	if (!refcount_dec_and_test(&smmu_mn->refs))
+		return;
+
+	list_del(&smmu_mn->list);
+	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+
+	/*
+	 * If we went through clear(), we've already invalidated, and no
+	 * new TLB entry can have been formed.
+	 */
+	if (!smmu_mn->cleared)
+		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+
+	/* Frees smmu_mn */
+	mmu_notifier_put(&smmu_mn->mn);
+	arm_smmu_free_shared_cd(cd);
+}
+
+static struct iommu_sva *
+__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+{
+	int ret;
+	struct arm_smmu_bond *bond;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	lockdep_assert_held(&sva_lock);
+
+	if (!master || !master->sva_enabled)
+		return ERR_PTR(-ENODEV);
+
+	/* If bind() was already called for this {dev, mm} pair, reuse it. */
+	list_for_each_entry(bond, &master->bonds, list) {
+		if (bond->mm == mm) {
+			refcount_inc(&bond->refs);
+			return &bond->sva;
+		}
+	}
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate a PASID for this mm if necessary */
+	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
+	if (ret)
+		goto err_free_bond;
+
+	bond->mm = mm;
+	bond->sva.dev = dev;
+	refcount_set(&bond->refs, 1);
+
+	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
+	if (IS_ERR(bond->smmu_mn)) {
+		ret = PTR_ERR(bond->smmu_mn);
+		goto err_free_pasid;
+	}
+
+	list_add(&bond->list, &master->bonds);
+	return &bond->sva;
+
+err_free_pasid:
+	iommu_sva_free_pasid(mm);
+err_free_bond:
+	kfree(bond);
+	return ERR_PTR(ret);
+}
+
+static struct iommu_sva *
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	struct iommu_sva *handle;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&sva_lock);
+	handle = __arm_smmu_sva_bind(dev, mm);
+	mutex_unlock(&sva_lock);
+	return handle;
+}
+
+static void arm_smmu_sva_unbind(struct iommu_sva *handle)
+{
+	struct arm_smmu_bond *bond = sva_to_bond(handle);
+
+	mutex_lock(&sva_lock);
+	if (refcount_dec_and_test(&bond->refs)) {
+		list_del(&bond->list);
+		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		iommu_sva_free_pasid(bond->mm);
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
+
+static int arm_smmu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct arm_smmu_bond *bond = sva_to_bond(handle);
+
+	return bond->mm->pasid;
+}
+
 static struct platform_driver arm_smmu_driver;
 
 static
@@ -3458,6 +3697,9 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.sva_bind		= arm_smmu_sva_bind,
+	.sva_unbind		= arm_smmu_sva_unbind,
+	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -4520,6 +4762,16 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static void arm_smmu_driver_unregister(struct platform_driver *drv)
+{
+	/*
+	 * Wait for all notifiers free() RCU callbacks, since they are still
+	 * using the arm_smmu_mmu_notifier_ops.
+	 */
+	mmu_notifier_synchronize();
+	platform_driver_unregister(drv);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
@@ -4530,7 +4782,8 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
+module_driver(arm_smmu_driver, platform_driver_register,
+	      arm_smmu_driver_unregister);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
