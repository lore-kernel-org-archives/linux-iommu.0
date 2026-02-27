Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD4362153
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214771; cv=none; b=HZpHG9PFWuBk/KMFptCseNfEc8hC33caXp6pRvzQx60UhtfrX7rjDRD7LRMhaAbtTyQD5XGjRFs08hfxDxD04/8RHf4vVXlA7uu7KfGBiwcSe34POerh7lPvuq1rJYQMykpg0nvelNX2Wt+gTk2bhda9k/2CGibZNI1Jq1DhFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214771; c=relaxed/simple;
	bh=WiRJzkEEb0lONyvkeUmffm6aceir+Qyck0Z8v2p3sz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VlN0ngIdylsqAfsjZjn0SUFqqehJ9nZxT3fkr1qWtUmIVfKyybfMcn4xaRK+H83SK5h18yY1ZBhPPUzjVGG6DiDsoSM5lQZ+QKawxzP7O2xywAmkIhT9PTHjK74e87emf0UfYF87MmLS9lJZbXWO+XswG9VmzMU1LfXA/lD3nLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=STWE34fN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="STWE34fN"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id B105320B6F02;
	Fri, 27 Feb 2026 09:52:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B105320B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214769;
	bh=OYCccDp1pYKQxSiFEOz24YLlhbNWV0oeyM66fgKtYXg=;
	h=From:To:Cc:Subject:Date:From;
	b=STWE34fNN98z2Mkd7xxKxCweKfvN0f5It0SJVRZxassn75wZu7MEL0tdvJNF4bzOg
	 DPpE7iaY0ByXCT1kyqQcVwk/dCZvKBFvHbm0phtKDhHZ/ebiW1aDLPEEQUOhs+D2/+
	 6+0ZuNlGX98VU4VXFQ6r5P9m6ydzwf80M5UDvq0Y=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 00/11] iommufd: Enable noiommu mode for cdev
Date: Fri, 27 Feb 2026 09:52:36 -0800
Message-Id: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
supports No-IOMMU mode for group-based devices under vfio_compat mode.
However, IOMMUFD's native character device (cdev) does not yet support
No-IOMMU mode, which is the purpose of this patch.

In summary, we have:

|-------------------------+------+---------------|
| Device access mode      | VFIO | IOMMUFD       |
|-------------------------+------+---------------|
| group /dev/vfio/$GROUP  | Yes  | Yes           |
|-------------------------+------+---------------|
| cdev /dev/vfio/devices/ | No   | This patch    |
|-------------------------+------+---------------|

Beyond enabling cdev for IOMMUFD, this patch also addresses the following
deficiencies in the current No-IOMMU mode suggested by Jason[1]:
- Devices operating under No-IOMMU mode are limited to device-level UAPI
  access, without container or IOAS-level capabilities. Consequently,
  user-space drivers lack structured mechanisms for page pinning and often
  resort to mlock(), which is less robust than pin_user_pages() used for
  devices backed by a physical IOMMU. For example, mlock() does not prevent
  page migration.
- There is no architectural mechanism for obtaining physical addresses for
  DMA. As a workaround, user-space drivers frequently rely on /proc/pagemap
  tricks or hardcoded values.

By allowing noiommu device access to IOMMUFD IOAS and HWPT objects, this
patch brings No-IOMMU mode closer to full citizenship within the IOMMU
subsystem. In addition to addressing the two deficiencies mentioned above,
the expectation is that it will also enable No-IOMMU devices to seamlessly
participate in live update sessions via KHO [2].

Furthermore, these devices will use the IOMMUFD-based ownership checking model for
VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access object
as required in a previous attempt [3].

ChangeLog:

Since RFC[4]:
- Abandoned dummy iommu driver approach as patch 1-3 absorbed the
  changes into iommufd.

[1] https://lore.kernel.org/linux-iommu/20250603175403.GA407344@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20251027134430.00007e46@linux.microsoft.com/
[3] https://lore.kernel.org/kvm/20230522115751.326947-1-yi.l.liu@intel.com/
[4] https://lore.kernel.org/linux-iommu/20251201173012.18371-1-jacob.pan@linux.microsoft.com/

Thanks,

Jacob

Jacob Pan (8):
  iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query PA from IOVA
  vfio: Allow null group for noiommu without containers
  vfio: Introduce and set noiommu flag on vfio_device
  vfio: Update noiommu device detection logic for cdev
  vfio: Enable cdev noiommu mode under iommufd
  vfio:selftest: Handle VFIO noiommu cdev
  selftests/vfio: Add iommufd noiommu mode selftest for cdev
  Doc: Update VFIO NOIOMMU mode

Jason Gunthorpe (3):
  iommufd: Support a HWPT without an iommu driver for noiommu
  iommufd: Move igroup allocation to a function
  iommufd: Allow binding to a noiommu device

 Documentation/driver-api/vfio.rst             |  44 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                | 161 ++++--
 drivers/iommu/iommufd/hw_pagetable.c          |  11 +-
 drivers/iommu/iommufd/hwpt_noiommu.c          |  91 +++
 drivers/iommu/iommufd/io_pagetable.c          |  39 ++
 drivers/iommu/iommufd/ioas.c                  |  22 +
 drivers/iommu/iommufd/iommufd_private.h       |   5 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/vfio/Kconfig                          |   6 +-
 drivers/vfio/group.c                          |  35 +-
 drivers/vfio/iommufd.c                        |   7 -
 drivers/vfio/vfio.h                           |  34 +-
 drivers/vfio/vfio_main.c                      |  22 +-
 include/linux/vfio.h                          |  10 +
 include/uapi/linux/iommufd.h                  |  25 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  25 +-
 .../vfio/vfio_iommufd_noiommu_test.c          | 540 ++++++++++++++++++
 19 files changed, 990 insertions(+), 92 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c

-- 
2.34.1

