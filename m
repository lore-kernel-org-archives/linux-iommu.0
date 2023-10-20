Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98212E76
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/SeEzCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794377; x=1729330377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFY6DFqQdqzEYR8dbOOBhT/l5R4uXZhFdyT3GIHn4js=;
  b=C/SeEzCoR1zzi26Kex5EtMmiBjVzi9Km341sCvG5zLxTD6acLJZBbMdS
   PuGZl+Wj45SZ39uEU4jVHwhVw+4vVdud2e3utOFqg5MKklB6xf0PqhWn6
   Hjj4ZjrzSAhSOHxuv1t9cm/ZOejhMTc1Hldh6Lg5dNH4551ZijfY/Swmo
   H+tO6BUMHEdHIlgMSjei0SAdCgReupZFMmpJCmHQwMGkgb8Mz1zT8B1fo
   2sh6ZF0VYXdcvkHjmjmGQYda+L2Ag5RPMgiK396rjIC38YDgxtkFe1lSV
   W5ZerEsmkWe1Pb2rLBlBdMEp7YhJ6LfdWB/hioCOWwtrWwzc+RZQAXIeN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691763"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691763"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906314"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906314"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:56 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest parent domain
Date: Fri, 20 Oct 2023 02:32:46 -0700
Message-Id: <20231020093246.17015-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093246.17015-1-yi.l.liu@intel.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

When remapping hardware is configured by system software in scalable mode
as Nested (PGTT=011b) and with PWSNP field Set in the PASID-table-entry,
it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled)
in first-stage page-table entries even when second-stage mappings indicate
that corresponding first-stage page-table is Read-Only.

As the result, contents of pages designated by VMM as Read-Only can be
modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
address translation process due to DMAs issued by Guest.

This disallows read-only mappings in the domain that is supposed to be used
as nested parent. Reference from Sapphire Rapids Specification Update [1],
errata details, SPR17. Userspace should know this limitation by checking
the IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 flag reported in the IOMMU_GET_HW_INFO
ioctl.

[1] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  |  9 +++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c7704e7efd4a..a0341a069fbf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2193,6 +2193,11 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
+	if (!(prot & DMA_PTE_WRITE) && domain->is_nested_parent) {
+		pr_err_ratelimited("Read-only mapping is disallowed on the domain which serves as the parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)\n");
+		return -EINVAL;
+	}
+
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
@@ -4101,6 +4106,9 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 		domain = iommu_domain_alloc(dev->bus);
 		if (!domain)
 			return ERR_PTR(-ENOMEM);
+		container_of(domain,
+			     struct dmar_domain,
+			     domain)->is_nested_parent = request_nest_parent;
 		return domain;
 	}
 
@@ -4839,6 +4847,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b4560983b8b9..0539a0f47557 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -593,6 +593,7 @@ struct dmar_domain {
 					 * otherwise, goes through the second
 					 * level.
 					 */
+	u8 is_nested_parent:1;		/* has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9b843a197ea8..c8f523a7bc06 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -439,10 +439,20 @@ struct iommu_hwpt_alloc {
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
+/**
+ * enum iommu_hw_info_vtd_flags - Flags for VT-d hw_info
+ * @IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17: If set, disallow nesting on domains
+ *                                   with read-only mapping.
+ *                                   https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
+ */
+enum iommu_hw_info_vtd_flags {
+	IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_vtd - Intel VT-d hardware information
  *
- * @flags: Must be 0
+ * @flags: Combination of enum iommu_hw_info_vtd_flags
  * @__reserved: Must be 0
  *
  * @cap_reg: Value of Intel VT-d capability register defined in VT-d spec
-- 
2.34.1

