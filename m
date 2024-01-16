Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9F210F8
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJDrr41b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367572; x=1736903572;
  h=from:to:cc:subject:date:message-id;
  bh=6G6DWi+fWxdzJGxa8imBUVBT7V5kya5gX30l1HNS6xI=;
  b=NJDrr41bes/yuK7UE88XRKfC1J2tCS4OrML/tOLlBRdtTdx+AxoFpnLb
   SD85sWIJsGtfDxdNEpnxhnA2palFzwJVDWGpjfZEYCO+6YUFeYOjjr8y4
   EcpXvJI8lRRcwlqt9S7+dux/ElJa6KG+zSVgkn9eENDU+ZQ3lRYDKsxHI
   TYZQ/tGzPCrYCNB0Yn9fQbqHnAuYXAjiZsWuGK1kGzwwpikmbjB35ZPSD
   1zRZC27BXr9PB7tGsTPoe0w4wCJm0pyl4QFp4p7rykpwMVUa7lQgrbfOj
   Lve7G/SDaHhMmSCfRCfB4J7Lr5vCqnbPn3edUWY9Y0KAMMQN+JDVJHO7K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004374"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427227"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427227"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:50 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 00/11] iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations
Date: Tue, 16 Jan 2024 09:11:35 +0800
Message-Id: <20240116011146.18645-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This series based on "Share sva" patch-set[1], aims to remove superfluous
IOMMU IOTLB invalidations in VT-d driver.

In the current VT-d driver, IOMMU IOTLB invalidation commands and
device-TLB commands are performed per device, which leads to superfluous
IOTLB invalidations. For example, if there are four devices behind a IOMMU
are attached to one sva domain (which could be a common case in
virtualization scenarios where one virtual IOMMU working for all the
virtual devices), four IOTLB invalidation commands and four device-IOTLB
invalidation commands will be issued. However, only one IOTLB invalidation
command and four device-IOTLB invalidation commands are necessary.
Superfluous IOMMU IOTLB invalidations impact run-time performance.

The first 11 patches of this patch-set are for refactoring:
1) Retire struct intel_svm_set_dev_pasid and struct intel_svm_dev to
avoid duplicating code for sva domain.
2) Reuse intel_iommu_set/remove_dev_pasid functions for both sva domain
and dmar_domain.

The last patch removes the superfluous IOMMU IOTLB invalidations.

[1]: https://lore.kernel.org/linux-iommu/ZXgj49cY2PEAwHsB@8bytes.org/


Change log:
RFC: https://lore.kernel.org/linux-iommu/20231017032045.114868-1-tina.zhang@intel.com/

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Tina Zhang (10):
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
  iommu/vt-d: Retire intel_svm_remove_dev_pasid function
  iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations

 drivers/iommu/intel/iommu.c |  76 ++++++----
 drivers/iommu/intel/iommu.h |  31 ++--
 drivers/iommu/intel/svm.c   | 288 ++++++++----------------------------
 drivers/iommu/iommu-sva.c   |  16 +-
 include/linux/iommu.h       |   3 +
 5 files changed, 134 insertions(+), 280 deletions(-)

-- 
2.39.3

