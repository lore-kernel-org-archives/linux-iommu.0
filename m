Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEF7477
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 05:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690437050; x=1721973050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6tVc4JDa/y31/t4vmR1KpWvG+69Czf6nIN4vbMNzhr0=;
  b=GSzGCk3MPuVPb3o03Zy6OhVn+PuYt13bmRcWHFnzfWrchUIVUPlRqePW
   jAY9zWY8u5gY75MIOESHFHZduqc4pcKQHZpwLsMAcDqjEaV4v1xWqPN7I
   vS3kwKDqqov/Xy8aYrdpvcdOHYKOr4D9aXpqR6Pd5nNtrycen6aeLAfFE
   GX6cpJRhulPVr7qYrrIHEQL3sRcHLbQuacnUBieedpM1zmA5RcdoJMR9A
   StrW2iWuBn595BO3qmuLNDeiVSn3c7TtWjAeXbg3r+bnswZjdPQAUF+/L
   tkObTRvwtD0o7Spacf+Ye6kuUWhOFhGQVVT+JcVUJAf4LEmhGcSabax2r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152455"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152455"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840585249"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840585249"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:50:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/12] iommu: Prepare to deliver page faults to user space
Date: Thu, 27 Jul 2023 13:48:25 +0800
Message-Id: <20230727054837.147050-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user-managed page table is attached to an IOMMU, it is necessary
to deliver IO page faults to user space so that they can be handled
appropriately. One use case for this is nested translation, which is
currently being discussed in the mailing list.

I have posted a RFC series [1] that describes the implementation of
delivering page faults to user space through IOMMUFD. This series has
received several comments on the IOMMU refactoring, which I have
addressed in this series.

The major refactoring includes:

- [PATCH 01 ~ 03] Move include/uapi/linux/iommu.h to
  include/linux/iommu.h. Remove the unrecoverable fault data definition.
- [PATCH 04 ~ 07] Remove iommu_[un]register_device_fault_handler().
- [PATCH 08 ~ 12] Separate SVA and IOPF. Make IOPF a generic page fault
  handling framework. 

This is also available at github [2]. I would appreciate your feedback
on this series.

[1] https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/preparatory-io-pgfault-delivery-v2

Change log:
v2:
 - Remove unrecoverable fault data definition as suggested by Kevin.
 - Drop the per-device fault cookie code considering that doesn't make
   much sense for SVA.
 - Make the IOMMU page fault handling framework generic. So that it can
   avaible for use cases other than SVA.

v1: https://lore.kernel.org/linux-iommu/20230711010642.19707-1-baolu.lu@linux.intel.com/

Lu Baolu (12):
  iommu: Move iommu fault data to linux/iommu.h
  iommu/arm-smmu-v3: Remove unrecoverable faults reporting
  iommu: Remove unrecoverable fault data
  iommu: Replace device fault handler with iommu_queue_iopf()
  iommu: Change the return value of dev_iommu_get()
  iommu: Make dev->fault_param static
  iommu: Remove iommu_[un]register_device_fault_handler()
  iommu: Prepare for separating SVA and IOPF
  iommu: Move iopf_handler() to iommu-sva.c
  iommu: Make iommu_queue_iopf() more generic
  iommu: Separate SVA and IOPF in Makefile and Kconfig
  iommu: Add helper to set iopf handler for domain

 include/linux/iommu.h                         | 196 +++++++++++++++---
 drivers/iommu/iommu-sva.h                     |  71 -------
 include/uapi/linux/iommu.h                    | 161 --------------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  14 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  47 ++---
 drivers/iommu/intel/iommu.c                   |  19 +-
 drivers/iommu/intel/svm.c                     |   1 -
 drivers/iommu/io-pgfault.c                    |  90 +++-----
 drivers/iommu/iommu-sva.c                     |  47 ++++-
 drivers/iommu/iommu.c                         | 153 ++++----------
 MAINTAINERS                                   |   1 -
 drivers/iommu/Kconfig                         |   4 +
 drivers/iommu/Makefile                        |   3 +-
 drivers/iommu/intel/Kconfig                   |   1 +
 14 files changed, 314 insertions(+), 494 deletions(-)
 delete mode 100644 drivers/iommu/iommu-sva.h
 delete mode 100644 include/uapi/linux/iommu.h

-- 
2.34.1

