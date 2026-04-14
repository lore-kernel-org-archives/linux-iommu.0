Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E137EFFA
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201256; cv=none; b=CQeUtb1rxdDxen+02AqrTFjzhnKNlqx2qIoPbQ31Zw/pDBQMfR+auEUA8FDInD+kay2E1VVupJW2qRk332db6UqmGEiMVP3MDaV2Ly68Xq4yeB4pbhJaTpfu1EIHhjKZ6fVhDW/KrXPMvlqGFnqMVgLnUS5Jm/mLL+LmVTVegWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201256; c=relaxed/simple;
	bh=a03dfvBDnjCIeZxAl25YvfWZamrx0OHLwY0Hdpk5i5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dACU90gjdeB58BnlPpgnIUyqvoWzW+boRyedwf/I2RW+Wwxa2Zw418w1ueQlutPmAstXIkqY1s208N4O9Pm3nM/JRV3omdWR9BL7Bu48tI2HizJhOx6Dt2n6zHV6Sn7n39JyfTIXK0CqGbnSGYh2YM12EVH+vAzrEyboEZP1J1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bl96z0C3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bl96z0C3"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EED420B6F01;
	Tue, 14 Apr 2026 14:14:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EED420B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776201254;
	bh=J+x8M7kZoay7wmXk4X4HYJDWsyg39BlXt9aAiFwn3cI=;
	h=From:To:Cc:Subject:Date:From;
	b=bl96z0C3FeLlAuOoURC7jEtKeWzagbS3K2HEKHX6qPraFT42UCamKNUIxSOoZBYaC
	 Mm4n156z8pvcgNaiy8Koa+ErPgEVTnNuTIWM3HcZTXI1FHzkL9DRgMDMys3sdpXWgP
	 qgrc8VKfRhNyLAnib1uXvcKjUkr45dPzzxS5/4xg=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V4 00/10] iommufd: Enable noiommu mode for cdev
Date: Tue, 14 Apr 2026 14:14:02 -0700
Message-Id: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
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

V4:
- Fix various corner cases pointed out by (Sashiko)
  Details in each patch changelog.

V3:
- Improve error handling [3/10] (Mostafa)
- Simplify vfio_device_is_noiommu logic and merged in [6/10] (Mostafa)
- Fix build dependency on !GENERIC_ATOMIC64
- Add comment to explain the design difference over the legacy noiommu
  VFIO code.[1/10]

V2:
- Fix build depenency by adding IOMMU_SUPPORT in [8/11]
- Add an optimization to scan beyond the first page for a contiguous physical
  address range and return its length instead of a single page.[4/11]

Since RFC[4]:
- Abandoned dummy iommu driver approach as patch 1-3 absorbed the
  changes into iommufd.

[1] https://lore.kernel.org/linux-iommu/20250603175403.GA407344@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20251027134430.00007e46@linux.microsoft.com/
[3] https://lore.kernel.org/kvm/20230522115751.326947-1-yi.l.liu@intel.com/
[4] https://lore.kernel.org/linux-iommu/20251201173012.18371-1-jacob.pan@linux.microsoft.com/

Thanks,

Jacob



Jacob Pan (7):
  iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query PA from IOVA
  vfio: Allow null group for noiommu without containers
  vfio: Introduce and set noiommu flag on vfio_device
  vfio: Enable cdev noiommu mode under iommufd
  vfio:selftest: Handle VFIO noiommu cdev
  selftests/vfio: Add iommufd noiommu mode selftest for cdev
  Documentation: Update VFIO NOIOMMU mode

Jason Gunthorpe (3):
  iommufd: Support a HWPT without an iommu driver for noiommu
  iommufd: Move igroup allocation to a function
  iommufd: Allow binding to a noiommu device

 Documentation/driver-api/vfio.rst             |  45 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                | 175 ++++--
 drivers/iommu/iommufd/hw_pagetable.c          |  11 +-
 drivers/iommu/iommufd/hwpt_noiommu.c          | 102 ++++
 drivers/iommu/iommufd/io_pagetable.c          |  60 ++
 drivers/iommu/iommufd/ioas.c                  |  25 +
 drivers/iommu/iommufd/iommufd_private.h       |   5 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/vfio/Kconfig                          |   8 +-
 drivers/vfio/group.c                          |  41 +-
 drivers/vfio/iommufd.c                        |   7 -
 drivers/vfio/vfio.h                           |  28 +-
 drivers/vfio/vfio_main.c                      |  12 +-
 include/linux/vfio.h                          |  10 +
 include/uapi/linux/iommufd.h                  |  25 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../lib/include/libvfio/vfio_pci_device.h     |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  32 +-
 .../vfio/vfio_iommufd_noiommu_test.c          | 567 ++++++++++++++++++
 .../vfio/vfio_pci_liveupdate_kexec_test.c     |   9 +
 21 files changed, 1074 insertions(+), 94 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c

-- 
2.34.1

