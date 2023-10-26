Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3C623
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h49RwwuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288815; x=1729824815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jnt3qquZ9palXNYk+43Q9HkECVOlSF4Vhez9GOgrGng=;
  b=h49RwwuIZGkDKpYEZAmVqLiDHbCqoc99qYEe3u8pqV+V6tWNGpMx0YWr
   d06ezmJD0YEAH85mwSBHUdZ5lT+2nImZsIp8dpIlk2kdXBuBWmdLLSAP4
   Z3OfXxD2WwgPcftMWAxv4dMLR9ScWpuKtvfqhnrG1pLQhALi04iBcCsc5
   nyyouWUFlFiSZLJD9Eo/WQBVNtyJ0yVreAOLXl6KvYY6mB4iO9If/qI3E
   ZmgBOWGtsOLkcIRQK2myF13eitG2JYpRq/NC6nF9RQXG/Wc6XJYPXvK0k
   nSsEnf6XUw9VtV6AkyLyxiCAw0OKsi5Gb7bI6J3uAnaDuoljUvwSR23sO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316139"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604476"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604476"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Date: Thu, 26 Oct 2023 10:49:24 +0800
Message-Id: <20231026024930.382898-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series implements the functionality of delivering IO page faults to
user space through the IOMMUFD framework for nested translation. Nested
translation is a hardware feature that supports two-stage translation
tables for IOMMU. The second-stage translation table is managed by the
host VMM, while the first-stage translation table is owned by user
space. This allows user space to control the IOMMU mappings for its
devices.

When an IO page fault occurs on the first-stage translation table, the
IOMMU hardware can deliver the page fault to user space through the
IOMMUFD framework. User space can then handle the page fault and respond
to the device top-down through the IOMMUFD. This allows user space to
implement its own IO page fault handling policies.

User space indicates its capability of handling IO page faults by
setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
hardware page table (HWPT). IOMMUFD will then set up its infrastructure
for page fault delivery. On a successful return of HWPT allocation, the
user can retrieve and respond to page faults by reading and writing to
the file descriptor (FD) returned in out_fault_fd.

The iommu selftest framework has been updated to test the IO page fault
delivery and response functionality.

This series is based on the latest implementation of nested translation
under discussion [1] and the page fault handling framework refactoring in
the IOMMU core [2].

The series and related patches are available on GitHub: [3]

[1] https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
[3] https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v2

Best regards,
baolu

Change log:
v2:
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

Lu Baolu (6):
  iommu: Add iommu page fault cookie helpers
  iommufd: Add iommu page fault uapi data
  iommufd: Initializing and releasing IO page fault data
  iommufd: Deliver fault messages to user space
  iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_IOPF test support
  iommufd/selftest: Add coverage for IOMMU_TEST_OP_TRIGGER_IOPF

 include/linux/iommu.h                         |   9 +
 drivers/iommu/iommu-priv.h                    |  15 +
 drivers/iommu/iommufd/iommufd_private.h       |  12 +
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  |  65 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  66 ++++-
 drivers/iommu/io-pgfault.c                    |  50 ++++
 drivers/iommu/iommufd/device.c                |  69 ++++-
 drivers/iommu/iommufd/hw_pagetable.c          | 260 +++++++++++++++++-
 drivers/iommu/iommufd/selftest.c              |  56 ++++
 tools/testing/selftests/iommu/iommufd.c       |  24 +-
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 12 files changed, 620 insertions(+), 16 deletions(-)

-- 
2.34.1

