Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A58C4741F
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47A122203
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3aevIQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47A122203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AAF262E136;
	Fri,  6 Nov 2020 15:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-ke1ovyTdCn; Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 909E520386;
	Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 794C1C088B;
	Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA347C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D165F86A39
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7Hp2R1JHNLU for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1411A868F0
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id cw8so2577926ejb.8
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4pmtVTCQAORkBrrk+wQN2T/YnLvtVms9fBQEGuovCw=;
 b=t3aevIQXhZEwd8a/6+Aa/hV9BJ6AtwH1K9plFNios6sSY2ZV5kl6nOFA5Q/djtm6tu
 aDW0D417b47ie7f/vHCHuu2Zj9NENwBwyIMGD2fl63TQeJPTpnqlkXwX9oVy9asvX6Vl
 ruJVRmtQ3vvnIUCt38qbUpl+StZTWB/1eFEDhw5IAkDBTOi/HDt5aGtDucv+TGKg6Oem
 jaa6dGlqnl1eXTWFOSHRtwafMiH51siqpsAND6Uq/icOVaVcAmlS6An/5tRUcMMCCmrr
 L+iKwSYDdVBLpOIiDEdualDSMJqDtnRRTsnYH8mb22LOBNyoP5Ukum7NVN2kTwDJb7+r
 SvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4pmtVTCQAORkBrrk+wQN2T/YnLvtVms9fBQEGuovCw=;
 b=OIWkYYLuTT/QfHT1wDmutIDbPAZfS3M22PKaFxcKywYLN48k+0VaMawikLoU7hd/IX
 nE3NgQ7xT/6ID0fF6U3tfTGNhtGr25HcyxLF6OJJZe3RrQccchJQaj5E8P5+JIk8nHBa
 OZ0zHbDaRUBbgJg55YYQ6jd3MxQw4FcHVcPVzgd3f9Ql4Mrd3ob+x08oImDFtyhizbry
 CCZUEgF7H+EBMhpQldwLfRN0vSeuet8hgRP+Y7qUvmyRKeyqJhOifUoCL2Pk8Pj21k/x
 tMKD0xvARTXWDNt9UOj6BBUrai93zUkQsORa/GphECPXPg8UO8/qfyU6vrAd4YU6nim4
 kyAA==
X-Gm-Message-State: AOAM533Q896GgxsKw3Xdx3fXn61YBkwaVsEpHCvcuQXAK5iU/Hlnyutd
 n75ne8Ro3rkGVsSgyx3jI+P4WtohQsqqEw==
X-Google-Smtp-Source: ABdhPJzE9CLY80Dr1z6puxAH1j1LM/ZkbI4PDC5J2kAW1yH+uiQx3vkauIErW4HmId9lra2UtuP6gQ==
X-Received: by 2002:a17:906:1381:: with SMTP id
 f1mr2570511ejc.87.1604677996742; 
 Fri, 06 Nov 2020 07:53:16 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lz27sm1249262ejb.39.2020.11.06.07.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:53:16 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v10 3/4] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Date: Fri,  6 Nov 2020 16:50:49 +0100
Message-Id: <20201106155048.997886-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201106155048.997886-1-jean-philippe@linaro.org>
References: <20201106155048.997886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com
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
 drivers/iommu/Kconfig                         |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  28 +++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 230 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  32 ++-
 4 files changed, 282 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f5ebbdfbf636..192ef8f61310 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -316,6 +316,8 @@ config ARM_SMMU_V3
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
+	select IOMMU_SVA_LIB
+	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
 	  SMMUv3.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d4b7f40ccb02..e03ca01e0908 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -678,10 +678,18 @@ struct arm_smmu_domain {
 
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
@@ -694,6 +702,11 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
+				    void *drvdata);
+void arm_smmu_sva_unbind(struct iommu_sva *handle);
+u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
+void arm_smmu_sva_notifier_synchronize(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -719,5 +732,20 @@ static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
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
+static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void arm_smmu_sva_notifier_synchronize(void) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9255c9600fb8..4d03481289ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -5,11 +5,35 @@
 
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
+#include "../../iommu-sva-lib.h"
 #include "../../io-pgtable-arm.h"
 
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
@@ -64,7 +88,6 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	return NULL;
 }
 
-__maybe_unused
 static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 {
 	u16 asid;
@@ -145,7 +168,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
-__maybe_unused
 static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 {
 	if (arm_smmu_free_asid(cd)) {
@@ -155,6 +177,201 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
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
+u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct arm_smmu_bond *bond = sva_to_bond(handle);
+
+	return bond->mm->pasid;
+}
+
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	unsigned long reg, fld;
@@ -246,3 +463,12 @@ int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 61002f305a72..769845c34503 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -76,6 +76,12 @@ struct arm_smmu_option_prop {
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
@@ -91,11 +97,6 @@ static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
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
@@ -983,7 +984,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
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
@@ -1000,8 +1003,10 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
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
@@ -1794,6 +1799,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
 }
@@ -2585,6 +2591,9 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.sva_bind		= arm_smmu_sva_bind,
+	.sva_unbind		= arm_smmu_sva_unbind,
+	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -3607,6 +3616,12 @@ static const struct of_device_id arm_smmu_of_match[] = {
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
@@ -3617,7 +3632,8 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
+module_driver(arm_smmu_driver, platform_driver_register,
+	      arm_smmu_driver_unregister);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
