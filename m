Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D6C433F2
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628AC207BB
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4fhKkMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628AC207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50B7E86B5B;
	Thu, 23 Jul 2020 15:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_tSsBXdilK0; Thu, 23 Jul 2020 15:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BDF9486FB2;
	Thu, 23 Jul 2020 15:06:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB78BC004E;
	Thu, 23 Jul 2020 15:06:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F277FC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ED57186949
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONd01VWjTimN for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7FB6086932
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:02 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id a8so4773704edy.1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mk8rfxkDw1PWo2f4BS9IArvvvnje70F6yQIOzpOD8IE=;
 b=U4fhKkMGWaZ7UQ9bJAW+0wCHxyBWb2e+wAcH3hCBcLXarR/1hw8C7KW6PC43KAOa85
 6Kisq+Cnbi2f1X9FUlyYdRbL5Th4fHsImfo8Uml1LFd5IeikdNXorA4tSHCmOe5Bpmy2
 zZyJ29h/Rn3ocyeFYy5TmhGQYtfUf5zucp+mQq8E4w4jxRpTRan/DTcUnMj19Ql7CzdC
 AqFcaO46/XFB9xyc47RtzBx526+v+DEqpsdAM/uIMHmhPWOTTuvRrXiVhysalUL9pJp2
 TdgrhdczKE2VTwvsLcM2Tphf3p+ekP3p3x7jiaZEILBntocIIC9+tlOzjaEeFJ145cP5
 asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mk8rfxkDw1PWo2f4BS9IArvvvnje70F6yQIOzpOD8IE=;
 b=TInAbhPqIJISMlZ43uap83+Zv6EiEkcgtIn++smNECzgH8vamSCwAQ+Ds3Y9VHCBDo
 Aj80QGsgL+/kiJC+WzR5y18j0GSh/Ua/Mk2/JbFi438gvDkOQvnCa911Ozz2XdJT+YR0
 uV9FgYqTereE4P9yqdvStLw+MX6fs9edNiuSe6O8ljUcco9BAi0sDBlIKwnpWad8t2+r
 G6TfXpvAt/f8ywxHKE+Ghy97bQVq+wPrtxK5JMOoSi73NbsWOR8roQsGA9PNoa84cHjG
 d8WMw6lrsKdC/mD3oK78nxTeVQJrxOi/SH2TNoQdtm6aufhtxRY2tqCNZvWqoAOrI2bV
 YtSg==
X-Gm-Message-State: AOAM530VH/OIFvpFE5q1ZMKMs4E7f2T5x9IFtrLjbCCsnz/Rl9ddcex6
 8jdav7fO1g3H1VqtrodUK7/tfc2Z5hs=
X-Google-Smtp-Source: ABdhPJwSlP//G+7+0FWTltT7MdleVtcsana2ram3En2LIIAiVx0hmuABWMxHroM+0IYv8b2AZ4FLkA==
X-Received: by 2002:aa7:ca05:: with SMTP id y5mr4669915eds.204.1595516760287; 
 Thu, 23 Jul 2020 08:06:00 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 12/13] iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
Date: Thu, 23 Jul 2020 16:57:24 +0200
Message-Id: <20200723145724.3014766-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
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
 drivers/iommu/Kconfig           |   2 +
 drivers/iommu/arm-smmu-v3.h     |  28 ++++
 drivers/iommu/arm-smmu-v3-sva.c | 230 +++++++++++++++++++++++++++++++-
 drivers/iommu/arm-smmu-v3.c     |  32 +++--
 4 files changed, 282 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index afe355c02a50..2d05aa570f51 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -449,6 +449,8 @@ config ARM_SMMU_V3
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
+	select IOMMU_SVA_LIB
+	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
 	  SMMUv3.
diff --git a/drivers/iommu/arm-smmu-v3.h b/drivers/iommu/arm-smmu-v3.h
index ba34914813ff..6365c81a4614 100644
--- a/drivers/iommu/arm-smmu-v3.h
+++ b/drivers/iommu/arm-smmu-v3.h
@@ -677,10 +677,18 @@ struct arm_smmu_domain {
 
 	struct list_head		devices;
 	spinlock_t			devices_lock;
+
+	struct list_head		mmu_notifiers;
 };
 
+static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
+extern struct arm_smmu_ctx_desc quiet_cd;
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
@@ -693,6 +701,11 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
+				    void *drvdata);
+void arm_smmu_sva_unbind(struct iommu_sva *handle);
+int arm_smmu_sva_get_pasid(struct iommu_sva *handle);
+void arm_smmu_sva_notifier_synchronize(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -718,5 +731,20 @@ static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
 	return -ENODEV;
 }
+
+static inline struct iommu_sva *
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
+
+static inline int arm_smmu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void arm_smmu_sva_notifier_synchronize(void) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm-smmu-v3-sva.c b/drivers/iommu/arm-smmu-v3-sva.c
index b6805effede4..a77abbb7a9d7 100644
--- a/drivers/iommu/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm-smmu-v3-sva.c
@@ -5,11 +5,35 @@
 
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
+#include "iommu-sva-lib.h"
 #include "io-pgtable-arm.h"
 
+struct arm_smmu_mmu_notifier {
+	struct mmu_notifier		mn;
+	struct arm_smmu_ctx_desc	*cd;
+	bool				cleared;
+	refcount_t			refs;
+	struct list_head		list;
+	struct arm_smmu_domain		*domain;
+};
+
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
 static DEFINE_MUTEX(sva_lock);
 
 /*
@@ -65,7 +89,6 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	return NULL;
 }
 
-__maybe_unused
 static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 {
 	u16 asid;
@@ -146,7 +169,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
-__maybe_unused
 static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 {
 	if (arm_smmu_free_asid(cd)) {
@@ -156,6 +178,201 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
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
+	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
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
+struct iommu_sva *
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
+void arm_smmu_sva_unbind(struct iommu_sva *handle)
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
+int arm_smmu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct arm_smmu_bond *bond = sva_to_bond(handle);
+
+	return bond->mm->pasid;
+}
+
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	unsigned long reg, fld;
@@ -245,3 +462,12 @@ int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 
 	return 0;
 }
+
+void arm_smmu_sva_notifier_synchronize(void)
+{
+	/*
+	 * Some MMU notifiers may still be waiting to be freed, using
+	 * arm_smmu_mmu_notifier_free(). Wait for them.
+	 */
+	mmu_notifier_synchronize();
+}
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0fd63d93bd2c..ad71c07e783f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -71,6 +71,12 @@ struct arm_smmu_option_prop {
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
+/*
+ * Special value used by SVA when a process dies, to quiesce a CD without
+ * disabling it.
+ */
+struct arm_smmu_ctx_desc quiet_cd = { 0 };
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -86,11 +92,6 @@ static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 	return smmu->base + offset;
 }
 
-static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct arm_smmu_domain, domain);
-}
-
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -974,7 +975,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
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
@@ -991,8 +994,10 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
-	if (!cd) { /* (4) */
+	if (!cd) { /* (5) */
 		val = 0;
+	} else if (cd == &quiet_cd) { /* (4) */
+		val |= CTXDESC_CD_0_TCR_EPD0;
 	} else if (cd_live) { /* (3) */
 		val &= ~CTXDESC_CD_0_ASID;
 		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
@@ -1785,6 +1790,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
 }
@@ -2576,6 +2582,9 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.sva_bind		= arm_smmu_sva_bind,
+	.sva_unbind		= arm_smmu_sva_unbind,
+	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -3595,6 +3604,12 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static void arm_smmu_driver_unregister(struct platform_driver *drv)
+{
+	arm_smmu_sva_notifier_synchronize();
+	platform_driver_unregister(drv);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
@@ -3605,7 +3620,8 @@ static struct platform_driver arm_smmu_driver = {
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
