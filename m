Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A7372
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917118; x=1707453118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FxTu9xVn0q17LFAoBZGb5vcNT6+3d43snW3rZ3K2Mik=;
  b=LDfAPZ0Ed7U2mo4s5GBGF5K7xqdQKkUCEKRyETS0ETSMPtb937tPtD43
   azBHAXKZvWB8cxX5rx9lqVboQJ1hxxJvgVogWXkBpMbZuk+H0lA9VxFJa
   MlhySCQ9HCiMRmIjG5xQDEOahsCDnHAMN0+O3kuCA2ecN+UG1vziXdH1+
   VNZPfG3KItXbj6mDQ80DaUsDXMdywTJ8Xu6RG1ShR0+aIu8c3AZHv68eQ
   mharjD5VHKV+FAHF7ed541LDES4qo2wBjOd3X9CakN5StLsqroP9ErR1l
   9UmYvxWPb/hzTSlgNZzyr6k1fR28YTbGLeoK9kJapqF6BL5GO81knaudx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298572"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447422"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447422"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:31:56 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: [PATCH 00/17] Add Intel VT-d nested translation
Date: Wed,  8 Feb 2023 20:31:36 -0800
Message-Id: <20230209043153.14964-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested translation has two stage address translations to get the final
physical addresses. Take Intel VT-d as an example, the first stage translation
structure is I/O page table. As the below diagram shows, guest I/O page
table pointer in GPA (guest physical address) is passed to host to do the
first stage translation. Along with it, guest modifications to present
mappings in the first stage page should be followed with an iotlb invalidation
to sync host iotlb.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest I/O page table      |
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush --+
    '-------------'                        |
    |             |                        V
    |             |           I/O page table pointer in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .------------------------.
    |   pIOMMU    |  |  FS for GIOVA->GPA      |
    |             |  '------------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.----------------------------------.
    |             |   | SS for GPA->HPA, unmanaged domain|
    |             |   '----------------------------------'
    '-------------'
Where:
 - FS = First stage page tables
 - SS = Second stage page tables
<Intel VT-d Nested translation>

Different platform vendors have different first stage translation formats,
so userspace should query the underlying iommu capability before setting
first stage translation structures to host.[1]

In iommufd subsystem, I/O page tables would be tracked by hw_pagetable objects.
First stage page table is owned by userspace (guest), while second stage page
table is owned by kernel for security. So First stage page tables are tracked
by user-managed hw_pagetable, second stage page tables are tracked by kernel-
managed hw_pagetable.

This series first introduces new iommu op for allocating domains for iommufd,
and op for syncing iotlb for first stage page table modifications, and then
add the implementation of the new ops in intel-iommu driver. After this
preparation, adds kernel-managed and user-managed hw_pagetable allocation for
userspace. Last, add self-test for the new ioctls.

This series is based on "[PATCH 0/6] iommufd: Add iommu capability reporting"[1]
and Nicolin's "[PATCH v2 00/10] Add IO page table replacement support"[2]. Complete
code can be found in[3]. Draft Qemu code can be found in[4].

Basic test done with DSA device on VT-d. Where the guest has a vIOMMU built
with nested translation.

[1] https://lore.kernel.org/linux-iommu/20230209041642.9346-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/linux-iommu/cover.1675802050.git.nicolinc@nvidia.com/
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting_vtd_v1
[4] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv3%2Bnesting

Regards,
	Yi Liu

Lu Baolu (5):
  iommu: Add new iommu op to create domains owned by userspace
  iommu: Add nested domain support
  iommu/vt-d: Extend dmar_domain to support nested domain
  iommu/vt-d: Add helper to setup pasid nested translation
  iommu/vt-d: Add nested domain support

Nicolin Chen (6):
  iommufd: Add/del hwpt to IOAS at alloc/destroy()
  iommufd/device: Move IOAS attaching and detaching operations into
    helpers
  iommufd/selftest: Add IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC ioctl
  iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl

Yi Liu (6):
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd: Split iommufd_hw_pagetable_alloc()
  iommufd: Add kernel-managed hw_pagetable allocation for userspace
  iommufd: Add infrastructure for user-managed hw_pagetable allocation
  iommufd: Add user-managed hw_pagetable allocation
  iommufd/device: Report supported stage-1 page table types

 drivers/iommu/intel/Makefile                  |   2 +-
 drivers/iommu/intel/iommu.c                   |  38 ++-
 drivers/iommu/intel/iommu.h                   |  50 +++-
 drivers/iommu/intel/nested.c                  | 143 +++++++++
 drivers/iommu/intel/pasid.c                   | 142 +++++++++
 drivers/iommu/intel/pasid.h                   |   2 +
 drivers/iommu/iommufd/device.c                | 117 ++++----
 drivers/iommu/iommufd/hw_pagetable.c          | 280 +++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h       |  23 +-
 drivers/iommu/iommufd/iommufd_test.h          |  35 +++
 drivers/iommu/iommufd/main.c                  |  11 +
 drivers/iommu/iommufd/selftest.c              | 149 +++++++++-
 include/linux/iommu.h                         |  11 +
 include/uapi/linux/iommufd.h                  | 196 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 124 +++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 106 +++++++
 16 files changed, 1329 insertions(+), 100 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

