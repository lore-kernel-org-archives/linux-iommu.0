Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAC7C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 02:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728412; x=1695264412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChgtKr8A4BKyl6+/zhVECzXxjkkkRIJ4TBTK2/cPFcI=;
  b=OWbfmNfFeA6ihA6SpTh+ttGazuq34Iukr0X/MCXOdPDojfQ+jdDazkc8
   oqyzPgFpkjhhN2F77hTDspsYRGZiiu1sUzn1IUhikt25Oi/hrjneFxJHD
   fEOWFVQ9CdIWkqwB3iEPkHqriWZPRmGKqnBTNCiCrIqsf/vgE+t9c82dq
   8o8LxCNabxGdzmlqhsj9RZtW69QepRomJRtHFlD7rGhEtNn1ra58de/U7
   5iq4uQxu84P2pkFJnVkwYFjD6wTDwqhNfcs7z4WpotGk9GlvJblvxlMDQ
   wjeDD6Rowx55BDT91zSEa6lvCIaB4W1C8rEEhs4ZVMUBg7FvmAgGw95gN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301277919"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="301277919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="681573935"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2022 19:46:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	George Hilliard <thirtythreeforty@gmail.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] Revert "iommu/vt-d: Fix possible recursive locking in intel_iommu_init()"
Date: Wed, 21 Sep 2022 10:40:53 +0800
Message-Id: <20220921024054.3570256-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
References: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 9cd4f1434479f1ac25c440c421fbf52069079914.

Some issues were reported on the original commit. Some thunderbolt devices
don't work anymore due to the following DMA fault.

DMAR: DRHD: handling fault status reg 2
DMAR: [INTR-REMAP] Request device [09:00.0] fault index 0x8080
      [fault reason 0x25]
      Blocked a compatibility format interrupt request

Bring it back for now to avoid functional regression.

Fixes: 9cd4f1434479f ("iommu/vt-d: Fix possible recursive locking in intel_iommu_init()")
Link: https://lore.kernel.org/linux-iommu/485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216497
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: <stable@vger.kernel.org> # 5.19.x
Reported-and-tested-by: George Hilliard <thirtythreeforty@gmail.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220920081701.3453504-1-baolu.lu@linux.intel.com
---
 include/linux/dmar.h        |  4 +---
 drivers/iommu/intel/dmar.c  |  7 -------
 drivers/iommu/intel/iommu.c | 27 +++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 8917a32173c4..d81a51978d01 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -65,7 +65,6 @@ struct dmar_pci_notify_info {
 
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
-extern int intel_iommu_enabled;
 
 #define for_each_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
@@ -89,8 +88,7 @@ extern int intel_iommu_enabled;
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
-	       system_state == SYSTEM_BOOTING ||
-	       (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled);
+	       system_state == SYSTEM_BOOTING;
 }
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 497c912ad9e1..5a8f780e7ffd 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2349,13 +2349,6 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
 	if (!dmar_in_use())
 		return 0;
 
-	/*
-	 * It's unlikely that any I/O board is hot added before the IOMMU
-	 * subsystem is initialized.
-	 */
-	if (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled)
-		return -EOPNOTSUPP;
-
 	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
 		tmp = handle;
 	} else {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1f2cd43cf9bc..64d30895a4c8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3019,7 +3019,13 @@ static int __init init_dmars(void)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+			/*
+			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
+			 * could cause possible lock race condition.
+			 */
+			up_write(&dmar_global_lock);
 			ret = intel_svm_enable_prq(iommu);
+			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
@@ -3932,6 +3938,7 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
+	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
@@ -3944,6 +3951,16 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+	up_write(&dmar_global_lock);
+
+	/*
+	 * The bus notifier takes the dmar_global_lock, so lockdep will
+	 * complain later when we register it under the lock.
+	 */
+	dmar_register_bus_notifier();
+
+	down_write(&dmar_global_lock);
+
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
@@ -3988,9 +4005,11 @@ int __init intel_iommu_init(void)
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
 	}
+	up_write(&dmar_global_lock);
 
 	init_iommu_pm_ops();
 
+	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		/*
 		 * The flush queue implementation does not perform
@@ -4008,11 +4027,13 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 	}
+	up_read(&dmar_global_lock);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
+	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
@@ -4023,15 +4044,17 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
+	up_read(&dmar_global_lock);
 
-	intel_iommu_enabled = 1;
-	dmar_register_bus_notifier();
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
+	intel_iommu_enabled = 1;
+
 	return 0;
 
 out_free_dmar:
 	intel_iommu_free_dmars();
+	up_write(&dmar_global_lock);
 	return ret;
 }
 
-- 
2.34.1

