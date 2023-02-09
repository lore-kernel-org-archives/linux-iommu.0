Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C3639
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917123; x=1707453123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpH4CQm84J9DnKJJMMRLFLLQ7LO+AHtC3nkTnQ/gZh4=;
  b=CK0+sAilCGktGWAUjNtJsMJwa8EvaZ4nLQ0amuSjQ1BNqLt4KUMBdDTe
   Ie97XLoJoKHsN5Jjl2+2WUEbmGQlBKP4FzwPgQfZ+luPbMjr/2gHV2XP5
   eW58H5OIfhFi7Jq6wS9L1u8RXOrBxMYTpSvycK3puRHpittivYipP+gxR
   NpTliRtJljhVOtQaslxSRvPH3lsD6Cvi/wO0Bw0f50GxW9Lcy6AQR8emq
   T61LBc3iXn1cHRQ7HSDC3gYlOReL2KuDUGKH8lBuAxGK4fycoJLgnHhq2
   DNCf/7sLAV1h6NKBi8qbsylKAPJL9zfXgPqXLnC7e0stuBSglK+4shPHe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298632"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298632"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447457"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447457"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:02 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 03/17] iommu/vt-d: Extend dmar_domain to support nested domain
Date: Wed,  8 Feb 2023 20:31:39 -0800
Message-Id: <20230209043153.14964-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The nested domain fields are exclusive to those that used for a DMA
remapping domain. Use union to avoid memory waste.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.h  | 35 ++++++++++++++++++++----
 include/uapi/linux/iommufd.h | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2e70265d4ceb..4fe74f217696 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,15 +541,38 @@ struct dmar_domain {
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
+	union {
+		/* DMA remapping domain */
+		struct {
+			/* virtual address */
+			struct dma_pte	*pgd;
+			/* max guest address width */
+			int		gaw;
+			/*
+			 * adjusted guest address width:
+			 *   0: level 2 30-bit
+			 *   1: level 3 39-bit
+			 *   2: level 4 48-bit
+			 *   3: level 5 57-bit
+			 */
+			int		agaw;
+			/* maximum mapped address */
+			u64		max_addr;
+		};
+
+		/* Nested user domain */
+		struct {
+			/* 2-level page table the user domain nested */
+			struct dmar_domain *s2_domain;
+			/* user page table pointer (in GPA) */
+			unsigned long s1_pgtbl;
+			/* page table attributes */
+			struct iommu_hwpt_intel_vtd s1_cfg;
+		};
+	};
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 6cfe102f26f3..0867900494c9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -407,4 +407,57 @@ struct iommu_device_info {
 	__u32 __reserved;
 };
 #define IOMMU_DEVICE_GET_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_INFO)
+
+/**
+ * enum iommu_hwpt_intel_vtd_flags - Intel VT-d stage-1 page
+ *				     table entry attributes
+ * @IOMMU_VTD_PGTBL_SRE: Supervisor request
+ * @IOMMU_VTD_PGTBL_EAFE: Extended access enable
+ * @IOMMU_VTD_PGTBL_PCD: Page-level cache disable
+ * @IOMMU_VTD_PGTBL_PWT: Page-level write through
+ * @IOMMU_VTD_PGTBL_EMTE: Extended mem type enable
+ * @IOMMU_VTD_PGTBL_CD: PASID-level cache disable
+ * @IOMMU_VTD_PGTBL_WPE: Write protect enable
+ */
+enum iommu_hwpt_intel_vtd_flags {
+	IOMMU_VTD_PGTBL_SRE = 1 << 0,
+	IOMMU_VTD_PGTBL_EAFE = 1 << 1,
+	IOMMU_VTD_PGTBL_PCD = 1 << 2,
+	IOMMU_VTD_PGTBL_PWT = 1 << 3,
+	IOMMU_VTD_PGTBL_EMTE = 1 << 4,
+	IOMMU_VTD_PGTBL_CD = 1 << 5,
+	IOMMU_VTD_PGTBL_WPE = 1 << 6,
+	IOMMU_VTD_PGTBL_LAST = 1 << 7,
+};
+
+/**
+ * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
+ *				 stage-1 page table info
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
+ * @pgtbl_addr: The base address of the user-managed stage-1 page table.
+ * @pat: Page attribute table data to compute effective memory type
+ * @emt: Extended memory type
+ * @addr_width: The address width of the untranslated addresses that are
+ *		subjected to the user-managed stage-1 page table.
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific data for creating hw_pagetable to represent
+ * the user-managed stage-1 page table that is used in nested translation.
+ *
+ * In nested translation, the stage-1 page table locates in the address
+ * space that defined by the corresponding stage-2 page table. Hence the
+ * stage-1 page table base address value should not be higher than the
+ * maximum untranslated address of stage-2 page table.
+ *
+ * The paging level of the stage-1 page table should be compataible with
+ * the hardware iommu. Otherwise, the allocation would be failed.
+ */
+struct iommu_hwpt_intel_vtd {
+	__u64 flags;
+	__u64 pgtbl_addr;
+	__u32 pat;
+	__u32 emt;
+	__u32 addr_width;
+	__u32 __reserved;
+};
 #endif
-- 
2.34.1

