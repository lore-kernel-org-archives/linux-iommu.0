Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8A3D75
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns2RwZxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295341; x=1729831341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nRXUEjVo6WsvWVdVhI2B73S84NxyvKLAwOWG3UCK4yQ=;
  b=ns2RwZxtEO9Cm+9QKcM8QS1KHhXzFFBdiFVHDDdbk+tuT3t4htP+fNbg
   2eX8Ni01cH+zCCr/8+1m7LgNQgal+CDIyLIjEuXZjRzgl3szELPkF6Hor
   tIBeCZ6oMtaR0ZO6BNwNUjT0J93DIvnr7sBUr47Iib6+M6kMmeJAXO+Lu
   o8zLcAf5/peYsEEHnXlVDbfeAAyd4HLtSB4LMpaVvi2WpeZb9TSJRPgKZ
   y4SBvEQSdn/ZiGHi3Iq86S2P1h4OGhomxMaQ0BT5tfYqlVk9GO5Q0Xapw
   AUmi+I50nWyMssiG6tsQWqYJVsT4PfWZqWvEaojUuvZftGgxVswefgmY+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670707"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670707"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478506"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478506"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:18 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v8 0/8] Add Intel VT-d nested translation (part 1/2)
Date: Wed, 25 Oct 2023 21:42:08 -0700
Message-Id: <20231026044216.64964-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first part to add Intel VT-d nested translation based on IOMMUFD
nesting infrastructure. As the iommufd nesting infrastructure series[1],
iommu core supports new ops to allocate domains with user data. For nesting,
the user data is vendor-specific, IOMMU_HWPT_DATA_VTD_S1 is defined for
the Intel VT-d stage-1 page table, it will be used in the stage-1 domain
allocation path. struct iommu_hwpt_vtd_s1 is defined to pass user_data
for the Intel VT-d stage-1 domain allocation. This series does not have
the cache invalidation path, it would be added in part 2/2.

The first Intel platform supporting nested translation is Sapphire
Rapids which, unfortunately, has a hardware errata [2] requiring special
treatment. This errata happens when a stage-1 page table page (either
level) is located in a stage-2 read-only region. In that case the IOMMU
hardware may ignore the stage-2 RO permission and still set the A/D bit
in stage-1 page table entries during page table walking.

A flag IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is introduced to report
this errata to userspace. With that restriction the user should either
disable nested translation to favor RO stage-2 mappings or ensure no
RO stage-2 mapping to enable nested translation.

Intel-iommu driver is armed with necessary checks to prevent such mix
in patch8 of this series.

Qemu currently does add RO mappings though. The vfio agent in Qemu
simply maps all valid regions in the GPA address space which certainly
includes RO regions e.g. vbios.

In reality we don't know a usage relying on DMA reads from the BIOS
region. Hence finding a way to skip RO regions (e.g. via a discard manager)
in Qemu might be an acceptable tradeoff. The actual change needs more
discussion in Qemu community. For now we just hacked Qemu to test.

Complete code can be found in [3], corresponding QEMU could can be found
in [4].

[1] https://lore.kernel.org/linux-iommu/20231026043938.63898-1-yi.l.liu@intel.com/
[2] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v8:
 - Adopt changes suggested by Jason on domain_alloc_user() op
   https://lore.kernel.org/linux-iommu/20231024230319.GW3952@nvidia.com/
 - Add Kevin's r-b on patch 06
 - Fix description for IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 (Kevin)

v7: https://lore.kernel.org/linux-iommu/20231024151412.50046-1-yi.l.liu@intel.com/
 - Rebase on top of latest iommufd nesting part 1/2
 - Add the nested_parent flag in patch 07 and sanitize it for nested domain
   allocation (Baolu)
 - Fail the nested domain allocation if dirty tracking flag is set

v6: https://lore.kernel.org/linux-iommu/20231020093246.17015-1-yi.l.liu@intel.com/
 - Add Kevin's r-b for patch 1 and 8
 - Drop Kevin's r-b for patch 7
 - Address comments from Kevin
 - Split the VT-d nesting series into two parts 1/2 and 2/2

v5: https://lore.kernel.org/linux-iommu/20230921075431.125239-1-yi.l.liu@intel.com/
 - Add Kevin's r-b for patch 2, 3 ,5 8, 10
 - Drop enforce_cache_coherency callback from the nested type domain ops (Kevin)
 - Remove duplicate agaw check in patch 04 (Kevin)
 - Remove duplicate domain_update_iommu_cap() in patch 06 (Kevin)
 - Check parent's force_snooping to set pgsnp in the pasid entry (Kevin)
 - uapi data structure check (Kevin)
 - Simplify the errata handling as user can allocate nested parent domain

v4: https://lore.kernel.org/linux-iommu/20230724111335.107427-1-yi.l.liu@intel.com/
 - Remove ascii art tables (Jason)
 - Drop EMT (Tina, Jason)
 - Drop MTS and related definitions (Kevin)
 - Rename macro IOMMU_VTD_PGTBL_ to IOMMU_VTD_S1_ (Kevin)
 - Rename struct iommu_hwpt_intel_vtd_ to iommu_hwpt_vtd_ (Kevin)
 - Rename struct iommu_hwpt_intel_vtd to iommu_hwpt_vtd_s1 (Kevin)
 - Put the vendor specific hwpt alloc data structure before enuma iommu_hwpt_type (Kevin)
 - Do not trim the higher page levels of S2 domain in nested domain attachment as the
   S2 domain may have been used independently. (Kevin)
 - Remove the first-stage pgd check against the maximum address of s2_domain as hw
   can check it anyhow. It makes sense to check every pfns used in the stage-1 page
   table. But it cannot make it. So just leave it to hw. (Kevin)
 - Split the iotlb flush part into an order of uapi, helper and callback implementation (Kevin)
 - Change the policy of VT-d nesting errata, disallow RO mapping once a domain is used
   as parent domain of a nested domain. This removes the nested_users counting. (Kevin)
 - Minor fix for "make htmldocs"

v3: https://lore.kernel.org/linux-iommu/20230511145110.27707-1-yi.l.liu@intel.com/
 - Further split the patches into an order of adding helpers for nested
   domain, iotlb flush, nested domain attachment and nested domain allocation
   callback, then report the hw_info to userspace.
 - Add batch support in cache invalidation from userspace
 - Disallow nested translation usage if RO mappings exists in stage-2 domain
   due to errata on readonly mappings on Sapphire Rapids platform.

v2: https://lore.kernel.org/linux-iommu/20230309082207.612346-1-yi.l.liu@intel.com/
 - The iommufd infrastructure is split to be separate series.

v1: https://lore.kernel.org/linux-iommu/20230209043153.14964-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Lu Baolu (5):
  iommu/vt-d: Extend dmar_domain to support nested domain
  iommu/vt-d: Add helper for nested domain allocation
  iommu/vt-d: Add helper to setup pasid nested translation
  iommu/vt-d: Add nested domain allocation
  iommu/vt-d: Disallow read-only mappings to nest parent domain

Yi Liu (3):
  iommufd: Add data structure for Intel VT-d stage-1 domain allocation
  iommu/vt-d: Make domain attach helpers to be extern
  iommu/vt-d: Set the nested domain to a device

 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  60 +++++++++---------
 drivers/iommu/intel/iommu.h  |  46 ++++++++++++--
 drivers/iommu/intel/nested.c | 117 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c  | 112 +++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h  |   2 +
 include/uapi/linux/iommufd.h |  42 ++++++++++++-
 7 files changed, 345 insertions(+), 36 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

