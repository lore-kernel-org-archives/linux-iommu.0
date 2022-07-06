Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248820F0
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076428; x=1688612428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7RBb24g7uZ3YBXaYjY6jWSesk0/66f3mKiYAyMbNb8=;
  b=nyuNck43NqwfngDHOhm8Brs0sQHSMiXIdRRLs3WbIcOLqn/WTTZfoSO3
   /FxYJ+lEHicFxSNuA+P3dJLkDYRvbqWJWYSQSzFIA+77uzINJD1CrTGjD
   ndO8t4nTpLBZ3Hl0TaTwAr2gIGX7JqMbObl+QSJZ6VR0FSjyzERI1wCvt
   yP2hbiD8fu/c82GKTCTzOlkfmJSurY4FcqxIJjGhiQVGZYoirFGow1Va9
   d3mYYRIuyzhXEACM5b5S0gfJ8NM4dsN1HihMbmnYxalyc9biMb6mefh/A
   IQ2LhsvfA/resrG/pfWlj7XOAHxa+VYE3LHiETTcevkNrsbTJf7ceDSsB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345310083"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="345310083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567875365"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 11/11] iommu/vt-d: Convert global spinlock into per domain lock
Date: Wed,  6 Jul 2022 10:55:24 +0800
Message-ID: <20220706025524.2904370-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220706025524.85fCJH8UoXDDhabaSc2P17N_yjPNC_h7d1KvKQ04L6M@z>

Using a global device_domain_lock spinlock to protect per-domain device
tracking lists is an inefficient way, especially considering this lock
is also needed in the hot paths. This optimizes the locking mechanism
by converting the global lock to per domain lock.

On the other hand, as the device tracking lists are never accessed in
any interrupt context, there is no need to disable interrupts while
spinning. Replace irqsave variant with spinlock calls.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++++-------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 198c6c822ef4..df64d3d9c49a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,6 +541,7 @@ struct dmar_domain {
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
 
+	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 
 	struct dma_pte	*pgd;		/* virtual address */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 46991e313bf3..e007049eb9ff 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -310,7 +310,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-static DEFINE_SPINLOCK(device_domain_lock);
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -535,7 +534,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		/*
 		 * There could possibly be multiple device numa nodes as devices
@@ -547,7 +546,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	return nid;
 }
@@ -1378,15 +1377,15 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			spin_unlock(&device_domain_lock);
+			spin_unlock(&domain->lock);
 			return info->ats_supported ? info : NULL;
 		}
 	}
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	return NULL;
 }
@@ -1396,7 +1395,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
@@ -1404,7 +1403,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 		}
 	}
 	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
@@ -1500,10 +1499,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1763,6 +1762,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	spin_lock_init(&domain->lock);
 
 	return domain;
 }
@@ -2446,9 +2446,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 	info->domain = domain;
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_add(&info->link, &domain->devices);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -4123,6 +4123,7 @@ static void domain_context_clear(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
 
 	if (!dev_is_real_dma_subdevice(info->dev)) {
@@ -4135,11 +4136,11 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		intel_pasid_free_table(info->dev);
 	}
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_del(&info->link);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
-	domain_detach_iommu(info->domain, iommu);
+	domain_detach_iommu(domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4421,7 +4422,7 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool support = true;
 
-	assert_spin_locked(&device_domain_lock);
+	assert_spin_locked(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!ecap_sc_support(info->iommu->ecap)) {
 			support = false;
@@ -4436,8 +4437,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 
-	assert_spin_locked(&device_domain_lock);
-
+	assert_spin_locked(&domain->lock);
 	/*
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
@@ -4459,15 +4459,15 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&dmar_domain->lock);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock(&device_domain_lock);
+		spin_unlock(&dmar_domain->lock);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&dmar_domain->lock);
 
 	return true;
 }
-- 
2.25.1

