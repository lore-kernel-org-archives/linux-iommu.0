Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE9EEA3
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnPhTCwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007100; x=1728543100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bBI2FZKsPnLrhMOSzCEEd0XdZov87F+NftJakDXO9Z4=;
  b=dnPhTCwf3Bs+qqkvy9mOCWrGFMlJNKEZuU9TxmK+jIxiv3ug5WiX4kzG
   X2WQnLx7pjxDRAuiyPfnYY1edtoT2SFpXj0s1kPV0UFH7STuA5t4mIvwm
   NtQVC1U1D7vEKseTbD8NzNz/1e+5SfhcmQb8xNAz3pjrLMptH4bkg6WuM
   wWBjHTnZHmS+0MVdXmLtB8bOHkcHnAFx/NC+fdqFAw4hMx+OcMLAfgIdq
   RDKy2Hco9QIalRoxTv2j0XceiGapSYoIpiEgzCDrIlYdRq7RpdPMoVBlN
   9NO3bpKtVye2U/O9w6DQsBCtcFwjiKur6AsF4DUF4CKb9sJYWQmHRgdBb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387436949"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387436949"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824050224"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824050224"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 23:51:36 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v6 PATCH 0/5] Share sva domains with all devices bound to a mm
Date: Wed, 11 Oct 2023 14:51:27 +0800
Message-Id: <20231011065132.102676-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to share sva(shared virtual addressing) domains with all
devices bound to one mm.

Problem
-------
In the current iommu core code, sva domain is allocated per IOMMU group,
when device driver is binding a process address space to a device (which is
handled in iommu_sva_bind_device()). If one than more device is bound to
the same process address space, there must be more than one sva domain
instance, with each device having one. In other words, the sva domain
doesn't share between those devices bound to the same process address
space, and that leads to two problems:
1) device driver has to duplicate sva domains with enqcmd, as those sva
domains have the same PASID and are relevant to one virtual address space.
This makes the sva domain handling complex in device drivers.
2) IOMMU driver cannot get sufficient info of the IOMMUs that have
devices behind them bound to the same virtual address space, when handling
mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
performed per device instead of per IOMMU, and that may lead to
superfluous IOTLB invalidation issue, especially in a virtualization
environment where all devices may be behind one virtual IOMMU.

Solution
--------
This patch-set tries to fix those two problems by allowing sharing sva
domains with all devices bound to a mm. To achieve this, a new structure
pointer is introduced to mm to replace the old PASID field, which can keep
the info of PASID as well as the corresponding shared sva domains.
Besides, function iommu_sva_bind_device() is updated to ensure a new sva
domain can only be allocated when the old ones cannot work for the IOMMU.
With these changes, a device driver can expect one sva domain could work
for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
their devices bound to one virtual address space) when handling
mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.

Arguably there shouldn't be more than one sva_domain with the same PASID,
and in any sane configuration there should be only 1 type of IOMMU driver
that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
may not be identical to each other. Thus, attaching a sva domain that has
been successfully bound to device A behind a IOMMU A, to device B behind
IOMMU B may get failed due to the difference between IOMMU A and IOMMU
B. In this case, a new sva domain with the same PASID needs to be
allocated to work with IOMMU B. That's why we need a list to keep sva
domains of one PASID. For the platform where IOMMUs are compatible to each
other, there should be one sva domain in the list.

v6:
 - Rename iommu_sva_alloc_pasid() to iommu_alloc_mm_data().
 - Hold the iommu_sva_lock before invoking iommu_alloc_mm_data().
 - Remove "iommu: Introduce mm_get_pasid() helper function" patch, because
   SMMUv3 decides to use mm_get_enqcmd_pasid() instead and other users are
   using iommu_sva_get_pasid() to get the pasid value. Besides, the iommu
   core accesses iommu_mm_data in the critical section protected by
   iommu_sva_lock. So no need to add another helper to retrieve PASID
   atomically.

v5:
 - Order patch "iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()"
   first in this series.
 - Update commit message of patch "iommu: Introduce mm_get_pasid()
   helper function"
 - Use smp_store_release() & READ_ONCE() in storing and loading mm's
   pasid value.

v4:
 - Rebase to v6.6-rc1.

v3:
 - Add a comment describing domain->next.
 - Expand explanation of why PASID isn't released in
   iommu_sva_unbind_device().
 - Add a patch to remove mm->pasid in intel_sva_bind_mm()

v2:
 - Add mm_get_enqcmd_pasid().
 - Update commit message.

v1: https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
  iommu: Add mm_get_enqcmd_pasid() helper function
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 +--
 drivers/iommu/intel/svm.c                     | 14 +--
 drivers/iommu/iommu-sva.c                     | 94 +++++++++++--------
 include/linux/iommu.h                         | 27 +++++-
 include/linux/mm_types.h                      |  3 +-
 kernel/fork.c                                 |  1 -
 mm/init-mm.c                                  |  3 -
 8 files changed, 93 insertions(+), 63 deletions(-)

-- 
2.39.3

