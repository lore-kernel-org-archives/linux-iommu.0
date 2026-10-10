Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF03D2FFC;
	Sat, 10 Oct 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617122; cv=none; b=rCwYTtHAw4jLabn6ZazTQodAnZugNNFzyhZEJjHt95Eo1yqX3kMxB+Q4zzga++12zlV8z79zhcH8P3yOmgLXytY8QdLV+0w503FIpEmcxNIV9Q4Tpbw9/bw0/WV+e5n/Vm2bWJKrgkFurY3uzyaqJT36EMSicVrmBrq95JBloi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617122; c=relaxed/simple;
	bh=liDgz4q1hO+XrTD5W6oZSJ5ZWPIvvAYajrBlzlN0ODg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT03mcRnyopIakM5SpKED0c+f0s0LxLAU5VyStgs0jl10EjSlOwE7ETC2nfDa3GikAVWhqBKV41deYvohO+aiRPX5cPoucst6jV5BI/3fN/NI8bVsf+XJg26P3IN07g+7nXtsZGl+bzvN5KPleKLizdfzzRAt2tQp7G2KEdog0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en5tO9pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en5tO9pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A51F000FF;
	Sat, 10 Oct 2026 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617120;
	bh=eVXi7g8HKOVzMCfl5QEZOyLNYidl4HZBIIBs5FYyxJg=;
	h=From:To:Cc:Subject:Date;
	b=en5tO9pfgaVVYvThk6DVmrg9dtMsYd1HYaUxIdEh+GSUVq81g2FyTK5RLC7eU7cRl
	 KWZkg+esMR9UtsEMJ5kuDvIqRC59zDdVbGP0KWTUk7o3zjk10xV+NMLC0Tsr8wvIUJ
	 gfl57eBR9XZnu8rFmC9bydY8slVTK41HZtJZr1JWIf4Fepax0rr+N+Xs1koLnUocyG
	 UBgW573q6R7r/rHZHlGZIaTR6Nnb9RMp8hFngZmPR+tmz3bgAWYZUklAti70wX470t
	 HtNIBtDgdB6gzPZeqLRvUw1dM8OmYcCdXVhy7su57LBqZoD5XddwRTsOlcA1et2JIZ
	 IO0cM07Q9dW9Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Fred Griffoul <griffoul@gmail.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device MMIO resources
Date: Sat, 10 Oct 2026 12:54:58 +0530
Message-ID: <20261010072504.536230-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a guest_memfd device-resource framework for exposing PCI
BAR memory to guests. The intended use is confidential device assignment,
where KVM needs to coordinate private device mappings with shared access
through VFIO. The Arm CCA backend is provided separately; these patches
contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.

The guest_memfd framework and Arm CCA backend are available together at:

  https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-da-gmem-backend

Userspace creates a device-backed guest_memfd using the ordinary VFIO
device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE,
GUEST_MEMFD_FLAG_DEVICE and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
intervals are registered as guest_memfd memslots. File offsets use the
existing VFIO region-offset namespace, allowing one guest_memfd to cover
multiple BAR intervals. Device-backed guest_memfd rejects mmap and
fallocate; shared guest faults obtain bare BAR PFNs from the provider
instead of resolving the memslot HVA or allocating folios.

IOMMUFD resolves and pins the device's existing vDEVICE for the VM and
serializes MMIO conversion through its MMIO mutex. VFIO supplies BAR PFNs,
checks eligible ranges and excludes independent dma-buf exports while a
guest_memfd provider is attached. VFIO host mmap faults, read/write and
ioeventfd accesses check the requested range's guest_memfd attributes.
Conversion revokes cached host mappings and shared guest mappings before
installing private mappings. Other shared intervals remain accessible.

This series depends on:
* Ackerley Tng's "Allow guest_memfd to be created using a resource (pool)
  fd" RFC, which provides the tmpfs resource-provider API:
  https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
* The IOMMUFD/TSM series, which provides the vIOMMU and vDEVICE interfaces:
  https://lore.kernel.org/all/20261008055955.4014342-1-aneesh.kumar@kernel.org/

Notes:
* While developing this framework, I looked at David Woodhouse's
  guest_memfd provider work, including the gmem-provider-v3 branch. It
  was used for comparison and was not merged. The posted RFC v2 is here:
  https://lore.kernel.org/all/20260720111259.122911-1-dwmw2@infradead.org/
* Codex assisted with implementation, review and series organization.

Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Fred Griffoul <griffoul@gmail.com> 
Cc: iommu@lists.linux.dev
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Aneesh Kumar K.V (Arm) (6):
  KVM: guest_memfd: attach and bind device resources
  KVM: guest_memfd: Support private/shared conversion of device memory
  iommufd: Support MMIO provider attachment to vDEVICEs
  vfio/pci: Provide guest_memfd backing for PCI BARs
  KVM/VFIO: Remove device mappings during guest_memfd teardown
  KVM: Invalidate guest_memfd mappings before removing memslot bindings

 Documentation/virt/kvm/api.rst          |   4 +
 drivers/iommu/iommufd/viommu.c          |  90 ++++
 drivers/vfio/device_cdev.c              |   3 +-
 drivers/vfio/group.c                    |   4 +-
 drivers/vfio/pci/Kconfig                |  11 +
 drivers/vfio/pci/Makefile               |   2 +
 drivers/vfio/pci/vfio_pci.c             |   3 +
 drivers/vfio/pci/vfio_pci_core.c        |  13 +
 drivers/vfio/pci/vfio_pci_dmabuf.c      |  10 +
 drivers/vfio/pci/vfio_pci_gmem.c        | 349 +++++++++++++++
 drivers/vfio/pci/vfio_pci_gmem.h        |  36 ++
 drivers/vfio/pci/vfio_pci_gmem_access.c | 138 ++++++
 drivers/vfio/pci/vfio_pci_rdwr.c        |  13 +-
 drivers/vfio/vfio.h                     |   8 +
 drivers/vfio/vfio_main.c                |  34 +-
 include/linux/guest_memfd.h             |  50 +++
 include/linux/iommufd.h                 |  33 ++
 include/linux/kvm_host.h                |  14 +-
 include/linux/vfio.h                    |   3 +
 include/linux/vfio_pci_core.h           |  23 +
 include/uapi/linux/kvm.h                |   1 +
 virt/kvm/guest_memfd.c                  | 545 +++++++++++++++++++++++-
 virt/kvm/guest_memfd.h                  |   6 +
 virt/kvm/kvm_main.c                     |   4 +
 24 files changed, 1362 insertions(+), 35 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem.c
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem.h
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem_access.c

-- 
2.43.0

