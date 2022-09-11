Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933417F
	for <iommu@lists.linux.dev>; Sun, 11 Sep 2022 03:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662866671; x=1694402671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v7v+F7tK2tcFH2L9abUD/QqnIXEyCAC87pcBr7y+hYI=;
  b=LlYZGBcUmDKSMUkB1FEQi84rRLG9kMvld2y/bQjc5SI/2QIc1TZvXeOL
   QTOlIB8DC7jz1skNDz2WmkoNRyORvJ7n+6fc63Ifl8Tv9fjzjZDNFExDY
   ErPB3k+XEQNUWIBYY/09thmgDitRP4o3j9ac0M6FN0qvnBxaRAR17+nCa
   Xw7AJIWzx5w2NAOgj0VHehUJwCGiPillEAJIwtiv6IssSOB0KkePeiIRc
   DZY63Wski3HfRrAJSV8DHVdpfULxe3bHX1T3W48VjfuHdeWaDg1KFUVNz
   Uz1pdHywprka7JgmgGDONvNPmEnGSZmrq43BO0sJvc4Z0ZZjT9JVd0sap
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="299027397"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="299027397"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 20:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="611431556"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2022 20:24:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in intel_iommu_init()
Date: Sun, 11 Sep 2022 11:18:45 +0800
Message-Id: <20220911031845.893192-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911031845.893192-1-baolu.lu@linux.intel.com>
References: <20220911031845.893192-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
is used to protect DMAR related global data from DMAR hotplug operations.

The dmar_global_lock used in the intel_iommu_init() might cause recursive
locking issue, for example, intel_iommu_get_resv_regions() is taking the
dmar_global_lock from within a section where intel_iommu_init() already
holds it via probe_acpi_namespace_devices().

Using dmar_global_lock in intel_iommu_init() could be relaxed since it is
unlikely that any IO board must be hot added before the IOMMU subsystem is
initialized. This eliminates the possible recursive locking issue by moving
down DMAR hotplug support after the IOMMU is initialized and removing the
uses of dmar_global_lock in intel_iommu_init().

Fixes: d5692d4af08cd ("iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com
Link: https://lore.kernel.org/r/20220718235325.3952426-1-baolu.lu@linux.intel.com
---
 include/linux/dmar.h        |  4 +++-
 drivers/iommu/intel/dmar.c  |  7 +++++++
 drivers/iommu/intel/iommu.c | 27 ++-------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index d81a51978d01..8917a32173c4 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -65,6 +65,7 @@ struct dmar_pci_notify_info {
 
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
+extern int intel_iommu_enabled;
 
 #define for_each_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
@@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
-	       system_state == SYSTEM_BOOTING;
+	       system_state == SYSTEM_BOOTING ||
+	       (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled);
 }
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 5a8f780e7ffd..497c912ad9e1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2349,6 +2349,13 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
 	if (!dmar_in_use())
 		return 0;
 
+	/*
+	 * It's unlikely that any I/O board is hot added before the IOMMU
+	 * subsystem is initialized.
+	 */
+	if (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled)
+		return -EOPNOTSUPP;
+
 	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
 		tmp = handle;
 	} else {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..59064cf92e7b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3013,13 +3013,7 @@ static int __init init_dmars(void)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
-			/*
-			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
-			 * could cause possible lock race condition.
-			 */
-			up_write(&dmar_global_lock);
 			ret = intel_svm_enable_prq(iommu);
-			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
@@ -3932,7 +3926,6 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
-	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
@@ -3945,16 +3938,6 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
-	up_write(&dmar_global_lock);
-
-	/*
-	 * The bus notifier takes the dmar_global_lock, so lockdep will
-	 * complain later when we register it under the lock.
-	 */
-	dmar_register_bus_notifier();
-
-	down_write(&dmar_global_lock);
-
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
@@ -3999,11 +3982,9 @@ int __init intel_iommu_init(void)
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
 	}
-	up_write(&dmar_global_lock);
 
 	init_iommu_pm_ops();
 
-	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		/*
 		 * The flush queue implementation does not perform
@@ -4021,13 +4002,11 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 	}
-	up_read(&dmar_global_lock);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
-	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
@@ -4038,17 +4017,15 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
-	up_read(&dmar_global_lock);
-
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	intel_iommu_enabled = 1;
+	dmar_register_bus_notifier();
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	return 0;
 
 out_free_dmar:
 	intel_iommu_free_dmars();
-	up_write(&dmar_global_lock);
 	return ret;
 }
 
-- 
2.25.1

