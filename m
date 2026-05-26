Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFA364942
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809563; cv=none; b=rrhK5hE5DZh/xoi71Va0E5CMJte/8IrDGaPQjMBYqU7cv02jyUO0mfl1T/RdRhWFNl6DN+ir+RXmjDQnQ42Llm2SpdYkT+Sx65G4Jv/ImcagT9dWZyRokskMA7PcmzehpmojBE/7y2EPft+lNMNt6AXDS3I+VpJ/0O15dbA/Cyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809563; c=relaxed/simple;
	bh=6Smg0+H001X4vpfcregQqRYkuGL6BlqFqwfdc8V5ATA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvlz6dEoyJt97amhsjYmhg6mmibt9e+BHzx0nX2xt/2dyUvHM+XJD79prtOKAqzjshqHwdAKaVZ5CC+9iWGd9nEpEABwHCCOwhBdiFTuR0iR0auTyWnWT/9zal/yohJk/BzAQddkPTQo7Y9pof1hCq5vruM7QHtklFyZitC6TdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dwuP54HW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dwuP54HW"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 955DA20B7167;
	Tue, 26 May 2026 08:32:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 955DA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779809550;
	bh=yA1277Aom5IgUUdoO1QcFFxCDVopNuaso7fvmwQT7vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwuP54HW4IGSI9FjGUMkm6jnG/s4nq7v3jwAMlL6JcC//Z2/Ehevsh3MGqeCYZsIN
	 T3JTcGvdNzpchSFXYWX9VonwNLtb32B+2+ManDuWN7skLNAHIZtXzeXN02+Vd0pPl/
	 1POMAXIxvyBQPOLERc5oxmM2XfQKtPInJYsOyFuU=
Date: Tue, 26 May 2026 08:32:37 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v6 0/7] iommufd: Enable noiommu mode for cdev
Message-ID: <20260526083237.00006a6c@linux.microsoft.com>
In-Reply-To: <BL1PR11MB52717A74E37BDED067EA45018C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52717A74E37BDED067EA45018C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Mon, 25 May 2026 08:30:12 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> Could you address the findings from Sashiko?
> 
> https://sashiko.dev/#/patchset/20260521221155.1375144-1-jacob.pan%40linux.microsoft.com
> 
I have go over my Sashiko review setup, but there are lots of
false positives, like this one below we already discussed in earlier
version. Is there a specific concern?

e.g.
> +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> +{
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> !idev->dev->iommu; +}
Does dynamically evaluating dev->iommu here allow the noiommu state to
flip during the device's lifetime?


> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Friday, May 22, 2026 6:12 AM
> > 
> > VFIO's unsafe_noiommu_mode has long provided a way for userspace
> > drivers
> > to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD
> > also supports No-IOMMU mode for group-based devices under
> > vfio_compat mode.
> > However, IOMMUFD's native character device (cdev) does not yet
> > support No-IOMMU mode, which is the purpose of this patch.
> > 
> > In summary, we have:
> > 
> > |-------------------------+------+---------------|
> > | Device access mode      | VFIO | IOMMUFD       |
> > |-------------------------+------+---------------|
> > | group /dev/vfio/$GROUP  | Yes  | Yes           |
> > |-------------------------+------+---------------|
> > | cdev /dev/vfio/devices/ | No   | This patch    |
> > |-------------------------+------+---------------|
> > 
> > Beyond enabling cdev for IOMMUFD, this patch also addresses the
> > following deficiencies in the current No-IOMMU mode suggested by
> > Jason[1]:
> > - Devices operating under No-IOMMU mode are limited to device-level
> > UAPI access, without container or IOAS-level capabilities.
> > Consequently, user-space drivers lack structured mechanisms for
> > page pinning and often resort to mlock(), which is less robust than
> > pin_user_pages() used for devices backed by a physical IOMMU. For
> > example, mlock() does not prevent
> >   page migration.
> > - There is no architectural mechanism for obtaining physical
> > addresses for DMA. As a workaround, user-space drivers frequently
> > rely on /proc/pagemap
> >   tricks or hardcoded values.
> > 
> > By allowing noiommu device access to IOMMUFD IOAS and HWPT objects,
> > this
> > patch brings No-IOMMU mode closer to full citizenship within the
> > IOMMU subsystem. In addition to addressing the two deficiencies
> > mentioned above, the expectation is that it will also enable
> > No-IOMMU devices to seamlessly participate in live update sessions
> > via KHO [2].
> > 
> > Furthermore, these devices will use the IOMMUFD-based ownership
> > checking model for
> > VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an
> > iommufd_access object
> > as required in a previous attempt [3].
> > 
> > ChangeLog:
> > V6:
> >   - Delete rename VFIO_IOMMU patch
> >   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and
> > group. Use Kconfig dependency to restrict usages and avoid null
> > group checks. (Alex & Yi)
> >   - Add CAP_SYS_RAWIO checks for cdev open to maintain security
> > parity with the group noiommu path. (Alex)
> >   - Updated documentation with Kconfig usage matrix
> >   - Added max length limit to get_pa ioctl (Baolu & Jason)
> > V5:
> >   - Split CONFIG_VFIO_NOIOMMU into CONFIG_VFIO_GROUP_NOIOMMU
> > and
> >     CONFIG_VFIO_CDEV_NOIOMMU so cdev noiommu is independent of
> >     VFIO_GROUP (Alex)
> >   - Add CAP_SYS_RAWIO check for cdev open and bind under noiommu,
> >     security parity with group noiommu (Alex)
> >   - Add IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) guard in
> >     iommufd_device_is_noiommu() to prevent noiommu bind when feature
> >     is disabled
> >   - Add prep patch to tolerate NULL group for cdev noiommu devices
> >     when CONFIG_VFIO_GROUP_NOIOMMU is not set [7/9]
> >   - Rename IOCTL to IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA to be more
> >     specific (Kevin)
> >   - Simplify iommufd_device_is_noiommu, use iommufd_bind_noiommu
> >     helper (Kevin, Yi)
> >   - Move IOMMU cap check under iommufd_bind_iommu() (Yi)
> >   - Fix next_iova exceeding iopt_area_last_iova in GET_PA (Alex)
> >   - Fix const hwpt, copyright date, typo in moved comment (Kevin)
> >   - Add Reviewed-by tags
> >   - Squash noiommu cdev selftest fix into selftest patch
> >   - Drop DSA selftest patch
> >   - Details in each patch changelog.
> > 
> > V4:
> >   - Fix various corner cases pointed out by (Sashiko)
> >     Details in each patch changelog.
> > 
> > V3:
> >   - Improve error handling [3/10] (Mostafa)
> >   - Simplify vfio_device_is_noiommu logic and merged in [6/10]
> > (Mostafa)
> >   - Add comment to explain the design difference over the legacy
> > noiommu VFIO code.[1/10]
> > 
> > V2:
> >   - Fix build dependency by adding IOMMU_SUPPORT in [8/11]
> >   - Add an optimization to scan beyond the first page for a
> > contiguous physical address range and return its length instead of
> > a single page.[4/11]
> > 
> > Since RFC[4]:
> >   - Abandoned dummy iommu driver approach as patch 1-3 absorbed the
> >     changes into iommufd.
> > 
> > [1] https://lore.kernel.org/linux-
> > iommu/20250603175403.GA407344@nvidia.com/
> > [2] https://lore.kernel.org/linux-
> > pci/20251027134430.00007e46@linux.microsoft.com/
> > [3] https://lore.kernel.org/kvm/20230522115751.326947-1-
> > yi.l.liu@intel.com/
> > [4] https://lore.kernel.org/linux-iommu/20251201173012.18371-1-
> > jacob.pan@linux.microsoft.com/
> > 
> > Future cleanup: consolidate all CONFIG_IOMMUFD_NOIOMMU code
> > (iopt_get_phys, iommufd_ioas_noiommu_get_pa, iommufd_noiommu_ops)
> > into
> > hwpt_noiommu.c to eliminate #ifdef guards from ioas.c and
> > io_pagetable.c.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > 
> > 
> > Jacob Pan (4):
> >   iommufd: Add an ioctl to query PA from IOVA for noiommu mode
> >   vfio: Enable cdev noiommu mode under iommufd
> >   selftests/vfio: Add iommufd noiommu mode selftest for cdev
> >   Documentation: Update VFIO NOIOMMU mode
> > 
> > Jason Gunthorpe (3):
> >   iommufd: Support a HWPT without an iommu driver for noiommu
> >   iommufd: Move igroup allocation to a function
> >   iommufd: Allow binding to a noiommu device
> > 
> >  Documentation/driver-api/vfio.rst             |  83 ++-
> >  drivers/iommu/iommufd/Kconfig                 |  12 +
> >  drivers/iommu/iommufd/Makefile                |   1 +
> >  drivers/iommu/iommufd/device.c                | 192 +++--
> >  drivers/iommu/iommufd/hw_pagetable.c          |  15 +-
> >  drivers/iommu/iommufd/hwpt_noiommu.c          |  97 +++
> >  drivers/iommu/iommufd/io_pagetable.c          |  72 ++
> >  drivers/iommu/iommufd/ioas.c                  |  30 +
> >  drivers/iommu/iommufd/iommufd_private.h       |  20 +
> >  drivers/iommu/iommufd/main.c                  |   3 +
> >  drivers/vfio/Kconfig                          |   8 +-
> >  drivers/vfio/device_cdev.c                    |   3 +
> >  drivers/vfio/iommufd.c                        |   6 +-
> >  drivers/vfio/vfio.h                           |  20 +-
> >  drivers/vfio/vfio_main.c                      |  23 +-
> >  include/linux/vfio.h                          |   1 +
> >  include/uapi/linux/iommufd.h                  |  27 +
> >  tools/testing/selftests/vfio/Makefile         |   1 +
> >  .../lib/include/libvfio/vfio_pci_device.h     |  16 +
> >  .../selftests/vfio/lib/vfio_pci_device.c      |   5 +-
> >  .../vfio/vfio_iommufd_noiommu_test.c          | 664
> > ++++++++++++++++++ 21 files changed, 1221 insertions(+), 78
> > deletions(-) create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> >  create mode 100644
> > tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c
> > 
> > --
> > 2.43.0  

