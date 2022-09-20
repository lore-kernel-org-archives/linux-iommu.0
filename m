Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6810F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 08:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663662191; x=1695198191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0hn16l7nMEx48O7cldxyv7rJ1vx4l2VvipRjvsZXCdk=;
  b=FdQXgwYUrV0Hr/XxZ4y1MZllf2IHBnRcJ+1w20cncgFD7dYIeptt13bd
   c1WFymLpXcD6g7WcaYPYgMST3UAs54GvToCb+noy3vz34pxfCDzNS34pD
   R1hph0djw08o/m7q+dDwNYkrMgZx2E6u02i2a+OIzk+F6K9R0C2B2VA7x
   ycyDosPB5qYAbb6TcDSOTCdLK0lPcWGreEte5yOrLJsdAslV1bTNJ3b/N
   El+kQ325L4zQEZF+EYUBEhgHQk1vBIsOWe8hynJDEdsqPfjUg6tgoQWd3
   Ezs4UEmLgkZmJVPWOqaNfv4wEqw4XLd+g2HuYv3FbYKcw198s83+piQhs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297225247"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="297225247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="649492435"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 01:22:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	George Hilliard <thirtythreeforty@gmail.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] Revert "iommu/vt-d: Fix possible recursive locking in intel_iommu_init()"
Date: Tue, 20 Sep 2022 16:17:01 +0800
Message-Id: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
Reported-and-tested-by: George Hilliard <thirtythreeforty@gmail.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index 04f7991734a9..3528058d253e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2356,13 +2356,6 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
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
index c20f3e060bac..5bab71a05830 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3029,7 +3029,13 @@ static int __init init_dmars(void)
 
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
@@ -3941,6 +3947,7 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
+	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
@@ -3953,6 +3960,16 @@ int __init intel_iommu_init(void)
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
 
@@ -3997,9 +4014,11 @@ int __init intel_iommu_init(void)
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
 	}
+	up_write(&dmar_global_lock);
 
 	init_iommu_pm_ops();
 
+	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		/*
 		 * The flush queue implementation does not perform
@@ -4017,10 +4036,12 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 	}
+	up_read(&dmar_global_lock);
 
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
+	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
@@ -4031,15 +4052,17 @@ int __init intel_iommu_init(void)
 
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

