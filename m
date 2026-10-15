Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F782C031E;
	Thu, 15 Oct 2026 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027192; cv=none; b=XEDB63wlwilnC8zboGobG+z5uYTTVCcic5YG3efeUmP58gkkYqIirctef3845gxVXHSk/B/J8lZC16h5w/yeQpSFhXdZ7RnJAHmFAi9l4p91qhr4E03EKixtRiUmVFvK2VP+E7Nm1KZO0x4OVxKSCAnnRtsDEcY2txRAS47Bpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027192; c=relaxed/simple;
	bh=HrWFrRtMHsV9x63M8QbsgJS1ohTZFuZ+YQgslFwAOAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd+qU++eVwdmuxzz3t1Uplv6dDOmzEt8F46HgXwuia9GDLg0u/0BwJc0ZpgZUoBvuHUSJYVy7v/QAVJYmpKYWThBr+J9BZvNYEyddkaGdG97OvJEmt8g3L8p1mH2J+qjNYJQ4Yw0uI8ROZkjdYQ8qDvJrIJI8kBzfocLM6etLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7HuUszg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7HuUszg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027191; x=1823563191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrWFrRtMHsV9x63M8QbsgJS1ohTZFuZ+YQgslFwAOAM=;
  b=b7HuUszgbcJ49gp+zwiWSu8/WpLPcQfbhdnmEgW7nH9ZSpSln7L/gxzb
   WViBcIssOBAquAtfcHmurDvw9NBCqg2FbuRTm5GQPJvh9JPy0vMy8A6IV
   uTRum+8q7DCRZw86RQCcEZ2SjhsvNgXgr8Z+aLbFTzHF6BI62/jfDab+j
   27msChiCF6dNcvOxaaulTH9wTdW7zcpuJ9hKlqZXGp38Y/NownLFx7Ycq
   kQYUgILrJxYuaFHI6VuasuiiYnVFRgSoc5KXXw7hvPXDVbmwhDZaKlKrj
   gx/i4gJt6ug854Swqh2PDYd2cFkYbArc9+tq8tz2aUfB7ycxBQ2x4WkAp
   g==;
X-CSE-ConnectionGUID: sYlJ3MviRu60a4PVE5tZ4Q==
X-CSE-MsgGUID: Nb0vSIsuTwOUAPHEv1OKlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789216"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789216"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:19:51 -0700
X-CSE-ConnectionGUID: RPuNlHPHSUKzygBaVbCzsw==
X-CSE-MsgGUID: qT0O9c/9Smi/8la6taQ//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1595582"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 18:19:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/4] iommu/vt-d: Add an API for tdx-host when enabling trusted DMA
Date: Thu, 15 Oct 2026 09:07:04 +0800
Message-ID: <20261015010705.1973284-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX Connect requires each Intel IOMMU that supports the trusted DMA
extension (ECAP.TDXCS) to be transitioned into Secure TDX Mode by the
TDX module. The transition itself is driven by TDH.IOMMU.SETUP, which
is issued by the tdx-host driver. The VT-d driver owns the hardware
state that the TDX module depends on, so it must validate that state
and adjust its resource management around it.

Add dmar_tdxcs_iommu_init_all() and dmar_tdxcs_iommu_release() as the
interface between the two. dmar_tdxcs_iommu_init_all() walks the active
DMAR units, and for every unit advertising ECAP.TDXCS it:

 - Verifies the preconditions that TDH.IOMMU.SETUP checks: translation
   enabled, queued invalidation enabled, and scalable mode in use. This
   allows a misconfiguration to be reported as -EINVAL rather than as
   an opaque TDX_IOMMU_INVALID_STATE status later on.

 - Splits the domain ID namespace. When an IOMMU runs in Secure TDX
   Mode, the TDX module owns the MSB-tagged half of the DID space and
   always sets that bit for trusted DMA translations, so the host must
   confine itself to the lower half.

 - Invokes the caller-supplied setup() callback, which performs the
   actual TDX module interaction, and marks the unit as being in TDX
   mode on success. On failure the DID cap is restored and the error is
   propagated.

dmar_tdxcs_iommu_release() reverses the DID restriction and clears the
TDX mode flag for a single unit.

The DMAR unit is passed to the callback so the tdx-host driver can
obtain the register base address, which is how the TDX module
identifies an IOMMU, and the NUMA node, which it needs in order to
allocate the metadata pages local to that IOMMU.

A DMAR unit in TDX mode cannot be hot-removed, because the TDX module
holds references to its resources. Reject such attempts with -EBUSY.
Conversely, an IOMMU that is hot-added after bring-up is not enrolled
into Secure TDX Mode because no platform currently supports both TDX
Connect and DMAR hotplug, so the flow cannot be validated on hardware.

TDH.IOMMU.SETUP requires that no enhanced command is in progress on
the target IOMMU. Block enhanced command submission on the target
IOMMU for the duration of TDH.IOMMU.SETUP.

The symbols are exported only to the tdx-host module.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |   6 +++
 include/linux/dmar.h        |   5 ++
 drivers/iommu/intel/dmar.c  | 103 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  19 +++++++
 4 files changed, 133 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 23dbe6c24439..a334226c4324 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -187,6 +187,7 @@
  */
 
 #define ecap_pms(e)		(((e) >> 51) & 0x1)
+#define ecap_tdxcs(e)		(((e) >> 50) & 0x1)
 #define ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
@@ -689,6 +690,11 @@ struct intel_iommu {
 	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
+	/*
+	 * Enhanced command submission is rejected due to TDH.IOMMU.SETUP.
+	 * Protected by register_lock.
+	 */
+	bool		ecmd_blocked;
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
 	int		msagaw; /* max sagaw of this iommu */
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 63e35df2cef4..4205945f099f 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -47,6 +47,8 @@ struct dmar_drhd_unit {
 	u8	ignored:1; 		/* ignore drhd		*/
 	u8	include_all:1;
 	u8	gfx_dedicated:1;	/* graphic dedicated	*/
+	bool	tdx_mode;		/* in Secure TDX Mode	*/
+	int	node;
 	struct intel_iommu *iommu;
 };
 
@@ -87,6 +89,9 @@ extern struct list_head dmar_drhd_units;
 				dmar_rcu_check())			\
 		if (i=drhd->iommu, 0) {} else 
 
+int dmar_tdxcs_iommu_init_all(int (*setup)(struct dmar_drhd_unit *));
+void dmar_tdxcs_iommu_release(struct dmar_drhd_unit *drhd);
+
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..c0eb2e3d94ef 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -431,6 +431,7 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	/* The size of the register set is 2 ^ N 4 KB pages. */
 	dmaru->reg_size = 1UL << (drhd->size + 12);
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
+	dmaru->node = NUMA_NO_NODE;
 	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
 					      ((void *)drhd) + drhd->header.length,
 					      &dmaru->devices_cnt);
@@ -499,6 +500,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 
 			if (node != NUMA_NO_NODE && !node_online(node))
 				node = NUMA_NO_NODE;
+			drhd->node = node;
 			drhd->iommu->node = node;
 			return 0;
 		}
@@ -2296,6 +2298,10 @@ static int dmar_hp_remove_drhd(struct acpi_dmar_header *header, void *arg)
 			return -EBUSY;
 	}
 
+	/* The TDX module holds references to this unit's resources. */
+	if (dmaru->tdx_mode)
+		return -EBUSY;
+
 	ret = dmar_ir_hotplug(dmaru, false);
 	if (ret == 0)
 		ret = dmar_iommu_hotplug(dmaru, false);
@@ -2468,3 +2474,100 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+static int dmar_tdxcs_block_ecmd(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (!cap_ecmds(iommu->cap))
+		return 0;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	if (readq(iommu->reg + DMAR_ECRSP_REG) & DMA_ECMD_ECRSP_IP)
+		ret = -EBUSY;
+	else
+		iommu->ecmd_blocked = true;
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	return ret;
+}
+
+static void dmar_tdxcs_unblock_ecmd(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	iommu->ecmd_blocked = false;
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+}
+
+int dmar_tdxcs_iommu_init_all(int (*setup)(struct dmar_drhd_unit *))
+{
+	struct dmar_drhd_unit *drhd;
+	int ret;
+
+	if (!intel_iommu_enabled)
+		return -EOPNOTSUPP;
+
+	guard(rwsem_write)(&dmar_global_lock);
+
+	for_each_active_drhd_unit(drhd) {
+		struct intel_iommu *iommu = drhd->iommu;
+		unsigned long ndoms;
+
+		if (!ecap_tdxcs(iommu->ecap))
+			continue;
+
+		/*
+		 * TDH.IOMMU.SETUP requires the unit not to be in Secure TDX
+		 * Mode yet, with DMA translation, queued invalidation and
+		 * scalable mode enabled. Catch these here so the error is
+		 * -EINVAL rather than an opaque TDX_IOMMU_INVALID_STATE.
+		 */
+		if (drhd->tdx_mode || !(iommu->gcmd & DMA_GCMD_TE) ||
+		    !iommu->qi || !sm_supported(iommu))
+			return -EINVAL;
+
+		ndoms = cap_ndoms(iommu->cap);
+		scoped_guard(mutex, &iommu->did_lock) {
+			if (ida_find_first_range(&iommu->domain_ida, ndoms >> 1,
+						 ndoms - 1) > 0)
+				return -EBUSY;
+			iommu->max_domain_id = ndoms >> 1;
+		}
+
+		ret = dmar_tdxcs_block_ecmd(iommu);
+		if (!ret) {
+			ret = setup(drhd);
+			dmar_tdxcs_unblock_ecmd(iommu);
+		}
+
+		if (ret) {
+			scoped_guard(mutex, &iommu->did_lock)
+				iommu->max_domain_id = ndoms;
+
+			/* Not covered by this TDX module. Skip it and keep going. */
+			if (ret == -EOPNOTSUPP)
+				continue;
+
+			return ret;
+		}
+
+		drhd->tdx_mode = true;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(dmar_tdxcs_iommu_init_all, "tdx-host");
+
+void dmar_tdxcs_iommu_release(struct dmar_drhd_unit *drhd)
+{
+	struct intel_iommu *iommu = drhd->iommu;
+
+	guard(rwsem_write)(&dmar_global_lock);
+	scoped_guard(mutex, &iommu->did_lock)
+		iommu->max_domain_id = cap_ndoms(iommu->cap);
+	drhd->tdx_mode = false;
+}
+EXPORT_SYMBOL_FOR_MODULES(dmar_tdxcs_iommu_release, "tdx-host");
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..37c8c375c020 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2189,6 +2189,15 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 		return -EINVAL;
 
 	if (insert) {
+		/*
+		 * A hot-added IOMMU is not enrolled into Secure TDX Mode.
+		 * Currently, there is no platform that supports both TDX Connect and
+		 * DMAR hotplug, so enrolling on hotplug cannot be validated on real
+		 * hardware. Log this limitation to make it visible.
+		 */
+		if (ecap_tdxcs(iommu->ecap))
+			pr_info("Trusted DMA for TEE is not enabled on hot-added IOMMU %s\n",
+				iommu->name);
 		ret = intel_iommu_add(dmaru);
 	} else {
 		disable_dmar_iommu(iommu);
@@ -4227,6 +4236,16 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
+	/*
+	 * TDH.IOMMU.SETUP requires that no enhanced command is in
+	 * progress. This may be called from atomic context (e.g. perf
+	 * pmu::start/stop), so don't sleep; just reject the request.
+	 */
+	if (iommu->ecmd_blocked) {
+		ret = -EBUSY;
+		goto err;
+	}
+
 	res = readq(iommu->reg + DMAR_ECRSP_REG);
 	if (res & DMA_ECMD_ECRSP_IP) {
 		ret = -EBUSY;
-- 
2.43.0

