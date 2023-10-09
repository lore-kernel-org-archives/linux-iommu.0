Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A661FAF
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7Pgc6iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841487; x=1728377487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QQiCA0/iZXkbwpDgf6IT/PWFnBNd1b0GHC0pta7p/Rk=;
  b=C7Pgc6ivLscECJZrN7j7SpK7k+GvObdDp1dJbcOviXfru0zrzQJLv30e
   XK7HwVJHTH/MYnV+dCA53ukAJZc3qhAuHypvdYYKYTrpnhARjXBRattlt
   dyPwA7zWxj8QbNn/f0kbRvBJeWFVVq3XoMlhNZINAXy/T6Kb7pShlIISr
   X46igJIIKJQkwtSS7hXzi/b8tg4hC8BR3co7ZchhrhwyfHTQnN36+3a2+
   bSkvq8LcEAhiQpBa0PJbVLL7QHRvOHGIeSyjijHwOkBG9U+wylsfl3zCb
   RVr615HnfRjABssiC2+oMayVGR6Kh8dbq9/hHZbSzTvOkfJ8NJwl4Sg9J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390745"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390745"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781640"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781640"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:25 -0700
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
Subject: [RFC 0/7] Add SIOV virtual device support
Date: Mon,  9 Oct 2023 01:51:16 -0700
Message-Id: <20231009085123.463179-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel SIOV allows creating virtual devices of which the vRID is
represented by a pasid of a physical device. It is called as SIOV
virtual device in this series. Such devices can be bound to an iommufd
as physical device does and then later be attached to an IOAS/hwpt
using that pasid. Such PASIDs are called as default pasid.

iommufd has already supported pasid attach[1]. So a simple way to
support SIOV virtual device attachment is to let device driver call
the iommufd_device_pasid_attach() and pass in the default pasid for
the virtual device. This should work for now, but it may have problem
if iommufd core wants to differentiate the default pasids with other
kind of pasids (e.g. pasid given by userspace). In the later forwarding
page request to userspace, the default pasids are not supposed to send
to userspace as default pasids are mainly used by the SIOV device driver.

With above reason, this series chooses to have a new API to bind the
default pasid to iommufd, and extends the iommufd_device_attach() to
convert the attachment to be pasid attach with the default pasid. Device
drivers (e.g. VFIO) that support SIOV shall call the below APIs to
interact with iommufd:

  - iommufd_device_bind_pasid(): Bind virtual device (a pasid of a device)
				 to iommufd;
  - iommufd_device_attach(): Attach a SIOV virtual device to IOAS/HWPT;
  - iommufd_device_replace(): Replace IOAS/HWPT of a SIOV virtual device;
  - iommufd_device_detach(): Detach IOAS/HWPT of a SIOV virtual device;
  - iommufd_device_unbind(): Unbind virtual device from iommufd;

For vfio devices, the device drivers that support SIOV should:

  - use below API to register vdev for SIOV virtual device
        vfio_register_pasid_iommu_dev()

  - use below API to bind vdev to iommufd in .bind_iommufd() callback
        iommufd_device_bind_pasid()

  - allocate pasid by itself before calling iommufd_device_bind_pasid()

Complete code can be found at[2]

[1] https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid_siov

Regards,
	Yi Liu

Kevin Tian (5):
  iommufd: Handle unsafe interrupts in a separate function
  iommufd: Introduce iommufd_alloc_device()
  iommufd: Add iommufd_device_bind_pasid()
  iommufd: Support attach/replace for SIOV virtual device {dev, pasid}
  vfio: Add vfio_register_pasid_iommu_dev()

Yi Liu (2):
  iommufd/selftest: Extend IOMMU_TEST_OP_MOCK_DOMAIN to pass in pasid
  iommufd/selftest: Add test coverage for SIOV virtual device

 drivers/iommu/iommufd/device.c                | 163 ++++++++++++++----
 drivers/iommu/iommufd/iommufd_private.h       |   7 +
 drivers/iommu/iommufd/iommufd_test.h          |   2 +
 drivers/iommu/iommufd/selftest.c              |  10 +-
 drivers/vfio/group.c                          |  18 ++
 drivers/vfio/vfio.h                           |   8 +
 drivers/vfio/vfio_main.c                      |  10 ++
 include/linux/iommufd.h                       |   3 +
 include/linux/vfio.h                          |   1 +
 tools/testing/selftests/iommu/iommufd.c       |  75 ++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  42 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  21 ++-
 12 files changed, 296 insertions(+), 64 deletions(-)

-- 
2.34.1

