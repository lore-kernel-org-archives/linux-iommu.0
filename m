Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A108F49
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282895; x=1726818895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMm83P7beXWMiji6R1eFj/4s+rv6p3/F5Z6Swx5xKU0=;
  b=mtp8ElGfaPU2kKfHvJSSVpQm5yD2uvoDfSQsn+My+ZcmaWPwDsmLDzJo
   qFSYMS0t9eaW+O4ZeV4b5HMEWuPolUHVvZXr3zlisfTwMffule49G4yeD
   5gjOSdZa76+5GvVnIRLgmw2MoW9erap6K+VGjBtShrg4dtr+mLHOmCxJJ
   LB4cxGE5wFfejkAKq9BCuBF5U0UXFqikr7oRogR6sjf25OFhuQjFae45k
   qnXDwZdSW/q18+Zl/OALEoZctXZsJIm2mW1FuReDe14JY4+TTGUSeL7T2
   9tLaxWqlmoTLw//UWMqDyYl4OmHlo19/LdhE4+jdpJprYnZ3jZA03l6a2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764508"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523193"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523193"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:54 -0700
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
Subject: [PATCH v5 11/11] iommu/vt-d: Disallow read-only mappings to nest parent domain
Date: Thu, 21 Sep 2023 00:54:31 -0700
Message-Id: <20230921075431.125239-12-yi.l.liu@intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 11 +++++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9b10e4b1d400..dbcdf7b95b9f 100644
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
@@ -4106,6 +4111,11 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			domain = ERR_PTR(-ENOMEM);
 	}
 
+	if (!IS_ERR(domain)) {
+		struct dmar_domain *dmar_domain = container_of(domain,
+						struct dmar_domain, domain);
+		dmar_domain->is_nested_parent = request_nest_parent;
+	}
 	return domain;
 }
 
@@ -4831,6 +4841,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ac23b9d22d20..8d0aac71c135 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -592,6 +592,7 @@ struct dmar_domain {
 					 * otherwise, goes through the second
 					 * level.
 					 */
+	u8 is_nested_parent:1;		/* has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3050efbceb57..99401d7d70b2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -440,10 +440,20 @@ struct iommu_hwpt_alloc {
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

