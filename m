Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A388C0C
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282892; x=1726818892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQnDRlYxK4u5p5FtxL9YdlZ+I6ppODJXxT8vFfaQbkw=;
  b=QQBrqggKjFCn7Sr7Bga697Z8H9d2HwX7UAsycSo28LYYRAIW7rnayD4+
   F1r7QGBLvPgRmGjUjtCI4EDjQUVCYZ9YbhgWPl4wJghqat/NFPaBEnW2M
   iRUEiCmSn3qmiHihtoP8ryuHVQN659iNWKeHnKsTNzF8S1WgpgojiyyVv
   Fi4Rv5DEnYmaJm0tIRY0+zFVFV+glnYVqRKS0ksgmmZCtxmtFfdqHSfRY
   5vU+4Gs8Jpk3j+8OgjevqV+ts4Y0rIxTG3SFWZJCxujKeSRYdo4UeHq2X
   08t+yCz0g3+4Ko7UTGgpkaiY6iRmLTAFexeZkmslTIMIswxVU7u7c1y7x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764428"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523117"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523117"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:48 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v5 05/11] iommu/vt-d: Make domain attach helpers to be extern
Date: Thu, 21 Sep 2023 00:54:25 -0700
Message-Id: <20230921075431.125239-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the helpers visible to nested.c.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 drivers/iommu/intel/iommu.h |  7 +++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4ffc939a71f0..7b75f407c623 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -282,7 +282,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void device_block_translation(struct device *dev);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -560,7 +559,7 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 }
 
 /* Some capabilities may be different across iommus */
-static void domain_update_iommu_cap(struct dmar_domain *domain)
+void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
@@ -1778,8 +1777,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-static int domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
@@ -1828,8 +1826,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return ret;
 }
 
-static void domain_detach_iommu(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
@@ -3974,7 +3971,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+void device_block_translation(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4102,8 +4099,8 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
-static int prepare_domain_attach_device(struct iommu_domain *domain,
-					struct device *dev)
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a82e232abae0..411cde769787 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -859,6 +859,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void device_block_translation(struct device *dev);
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev);
+void domain_update_iommu_cap(struct dmar_domain *domain);
+
 int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node, gfp_t gfp);
-- 
2.34.1

