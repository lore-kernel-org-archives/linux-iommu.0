Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBC25DCFA
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738435; cv=none; b=FtV0ojL+mYF06DEAUCf7Uub0VMpCV87T5LNc4Y1zJ379yBabbuxCM4uAArpA1fr0ACCmRC/uRtCub4rs5aXFi2HUoZS1Qs96lsJU42Lj6GgVetqEehgmjk8pqA3MNADxYxxfEQCzAGhNA0nVbN4SPlmEAIzLzh37Q8pz7R077Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738435; c=relaxed/simple;
	bh=xo5tsQZbpooLWFUPwrT+vqXnPUyi54lZIUsBGdgQg4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be7/uod/N16bzuIicofW57Moy/pxKM5nvEz4IEEUNpWkVgIH7Ly/FPuRrp9O9eZTtq5ATSTsH6fCj7Uh1+r+zegyugWzmRA19cId08OIZm5I2JjyZZNuwVq9JgWkJPoOt5vRm8Oz8DVKMr7PtcIOfFo2du3Wfl5C59t0uI7HdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kk5l3bRe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk5l3bRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740738434; x=1772274434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xo5tsQZbpooLWFUPwrT+vqXnPUyi54lZIUsBGdgQg4o=;
  b=Kk5l3bReGIvHhmvV4ENmIaLe1jcos/vYA95SKlYpNVwQlsl/EqpU3ezH
   /H93kjDjodrltSdPQJNJDJTxj8mYxDpECZ29PWjlk3i9qjodT6Sx9/sJ5
   6I4G5rXagUsENzOVjc1TCHGSIzw+OI/Egu3TeoK5JQWTEBVAbs1gQ8CZk
   7pv66qhhAvAtCFN5GFOehzJm2rsZEsOB+7yBomkLxluutpwiwTiZb/KRL
   OWm93gIhCka6CzDpy0bq7xxXSLESj+TExPPLs+aY/4goYXsQ7kHuPs8g+
   8tqU4+Q3tiUGX6DhMpwxHOEZB3L2NiPwN7yViCYYIWqKkSFQfr7yoLruk
   w==;
X-CSE-ConnectionGUID: xm+x5/PkSvCT1jadV0Z6jA==
X-CSE-MsgGUID: CNeXPd/bRPSSMubfxlnl6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45313089"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45313089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:27:14 -0800
X-CSE-ConnectionGUID: pPE+RemPRYusGsftCxheIQ==
X-CSE-MsgGUID: n2fAcSaTRvm/LMuDtOsouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121909455"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 02:27:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Fix suspicious RCU usage
Date: Fri, 28 Feb 2025 18:27:26 +0800
Message-ID: <20250228102726.3429268-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
References: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
locally") moved the call to enable_drhd_fault_handling() to a code
path that does not hold any lock while traversing the drhd list. Fix
it by ensuring the dmar_global_lock lock is held when traversing the
drhd list.

Without this fix, the following warning is triggered:
 =============================
 WARNING: suspicious RCU usage
 6.14.0-rc3 #55 Not tainted
 -----------------------------
 drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
               other info that might help us debug this:
               rcu_scheduler_active = 1, debug_locks = 1
 2 locks held by cpuhp/1/23:
 #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
 #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
 stack backtrace:
 CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
 Call Trace:
  <TASK>
  dump_stack_lvl+0xb7/0xd0
  lockdep_rcu_suspicious+0x159/0x1f0
  ? __pfx_enable_drhd_fault_handling+0x10/0x10
  enable_drhd_fault_handling+0x151/0x180
  cpuhp_invoke_callback+0x1df/0x990
  cpuhp_thread_fun+0x1ea/0x2c0
  smpboot_thread_fn+0x1f5/0x2e0
  ? __pfx_smpboot_thread_fn+0x10/0x10
  kthread+0x12a/0x2d0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x4a/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Holding the lock in enable_drhd_fault_handling() triggers a lockdep splat
about a possible deadlock between dmar_global_lock and cpu_hotplug_lock.
This is avoided by not holding dmar_global_lock when calling
iommu_device_register(), which initiates the device probe process.

Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
Reported-and-tested-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
Tested-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250218022422.2315082-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c  | 1 +
 drivers/iommu/intel/iommu.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9f424acf474e..e540092d664d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2043,6 +2043,7 @@ int enable_drhd_fault_handling(unsigned int cpu)
 	/*
 	 * Enable fault control interrupt.
 	 */
+	guard(rwsem_read)(&dmar_global_lock);
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
 		int ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d8d4593c9c8..bf1f0c814348 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3146,7 +3146,14 @@ int __init intel_iommu_init(void)
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
+		/*
+		 * The iommu device probe is protected by the iommu_probe_device_lock.
+		 * Release the dmar_global_lock before entering the device probe path
+		 * to avoid unnecessary lock order splat.
+		 */
+		up_read(&dmar_global_lock);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
 	}
-- 
2.43.0

