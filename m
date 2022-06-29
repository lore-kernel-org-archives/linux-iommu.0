Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219F7EB
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489138; x=1688025138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDw7P6FJi7QTKFVWwAK42b0Q1umngDHKfvQybxOrxMU=;
  b=Ix33XUlsrLcln0zTLeE6tBb5BsYDs6Rainh+U+9YtlwDjJFufyRtwtPl
   y2gmka7ngEhP0RrEK1VtOM2egCTe6H+0HI98xYdq6leOl5c5SECdWcWli
   BJ5kAVFFTYsyyASFCsxtsL/0CtEF031SS03qotQVJmZs2u4rOD088XYhE
   6azanCaX33N4iT5r7tVZHWNf/pXSzs5pxRUlADjTRRbNA5FQ/METWQuIE
   VY4i738GjJ4GTObKLE2/BOcu6Tfly+jt28asy7WJUsk44ilN3k9zhVMhG
   HzlZ86wTasJvymWp68X7MF5YFy5mzwYoo91HfAosbVitm/Q18+ItgXy0c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280718581"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="280718581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="588209753"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:52:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 11/11] iommu/vt-d: Convert global spinlock into per domain lock
Date: Wed, 29 Jun 2022 15:47:25 +0800
Message-ID: <20220629074725.2331441-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220629074725.nREgAYBWRolAzuuhRwEOdVidhq92ZesrUj3scnG0JnU@z>

Using a global device_domain_lock spinlock to protect per-domain device
tracking lists is an inefficient way, especially considering this lock
is also needed in the hot paths. This optimizes the locking mechanism
by converting the global lock to per domain lock.

On the other hand, as the device tracking lists are never accessed in
any interrupt context, there is no need to disable interrupts while
spinning. Replace irqsave variant with spinlock calls.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 29 deletions(-)

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
index 1783859b511a..da6cfea0f0d6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -310,7 +310,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-static DEFINE_SPINLOCK(device_domain_lock);
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -534,9 +533,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		/*
 		 * There could possibly be multiple device numa nodes as devices
@@ -548,7 +546,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 
 	return nid;
 }
@@ -1375,20 +1373,19 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 			u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
-	unsigned long flags;
 
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
+			spin_unlock(&domain->lock);
 			return info->ats_supported ? info : NULL;
 		}
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 
 	return NULL;
 }
@@ -1397,9 +1394,8 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
@@ -1407,7 +1403,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 		}
 	}
 	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
@@ -1498,17 +1494,15 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	unsigned long flags;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1768,6 +1762,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	spin_lock_init(&domain->lock);
 
 	return domain;
 }
@@ -2441,7 +2436,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 	int ret;
 
@@ -2454,9 +2448,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		return ret;
 
 	info->domain = domain;
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -4131,8 +4125,8 @@ static void domain_context_clear(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
 
 	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
@@ -4144,11 +4138,11 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		intel_pasid_free_table(info->dev);
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&domain->lock);
 	list_del(&info->link);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&domain->lock);
 
-	domain_detach_iommu(info->domain, iommu);
+	domain_detach_iommu(domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4430,7 +4424,7 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool support = true;
 
-	assert_spin_locked(&device_domain_lock);
+	assert_spin_locked(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!ecap_sc_support(info->iommu->ecap)) {
 			support = false;
@@ -4445,8 +4439,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 
-	assert_spin_locked(&device_domain_lock);
-
+	assert_spin_locked(&domain->lock);
 	/*
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
@@ -4464,20 +4457,19 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long flags;
 
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&dmar_domain->lock);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&dmar_domain->lock);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&dmar_domain->lock);
 
 	return true;
 }
-- 
2.25.1

