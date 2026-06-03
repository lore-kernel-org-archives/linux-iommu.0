Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A939E18E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465484; cv=none; b=T1qD15gQaGSbbEIYeDsDso2BxYk32RK/VhgLV43vB2UYca4tuVjjB7HXumadxPRlZUS0PxY3smvSqRTNvmbHCjvO3ZZn4vMy7JcJm1QflRxWaJa6twOxWKP7NhvyQFGffEC/r8ADfoXhVSu+gjMkuuk6ijcrimWm6WO2/kpKbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465484; c=relaxed/simple;
	bh=t6eo8TwuB283GmkmRPiDJ6NSiS5Beyk944tJHV9KC7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/14s5d6MNbgF0MMpkrPvaUWGSd2NBR/8O5IBA7E0gglYol46A0Q4pezTeuHajnwLNMliR1Z5MMNuycjns+ArK1M+nmtY7pujskecTQQ9ZRrqq4WILwi8L9Y9OZ79FSq9cG8t+kC6SMdYTSjiyZ6U3RXgt6eGNe8kP/52kXLNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BeT4MzZK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BeT4MzZK"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0E9D520B7167;
	Tue,  2 Jun 2026 22:44:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E9D520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780465465;
	bh=jQ9a/x1wl9L8iFNldrwfJxXeb2t5IYLItBpRwSEnCkY=;
	h=From:To:Cc:Subject:Date:From;
	b=BeT4MzZKDazFjcySvm8wZBzp3pFH0a6mGrbqPxP4lLG5bKdZw08HYc89fzsCk98cP
	 BzFxWDnDYRhz5f6xMguw73wv3M3tIF40jHSX6gS0KTphuryJSUX0ehcucf6uA9Pvuo
	 qv4yWtWexxHhbPbvvwqs+OdkFJY8379KCCNxX1h8=
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
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH v7 0/6] iommufd: Enable noiommu mode for cdev
Date: Tue,  2 Jun 2026 22:44:32 -0700
Message-ID: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

ChangeLog (details in each patch):

v7: 
  - Handle Sashiko reviews.
  - Dropped selftest for now, will submit separately for v7.2 to use
    new lib helpers
v6: Undo CDEV-GROUP NOIOMMU split, use Kconfig to restrict unwanted
    combo.
V5:
  - Split CONFIG_VFIO_NOIOMMU into CONFIG_VFIO_GROUP_NOIOMMU and
    CONFIG_VFIO_CDEV_NOIOMMU so cdev noiommu is independent of
    VFIO_GROUP (Alex)
  - Add CAP_SYS_RAWIO check for cdev open and bind under noiommu,
    security parity with group noiommu (Alex)
  - Add IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) guard in
    iommufd_device_is_noiommu() to prevent noiommu bind when feature
    is disabled
  - Add prep patch to tolerate NULL group for cdev noiommu devices
    when CONFIG_VFIO_GROUP_NOIOMMU is not set [7/9]
  - Rename IOCTL to IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA to be more
    specific (Kevin)
  - Simplify iommufd_device_is_noiommu, use iommufd_bind_noiommu
    helper (Kevin, Yi)
  - Move IOMMU cap check under iommufd_bind_iommu() (Yi)
  - Fix next_iova exceeding iopt_area_last_iova in GET_PA (Alex)
  - Fix const hwpt, copyright date, typo in moved comment (Kevin)
  - Add Reviewed-by tags
  - Squash noiommu cdev selftest fix into selftest patch
  - Drop DSA selftest patch
  - Details in each patch changelog.

V4:
  - Fix various corner cases pointed out by (Sashiko)
    Details in each patch changelog.

V3:
  - Improve error handling [3/10] (Mostafa)
  - Simplify vfio_device_is_noiommu logic and merged in [6/10] (Mostafa)
  - Add comment to explain the design difference over the legacy noiommu
    VFIO code.[1/10]

V2:
  - Fix build dependency by adding IOMMU_SUPPORT in [8/11]
  - Add an optimization to scan beyond the first page for a contiguous
    physical address range and return its length instead of a single
    page.[4/11]

Since RFC[4]:
  - Abandoned dummy iommu driver approach as patch 1-3 absorbed the
    changes into iommufd.

[1] https://lore.kernel.org/linux-iommu/20250603175403.GA407344@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20251027134430.00007e46@linux.microsoft.com/
[3] https://lore.kernel.org/kvm/20230522115751.326947-1-yi.l.liu@intel.com/
[4] https://lore.kernel.org/linux-iommu/20251201173012.18371-1-jacob.pan@linux.microsoft.com/

Future cleanup: consolidate all CONFIG_IOMMUFD_NOIOMMU code
(iopt_get_phys, iommufd_ioas_noiommu_get_pa, iommufd_noiommu_ops) into
hwpt_noiommu.c to eliminate #ifdef guards from ioas.c and io_pagetable.c.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>


Jacob Pan (3):
  iommufd: Add an ioctl to query PA from IOVA for noiommu mode
  vfio: Enable cdev noiommu mode under iommufd
  Documentation: Update VFIO NOIOMMU mode

Jason Gunthorpe (3):
  iommufd: Support a HWPT without an iommu driver for noiommu
  iommufd: Move igroup allocation to a function
  iommufd: Allow binding to a noiommu device

 Documentation/driver-api/vfio.rst       |  83 +++++++++-
 drivers/iommu/iommufd/Kconfig           |  12 ++
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          | 197 +++++++++++++++++-------
 drivers/iommu/iommufd/hw_pagetable.c    |  15 +-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 105 +++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |  80 ++++++++++
 drivers/iommu/iommufd/ioas.c            |  33 ++++
 drivers/iommu/iommufd/iommufd_private.h |  20 +++
 drivers/iommu/iommufd/main.c            |   4 +
 drivers/vfio/Kconfig                    |   7 +-
 drivers/vfio/device_cdev.c              |   3 +
 drivers/vfio/iommufd.c                  |  12 +-
 drivers/vfio/vfio.h                     |  23 ++-
 drivers/vfio/vfio_main.c                |  26 +++-
 include/linux/vfio.h                    |   1 +
 include/uapi/linux/iommufd.h            |  27 ++++
 17 files changed, 568 insertions(+), 81 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c

-- 
2.43.0

