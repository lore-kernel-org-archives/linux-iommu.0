Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184516D30F
	for <iommu@lists.linux.dev>; Sun, 16 Jun 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518465; cv=none; b=nCN3KmSS6keCYBl0woVxfpPzW5llELu2b4qzmDizZOdADjVus7yuQhNXWnmtvQQd3gGqoQ+iZ8xRH8QJ8s8ZP+O3/SXWPhejfQmLZFn1aWFEf7ZGZcEyNj3e2zXzgR93Gg2L2gREfLipGuC6gDBD9kOda+BcM23fMN2kupfYAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518465; c=relaxed/simple;
	bh=qghNC2kj31fGGHUoSzg8Ks67YuqW3ScXQtYuqanUTSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PBfGh0OzB1HxxXsJIZM+F2IZqC3jNTrcKOv9Xc6tWx6mDcFcvSlUZjD3PHA6MYJAJ1ivMjx+HyqyoPlKcvqJI277TPLw4b4LfgUqlyUy1r9uTXUTtEBcvRUL1Vhx43Yg9Cd25TZqrxnpVXu9Bz1ivTQU6hturcHkQKAzIHWOIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrF5eQR0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrF5eQR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518463; x=1750054463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qghNC2kj31fGGHUoSzg8Ks67YuqW3ScXQtYuqanUTSQ=;
  b=mrF5eQR0zPvppPegi4KL90eFxk2GNK4WwnvhsHactTFQo9v578YdoWW/
   w6ICDvIo7QTVSi3zQJb4uTDKHgxXnK4io7Kd5kMwzMuPpjpnzfy9JH9cr
   rYkxrYxxI6MOu4qCVlDuXGwLo19LUmkmEB/KGIQrSwqAViSPy0H9AnLME
   DxoQh5a/ABRMYpQrvLnVw/lkEEMgN7qr7XUaRQzy/ea2R25zJXsYQSrtw
   gXA5Z22oRkFmsDDRXTuoSUFgwwALesj0FU+pctQ4uXooBhFVfWORrHF0T
   kq8ndWaXXCJbMSmxeZK33uU5c3ojP9vtKOYTN6UcEAzJyWmaIhEvRValj
   g==;
X-CSE-ConnectionGUID: r4CvnAMTR7C25UVpOJXYCg==
X-CSE-MsgGUID: 1EQQW1ITRou3H5nka3+e1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18289964"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18289964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:22 -0700
X-CSE-ConnectionGUID: DFVHY0HYRMOVguGv6E0a/g==
X-CSE-MsgGUID: OZ8PuFrSRjmOoNkOirxt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748129"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Date: Sun, 16 Jun 2024 14:11:45 +0800
Message-Id: <20240616061155.169343-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the functionality of delivering IO page faults to
user space through the IOMMUFD framework. One feasible use case is the
nested translation. Nested translation is a hardware feature that
supports two-stage translation tables for IOMMU. The second-stage
translation table is managed by the host VMM, while the first-stage
translation table is owned by user space. This allows user space to
control the IOMMU mappings for its devices.

When an IO page fault occurs on the first-stage translation table, the
IOMMU hardware can deliver the page fault to user space through the
IOMMUFD framework. User space can then handle the page fault and respond
to the device top-down through the IOMMUFD. This allows user space to
implement its own IO page fault handling policies.

User space application that is capable of handling IO page faults should
allocate a fault object, and bind the fault object to any domain that it
is willing to handle the fault generatd for them. On a successful return
of fault object allocation, the user can retrieve and respond to page
faults by reading or writing to the file descriptor (FD) returned.

The iommu selftest framework has been updated to test the IO page fault
delivery and response functionality.

The series and related patches are available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v7

Change log:
v7:
 - Move the setting of handle.domain into the helpers.
 - Return value of copy_to_user() should be converted to -EFAULT.
 - Add more checks on a fetched dma handle in the sva bind path.
 - Add a constant flag in iommu_ops to replace
   IOMMU_CAP_USER_IOASID_TABLE.
 - Simplify iommu_hwpt_pgfault and iommu_hwpt_page_response by removing
   some unnecessary fields.
 - Address the wrong order between dec users and ctx_put in fault FD
   release path.
 - Miscellaneous cleanup.

v6: https://lore.kernel.org/linux-iommu/20240527040517.38561-1-baolu.lu@linux.intel.com/
 - Refine the attach handle code by shifting the handle allocation to
   the caller. The caller will then provide the allocated handle to the
   domain attachment interfaces.
 - Add reference counter in iommufd_fault_iopf_enable/disable() helpers.
 - Fix the return values of fault FD's read/write fops.
 - Add IOMMU_CAP_USER_IOASID_TABLE capability and check it before roll
   back getting attach_handle to RID.
 - Move the iopf respond queue from iommufd device to iommufd fault.
 - Disallow PRI enablement on SR-IOV VF devices.
 - Miscellaneous cleanup.

v5: https://lore.kernel.org/linux-iommu/20240430145710.68112-1-baolu.lu@linux.intel.com/
 - Removed attach handle reference count from the core. Drivers will now
   synchronize their use of handles and domain attach/detach.
 - Automatically responds to all outstanding faults in hwpt detach or
   replace paths.
 - Supports getting a domain-type specific attach handle.
 - Reorganized the series by changing the patch order.
 - Miscellaneous cleanup.

v4: https://lore.kernel.org/linux-iommu/20240403011519.78512-1-baolu.lu@linux.intel.com/
 - Add the iommu domain attachment handle to replace the iopf-specific
   domain attachment interfaces introduced in the previous v3.
 - Replace the iommu_sva with iommu domain attachment handle.
 - Refine some fields in the fault and response message encoding
   according to feedback collected during v3 review period.
 - Refine and fix some problems in the fault FD implementation.
 - Miscellaneous cleanup.

v3: https://lore.kernel.org/linux-iommu/20240122073903.24406-1-baolu.lu@linux.intel.com/
 - Add iopf domain attach/detach/replace interfaces to manage the
   reference counters of hwpt and device, ensuring that both can only be
   destroyed after all outstanding IOPFs have been responded to. 
 - Relocate the fault handling file descriptor from hwpt to a fault
   object to enable a single fault handling object to be utilized
   across multiple domains.
 - Miscellaneous cleanup and performance improvements.

v2: https://lore.kernel.org/linux-iommu/20231026024930.382898-1-baolu.lu@linux.intel.com/
 - Move all iommu refactoring patches into a sparated series and discuss
   it in a different thread. The latest patch series [v6] is available at
   https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
 - We discussed the timeout of the pending page fault messages. We
   agreed that we shouldn't apply any timeout policy for the page fault
   handling in user space.
   https://lore.kernel.org/linux-iommu/20230616113232.GA84678@myrica/
 - Jason suggested that we adopt a simple file descriptor interface for
   reading and responding to I/O page requests, so that user space
   applications can improve performance using io_uring.
   https://lore.kernel.org/linux-iommu/ZJWjD1ajeem6pK3I@ziepe.ca/

v1: https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/


Lu Baolu (10):
  iommu: Introduce domain attachment handle
  iommu: Remove sva handle list
  iommu: Add attach handle to struct iopf_group
  iommu: Extend domain attach group with handle support
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Fault-capable hwpt attach/detach/replace
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  41 +-
 drivers/iommu/iommu-priv.h                    |  11 +
 drivers/iommu/iommufd/iommufd_private.h       |  80 ++++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 109 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  80 +++-
 drivers/dma/idxd/init.c                       |   2 +-
 drivers/iommu/io-pgfault.c                    |  63 +--
 drivers/iommu/iommu-sva.c                     |  42 +-
 drivers/iommu/iommu.c                         | 184 ++++++--
 drivers/iommu/iommufd/device.c                |   7 +-
 drivers/iommu/iommufd/fault.c                 | 433 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  41 +-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  64 +++
 tools/testing/selftests/iommu/iommufd.c       |  18 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 18 files changed, 1074 insertions(+), 118 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1

