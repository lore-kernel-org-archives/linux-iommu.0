Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAE8289A
	for <iommu@lists.linux.dev>; Sat,  7 Dec 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733572988; cv=none; b=V/t6HRwaGtbBWFCHAoko5qL7+s9T8hr6/6QNVDfkBlQDGZcO5hl3wsrhtfAdhSZvkkZgX46PseBrneDE8jPRUWyqqsYdXu4QRB359Zc3lssm0VDInQH9wi9mgLkJV5yB7iu0FuR+kic56dxliQ0DIHuui4SHkLJrK2fhOG2IrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733572988; c=relaxed/simple;
	bh=7TVeANMl4zi4hc2j3S4k4ChfWYMnRu0pPGmPJp8Hzk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MozwFqqa3qvCx/VILUos99UKypfGoLNLMYNKX6s1mPL7/8NUlayzBtmZexvxBM5E0RoH5I62HhSnWrX1UhCg5DWQjmQVDuZlH0itNDYBmW6Zh8qrxLZw7B8NtmwbQzv136BQJqnuYvJZoye24aD8lGT6wTdZsAO+Gp4OHaAuMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMRNEfHa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMRNEfHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733572987; x=1765108987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7TVeANMl4zi4hc2j3S4k4ChfWYMnRu0pPGmPJp8Hzk8=;
  b=IMRNEfHa5VNscfk5RjmoBDnL/zAMsNLxNWS5vAlWFo9hytWH/URXOBum
   SzthPsHUElBSd159kWIix6uY4ObfjBWyFQdEOFAfHZmcQTgenexgih0rU
   QM6N9RCfC7KFKSnWYYkFP/oa98AxdsK6VCFC5/CeyPswIBcJAE29OQNyW
   aQem5yRKhwfJvyYGiMhrZOQ60scd/iCy8UCrw1SL/FKimpM+hAF31OhuK
   dKKasziMsiYd9IJokepq3R3VI5jqe5k2rhesUvOpezt3wV5mL0/lgk/D0
   BDHDzuDA9E1xnsGsFylibKBAl4ibLdnZFzA8nnX6GcQ1vo+EKTH8dG+G2
   Q==;
X-CSE-ConnectionGUID: WlUsTDnHQSSdnjxxBfi7Tg==
X-CSE-MsgGUID: Yh2kn+EoTQuBYPbeCWUIhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33657986"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="33657986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 04:03:06 -0800
X-CSE-ConnectionGUID: +SO4zV7NS5iabAG/bMes0g==
X-CSE-MsgGUID: XQHscIbFSFWVGEZxgXapfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="99595573"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 07 Dec 2024 04:03:06 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain
Date: Sat,  7 Dec 2024 04:03:04 -0800
Message-Id: <20241207120304.5710-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qi_batch is allocated when assigning cache tag for a domain. While
for nested parent domain, it is missed. Hence, when trying to map pages
to the nested parent, NULL dereference occurred.

To solve it, allocate qi_batch for the nested parent domain when assigning
cache tag for the nested domain is enough. However, it seems not quite
reliable to allocate qi_batch in cache tag as a domain may be used by
multiple devices, and there is no lock around the domain->qi_batch check.
As all the domains (except blocking domain and identity domain) are supposed
to have qi_batch, this fix just allocates the qi_batch in the domain
allocation.

[  176.749284] BUG: kernel NULL pointer dereference, address: 0000000000000200
[  176.758178] #PF: supervisor read access in kernel mode
[  176.765052] #PF: error_code(0x0000) - not-present page
[  176.771985] PGD 8104795067 P4D 0
[  176.776900] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  176.783640] CPU: 223 UID: 0 PID: 4357 Comm: qemu-system-x86 Not tainted 6.13.0-rc1-00028-g4b50c3c3b998-dirty #2632
[  176.797868] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.SYS.0107.D52.2311070228 11/07/2023
[  176.812762] RIP: 0010:cache_tag_flush_range_np+0x13c/0x260
[  176.820656] Code: 8b 6e 18 41 f6 45 18 80 0f 85 66 ff ff ff 4c 89 ef e8 e8 98 ff ff 4d 8b 36 49 39 ee 75 a3 4d 85 ed 48 8b ab 28 01 00 00 74 0e <8b> 95 00 02 00 00 85 d2 0f 85 88 00 00 00 48 8b 74 24 08 4c 89 ff
[  176.847296] RSP: 0018:ff2e80d8b4887aa0 EFLAGS: 00010086
[  176.855207] RAX: 0000000000000000 RBX: ff18cd64bca69000 RCX: 0000000000000001
[  176.865337] RDX: 0000000000000000 RSI: ffffffff98206127 RDI: ff18cd6440139c00
[  176.875453] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[  176.885622] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  176.895802] R13: ff18cd6440139c00 R14: ff18cd64bca69118 R15: ff18cd64bca690d0
[  176.906056] FS:  00007f070a7fc640(0000) GS:ff18cde22fa00000(0000) knlGS:0000000000000000
[  176.917459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  176.926274] CR2: 0000000000000200 CR3: 00000080996ee003 CR4: 0000000000f73ef0
[  176.936703] PKRU: 55555554
[  176.942175] Call Trace:
[  176.947385]  <TASK>
[  176.952216]  ? __die+0x24/0x70
[  176.958114]  ? page_fault_oops+0x80/0x150
[  176.965133]  ? do_user_addr_fault+0x63/0x7b0
[  176.972462]  ? exc_page_fault+0x7c/0x220
[  176.979437]  ? asm_exc_page_fault+0x26/0x30
[  176.986755]  ? cache_tag_flush_range_np+0x13c/0x260
[  176.994903]  intel_iommu_iotlb_sync_map+0x1a/0x30
[  177.002880]  iommu_map+0x61/0xf0
[  177.009198]  batch_to_domain+0x188/0x250
[  177.016344]  iopt_area_fill_domains+0x125/0x320
[  177.024220]  ? rcu_is_watching+0x11/0x50
[  177.031442]  iopt_map_pages+0x63/0x100
[  177.038420]  iopt_map_common.isra.0+0xa7/0x190
[  177.046131]  iopt_map_user_pages+0x6a/0x80
[  177.053435]  iommufd_ioas_map+0xcd/0x1d0
[  177.060537]  iommufd_fops_ioctl+0x118/0x1c0
[  177.067918]  __x64_sys_ioctl+0x93/0xc0
[  177.074736]  do_syscall_64+0x71/0x140
[  177.081376]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  177.089489] RIP: 0033:0x7f071491a94f
[  177.095876] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  177.124032] RSP: 002b:00007f070a7f76d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  177.134964] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f071491a94f
[  177.145390] RDX: 00007f070a7f7760 RSI: 0000000000003b85 RDI: 0000000000000015
[  177.155834] RBP: 0000000000000015 R08: 00007f0603e00000 R09: 0000000000000000
[  177.166247] R10: 000056326cd25970 R11: 0000000000000246 R12: 00000000000a0000
[  177.177421] R13: 0000000000000004 R14: 0000000000000000 R15: 00000000000a0000
[  177.187869]  </TASK>
[  177.192700] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1 vfio intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi ofpart snd_hda_codec pmt_telemetry kvm_intel binfmt_misc pmt_class intel_sdsi snd_hda_core spi_nor isst_if_mbox_pci isst_if_mmio kvm dax_hmem mei_me joydev mtd isst_if_common snd_pcm intel_vsec idxd mei snd_timer cxl_acpi cxl_port cxl_core einj acpi_power_meter dm_multipath fuse ip_tables crc32c_intel i2c_i801 spi_intel_pci i2c_smbus i2c_ismt spi_intel drm_shmem_helper igc pinctrl_emmitsburg pinctrl_intel pwm_lpss

Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/cache.c  | 7 -------
 drivers/iommu/intel/iommu.c  | 7 +++++++
 drivers/iommu/intel/nested.c | 6 ++++++
 drivers/iommu/intel/svm.c    | 7 +++++++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e5b89f728ad3..66283e065ae2 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -190,13 +190,6 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 	u16 did = domain_get_id_for_dev(domain, dev);
 	int ret;
 
-	/* domain->qi_bach will be freed in iommu_free_domain() path. */
-	if (!domain->qi_batch) {
-		domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_KERNEL);
-		if (!domain->qi_batch)
-			return -ENOMEM;
-	}
-
 	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
 	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c8f9c70a04ab..238936c3eb55 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3277,6 +3277,12 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->qi_batch = kzalloc(sizeof(struct qi_batch), GFP_KERNEL);
+	if (!domain->qi_batch) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
@@ -3319,6 +3325,7 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	/* always allocate the top pgd */
 	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_KERNEL);
 	if (!domain->pgd) {
+		kfree(domain->qi_batch);
 		kfree(domain);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index aba92c00b427..90ea7ebc9708 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -217,6 +217,12 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->qi_batch = kzalloc(sizeof(struct qi_batch), GFP_KERNEL);
+	if (!domain->qi_batch) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	domain->use_first_level = true;
 	domain->s2_domain = s2_domain;
 	domain->s1_cfg = vtd;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f5569347591f..e036fa83a0da 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -165,6 +165,12 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->qi_batch = kzalloc(sizeof(struct qi_batch), GFP_KERNEL);
+	if (!domain->qi_batch) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	domain->domain.ops = &intel_svm_domain_ops;
 	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->dev_pasids);
@@ -175,6 +181,7 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	domain->notifier.ops = &intel_mmuops;
 	ret = mmu_notifier_register(&domain->notifier, mm);
 	if (ret) {
+		kfree(domain->qi_batch);
 		kfree(domain);
 		return ERR_PTR(ret);
 	}
-- 
2.34.1

