Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6757D230;
	Thu, 17 Sep 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653753; cv=none; b=ayJ8Dx4hFNKKryN+f5f/FNTpdxJ88U2PUV/2Yli4oqen7YT7BXisbCR6LUCIiIXn6jGFr1P2eiLpmeoNsNeTbaFcbhRHp2B4bUrXT2qVgUwh/QN3LLqERE7WjnE0DrI64jCX7GmVlY1r0tkoxX8X4M6oy3kX+rNp8JjMdAXvRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653753; c=relaxed/simple;
	bh=UL2y8zOrLA4NiU4VIcQUTmVYr/Y/eUfnHg52b7dqraA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBdoJY4bsXZo2XS8Yx6FrU8DYCZ6Z+ZIMwCqOPmFFWIRM8S/ZoVmQFihOVVRRDWxP96dh412GVAxJo5qekCQQFE31THgAObozUOICve+h/0zUq1CC9YFXlXrYUf4HXxxiLKgqVX/Nd4NOVqWRzOPuy7A1q/JLzyxOcZdGWgkZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgRfl2k7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgRfl2k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF591F000FF;
	Thu, 17 Sep 2026 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653751;
	bh=LzKajrBn/qC8mgh1RH/uGLuNLuDzCmGSRhLwjf+Ueok=;
	h=From:To:Cc:Subject:Date;
	b=WgRfl2k7qtXCTWaiEs2GORh3UIHYae846WygWIEpP2Qk6WuoA4xOXCb/CEXjMwKMF
	 89DR4VlDKnRG9OzYg47Ir1zCSDss9G+/ITNRKe3WXP56LXtwCSw6qng9+ooE4S5iiL
	 bFD5XJUEbtrsObxAtWcwbnKaFT9NuAeoUd2wcx6oX74Byy30MhzSYdfHcDsCN5yWiJ
	 gKNSZM36ZZSASo1R39OZdlcIukVQdcyrwIgi/s/Kb0TCt9FYZFEU6USzj6QLDHVr5w
	 SFsuP/hyZnZU31n+M3SH0S0dJO/qGhLFR18wJPrQVFgDbSCaAtQyqpymiekBoRdEx2
	 ViZu+WIgsLygQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation for confidential guests and guest TSM requests
Date: Thu, 17 Sep 2026 19:31:48 +0530
Message-ID: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the IOMMUFD and PCI/TSM infrastructure required for device
assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and the
IOMMU_VDEVICE_TSM_REQ ioctl.

The series adds a vIOMMU provider abstraction that allows a subsystem
other than the physical IOMMU driver to implement a vIOMMU type. It groups
the vIOMMU operations with their module owner and private data, and makes
that implementation discoverable during vIOMMU allocation.

External providers are selected by exact vIOMMU type. When no provider
matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
provider matches, its result is authoritative and failures do not trigger
fallback.

Guest TSM requests are dispatched through the vdevice. PCI/TSM uses
reference-counted contexts to retain the resources needed by providers,
without introducing separate IOMMUFD TSM bind or unbind ioctls.

Note: Codex was used to assist with commit message formatting and code
rearrangement.

Changes from v5:
https://lore.kernel.org/all/20260525154816.1029642-1-aneesh.kumar@kernel.org
* Replace the TSM bind/unbind interface with reference-counted contexts.
* Add the IOMMUFD vIOMMU provider abstraction.
* Route TSM guest requests through viommu operations.

Changes from v4:
https://lore.kernel.org/all/20260427061005.901854-1-aneesh.kumar@kernel.org
* Switch VFIO/iommufd to use struct file *kvm_file instead of relying on
  kvm->users_count references.
* Define TSM request scope values globally in iommufd.
* Rename the ioctl to IOMMU_VDEVICE_TSM_REQ.
* Address other review feedback.

Changes from v2:
https://lore.kernel.org/all/20260309111704.2330479-1-aneesh.kumar@kernel.org
* Bump the series revision to v4 to keep it in sync with the dependent CCA DA
  patchsets. There was no v3 posting.
* Drop [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd with a
  vIOMMU
* Add two new patches to associate a struct kvm * with iommufd objects:
  iommufd/device: Associate a kvm pointer to iommufd_device
  iommufd/viommu: Associate a kvm pointer to iommufd_viommu
* Address review feedback

Changes from v1:
https://lore.kernel.org/all/20250728135216.48084-8-aneesh.kumar@kernel.org
* Rebase onto the latest kernel
* Address review feedback
* Drop the TSM map ioctl; the KVM prefault patch will be used instead to
  ensure that private memory is preallocated

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Aneesh Kumar K.V (Arm) (9):
  vfio: cache KVM VM file references instead of raw struct kvm pointers
  vfio: cdev: Reject duplicate bind before updating KVM file
  iommu: Add a helper to validate a vIOMMU parent
  iommu: Add a helper to query vIOMMU hardware parameters
  coco: tsm: Expose active-user lifetime references
  iommufd: Add vIOMMU provider support
  iommufd: Add the vdevice TSM request ioctl
  PCI/TSM: Remove the legacy guest request interface
  PCI/TSM: Add reference-counted contexts for vdevice providers

Nicolin Chen (1):
  iommufd/viommu: Keep a reference to the KVM file

Shameer Kolothum (1):
  iommufd/device: Associate KVM file pointer with iommufd_device

 Documentation/ABI/testing/sysfs-bus-pci |  29 ++-
 drivers/iommu/iommu.c                   |  22 ++
 drivers/iommu/iommufd/Makefile          |   5 +-
 drivers/iommu/iommufd/device.c          |   7 +-
 drivers/iommu/iommufd/iommufd_private.h |  32 +++
 drivers/iommu/iommufd/main.c            |   3 +
 drivers/iommu/iommufd/selftest.c        |   2 +-
 drivers/iommu/iommufd/tsm.c             |  98 ++++++++
 drivers/iommu/iommufd/viommu.c          |  36 ++-
 drivers/iommu/iommufd/viommu_provider.c | 160 ++++++++++++
 drivers/pci/tsm/core.c                  | 312 ++++++++++--------------
 drivers/s390/crypto/vfio_ap_ops.c       |   5 +-
 drivers/vfio/device_cdev.c              |  14 +-
 drivers/vfio/group.c                    |  14 +-
 drivers/vfio/iommufd.c                  |   3 +-
 drivers/vfio/pci/vfio_pci_zdev.c        |   7 +-
 drivers/vfio/vfio.h                     |  16 +-
 drivers/vfio/vfio_main.c                |  81 +++---
 drivers/virt/coco/tsm-core.c            |  55 ++++-
 include/linux/iommu.h                   |  15 ++
 include/linux/iommufd.h                 |  42 +++-
 include/linux/kvm_host.h                |   3 +
 include/linux/pci-tsm.h                 | 140 ++++-------
 include/linux/tsm.h                     |  38 +++
 include/linux/vfio.h                    |  17 +-
 include/uapi/linux/iommufd.h            |  73 ++++++
 samples/devsec/link_tsm.c               | 146 -----------
 tools/testing/devsec/devsec.sh          |  27 +-
 virt/kvm/kvm_main.c                     |   2 +
 29 files changed, 866 insertions(+), 538 deletions(-)
 create mode 100644 drivers/iommu/iommufd/tsm.c
 create mode 100644 drivers/iommu/iommufd/viommu_provider.c

-- 
2.43.0

