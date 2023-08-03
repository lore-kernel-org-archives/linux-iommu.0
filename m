Received: from mgamail.intel.com (unknown [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012772570
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691073348; x=1722609348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5XOAANYi6PhPbrJ+klTCobbNvd+SaqKSvWlM8mBjHuA=;
  b=OpfHuZavf8bwzVr7Ojy7TtvpR2dnrieI2iE6RkiEbTt7DhXAlBnVbxI5
   NdwLCZ7bTkqLsfC63bHbuoq81AvTg3m9AymVCc535UKh1yLdk33F7z0a8
   19ZWTLvpmsk7/MHIdZ2JjGLx7qA7yTRhzroo7DXjEhYn8CypnHGXr6TQ4
   SUMxJXO1tEO9o++wMM1TvL8HVOP0vgZlhJ+GuL0jxDzE5yDs2qogqxWdC
   g2enq9B7GdBQOU9VdXeYG45hD9W4bU7zbCk/g3Laqwx4m8tCK/UXFB5Se
   /lKa+9yLg/tsZQn/aoH6finu2v0XALSky8EImucDhN+igHij7umVa/nOd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="372643346"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="372643346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759153147"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="759153147"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2023 07:31:45 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v5 0/4] iommufd: Add iommu hardware info reporting
Date: Thu,  3 Aug 2023 07:31:40 -0700
Message-Id: <20230803143144.200945-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd gives userspace the capability to manipulate iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will support iommu nested
translation. Different platform vendors have different implementation for
the nested translation. For example, Intel VT-d supports using guest I/O
page table as the stage-1 translation table. This requires guest I/O page
table be compatible with hardware IOMMU. So before set up nested translation,
userspace needs to know the hardware iommu information to understand the
nested translation requirements.

This series reports the iommu hardware information for a given device
which has been bound to iommufd. It is preparation work for userspace to
allocate hwpt for given device. Like the nested translation support[1].

This series introduces an iommu op to report the iommu hardware info,
and an ioctl IOMMU_GET_HW_INFO is added to report such hardware info to
user. enum iommu_hw_info_type is defined to differentiate the iommu hardware
info reported to user hence user can decode them. This series only adds the
framework for iommu hw info reporting, the complete reporting path needs vendor
specific definition and driver support. The full code is available in [1]
as well.

[1] https://github.com/yiliu1765/iommufd/tree/wip/iommufd_nesting_08032023-yi
(only the hw_info report path is the latest, other parts is wip)

Change log:

v5:
 - Return hw_info_type in the .hw_info op, hence drop hw_info_type field in iommu_ops (Kevin)
 - Add Jason's r-b for patch 01
 - Address coding style comments from Jason and Kevin w.r.t. patch 02, 03 and 04

v4: https://lore.kernel.org/linux-iommu/20230724105936.107042-1-yi.l.liu@intel.com/
 - Rename ioctl to IOMMU_GET_HW_INFO and structure to iommu_hw_info
 - Move the iommufd_get_hw_info handler to main.c
 - Place iommu_hw_info prior to iommu_hwpt_alloc
 - Update the function namings accordingly
 - Update uapi kdocs

v3: https://lore.kernel.org/linux-iommu/20230511143024.19542-1-yi.l.liu@intel.com/#t
 - Add r-b from Baolu
 - Rename IOMMU_HW_INFO_TYPE_DEFAULT to be IOMMU_HW_INFO_TYPE_NONE to
   better suit what it means
 - Let IOMMU_DEVICE_GET_HW_INFO succeed even the underlying iommu driver
   does not have driver-specific data to report per below remark.
   https://lore.kernel.org/kvm/ZAcwJSK%2F9UVI9LXu@nvidia.com/

v2: https://lore.kernel.org/linux-iommu/20230309075358.571567-1-yi.l.liu@intel.com/
 - Drop patch 05 of v1 as it is already covered by other series
 - Rename the capability info to be iommu hardware info

v1: https://lore.kernel.org/linux-iommu/20230209041642.9346-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Lu Baolu (1):
  iommu: Add new iommu op to get iommu hardware information

Nicolin Chen (1):
  iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl

Yi Liu (2):
  iommu: Move dev_iommu_ops() to private header
  iommufd: Add IOMMU_GET_HW_INFO

 drivers/iommu/iommu-priv.h                    | 11 +++
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++
 drivers/iommu/iommufd/main.c                  | 79 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++
 include/linux/iommu.h                         | 20 +++--
 include/uapi/linux/iommufd.h                  | 44 +++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 +++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 ++++++
 8 files changed, 210 insertions(+), 12 deletions(-)

-- 
2.34.1

