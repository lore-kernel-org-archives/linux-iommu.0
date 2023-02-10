Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01488816
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 22:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676069912; x=1707605912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6RYPYNudeO92HkgYSZvErdX3dsaQSj5ow61NfTrlatg=;
  b=Gzd0w42nWIpOa2pYe+Kmdpwm0qGTtFwHbwc4MpdhRmdeebWnLV0RutEC
   Cz8IfK3HAUaYYCZzT9CpjU9EEPud6Ke820YaHUMJB610bvv7OA3ylArva
   IKEdrguHMlgVGsutEcFnd7OaojEzO3m5FZV7IlZ1KJEygE6QaD+w1OQmi
   eov+gL939q5wN9NWSGL83vH9/jM9GL2Ek808ObcBH2O+ySaaqVtnuYpDo
   2xD1Hae163sIdnLdSgs0Q6QjkrS00FapoFY2UputbunkF0hHylAwPIaSa
   sdOyvSZgWOqHqsEbbQw8pYvVKv6TGkCivpPK8FwvpqyLromnj3VTFQIJm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310179488"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310179488"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:58:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="777093496"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="777093496"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 14:58:30 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Remove virtual command interface
Date: Fri, 10 Feb 2023 15:02:05 -0800
Message-Id: <20230210230206.3160144-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtual command interface was introduced to allow using host PASIDs
inside VMs. It is unused and abandoned due to architectural change.

With this patch, we can safely remove this feature and the related helpers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/cap_audit.c |  2 -
 drivers/iommu/intel/dmar.c      |  2 -
 drivers/iommu/intel/iommu.c     | 85 ---------------------------------
 drivers/iommu/intel/iommu.h     |  8 ----
 4 files changed, 97 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 806986696841..9862dc20b35e 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -54,7 +54,6 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, nwfs, ECAP_NWFS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, vcs, ECAP_VCS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
@@ -101,7 +100,6 @@ static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slts, ECAP_SLTS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nwfs, ECAP_NWFS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, vcs, ECAP_VCS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smts, ECAP_SMTS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pds, ECAP_PDS_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dit, ECAP_DIT_MASK);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b00a0ceb2d13..bf0bfe5ba7a7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -989,8 +989,6 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
-	if (ecap_vcs(iommu->ecap))
-		iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2ee270e4d484..ca989d997a9a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1721,9 +1721,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
-	if (vccap_pasid(iommu->vccap))
-		ioasid_unregister_allocator(&iommu->pasid_allocator);
-
 #endif
 }
 
@@ -2793,85 +2790,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-static ioasid_t intel_vcmd_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
-{
-	struct intel_iommu *iommu = data;
-	ioasid_t ioasid;
-
-	if (!iommu)
-		return INVALID_IOASID;
-	/*
-	 * VT-d virtual command interface always uses the full 20 bit
-	 * PASID range. Host can partition guest PASID range based on
-	 * policies but it is out of guest's control.
-	 */
-	if (min < PASID_MIN || max > intel_pasid_max_id)
-		return INVALID_IOASID;
-
-	if (vcmd_alloc_pasid(iommu, &ioasid))
-		return INVALID_IOASID;
-
-	return ioasid;
-}
-
-static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
-{
-	struct intel_iommu *iommu = data;
-
-	if (!iommu)
-		return;
-	/*
-	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
-	 * We can only free the PASID when all the devices are unbound.
-	 */
-	if (ioasid_find(NULL, ioasid, NULL)) {
-		pr_alert("Cannot free active IOASID %d\n", ioasid);
-		return;
-	}
-	vcmd_free_pasid(iommu, ioasid);
-}
-
-static void register_pasid_allocator(struct intel_iommu *iommu)
-{
-	/*
-	 * If we are running in the host, no need for custom allocator
-	 * in that PASIDs are allocated from the host system-wide.
-	 */
-	if (!cap_caching_mode(iommu->cap))
-		return;
-
-	if (!sm_supported(iommu)) {
-		pr_warn("VT-d Scalable Mode not enabled, no PASID allocation\n");
-		return;
-	}
-
-	/*
-	 * Register a custom PASID allocator if we are running in a guest,
-	 * guest PASID must be obtained via virtual command interface.
-	 * There can be multiple vIOMMUs in each guest but only one allocator
-	 * is active. All vIOMMU allocators will eventually be calling the same
-	 * host allocator.
-	 */
-	if (!vccap_pasid(iommu->vccap))
-		return;
-
-	pr_info("Register custom PASID allocator\n");
-	iommu->pasid_allocator.alloc = intel_vcmd_ioasid_alloc;
-	iommu->pasid_allocator.free = intel_vcmd_ioasid_free;
-	iommu->pasid_allocator.pdata = (void *)iommu;
-	if (ioasid_register_allocator(&iommu->pasid_allocator)) {
-		pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
-		/*
-		 * Disable scalable mode on this IOMMU if there
-		 * is no custom allocator. Mixing SM capable vIOMMU
-		 * and non-SM vIOMMU are not supported.
-		 */
-		intel_iommu_sm = 0;
-	}
-}
-#endif
-
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -2960,9 +2878,6 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-#ifdef CONFIG_INTEL_IOMMU_SVM
-		register_pasid_allocator(iommu);
-#endif
 		iommu_set_root_entry(iommu);
 	}
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..6bdfbead82c4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -184,7 +184,6 @@
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_slads(e)		(((e) >> 45) & 0x1)
-#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		(((e) >> 41) & 0x1)
 #define ecap_pds(e)		(((e) >> 42) & 0x1)
@@ -210,9 +209,6 @@
 #define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
 #define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
 
-/* Virtual command interface capability */
-#define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
-
 /* IOTLB_REG */
 #define DMA_TLB_FLUSH_GRANU_OFFSET  60
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
@@ -307,8 +303,6 @@
 #define DMA_PRS_PPR	((u32)1)
 #define DMA_PRS_PRO	((u32)2)
 
-#define DMA_VCS_PAS	((u64)1)
-
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
 	cycles_t start_time = get_cycles();				\
@@ -560,7 +554,6 @@ struct intel_iommu {
 	u64		reg_size; /* size of hw register set */
 	u64		cap;
 	u64		ecap;
-	u64		vccap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -583,7 +576,6 @@ struct intel_iommu {
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	unsigned long prq_seq_number;
 	struct completion prq_complete;
-	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
-- 
2.25.1

