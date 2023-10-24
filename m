Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250313FED
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxQWhfTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160169; x=1729696169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0e9QWCay9p8tvtJQgxTM422MLlZGo4iqwTVw+W3Gtto=;
  b=CxQWhfTeWoecf/JawOmvgfW1q7NnFVPuZ9OTFNqk+iaBPnQq67Q4JGuG
   PDP0zMw3/5HZuW5ig+J3eH+SO+xR+MnnwYCFOvSgxQb2A23BRegzevAOj
   xGuZIyGvG4XupOL4HeDEbz4Xw1rMsAlfQidgL1ZdEryp7M2DEeapvzTp9
   3QjDTNxnrfzzUBBk91d2aOtLWKmWHEVD2h38V00IwR5+X2rwIp/g3iMyF
   ayu1nGnen8yw9Fq57byRrQLKVws5lApWG5mId24M8wJY+oVaXqdY2+YZG
   UAT2VJ13yB/ie26fpqBMtUCijtw2mJzavUvvkoFBSiopv2iRrkC0giBSX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418202753"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418202753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486131"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:04 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v6 00/10] iommufd: Add nesting infrastructure (part 1/2)
Date: Tue, 24 Oct 2023 08:05:59 -0700
Message-Id: <20231024150609.46884-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested translation is a hardware feature that is supported by many modern
IOMMU hardwares. It has two stages of address translations to get access
to the physical address. A stage-1 translation table is owned by userspace
(e.g. by a guest OS), while a stage-2 is owned by kernel. Any change to a
stage-1 translation table should be followed by an IOTLB invalidation.

Take Intel VT-d as an example, the stage-1 translation table is guest I/O
page table. As the below diagram shows, the guest I/O page table pointer
in GPA (guest physical address) is passed to host and be used to perform
a stage-1 translation. Along with it, a modification to present mappings
in the guest I/O page table should be followed by an IOTLB invalidation.

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
------| Shadow |---------------------------|--------
      v        v                           v
Host
    .-------------.  .------------------------.
    |   pIOMMU    |  |  FS for GIOVA->GPA     |
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

In IOMMUFD, all the translation tables are tracked by hw_pagetable (hwpt)
and each hwpt is backed by an iommu_domain allocated from an iommu driver.
So in this series hw_pagetable and iommu_domain means the same thing if no
special note. IOMMUFD has already supported allocating hw_pagetable linked
with an IOAS. However, a nesting case requires IOMMUFD to allow allocating
hw_pagetable with driver specific parameters and interface to sync stage-1
IOTLB as user owns the stage-1 translation table.

This series is based on the iommu hw info reporting series [1] and nested
parent domain allocation [2]. It first extends domain_alloc_user to allocate
hwpt with user data by allowing the IOMMUFD internal infrastructure to accept
user_data and parent hwpt, relaying the user_data/parent to the iommu core
to allocate IOMMU_DOMAIN_NESTED. And it then extends the IOMMU_HWPT_ALLOC
ioctl to accept user data and a parent hwpt ID.

Note that this series is the part-1 set of a two-part nesting series. It
does not include the cache invalidation interface, which will be added in
the part 2.

Complete code can be found in [3], it is on top of Joao's dirty page tracking
v6 series and fix patches. QEMU could can be found in [4].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20230818101033.4100-1-yi.l.liu@intel.com/#r - merged
[2] https://lore.kernel.org/linux-iommu/20230928071528.26258-1-yi.l.liu@intel.com/ - merged
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v6:
 - Rebase on top of Joao's dirty tracking series:
   https://lore.kernel.org/linux-iommu/20231024135109.73787-1-joao.m.martins@oracle.com/
 - Rebase on top of the enforce_cache_coherency removal patch:
   https://lore.kernel.org/linux-iommu/ZTcAhwYjjzqM0A5M@Asurada-Nvidia/
 - Add parent and user_data check in iommu driver before the driver actually
   supports the two input. This can make better bisect support, the change is
   in patch 02.

v5: https://lore.kernel.org/linux-iommu/20231020091946.12173-1-yi.l.liu@intel.com/
 - Split the iommufd nesting series into two parts of alloc_user and
   invalidation (Jason)
 - Split IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING/_NESTED, and
   do the same with the structures/alloc()/abort()/destroy(). Reworked the
   selftest accordingly too. (Jason)
 - Move hwpt/data_type into struct iommu_user_data from standalone op
   arguments. (Jason)
 - Rename hwpt_type to be data_type, the HWPT_TYPE to be HWPT_ALLOC_DATA,
   _TYPE_DEFAULT to be _ALLOC_DATA_NONE (Jason, Kevin)
 - Rename iommu_copy_user_data() to iommu_copy_struct_from_user() (Kevin)
 - Add macro to the iommu_copy_struct_from_user() to calculate min_size
   (Jason)
 - Fix two bugs spotted by ZhaoYan

v4: https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
 - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
   and kernel-managed HWPTs
 - Rework invalidate uAPI to be a multi-request array-based design
 - Add a struct iommu_user_data_array and a helper for driver to sanitize
   and copy the entry data from user space invalidation array
 - Add a patch fixing TEST_LENGTH() in selftest program
 - Drop IOMMU_RESV_IOVA_RANGES patches
 - Update kdoc and inline comments
 - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested
   translation, this does not change the rule that resv regions should only
   be added to the kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be
   added in later series as it is needed only by SMMU so far.

v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
 - Add new uAPI things in alphabetical order
 - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user for
   sanity, replacing the previous op->domain_alloc_user_data_len solution
 - Return ERR_PTR from domain_alloc_user instead of NULL
 - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation
   (Kevin)
 - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspace hence
   userspace is able to exclude the ranges in the stage-1 HWPT (e.g. guest
   I/O page table). (Kevin)
 - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
 - Minor changes per Kevin's inputs

v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@intel.com/
 - Add union iommu_domain_user_data to include all user data structures to
   avoid passing void * in kernel APIs.
 - Add iommu op to return user data length for user domain allocation
 - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
 - Store the invalidation data length in
   iommu_domain_ops::cache_invalidate_user_data_len
 - Convert cache_invalidate_user op to be int instead of void
 - Remove @data_type in struct iommu_hwpt_invalidate
 - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop patch 08
   of v1

v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@intel.com/

Thanks,
	Yi Liu

Jason Gunthorpe (2):
  iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
  iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations

Lu Baolu (1):
  iommu: Add IOMMU_DOMAIN_NESTED

Nicolin Chen (6):
  iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
  iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
  iommufd: Add a nested HW pagetable object
  iommu: Add iommu_copy_struct_from_user helper
  iommufd/selftest: Add nested domain allocation for mock domain
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs

Yi Liu (1):
  iommu: Pass in parent domain with user_data to domain_alloc_user op

 drivers/iommu/intel/iommu.c                   |   7 +-
 drivers/iommu/iommufd/device.c                | 157 +++++++---
 drivers/iommu/iommufd/hw_pagetable.c          | 271 +++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |  73 +++--
 drivers/iommu/iommufd/iommufd_test.h          |  18 ++
 drivers/iommu/iommufd/main.c                  |  10 +-
 drivers/iommu/iommufd/selftest.c              | 151 ++++++++--
 drivers/iommu/iommufd/vfio_compat.c           |   6 +-
 include/linux/iommu.h                         |  72 ++++-
 include/uapi/linux/iommufd.h                  |  31 +-
 tools/testing/selftests/iommu/iommufd.c       | 120 ++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  31 +-
 13 files changed, 768 insertions(+), 182 deletions(-)

-- 
2.34.1

