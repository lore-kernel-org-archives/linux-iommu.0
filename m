Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D61FC433EF
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 20:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3762283148;
	Fri, 28 Jan 2022 20:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNQ6hf0Rezvl; Fri, 28 Jan 2022 20:29:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A427083E93;
	Fri, 28 Jan 2022 20:29:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDBB0C007C;
	Fri, 28 Jan 2022 20:29:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18257C0039
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3064D828BA
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCAj88-0Bd1H for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1444B83148
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643401764; x=1674937764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S+9m7eyuXn1c2Qq6KqmCa13eplXgcNSM8btSUXiOqqw=;
 b=Vs/pLpVoKTWWriRdxHLPbwDjLefS0XZWEM2eXGWGoyt2oriu4ftc8oGz
 gaNF0P9sjbp14gJC1/fjcrMoo31He+4bwNcs9ayXWeI9bWGlGOQ86b4c7
 UxaQsGcDnYm+Un62NDTXeoQsqcwqI4oc7jUtCCkD9ZXNGrt2punkfTAR0
 ESrjCgEZ3OA6OOakLQReJMP+oFcyIEvc/ar++SPK6NkgjTkgsj7vg9kh7
 SGrG24kxaIICDiuo8lyiLgFvR2WvAkAp/uD5jriVI7VPXJORno5z4RiSW
 OaKJKqGjQka70dT9KRHS27vajbcgTi5j/au2g8yqGP9pWRbcf8lpccXbC Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227862441"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="227862441"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 12:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="618827700"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:22 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID allocation
 and free it on mm exit
Date: Fri, 28 Jan 2022 12:28:59 -0800
Message-Id: <20220128202905.2274672-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

To avoid complexity of updating each thread's PASID status (e.g. sending
IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
allocated and assigned to an mm, the PASID stays with the mm for the
rest of the mm's lifetime. A reference to the PASID is taken on
allocating the PASID. Binding/unbinding the PASID won't change refcount.
The reference is dropped on mm exit and thus the PASID is freed.

Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
the PASID operations handle the pasid member in mm_struct and should be
part of mm operations. Because IOASID's reference count is not used any
more and removed, unused ioasid_get() and iommu_sva_free_pasid()
are deleted and ioasid_put() is renamed to ioasid_free().

20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
With cgroups and other controls that might limit the number of process
creation, the limited number of PASIDs is not a realistic issue for
lazy PASID free.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v3:
- Rename mm_pasid_get() to mm_pasid_set() (Thomas).
- Remove ioasid_get() because it's not used any more when the IOASID
  is freed on mm exit (Thomas).
- Remove PASID's refcount exercise in ioasid_put() and rename
  ioasid_put() to ioasid_free() (Thomas).

v2:
- Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
  PeterZ)
- Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
  So the mm's PASID operations are generic for both X86 and ARM
  (Dave Hansen)

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
 drivers/iommu/intel/iommu.c                   |  4 +-
 drivers/iommu/intel/svm.c                     |  9 -----
 drivers/iommu/ioasid.c                        | 38 ++----------------
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
 drivers/iommu/iommu-sva-lib.h                 |  1 -
 include/linux/ioasid.h                        | 12 +-----
 include/linux/sched/mm.h                      | 16 ++++++++
 kernel/fork.c                                 |  1 +
 9 files changed, 38 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a737ba5f727e..22ddd05bbdcd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -340,14 +340,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
 		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_pasid;
+		goto err_free_bond;
 	}
 
 	list_add(&bond->list, &master->bonds);
 	return &bond->sva;
 
-err_free_pasid:
-	iommu_sva_free_pasid(mm);
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -377,7 +375,6 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		iommu_sva_free_pasid(bond->mm);
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..ef03b2176bbd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 
 	return ret;
 }
@@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 }
 
 static int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b04fcc..51ac2096b3da 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -514,11 +514,6 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
 }
 
-static void intel_svm_free_pasid(struct mm_struct *mm)
-{
-	iommu_sva_free_pasid(mm);
-}
-
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm,
@@ -662,8 +657,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 				kfree(svm);
 			}
 		}
-		/* Drop a PASID reference and free it if no reference. */
-		intel_svm_free_pasid(mm);
 	}
 out:
 	return ret;
@@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void
 	}
 
 	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
-	if (IS_ERR_OR_NULL(sva))
-		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..a786c034907c 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -2,7 +2,7 @@
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_put.
+ * free IOASIDs with ioasid_alloc() and ioasid_free().
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -15,7 +15,6 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
-	refcount_t refs;
 };
 
 /*
@@ -315,7 +314,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
-	refcount_set(&data->refs, 1);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -348,34 +346,11 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
- * ioasid_get - obtain a reference to the IOASID
- */
-void ioasid_get(ioasid_t ioasid)
-{
-	struct ioasid_data *ioasid_data;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		refcount_inc(&ioasid_data->refs);
-	else
-		WARN_ON(1);
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_get);
-
-/**
- * ioasid_put - Release a reference to an ioasid
+ * ioasid_free - Free an ioasid
  * @ioasid: the ID to remove
- *
- * Put a reference to the IOASID, free it when the number of references drops to
- * zero.
- *
- * Return: %true if the IOASID was freed, %false otherwise.
  */
-bool ioasid_put(ioasid_t ioasid)
+void ioasid_free(ioasid_t ioasid)
 {
-	bool free = false;
 	struct ioasid_data *ioasid_data;
 
 	spin_lock(&ioasid_allocator_lock);
@@ -385,10 +360,6 @@ bool ioasid_put(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
-	free = refcount_dec_and_test(&ioasid_data->refs);
-	if (!free)
-		goto exit_unlock;
-
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -398,9 +369,8 @@ bool ioasid_put(ioasid_t ioasid)
 
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
-	return free;
 }
-EXPORT_SYMBOL_GPL(ioasid_put);
+EXPORT_SYMBOL_GPL(ioasid_free);
 
 /**
  * ioasid_find - Find IOASID data
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..106506143896 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
  *
  * Try to allocate a PASID for this mm, or take a reference to the existing one
  * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid, and must be released with iommu_sva_free_pasid().
- * @min must be greater than 0, because 0 indicates an unused mm->pasid.
+ * available in mm->pasid and will be available for the lifetime of the mm.
  *
  * Returns 0 on success and < 0 on error.
  */
@@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
-	if (mm->pasid) {
-		if (mm->pasid >= min && mm->pasid <= max)
-			ioasid_get(mm->pasid);
-		else
+	/* Is a PASID already associated with this mm? */
+	if (pasid_valid(mm->pasid)) {
+		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
-	} else {
-		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-		if (pasid == INVALID_IOASID)
-			ret = -ENOMEM;
-		else
-			mm->pasid = pasid;
+		goto out;
 	}
+
+	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+	if (!pasid_valid(pasid))
+		ret = -ENOMEM;
+	else
+		mm_pasid_set(mm, pasid);
+out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
-/**
- * iommu_sva_free_pasid - Release the mm's PASID
- * @mm: the mm
- *
- * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
- */
-void iommu_sva_free_pasid(struct mm_struct *mm)
-{
-	mutex_lock(&iommu_sva_lock);
-	if (ioasid_put(mm->pasid))
-		mm->pasid = 0;
-	mutex_unlock(&iommu_sva_lock);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
-
 /* ioasid_find getter() requires a void * argument */
 static bool __mmget_not_zero(void *mm)
 {
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 95dc3ebc1928..8909ea1094e3 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2237f64dbaae..af1c9d62e642 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,8 +34,7 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_get(ioasid_t ioasid);
-bool ioasid_put(ioasid_t ioasid);
+void ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -53,14 +52,7 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_get(ioasid_t ioasid)
-{
-}
-
-static inline bool ioasid_put(ioasid_t ioasid)
-{
-	return false;
-}
+static inline void ioasid_free(ioasid_t ioasid) { }
 
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c74d1edbac2f..a80356e9dc69 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -439,8 +439,24 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
+
+/* Associate a PASID with an mm_struct: */
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid = pasid;
+}
+
+static inline void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index deacd2c17a7f..c03c6682464c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1115,6 +1115,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
