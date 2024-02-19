Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF76328B6
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347461; cv=none; b=hTjXyc+UBvWFlPyHSwU3WQc492KUawErBl3KpeEztDqgRZcYlMR5dwjE6Dg3CuAUzuIWqAOdXVSp0YsO6V97XhGAN7Fi9v57sKhnHGx6Ln3ex3z+FPgEM0I7ejRJ5sKUnX0XwMYDt5YLOlQeq1mAZBZpu82m57boVZajcDzx3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347461; c=relaxed/simple;
	bh=inswbJ2p5T3SoQZeKfBBoa1zBFeTU9nsJxnUk4i2gY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDfbS/8Jww0gSqN2rQDeCODICPOu/7eVUSBcY0MRh/6Mq1NjRJX+qDr7vvAGzqQxOfxdCB+bwnTn2tisSude95yC9//hsEirxHWk2/SETcZstardctzFwN+v9qUpQTnW7RlmtOeRs9BOYu9vJtudZS4pMzvb6l3s3V5sEqaHyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HR2VvD6/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HR2VvD6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347460; x=1739883460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=inswbJ2p5T3SoQZeKfBBoa1zBFeTU9nsJxnUk4i2gY4=;
  b=HR2VvD6/2FR+JQ/kLOl/bepPZCc97DQSpeNG81pFA4CjGG6+NWxSS3M6
   X2mtaliq78MkoSUTxdEdzR2p7iHCPBxtcvcvhtSlqhA8qJPutPIxPp7Gs
   Nwucpg0z3ay4ALQm6d3dEuTzkOyk5blWGYPIwrjoZi1sXlwchl5PMIkZD
   G3EzJKWN12FCDeUApVYk/DmNyTNl1wZ1++u2+oMZ6XegLlakNlBnrOen3
   /Cs/g3JA37Q9viSEEqKKfr2f83xgB6QoKNihPUjHmn+z4IIKzUPL92/Jl
   zQKpd++kBFMSc069YVVtfie263WhBRNstWlJmCUUPmj9EONyJ7gFd2w0D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296416"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296416"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449257"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:37 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 00/13] iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations
Date: Mon, 19 Feb 2024 20:57:10 +0800
Message-Id: <20240219125723.1645703-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current VT-d driver, IOMMU IOTLB invalidation commands and
device-TLB commands are performed per device, which leads to superfluous
IOTLB invalidations. For example, if there are four devices behind a IOMMU
are attached to one sva domain (which could be a common case in
virtualization scenarios where one virtual IOMMU working for all the
virtual devices), four IOTLB invalidation commands and four device-IOTLB
invalidation commands will be issued. However, only one IOTLB invalidation
command and four device-IOTLB invalidation commands are necessary.
Superfluous IOMMU IOTLB invalidations impact run-time performance.

The first 12 patches of this patch-set are for refactoring:
1) Retire struct intel_svm_set_dev_pasid and struct intel_svm_dev to
avoid duplicating code for sva domain.
2) Reuse intel_iommu_set/remove_dev_pasid functions for both sva domain
and dmar_domain.

The last patch removes the superfluous IOMMU IOTLB invalidations.

[1]: https://lore.kernel.org/linux-iommu/ZXgj49cY2PEAwHsB@8bytes.org/

v2:
 - Rebase on v6.8-rc4.
 - Sort dev_pasids list to make the devices behine the same IOMMU stay
   together.
 - Doesn't allocate iommu_domain_info for sva domain and add comments
   to tell the reason.
 - Make intel_iommu_set_dev_pasid() be compatible with sva domain.
v1: https://lore.kernel.org/linux-iommu/20240116011146.18645-1-tina.zhang@intel.com/
RFC: https://lore.kernel.org/linux-iommu/20231017032045.114868-1-tina.zhang@intel.com/

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Tina Zhang (12):
  iommu/vt-d: Retire the treatment for revoking PASIDs with pending
    pgfaults
  iommu/vt-d: Remove initialization for dynamically heap-allocated
    rcu_head
  iommu/vt-d: Refactor intel_svm_set_dev_pasid function
  iommu/vt-d: Retire struct intel_svm_dev
  iommu/vt-d: Retire struct intel_svm
  iommu/vt-d: Use RCU for dev_pasids list updates in
    set/remove_dev_pasid()
  iommu/vt-d: Add domain_type_is_sva helper function
  iommu/vt-d: Reuse intel_iommu_set_dev_pasid function
  iommu/vt-d: Use dev_pasid->sid field
  iommu/vt-d: Retire intel_svm_remove_dev_pasid function
  iommu/vt-d: Sort dev_pasids list
  iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations

 drivers/iommu/intel/iommu.c |  75 ++++++---
 drivers/iommu/intel/iommu.h |  31 ++--
 drivers/iommu/intel/svm.c   | 300 +++++++++---------------------------
 drivers/iommu/iommu-sva.c   |   4 +-
 drivers/iommu/iommu.c       |  12 +-
 include/linux/iommu.h       |   3 +
 6 files changed, 151 insertions(+), 274 deletions(-)

-- 
2.34.1

