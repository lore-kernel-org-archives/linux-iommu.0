Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFC1854
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584821; x=1689120821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YFPp8eQRfKyYxbsjHpcOv+2EbgCO4an3Fpmg9Fo1F8g=;
  b=X5tzR5hm8+p2lLIM3QRXYyue1JsvMp3n8fEnzscyzjp+XmDWmq8dkV2D
   R+E2P6RSkjOPfgHx+tzb5QBEV/80k6h3J1INfKVbSnq7162sqW8KZymOZ
   gENs23K4/Up2fJGDYRnl3l3cr2hwe3qhdi3JJlJUGMCUe66PrkEvzkG3e
   WKIm0pa4ZA5P7Op7nBK/q1ZkC4+RSfXYBWin2fK0dE0vJlBO1S4jKMBha
   xsjCdtbqRrgged1Ozjn54fViIsIFDmLcduWDnRvg5kN7zppih+EihFe7F
   Xwt8zzt3ceGpXkAKWb/vAtuOCpR3z2A2Z2OAYe/44oPz55NQVeeIQXwKu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589860"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445678"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] [PULL REQUEST] Intel IOMMU updates for Linux v5.20
Date: Tue, 12 Jul 2022 08:08:43 +0800
Message-Id: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v5.20. It includes:

 - Make intel-iommu.h private
 - Optimize the use of two locks
 - Extend the driver to support large-scale platforms
 - Cleanup some dead code

The whole series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v5.20

Please consider them for v5.20.

[The vt-d branch needs to include below fix patch:
 4140d77a02210 ("iommu/vt-d: Fix RID2PASID setup/teardown failure")
 before applying the patches.]

Best regards,
Baolu

Lu Baolu (25):
  iommu/vt-d: Move trace/events/intel_iommu.h under iommu
  agp/intel: Use per device iommu check
  iommu/vt-d: Remove unnecessary exported symbol
  drm/i915: Remove unnecessary include
  KVM: x86: Remove unnecessary include
  x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
  iommu/vt-d: Move include/linux/intel-iommu.h under iommu
  iommu/vt-d: Remove unused iovad from dmar_domain
  iommu/vt-d: debugfs: Remove device_domain_lock usage
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unnecessary spinlock for root table alloc and free
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert global spinlock into per domain lock
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Remove unnecessary check in intel_iommu_add()
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h                          |   6 +-
 include/linux/tboot.h                         |   2 -
 .../iommu/intel/iommu.h                       |  35 +-
 drivers/iommu/intel/pasid.h                   |   1 +
 .../iommu/intel/trace.h                       |   7 +-
 arch/x86/kernel/tboot.c                       |  15 -
 arch/x86/kvm/x86.c                            |   1 -
 drivers/char/agp/intel-gtt.c                  |  17 +-
 drivers/gpu/drm/i915/display/intel_display.c  |   1 -
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |   1 -
 drivers/iommu/intel/cap_audit.c               |   2 +-
 drivers/iommu/intel/debugfs.c                 |  51 +-
 drivers/iommu/intel/dmar.c                    |  39 +-
 drivers/iommu/intel/iommu.c                   | 446 ++++++------------
 drivers/iommu/intel/irq_remapping.c           |   2 +-
 drivers/iommu/intel/pasid.c                   | 107 +++--
 drivers/iommu/intel/perf.c                    |   2 +-
 drivers/iommu/intel/svm.c                     |  11 +-
 drivers/iommu/intel/trace.c                   |   2 +-
 MAINTAINERS                                   |   1 -
 20 files changed, 297 insertions(+), 452 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (97%)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (93%)

-- 
2.25.1

