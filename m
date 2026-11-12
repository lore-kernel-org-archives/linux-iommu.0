Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458649;
	b=tsB7Ed7TZkVUUoWk3B1wzimUL++wxtuaitMdZ1Sa3vNvhzzcxcPHhHXM0wmuDQZzhmOo
	 PxdlArvudk4m9VJh6/IRWDuyF48oIwBwnK7wCMJf0s8xsPEhDi/9FxvUj10xciVhvvmYC
	 xH94fALKkAtVGBOzuWkjqLzbW3AeHS8xbmHIlgYCMi3WOr6vwijmNs2u34RqXii82d1rr
	 hZPl8uS4s1OJbJhvvmQ+Hy4QE9apLafAdwxRVe/Je50khY4ZECCJav6t08nEro+Xk1Udu
	 nL0P5BkhIOvdJeF3MM/1P+cDvzILYNiO+Mhoa/MPnLOju4U3ZgXELyMBmcnUEeHl//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3VHUFRhVJ3Z7VHtcGgzszhalavoCxDK+NJk4v4/GkIQ=;
	b=mOz5JQfObT0C+iabgSXlFdx8Jb16tT37sh0wHWnAM13DB1mv39KjYqoe7weyNCJLVHc6
	 cVJFnkpQ+dNY3OMalUrTPRKHpIYlmJJqbIDJdZekR75gUyfXxaEDyd1lC7YWQ+o8X5CeU
	 F75vMPP+qNVcvxgCko3fVkK1a8LD79FDzz/0QewshDtkEa7WqhlhVu5py+KaTuEn4tSnf
	 x7J/mNRT1Cl4DtzDn8rhBsja3zoSOGPpXF9p5qntWLzlSXb9U41k6wjh/73vCZySJPAge
	 3vpMxhQCbkS9f9A231tCOHJWGBWtdCyeBZnhnYEST5FnagT3c0ZkqT50YQuKHVYS+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kc2Qs8bu;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B7606A899;
	Thu, 12 Nov 2026 04:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8B7606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kc2Qs8bu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458649; x=1825994649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nlZZYkhZyH/D3N1WM4kWMibPhzAVPt4BQyzuIb1zz84=;
  b=kc2Qs8buFQAAX3xEjOat2Ko7znk/xGUFDMwxDpszATj8nzzhz17q9PLN
   d+PaySv/hIQA6Hj1cM0+CIChR9KMSsTMfoML7+i/7gHQ41AhYJgU37dQ3
   yheQQo3FdgmnVUhb51k0vTCTQGyzEMSV6cWLhijP5SGsnPz6nJQpu1UtN
   rOjwve/Ep7gy272V8epoXwogZetBw8cfLyynaFW4rvbZqTKKmfShYBxRx
   3d/TYVSQonmKOVFbD5Z1dp3rhWNfdcep6GvFUwjtIZC17v506XNM7vHRK
   2DgRdX5oTaK47x149hCkTKW6m6r8mxLfXNYZLvgsBq3k/C7XOGM7HTZga
   Q==;
X-CSE-ConnectionGUID: OrljOD63SGmKJcOFHOeA/w==
X-CSE-MsgGUID: 32oIXm2xTXC4CP/R2zH0/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318362"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318362"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:08 -0800
X-CSE-ConnectionGUID: AappA12iTRSrhN56YRsJKw==
X-CSE-MsgGUID: orzJ1QXEQ1ySRNzn6nQpTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728658"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:44:05 -0800
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
Subject: [PATCH v3 6/9] iommu/vt-d: Refuse system suspend while acquired by the TDX module
Date: Thu, 12 Nov 2026 12:30:51 +0800
Message-ID: <20261112043054.2664857-7-baolu.lu@linux.intel.com>
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

While tdx-host has acquired an IOMMU, the VT-d driver blocks its GCMD
writes. TDX disables S3 by clearing acpi_suspend_lowlevel, but that is
only checked after the syscore suspend callbacks have run, so an S3
request, e.g. "echo mem > /sys/power/state", still runs iommu_suspend()
and then iommu_resume():

  suspend_enter()
    syscore_suspend()
      iommu_suspend()                  <- runs on the acquired IOMMU
    suspend_ops->enter() = acpi_suspend_enter()
      if (!acpi_suspend_lowlevel)      <- TDX's "S3 disabled" check
          return -ENOSYS
    syscore_resume()
      iommu_resume()                   <- runs on the acquired IOMMU

Register a PM notifier for each DMAR unit that supports trusted DMA and
refuse PM_SUSPEND_PREPARE with -EBUSY while the unit is acquired. The
suspend then fails before tasks are frozen and before syscore callbacks
run.

A check at PM_SUSPEND_PREPARE alone leaves a window: user space is only
frozen after the notifiers run, so a device connect may still acquire
the unit in between. Close it with a per-unit tdxc_suspending flag, set
when the notifier lets the suspend proceed and cleared at
PM_POST_SUSPEND. dmar_tdxc_acquire() fails with -EBUSY while it is set.
Both the notifier and dmar_tdxc_acquire() hold the unit's tdxc_lock, so
the check and the acquisition can't interleave.

The notifiers are registered at init only for units advertising
ECAP.TDXCS. Such units are never hot-added or hot-removed, so the set
doesn't change afterwards and the notifiers are never unregistered.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 include/linux/dmar.h        |  4 ++-
 drivers/iommu/intel/dmar.c  | 53 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 26135248675d..f7554df8cd2d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1363,6 +1363,7 @@ extern int rwbf_quirk;
 int iommu_calculate_agaw(struct intel_iommu *iommu);
 int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob);
+void dmar_tdxc_pm_init(void);
 
 static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 {
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index a39ca13f13dc..8b407bc6d179 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -47,7 +47,9 @@ struct dmar_drhd_unit {
 	u8	ignored:1; 		/* ignore drhd		*/
 	u8	include_all:1;
 	u8	gfx_dedicated:1;	/* graphic dedicated	*/
-	struct mutex tdxc_lock;		/* serializes acquire/release */
+	struct mutex tdxc_lock;		/* serializes acquire/release/suspend */
+	struct notifier_block tdxc_pm_nb;
+	bool	tdxc_suspending;	/* protected by tdxc_lock */
 	struct intel_iommu *iommu;
 };
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 91826705a06b..ad6b22601446 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
+#include <linux/suspend.h>
 #include <asm/irq_remapping.h>
 
 #include "iommu.h"
@@ -2683,6 +2684,9 @@ int dmar_tdxc_acquire(struct pci_dev *pdev,
 		return -EINVAL;
 
 	guard(mutex)(&drhd->tdxc_lock);
+	if (drhd->tdxc_suspending)
+		return -EBUSY;
+
 	/* Still set if TDH.IOMMU.CLEAR failed and tdx-host was reloaded. */
 	if (iommu->tdxc_acquired)
 		return -EBUSY;
@@ -2737,3 +2741,52 @@ void dmar_tdxc_release(struct pci_dev *pdev,
 	dmar_tdxc_unreserve_did(drhd->iommu);
 }
 EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_release, "tdx-host");
+
+/*
+ * TDX only fails S3 after syscore suspend/resume have run, and those
+ * would hit the blocked GCMD paths. Refuse the suspend up front instead.
+ */
+static int dmar_tdxc_pm_notify(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct dmar_drhd_unit *drhd =
+		container_of(nb, struct dmar_drhd_unit, tdxc_pm_nb);
+
+	guard(mutex)(&drhd->tdxc_lock);
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+		if (drhd->iommu->tdxc_acquired)
+			return notifier_from_errno(-EBUSY);
+		drhd->tdxc_suspending = true;
+		break;
+	case PM_POST_SUSPEND:
+		drhd->tdxc_suspending = false;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+void __init dmar_tdxc_pm_init(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	down_read(&dmar_global_lock);
+	for_each_active_iommu(iommu, drhd) {
+		if (!ecap_tdxcs(iommu->ecap))
+			continue;
+
+		drhd->tdxc_pm_nb.notifier_call = dmar_tdxc_pm_notify;
+		/*
+		 * CPU hotplug takes dmar_global_lock under the PM notifier chain
+		 * lock. Drop it to avoid a lock order splat; TDXCS units are never
+		 * hot-removed, so @drhd stays valid.
+		 */
+		up_read(&dmar_global_lock);
+		register_pm_notifier(&drhd->tdxc_pm_nb);
+		down_read(&dmar_global_lock);
+	}
+	up_read(&dmar_global_lock);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 69e8c2c8680a..d8b9610ae791 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2041,6 +2041,7 @@ static struct syscore iommu_syscore = {
 static void __init init_iommu_pm_ops(void)
 {
 	register_syscore(&iommu_syscore);
+	dmar_tdxc_pm_init();
 }
 
 #else
-- 
2.43.0

