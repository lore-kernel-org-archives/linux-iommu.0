Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5BC43460
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3C0613C4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3C0613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E199B41503;
	Fri, 23 Apr 2021 09:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIq3Ggsp2KoN; Fri, 23 Apr 2021 09:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D94541504;
	Fri, 23 Apr 2021 09:52:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE03C000F;
	Fri, 23 Apr 2021 09:52:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4C5C000B;
 Fri, 23 Apr 2021 09:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6823740602;
 Fri, 23 Apr 2021 09:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7OXql4wxp5O; Fri, 23 Apr 2021 09:52:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D72E40613;
 Fri, 23 Apr 2021 09:52:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEF041655;
 Fri, 23 Apr 2021 02:52:35 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9746C3F774;
 Fri, 23 Apr 2021 02:52:31 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 08/11] iommu/arm-smmu-v3: Implement shared context
 alloc and free ops
Date: Fri, 23 Apr 2021 15:21:44 +0530
Message-Id: <20210423095147.27922-9-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, Vivek Gautam <vivek.gautam@arm.com>, robin.murphy@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Implementing the alloc_shared_cd and free_shared_cd in cd-lib, and
start using them for arm-smmu-v3-sva implementation.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 71 ++++++++--------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 83 ++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ----
 4 files changed, 73 insertions(+), 96 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index 537b7c784d40..b87829796596 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -285,16 +285,14 @@ static bool arm_smmu_free_asid(struct xarray *xa, void *cookie_cd)
  * descriptor is using it, try to replace it.
  */
 static struct arm_smmu_ctx_desc *
-arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
+arm_smmu_share_asid(struct iommu_pasid_table *tbl, struct mm_struct *mm,
+		    struct xarray *xa, u16 asid, u32 asid_bits)
 {
 	int ret;
 	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_device *smmu;
-	struct arm_smmu_domain *smmu_domain;
-	struct iommu_pasid_table *tbl;
 
-	cd = xa_load(&arm_smmu_asid_xa, asid);
+	cd = xa_load(xa, asid);
 	if (!cd)
 		return NULL;
 
@@ -306,12 +304,8 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 		return cd;
 	}
 
-	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
-	smmu = smmu_domain->smmu;
-	tbl = smmu_domain->tbl;
-
-	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	ret = xa_alloc(xa, &new_asid, cd, XA_LIMIT(1, (1 << asid_bits) - 1),
+		       GFP_KERNEL);
 	if (ret)
 		return ERR_PTR(-ENOSPC);
 	/*
@@ -325,48 +319,52 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
+	ret = arm_smmu_write_ctx_desc(&tbl->cfg, 0, cd);
 	if (ret)
 		return ERR_PTR(-ENOSYS);
 
 	/* Invalidate TLB entries previously associated with that context */
-	iommu_psdtable_flush_tlb(tbl, smmu_domain, asid);
+	iommu_psdtable_flush_tlb(tbl, tbl->cookie, asid);
 
-	xa_erase(&arm_smmu_asid_xa, asid);
+	xa_erase(xa, asid);
 	return NULL;
 }
 
-struct arm_smmu_ctx_desc *
-arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
+static struct iommu_psdtable_mmu_notifier *
+arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm,
+			 struct xarray *xa, u32 asid_bits)
 {
 	u16 asid;
 	int err = 0;
 	u64 tcr, par, reg;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_ctx_desc *ret = NULL;
+	struct iommu_psdtable_mmu_notifier *pst_mn;
 
 	asid = arm64_mm_context_get(mm);
 	if (!asid)
 		return ERR_PTR(-ESRCH);
 
+	pst_mn = kzalloc(sizeof(*pst_mn), GFP_KERNEL);
+	if (!pst_mn) {
+		err = -ENOMEM;
+		goto out_put_context;
+	}
+
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd) {
 		err = -ENOMEM;
-		goto out_put_context;
+		goto out_free_mn;
 	}
 
 	refcount_set(&cd->refs, 1);
 
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = arm_smmu_share_asid(mm, asid);
+	ret = arm_smmu_share_asid(tbl, mm, xa, asid, asid_bits);
 	if (ret) {
-		mutex_unlock(&arm_smmu_asid_lock);
 		goto out_free_cd;
 	}
 
-	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
-	mutex_unlock(&arm_smmu_asid_lock);
-
+	err = xa_insert(xa, asid, cd, GFP_KERNEL);
 	if (err)
 		goto out_free_asid;
 
@@ -406,21 +404,26 @@ arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
 	cd->asid = asid;
 	cd->mm = mm;
 
-	return cd;
+	pst_mn->vendor.cd = cd;
+	return pst_mn;
 
 out_free_asid:
-	iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd);
+	arm_smmu_free_asid(xa, cd);
 out_free_cd:
 	kfree(cd);
+out_free_mn:
+	kfree(pst_mn);
 out_put_context:
 	arm64_mm_context_put(mm);
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
-void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
-			     struct arm_smmu_ctx_desc *cd)
+static void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
+				    struct xarray *xa, void *cookie)
 {
-	if (iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd)) {
+	struct arm_smmu_ctx_desc *cd = cookie;
+
+	if (iommu_psdtable_free_asid(tbl, xa, cd)) {
 		/* Unpin ASID */
 		arm64_mm_context_put(cd->mm);
 		kfree(cd);
@@ -428,11 +431,13 @@ void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
 }
 
 struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
-	.alloc	 = arm_smmu_alloc_cd_tables,
-	.free	 = arm_smmu_free_cd_tables,
-	.prepare = arm_smmu_prepare_cd,
-	.write	 = arm_smmu_write_ctx_desc,
-	.free_asid = arm_smmu_free_asid,
+	.alloc		= arm_smmu_alloc_cd_tables,
+	.free		= arm_smmu_free_cd_tables,
+	.prepare	= arm_smmu_prepare_cd,
+	.write		= arm_smmu_write_ctx_desc,
+	.free_asid	= arm_smmu_free_asid,
+	.alloc_shared	= arm_smmu_alloc_shared_cd,
+	.free_shared	= arm_smmu_free_shared_cd,
 };
 
 struct iommu_pasid_table *
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index da35d4cc0c1e..ef28d0c409da 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -13,23 +13,12 @@
 #include "../../io-pgtable-arm.h"
 #include "../../iommu-pasid-table.h"
 
-struct arm_smmu_mmu_notifier {
-	struct mmu_notifier		mn;
-	struct arm_smmu_ctx_desc	*cd;
-	bool				cleared;
-	refcount_t			refs;
-	struct list_head		list;
-	struct arm_smmu_domain		*domain;
-};
-
-#define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
-
 struct arm_smmu_bond {
-	struct iommu_sva		sva;
-	struct mm_struct		*mm;
-	struct arm_smmu_mmu_notifier	*smmu_mn;
-	struct list_head		list;
-	refcount_t			refs;
+	struct iommu_sva			sva;
+	struct mm_struct			*mm;
+	struct iommu_psdtable_mmu_notifier	*smmu_mn;
+	struct list_head			list;
+	refcount_t				refs;
 };
 
 #define sva_to_bond(handle) \
@@ -41,20 +30,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
 {
-	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
+	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
+	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
 	size_t size = end - start + 1;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+		arm_smmu_tlb_inv_range_asid(start, size, cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
+	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
+	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
 	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	mutex_lock(&sva_lock);
@@ -69,7 +60,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, &quiet_cd);
 
-	iommu_psdtable_flush_tlb(tbl, smmu_domain, smmu_mn->cd->asid);
+	iommu_psdtable_flush_tlb(tbl, smmu_domain, cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
@@ -78,7 +69,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
-	kfree(mn_to_smmu(mn));
+	kfree(mn_to_pstiommu(mn));
 }
 
 static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
@@ -88,63 +79,59 @@ static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 };
 
 /* Allocate or get existing MMU notifier for this {domain, mm} pair */
-static struct arm_smmu_mmu_notifier *
+static struct iommu_psdtable_mmu_notifier *
 arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_mmu_notifier *smmu_mn;
+	struct iommu_psdtable_mmu_notifier *smmu_mn;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
-	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
+	list_for_each_entry(smmu_mn, &tbl->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
 			refcount_inc(&smmu_mn->refs);
 			return smmu_mn;
 		}
 	}
 
-	cd = arm_smmu_alloc_shared_cd(tbl, mm);
-	if (IS_ERR(cd))
-		return ERR_CAST(cd);
-
-	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
-	if (!smmu_mn) {
-		ret = -ENOMEM;
-		goto err_free_cd;
-	}
+	mutex_lock(&arm_smmu_asid_lock);
+	smmu_mn = iommu_psdtable_alloc_shared(tbl, mm, &arm_smmu_asid_xa,
+					      smmu->asid_bits);
+	mutex_unlock(&arm_smmu_asid_lock);
+	if (IS_ERR(smmu_mn))
+		return ERR_CAST(smmu_mn);
 
 	refcount_set(&smmu_mn->refs, 1);
-	smmu_mn->cd = cd;
-	smmu_mn->domain = smmu_domain;
+	smmu_mn->cookie = smmu_domain;
 	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
 
 	ret = mmu_notifier_register(&smmu_mn->mn, mm);
-	if (ret) {
-		kfree(smmu_mn);
+	if (ret)
 		goto err_free_cd;
-	}
 
-	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, cd);
+	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
+				   smmu_mn->vendor.cd);
 	if (ret)
 		goto err_put_notifier;
 
-	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
+	list_add(&smmu_mn->list, &tbl->mmu_notifiers);
 	return smmu_mn;
 
 err_put_notifier:
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
 err_free_cd:
-	arm_smmu_free_shared_cd(tbl, cd);
+	iommu_psdtable_free_shared(tbl, &arm_smmu_asid_xa, smmu_mn->vendor.cd);
 	return ERR_PTR(ret);
 }
 
-static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
+static void
+arm_smmu_mmu_notifier_put(struct iommu_psdtable_mmu_notifier *smmu_mn)
 {
 	struct mm_struct *mm = smmu_mn->mn.mm;
-	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
+	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
 	struct iommu_pasid_table *tbl = smmu_domain->tbl;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
@@ -164,7 +151,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
-	arm_smmu_free_shared_cd(tbl, cd);
+	iommu_psdtable_free_shared(tbl, &arm_smmu_asid_xa, cd);
 }
 
 static struct iommu_sva *
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bbc4dc75de72..e55567b4d2f4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1987,7 +1987,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 13ff024ab0d5..8a689b4316ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -737,8 +737,6 @@ struct arm_smmu_domain {
 
 	struct list_head		devices;
 	spinlock_t			devices_lock;
-
-	struct list_head		mmu_notifiers;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -773,10 +771,6 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
-struct arm_smmu_ctx_desc *
-arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm);
-void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
-			     struct arm_smmu_ctx_desc *cd);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -832,13 +826,5 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
-struct arm_smmu_ctx_desc *
-arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
-					   struct arm_smmu_ctx_desc *cd) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
