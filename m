Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5B337B96
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610218; cv=none; b=ovdw4fN6AhIr1ppZZyeZH3+6BqLscVMSFtnmiClpOwrqb/NlC+/p5llAxYW/32ukdNmByLAeWAQNdvytDPARxJfFPFr4w82SRLJ2jpwNFcgB7vf8jLoy9dZGxTwIl2WYJCIwp1nH8qm8zImR4tZnNSkBKbGIjb2dHWC8WnY1r84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610218; c=relaxed/simple;
	bh=XAArNVjNKUEBoPf/sXEi6hrAJhhZ/Obp/R73KWum4r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vv8Kh9S2eS6obdS4ErJgfYcrZ3pbkZ7SXfoER8s1jyZhFIbRX1DdRapL8B7yTg7AyfHJBmtcMqXW5HDx4EiN25GqCG8bvJWYU9HArRv+qHGf9vRB8bhyaSfI0Swyqe4wg+4cv80Rm0RtkyPDtFbmImhuDFONZSfUJCtidjExKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Do3dapdV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Do3dapdV"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 77C202012085;
	Mon,  1 Dec 2025 09:30:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77C202012085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610214;
	bh=Xk278RuJ3JydR2IMcSjlTpTCUb3lVo+YdPZ3tban+a0=;
	h=From:To:Cc:Subject:Date:From;
	b=Do3dapdVZmS6XF8+iJQ9YyemLa67PnUk5k3aJToiW5JmM8/gVzZhOvi5GulDH8XtF
	 mRwepw0GkBfdoLKZ1dLoHEjP6vGWxgYXaObnBbrqa6xpyhGz1ARAnAMrZnF9/5tYfp
	 Y6bf7CzMDNyvBQBtv6lHfVYm+UdIUPEVdowK6m54=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 0/8] iommufd: Enable noiommu mode for cdev
Date: Mon,  1 Dec 2025 09:30:04 -0800
Message-Id: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
supports No-IOMMU mode for group based devices under vfio_compat mode.
However, IOMMUFD's native character device (cdev) does not yet implement
No-IOMMU mode, which is the purpose of this patch. In summary, we have:

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

By introducing a dummy IOMMU driver, this patch brings No-IOMMU mode closer
to full citizenship within the IOMMU subsystem. In addition to addressing
the two deficiencies mentioned above, the expectation is that it will also
enable No-IOMMU devices to seamlessly participate in KHO [2]. Furthermore,
these devices will use the IOMMUFD-based ownership checking model for
VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access object
as required in a previous attempt [3].

For in-kernel DMA, DMA APIs will use direct mode only since this driver
provides identity domain only.

The key implementation points are as follows:

1) Explicitly adding a new cdev with noiommu prefix, e.g.
/dev/vfio/
|-- 7
|-- devices
|   `-- noiommu-vfio0
`-- vfio

2) Add a new dummy iommu driver that claims all PCI devices under its device
scope: e.g.
$ ls /sys/class/iommu/noiommu/devices/
0000:00:00.0  0000:00:02.0  0000:00:04.0  0000:01:00.0

3) Leverage Jason's generic iommupt[4] for IOVA, use a mock AMDv1 page table
format. IOVA is not used for DMA but used as a key to lookup physical address
for DMA by userspace drivers.

4) Support IOAS attachment, map/unmap, and auto iommu_domain/HWPT. Page
pinning is done exactly the same as devices with physical IOMMU backing.

5) Add a new IOMMUFD ioctl to retrieve physical address from mock IOVA

Enabling noiommu mode is backward compatible with VFIO, i.e.
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode

Other than that, the usage of noiommu cdev is nearly identical to normal IOMMU
backed devices with the following exceptions:
1) open /dev/vfio/devices/noiommu-vfio0 instead of /dev/vfio/devices/vfio0
2) cannot explicitly allocate HWPT object from user
3) IOMMU_IOAS_MAP returned IOVAs (IOMMU_IOAS_MAP_FIXED_IOVA set or not) are
not usable for DMA. Instead, IOVAs are used as keys to look up physical
addresses.

For example:
	__iommufd = open("/dev/iommu", O_RDWR);
	devfd = open("/dev/vfio/devices/noiommu-vfio0â€);
	ioas_id = ioas_alloc(__iommufd);
	iommufd_bind(__iommufd, devfd);
	uvaddr = (uint64_t)mmap(NULL, len, PROT_READ | PROT_WRITE,
				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	struct iommu_ioas_map map = {
		.size = sizeof(map),
		.flags = IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE;
		.ioas_id = ioas_id,
		.iova = iova,
		.user_va = uvaddr,
		.length = size,
	};
	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
	struct iommu_ioas_get_pa get_pa = {
		.size = sizeof(get_pa),
		.flags = 0,
		.ioas_id = ioas_id,
		.iova = iova,
		.length = 0,
		.phys = 0,
	};

	ioctl(iommufd, IOMMU_IOAS_GET_PA, &get_pa);
	/* Do DMA with PA in get_pa.phys */
	iommufd_ioas_unmap(iommufd, ioas_id, iova, len);

There are still a few known issues I am trying to work through, welcome
suggestions.
- Warning "late IOMMU probe at driver bind, something fishy here!" is
  reported. This is likely due to PCI devices are artificially added to the
  dummy IOMMU's device scope (during iommu probe) without early fwspec
  initialization.
- Physical address lookup returns the starting address and default page size
  only, probably we'll be more useful to provide the range of contiguous
  physical address.

Thanks,

Jacob

References:
[1] https://lore.kernel.org/linux-iommu/20250603175403.GA407344@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20251027134430.00007e46@linux.microsoft.com/
[3] https://lore.kernel.org/kvm/20230522115751.326947-1-yi.l.liu@intel.com/
[4] https://lore.kernel.org/linux-iommu/4-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com/T/#u


Jacob Pan (8):
  iommu: Make iommu_device_register_bus available beyond selftest
  iommu: Add a helper to check if any iommu device is registered
  iommufd: Add a mock page table format for noiommu mode
  iommu: Add a dummy driver for noiommu mode
  vfio: IOMMUFD relax requirement for noiommu mode
  vfio: Rename and remove compat from noiommu set function
  iommu: Enable cdev noiommu mode under iommufd
  iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query PA from IOVA

 drivers/iommu/Kconfig                        |  25 +++
 drivers/iommu/Makefile                       |   1 +
 drivers/iommu/generic_pt/fmt/Makefile        |   1 +
 drivers/iommu/generic_pt/fmt/iommu_noiommu.c |  10 +
 drivers/iommu/iommu.c                        |  12 +-
 drivers/iommu/iommufd/hw_pagetable.c         |   8 +
 drivers/iommu/iommufd/io_pagetable.c         |  44 ++++
 drivers/iommu/iommufd/ioas.c                 |  24 +++
 drivers/iommu/iommufd/iommufd_private.h      |   3 +
 drivers/iommu/iommufd/main.c                 |   3 +
 drivers/iommu/iommufd/vfio_compat.c          |   6 +-
 drivers/iommu/noiommu.c                      | 204 +++++++++++++++++++
 drivers/vfio/Kconfig                         |   3 +-
 drivers/vfio/device_cdev.c                   |   6 +
 drivers/vfio/group.c                         |   2 +-
 drivers/vfio/vfio.h                          |  38 +++-
 drivers/vfio/vfio_main.c                     |  20 +-
 include/linux/generic_pt/iommu.h             |   5 +
 include/linux/iommu.h                        |   1 +
 include/linux/iommufd.h                      |   4 +-
 include/linux/vfio.h                         |   2 +
 include/uapi/linux/iommufd.h                 |  25 +++
 22 files changed, 431 insertions(+), 16 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_noiommu.c
 create mode 100644 drivers/iommu/noiommu.c

-- 
2.34.1

