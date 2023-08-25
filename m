Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264865C
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 02:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692930798; x=1724466798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CuGojWCN1Q3oMFDKhD2YkAF8gHfytrzxJhYuhDOxwBI=;
  b=W7YjZx7L9XgjoNFrphNaImvHhWtCK1OtHqT1Dty1KIHcgkBrKy++9N2M
   EgHpX3ncMZBDYl/zc40l7/0Cb98b/i2EcF6V5OiDIbQxVVMD9ZRSB0qgn
   f5jSxQoUypznsam0D832eHd47J5m68L36ASPpIvc0FJbiKMocw8nQ9zNR
   LPFMElmHNZGmh7lnxESmpv/dmqQ6kvJ3P7fpONpmF6F4T+KxCKNX6N99w
   iC+V3SvZYcdDYf8D1QgACXBGTG3qhJxrhrGF1psRmCIQFANeRgX90FOFu
   97r0s4ri6zGBTYEGJjhPRMXscnxLwYXpGRH+stZ56hGDEW9ZRBoAvO05L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372009377"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372009377"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 19:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730874987"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730874987"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 19:33:12 -0700
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
Subject: [PATCH v4 00/10] iommu: Prepare to deliver page faults to user space
Date: Fri, 25 Aug 2023 10:30:16 +0800
Message-Id: <20230825023026.132919-1-baolu.lu@linux.intel.com>
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
received several comments on the IOMMU refactoring, which I am trying to
address in this series.

The major refactoring includes:

- [PATCH 01 ~ 04] Move include/uapi/linux/iommu.h to
  include/linux/iommu.h. Remove the unrecoverable fault data definition.
- [PATCH 05 ~ 06] Remove iommu_[un]register_device_fault_handler().
- [PATCH 07 ~ 10] Separate SVA and IOPF. Make IOPF a generic page fault
  handling framework. 

This is also available at github [2]. I would appreciate your feedback
on this series.

[1] https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/preparatory-io-pgfault-delivery-v4

Change log:
v4:
 - Merge iommu_fault_event and iopf_fault. They are duplicate.
 - Move iommu_report_device_fault() and iommu_page_response() to
   io-pgfault.c.
 - Move iommu_sva_domain_alloc() to iommu-sva.c.
 - Add group->domain and use it directly in sva fault handler.
 - Misc code refactoring and refining.

v3: https://lore.kernel.org/linux-iommu/20230817234047.195194-1-baolu.lu@linux.intel.com/
 - Convert the fault data structures from uAPI to kAPI.
 - Merge iopf_device_param into iommu_fault_param.
 - Add debugging on domain lifetime for iopf.
 - Remove patch "iommu: Change the return value of dev_iommu_get()".
 - Remove patch "iommu: Add helper to set iopf handler for domain".
 - Misc code refactoring and refining.

v2: https://lore.kernel.org/linux-iommu/20230727054837.147050-1-baolu.lu@linux.intel.com/
 - Remove unrecoverable fault data definition as suggested by Kevin.
 - Drop the per-device fault cookie code considering that doesn't make
   much sense for SVA.
 - Make the IOMMU page fault handling framework generic. So that it can
   avaible for use cases other than SVA.

v1: https://lore.kernel.org/linux-iommu/20230711010642.19707-1-baolu.lu@linux.intel.com/

Lu Baolu (10):
  iommu: Move iommu fault data to linux/iommu.h
  iommu/arm-smmu-v3: Remove unrecoverable faults reporting
  iommu: Remove unrecoverable fault data
  iommu: Cleanup iopf data structure definitions
  iommu: Merge iopf_device_param into iommu_fault_param
  iommu: Remove iommu_[un]register_device_fault_handler()
  iommu: Merge iommu_fault_event and iopf_fault
  iommu: Prepare for separating SVA and IOPF
  iommu: Make iommu_queue_iopf() more generic
  iommu: Separate SVA and IOPF

 include/linux/iommu.h                         | 255 ++++++++++----
 drivers/iommu/intel/iommu.h                   |   2 +-
 drivers/iommu/iommu-sva.h                     |  71 ----
 include/uapi/linux/iommu.h                    | 161 ---------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  14 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  51 +--
 drivers/iommu/intel/iommu.c                   |  25 +-
 drivers/iommu/intel/svm.c                     |   6 +-
 drivers/iommu/io-pgfault.c                    | 322 +++++++++++-------
 drivers/iommu/iommu-sva.c                     |  82 ++++-
 drivers/iommu/iommu.c                         | 255 ++------------
 MAINTAINERS                                   |   1 -
 drivers/iommu/Kconfig                         |   4 +
 drivers/iommu/Makefile                        |   3 +-
 drivers/iommu/intel/Kconfig                   |   1 +
 15 files changed, 504 insertions(+), 749 deletions(-)
 delete mode 100644 drivers/iommu/iommu-sva.h
 delete mode 100644 include/uapi/linux/iommu.h

-- 
2.34.1

