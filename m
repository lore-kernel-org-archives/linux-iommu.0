Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458644;
	b=mJPcZG57EOkIxMfU+SuUDiupW2zojpPF92tdkuBFuOmPyNfasBN7u8Q5Kpwjdmf9tigz
	 vy4I7vbsC8i1EQsqJ3Yp2Rlv5owLkl7pXBLRG0q1Z2LZDGffDcfTuCNxMEIaAypvBaI8Y
	 pt6e4AJmfH5qhhdS2YpTDWu/sR6fIfcFaIAdclDln1mN0qL1CqR65UHreD//EAvqE9K68
	 XCt7LeyW/un8CK79bkBeavgjc42rh0qLK0PPqCgvtCGAsfBv4cVcl0q7+v4FnJ/VSKqEN
	 4HYCe+5aiJe+kKB35U1p1NFIdRDQ/6iXboSUqayvT1CAF3I+Bspeik5lypiGdoUMLxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458644;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gdFaP5z/d8g2/zQpFGODMkM849k6CYUFHHgzID0OGSI=;
	b=QeDKKNriIWaSpJ2DnblRgoxmPG09ixbmW9uVHa5TwBwLVx/bSUgeclyPdKrNVXKBac0+
	 jM8lhtZA2820ZuLjkPEQCfOM5D4+qSdXwDUf/trHfaQ3tnPTe3YyIhMl5z5trAWLIhZVp
	 XGhukBl3Wq21uWCUXngHpMlOsjuHCMgFO2joS8YwQ81tKuuF0rTZfC9CIlypP7Vjrdu1C
	 Ju3zIhud+e39t/E+VMW49MWp3es3G7SHjspAYEupnxM9AZGsU1V4+CcsP0D+ZCSh5IbcV
	 VbqvhrliOEuYO3zB0RMTPoXkRvJ/wMMF54/Jpv01YUA3RkLgZqetB0qSad6nGlee9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IiBrVJwz;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C8606A889;
	Thu, 12 Nov 2026 04:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841C8606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IiBrVJwz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458643; x=1825994643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CK5jXPK8E8Bbfj51zOmj5JuHHKDcflexBQMad5gytYM=;
  b=IiBrVJwzl6bX3gkPMnR4XHqQYT/mGjIA+OxGYNiWRfgfqMuo7PbWRCdJ
   gdHIkGlRTpKPI3qqMGgy92uxhXBLZEWNU0aP8lcQuoA2WA0VnT9jv4vMd
   hp3hqj8wEaairoivvgG7bJX2RDD2DgUvSViYQuYEum1+0TfpZvgMqmz8n
   l/FtfV42iLJApCrHd75+1q8UQyqIxUEYR+ex69FGzbA278pm9qylXknVs
   XhvL0MZK9RAIWCZnYrUFjkwnLMDQAU0wYajniZ4Dw/V7cFB/S7B4PefiZ
   DlFqZogUxinnYrIElZXS8JmmyG8K3hi0TbMHcCmwZ1aPsM0xbTXWo9kHS
   A==;
X-CSE-ConnectionGUID: 75J7Yjo8QVOz4fpg1xixJQ==
X-CSE-MsgGUID: Kz3kUs5FQrmb/MkcHiQLdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318346"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318346"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:02 -0800
X-CSE-ConnectionGUID: gxBLdV0hTLuK563WClHgPw==
X-CSE-MsgGUID: jGzRQuc2RT+cmUxIyfEo+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728634"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:43:58 -0800
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
Subject: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when enabling trusted DMA
Date: Thu, 12 Nov 2026 12:30:49 +0800
Message-ID: <20261112043054.2664857-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An Intel IOMMU that supports trusted DMA (ECAP.TDXCS) provides a second
set of DMA translation resources, managed by the TDX module and used
only for devices assigned to TDs. Before they can be used, the tdx-host
driver issues TDH.IOMMU.SETUP to put the IOMMU into Secure TDX Mode, and
issues TDH.IOMMU.CLEAR to take it out again.

The VT-d driver owns the hardware state these SEAMCALLs depend on, so
it checks that state and keeps its own use of the IOMMU out of the TDX
module's way. This is cooperation, not enforcement: the TDX module
protects trusted DMA regardless, and a misbehaving host can only cause
failures.

Add a per-device interface so that an IOMMU is put into Secure TDX Mode
only when a device behind it needs trusted DMA. tdx-host tracks how many
devices use each IOMMU and calls into the VT-d driver only for the first
and the last of them:

- dmar_tdxc_get_params() looks up the DMAR unit translating the device
  and returns its register base address, which is how the TDX module
  identifies an IOMMU, and its NUMA node, so that tdx-host can allocate
  the TDX module's metadata pages local to that IOMMU.

- dmar_tdxc_acquire() is called right before TDH.IOMMU.SETUP. It checks
  the preconditions TDH.IOMMU.SETUP requires (DMA translation, queued
  invalidation and scalable mode enabled) and confines the host to the
  lower half of the domain ID space, since the TDX module owns the half
  with the MSB set.

- dmar_tdxc_release() undoes acquire(). tdx-host calls it if
  TDH.IOMMU.SETUP fails, or after TDH.IOMMU.CLEAR succeeds for the last
  user. If TDH.IOMMU.CLEAR fails, tdx-host doesn't call it, so the upper
  half of the domain ID space stays reserved for the TDX module.

DMAR units advertising ECAP.TDXCS are excluded from DMAR hotplug. No
platform currently supports both trusted DMA and DMAR hotplug, so that
flow can't be validated on hardware. Hot-removing such a unit is also
unsafe, because tdx-host may hold a reference to it and the TDX module
may own its trusted DMA resources. This also keeps the unit handle
returned by dmar_tdxc_get_params() valid for the lifetime of the system.

The symbols are exported only to the tdx-host module.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |   3 +
 include/linux/dmar.h        |  23 +++++
 drivers/iommu/intel/dmar.c  | 185 ++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5b3d234ae265..18fef91753a0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -187,6 +187,7 @@
  */
 
 #define ecap_pms(e)		(((e) >> 51) & 0x1)
+#define ecap_tdxcs(e)		(((e) >> 50) & 0x1)
 #define ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
@@ -689,6 +690,8 @@ struct intel_iommu {
 	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
+	/* Acquired for the TDX module. Protected by register_lock. */
+	bool		tdxc_acquired;
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
 	int		msagaw; /* max sagaw of this iommu */
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 63e35df2cef4..a39ca13f13dc 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -47,9 +47,32 @@ struct dmar_drhd_unit {
 	u8	ignored:1; 		/* ignore drhd		*/
 	u8	include_all:1;
 	u8	gfx_dedicated:1;	/* graphic dedicated	*/
+	struct mutex tdxc_lock;		/* serializes acquire/release */
 	struct intel_iommu *iommu;
 };
 
+/*
+ * struct dmar_tdxc_params - IOMMU information for driving TDH.IOMMU.*
+ * @reg_base_addr: Register base address of the IOMMU. The TDX module
+ *		   identifies an IOMMU by it.
+ * @node: NUMA node of the IOMMU, for allocating the TDX module's
+ *	  metadata pages local to it.
+ * @drhd: VT-d internal handle; the caller must not dereference it. It
+ *	  stays valid for the lifetime of the system because TDX
+ *	  Connect-capable units are never hot-removed.
+ */
+struct dmar_tdxc_params {
+	u64 reg_base_addr;
+	int node;
+	struct dmar_drhd_unit *drhd;
+};
+
+int dmar_tdxc_get_params(struct pci_dev *pdev, struct dmar_tdxc_params *params);
+int dmar_tdxc_acquire(struct pci_dev *pdev,
+		      const struct dmar_tdxc_params *params);
+void dmar_tdxc_release(struct pci_dev *pdev,
+		       const struct dmar_tdxc_params *params);
+
 struct dmar_pci_path {
 	u8 bus;
 	u8 device;
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6377ba97a9ea..60d4c8ab1b4c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -431,6 +431,7 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	/* The size of the register set is 2 ^ N 4 KB pages. */
 	dmaru->reg_size = 1UL << (drhd->size + 12);
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
+	mutex_init(&dmaru->tdxc_lock);
 	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
 					      ((void *)drhd) + drhd->header.length,
 					      &dmaru->devices_cnt);
@@ -2367,6 +2368,25 @@ static int dmar_hp_release_drhd(struct acpi_dmar_header *header, void *arg)
 	return 0;
 }
 
+static int dmar_hp_check_tdxc(struct acpi_dmar_header *header, void *arg)
+{
+	struct dmar_drhd_unit *dmaru;
+
+	dmaru = dmar_find_dmaru((struct acpi_dmar_hardware_unit *)header);
+	if (!dmaru || !dmaru->iommu || !ecap_tdxcs(dmaru->iommu->ecap))
+		return 0;
+
+	/*
+	 * No platform currently supports both trusted DMA and DMAR hotplug,
+	 * so it cannot be validated on real hardware. Removal is also unsafe:
+	 * tdx-host may hold a pointer to this unit and the TDX module may own
+	 * its trusted DMA resources.
+	 */
+	pr_info("%s: hotplug of an IOMMU with trusted DMA support is not supported\n",
+		dmaru->iommu->name);
+	return -EOPNOTSUPP;
+}
+
 static int dmar_hotplug_insert(acpi_handle handle)
 {
 	int ret;
@@ -2396,6 +2416,11 @@ static int dmar_hotplug_insert(acpi_handle handle)
 	if (ret)
 		goto release_atsr;
 
+	ret = dmar_walk_dsm_resource(handle, DMAR_DSM_FUNC_DRHD,
+				     &dmar_hp_check_tdxc, NULL);
+	if (ret)
+		goto release_atsr;
+
 	ret = dmar_walk_dsm_resource(handle, DMAR_DSM_FUNC_DRHD,
 				     &dmar_hp_add_drhd, NULL);
 	if (!ret)
@@ -2422,6 +2447,11 @@ static int dmar_hotplug_remove(acpi_handle handle)
 	if (ret)
 		return ret;
 
+	ret = dmar_walk_dsm_resource(handle, DMAR_DSM_FUNC_DRHD,
+				     &dmar_hp_check_tdxc, NULL);
+	if (ret)
+		return ret;
+
 	ret = dmar_walk_dsm_resource(handle, DMAR_DSM_FUNC_DRHD,
 				     &dmar_hp_remove_drhd, NULL);
 	if (ret == 0) {
@@ -2518,3 +2548,158 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+static void dmar_tdxc_fill_params(struct dmar_drhd_unit *drhd,
+				  struct dmar_tdxc_params *params)
+{
+	params->reg_base_addr = drhd->reg_base_addr;
+	params->node = drhd->iommu->node;
+	/*
+	 * params->drhd stays valid because trusted DMA-capable units are
+	 * never hot-removed.
+	 */
+	params->drhd = drhd;
+}
+
+/*
+ * When the IOMMU runs in Secure TDX Mode, the TDX module owns the
+ * MSB-tagged half of the domain ID space. Confine the host to the
+ * lower half, failing if any upper-half DID is already in use.
+ */
+static int dmar_tdxc_reserve_did(struct intel_iommu *iommu)
+{
+	unsigned long ndoms = cap_ndoms(iommu->cap);
+
+	guard(mutex)(&iommu->did_lock);
+	if (ida_find_first_range(&iommu->domain_ida, ndoms >> 1, ndoms - 1) >= 0)
+		return -EBUSY;
+
+	iommu->max_domain_id = ndoms >> 1;
+	return 0;
+}
+
+static void dmar_tdxc_unreserve_did(struct intel_iommu *iommu)
+{
+	guard(mutex)(&iommu->did_lock);
+	iommu->max_domain_id = cap_ndoms(iommu->cap);
+}
+
+static void dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool acquired)
+{
+	guard(raw_spinlock_irqsave)(&iommu->register_lock);
+	iommu->tdxc_acquired = acquired;
+}
+
+static struct dmar_drhd_unit *dmar_tdxc_find_drhd(struct pci_dev *pdev)
+{
+	struct dmar_drhd_unit *drhd;
+
+	if (!intel_iommu_enabled)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	guard(rwsem_read)(&dmar_global_lock);
+
+	drhd = dmar_find_matched_drhd_unit(pdev);
+	if (!drhd || drhd->ignored || !drhd->iommu)
+		return ERR_PTR(-ENODEV);
+
+	if (!ecap_tdxcs(drhd->iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return drhd;
+}
+
+/*
+ * dmar_tdxc_get_params() - Get the IOMMU information for a device
+ * @dev: PCI device that will use trusted DMA
+ * @params: Filled in on success
+ *
+ * Look up the IOMMU that translates @dev and return what tdx-host needs
+ * to issue TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR on it. This only reads
+ * information and doesn't change any state. Devices behind the same
+ * IOMMU get the same @params->reg_base_addr.
+ *
+ * Return 0 on success and error code on failure.
+ */
+int dmar_tdxc_get_params(struct pci_dev *pdev, struct dmar_tdxc_params *params)
+{
+	struct dmar_drhd_unit *drhd = dmar_tdxc_find_drhd(pdev);
+
+	if (IS_ERR(drhd))
+		return PTR_ERR(drhd);
+
+	dmar_tdxc_fill_params(drhd, params);
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_get_params, "tdx-host");
+
+/*
+ * dmar_tdxc_acquire() - Acquire an IOMMU for TDH.IOMMU.SETUP
+ * @dev: PCI device that will use trusted DMA
+ * @params: Returned by dmar_tdxc_get_params() for @dev
+ *
+ * Call this right before issuing TDH.IOMMU.SETUP for the first user of
+ * the IOMMU. On success, the caller must issue TDH.IOMMU.SETUP and call
+ * dmar_tdxc_release() if it fails. The caller owns the per-IOMMU refcount
+ * and must serialize all calls for the same IOMMU.
+ *
+ * Return: 0 on success and error code on failure.
+ */
+int dmar_tdxc_acquire(struct pci_dev *pdev,
+		      const struct dmar_tdxc_params *params)
+{
+	struct dmar_drhd_unit *drhd = params->drhd;
+	struct intel_iommu *iommu = drhd->iommu;
+	int ret;
+
+	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))
+		return -EINVAL;
+
+	guard(mutex)(&drhd->tdxc_lock);
+	/* Still set if TDH.IOMMU.CLEAR failed and tdx-host was reloaded. */
+	if (iommu->tdxc_acquired)
+		return -EBUSY;
+
+	/*
+	 * TDH.IOMMU.SETUP requires DMA translation, queued invalidation and
+	 * scalable mode to be enabled. Catch these here so the error is
+	 * -EINVAL rather than an opaque TDX_IOMMU_INVALID_STATE.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi || !sm_supported(iommu))
+		return -EINVAL;
+
+	ret = dmar_tdxc_reserve_did(iommu);
+	if (ret)
+		return ret;
+
+	dmar_tdxc_set_acquired(iommu, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_acquire, "tdx-host");
+
+/*
+ * dmar_tdxc_release() - Take an IOMMU out of Secure TDX Mode
+ * @dev: PCI device whose IOMMU was acquired via dmar_tdxc_acquire()
+ * @params: Returned by dmar_tdxc_get_params() for @dev
+ *
+ * Call this if TDH.IOMMU.SETUP fails, or for the last user of the IOMMU
+ * after TDH.IOMMU.CLEAR has succeeded.
+ */
+void dmar_tdxc_release(struct pci_dev *pdev,
+		       const struct dmar_tdxc_params *params)
+{
+	struct dmar_drhd_unit *drhd = params->drhd;
+
+	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))
+		return;
+
+	guard(mutex)(&drhd->tdxc_lock);
+	if (WARN_ON(!drhd->iommu->tdxc_acquired))
+		return;
+
+	dmar_tdxc_set_acquired(drhd->iommu, false);
+	dmar_tdxc_unreserve_did(drhd->iommu);
+}
+EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_release, "tdx-host");
-- 
2.43.0

