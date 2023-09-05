Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345D19B
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872607; x=1725408607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0kxt6FFlHw1DUH3cmrz8eMgVCP5TKfKG8u9aLn4wgcs=;
  b=A3BAwFR9C7MudOnXJAhdnbyvtzNEVvNDC3GlZmmvId+EnYfywCZuRFi/
   iC7rc83GVJUWEeEgcX/96rKY+peMTJEV1GWw7t9ZsyPFWnubvS2g907+A
   B+VD2IPn3Xt67XqSMOl598Aj+W8UGSc/lhgLgYfrfVDE4i9G7VivrfOyZ
   Qrt3U3rHDmgv4Neh6iaCOCkGys2DTCl9YKPeKE68bWUAJqhsZbpyf7Dc+
   Aou8HwG59zQYGddDR/pyFyook3Le1m8uHRWhVshBvcPjK45Q15+YwaAuR
   sebbLKh8K99iXAsU9LY4HMrEf9xmBRfNW+t07IK1f4bkqN8q2F8qWtRY9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463039983"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="463039983"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884125143"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="884125143"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 17:09:57 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 5/6] iommu: Support mm PASID 1:n with sva domains
Date: Tue,  5 Sep 2023 08:09:29 +0800
Message-Id: <20230905000930.24515-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905000930.24515-1-tina.zhang@intel.com>
References: <20230905000930.24515-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Each mm bound to devices gets a PASID and corresponding sva domains
allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
field of the mm. The PASID is released in __mmdrop(), while a sva domain
is released when no one is using it (the reference count is decremented
in iommu_sva_unbind_device()). However, although sva domains and their
PASID are separate objects such that their own life cycles could be
handled independently, an enqcmd use case may require releasing the
PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
will be permanently used by the mm and won't be released until the end
of mm) and only allows to drop the PASID after the sva domains are
released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
increment the mm reference count and mmdrop() is invoked in
iommu_domain_free() to decrement the mm reference count.

Since the required info of PASID and sva domains is kept in struct
iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
field in mm struct. The sva domain list is protected by iommu_sva_lock.

Besides, this patch removes mm_pasid_init(), as with the introduced
iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Changes in v3:
- Add a comment describing domain->next.
- Update the commit message.

 drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
 include/linux/iommu.h     | 14 +++++++-------
 kernel/fork.c             |  1 -
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 0a4a1ed40814..e7e3aeaa7055 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
 /* Allocate a PASID for the mm within range (inclusive) */
 static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
+	struct iommu_mm_data *iommu_mm;
 	int ret = 0;
 
 	if (min == IOMMU_PASID_INVALID ||
@@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
+	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
+	if (!iommu_mm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(iommu_mm);
 		goto out;
+	}
+
+	iommu_mm->pasid = ret;
+	INIT_LIST_HEAD(&iommu_mm->sva_domains);
+	mm->iommu_mm = iommu_mm;
 
-	mm->pasid = ret;
 	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
-	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
-						IOMMU_DOMAIN_SVA);
-	if (IS_ERR(domain)) {
-		ret = PTR_ERR(domain);
-		goto out_unlock;
-	}
-
-	if (domain) {
-		domain->users++;
-		goto out;
+	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
+		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
+		if (!ret) {
+			domain->users++;
+			goto out;
+		}
 	}
 
 	/* Allocate a new domain and set it on device pasid. */
@@ -105,6 +113,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
+	list_add(&domain->next, &mm->iommu_mm->sva_domains);
+
 out:
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
@@ -137,8 +147,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
+	iommu_detach_device_pasid(domain, dev, pasid);
 	if (--domain->users == 0) {
-		iommu_detach_device_pasid(domain, dev, pasid);
+		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
 	mutex_unlock(&iommu_sva_lock);
@@ -218,4 +229,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 		return;
 
 	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
+	kfree(mm->iommu_mm);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 937f3abc26f2..95ada53f24ec 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -109,6 +109,11 @@ struct iommu_domain {
 		struct {	/* IOMMU_DOMAIN_SVA */
 			struct mm_struct *mm;
 			int users;
+			/*
+			 * Next iommu_domain in mm->iommu_mm->sva-domains list
+			 * protected by iommu_sva_lock.
+			 */
+			struct list_head next;
 		};
 	};
 };
@@ -1177,17 +1182,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 }
 
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = IOMMU_PASID_INVALID;
-}
 static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
-	return mm->pasid != IOMMU_PASID_INVALID;
+	return mm->iommu_mm ? true : false;
 }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
-	return mm->pasid;
+	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
 }
 static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
@@ -1213,7 +1214,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
-static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..f06392dd1ca8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1274,7 +1274,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.17.1

