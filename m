Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D45DC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 07:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB43084057;
	Wed, 29 Jun 2022 07:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB43084057
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZSn1Dz1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WiS85c2rS1k4; Wed, 29 Jun 2022 07:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F2AF83FAB;
	Wed, 29 Jun 2022 07:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F2AF83FAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB29DC007A;
	Wed, 29 Jun 2022 07:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABC2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34D65419CB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34D65419CB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZSn1Dz1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id khMyoQSLGvZa for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6790C416CD
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6790C416CD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656489123; x=1688025123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7xJG/RHuTiPYTwDACaNvM5KqLLJ+9JGGZJR7/2WHQCo=;
 b=ZSn1Dz1lpgaC7QzAOqYYfcd7ppTcHnENZH8+piLDu7MK+nh7c9IqoAnB
 12FRp5ihcXFdseWMtheQ8gE6bPHwpgB/DuRnJDAQVwjt8a1QvRsLc87C9
 Kv6BbOUAk8wQr5qnK8QeI5APrx7J2PPx+4oeDISz4ot808AvZmwesq22i
 eI/RFuwXhdJN1frNxx5HZPfbpZAwHJZz6u/6DegEKp8bwNUM33+zX8W50
 PVMKihYA54Zkfrc7gpKWMGRHTtXgwZ5yeJoqRTbQh9QFsiOgKU22WXz5q
 PDyM7E02F+ffogbC8rhresprUtKurRnq37VxB9pIQ0PL9EthZ/sg270a+ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262362943"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="262362943"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 00:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="588209637"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:52:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 05/11] iommu/vt-d: Replace spin_lock_irqsave() with
 spin_lock()
Date: Wed, 29 Jun 2022 15:47:19 +0800
Message-Id: <20220629074725.2331441-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

The iommu->lock is used to protect changes in root/context/pasid tables
and domain ID allocation. There's no use case to change these resources
in any interrupt context. Therefore, it's unnecessary to disable the
interrupts when the spinlock is held.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/debugfs.c |  6 ++----
 drivers/iommu/intel/iommu.c   | 26 +++++++++++---------------
 drivers/iommu/intel/svm.c     |  6 +++---
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 6e1a3f88abc8..1f925285104e 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -263,10 +263,9 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
 
 static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 {
-	unsigned long flags;
 	u16 bus;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	seq_printf(m, "IOMMU %s: Root Table Address: 0x%llx\n", iommu->name,
 		   (u64)virt_to_phys(iommu->root_entry));
 	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\t\t\t\tPASID\tPASID_table_entry\n");
@@ -278,8 +277,7 @@ static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 	 */
 	for (bus = 0; bus < 256; bus++)
 		ctx_tbl_walk(m, iommu, bus);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 }
 
 static int dmar_translation_struct_show(struct seq_file *m, void *unused)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ff49c9460ede..a81bdddf1091 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -797,13 +797,12 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct context_entry *context;
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (context)
 		ret = context_present(context);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	return ret;
 }
 
@@ -2296,16 +2295,15 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 {
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
-	unsigned long flags;
 	u16 did_old;
 
 	if (!iommu)
 		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		spin_unlock(&iommu->lock);
 		return;
 	}
 
@@ -2320,7 +2318,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	iommu->flush.flush_context(iommu,
 				   did_old,
 				   (((u16)bus) << 8) | devfn,
@@ -2499,7 +2497,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
+		spin_lock(&iommu->lock);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2509,7 +2507,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
@@ -2777,7 +2775,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	struct root_entry *old_rt;
 	phys_addr_t old_rt_phys;
 	int ctxt_table_entries;
-	unsigned long flags;
 	u64 rtaddr_reg;
 	int bus, ret;
 	bool new_ext, ext;
@@ -2820,7 +2817,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		}
 	}
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 
 	/* Context tables are copied, now write them to the root_entry table */
 	for (bus = 0; bus < 256; bus++) {
@@ -2839,7 +2836,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		iommu->root_entry[bus].hi = val;
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 
 	kfree(ctxt_tbls);
 
@@ -4166,7 +4163,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4188,9 +4184,9 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 	list_del(&info->link);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	domain_detach_iommu(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 580713aa9e07..82288a50660d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -328,9 +328,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   unsigned int flags)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long iflags, sflags;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
+	unsigned long sflags;
 	int ret = 0;
 
 	svm = pasid_private_find(mm->pasid);
@@ -394,10 +394,10 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	spin_lock_irqsave(&iommu->lock, iflags);
+	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-	spin_unlock_irqrestore(&iommu->lock, iflags);
+	spin_unlock(&iommu->lock);
 
 	if (ret)
 		goto free_sdev;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
