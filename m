Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190FA30F95C
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156593; cv=none; b=A+jn8suk7bxRFB4thTI17UDjHJHWeylJa+/KYdDB1uI2XQPNXJE3CVq/1fpChITFzA5o/Niufc3VOeeH49acWuDMK9qCZGkfdHTadAkaUTNp0Bq+IvR0HKp4AvWP+XfpiuKQH5xtrcj/1fRTDIKM5niZxB0wRFZvHnWNgDybX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156593; c=relaxed/simple;
	bh=++pOXY7jKvruZEFWEcAkOOnM7B77EUJ5Be21PQUqBGI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lXgvhmCdHcsVROqmhYW6fNWcoyq7BiQhT1kScagbebuYWxrP91qYT28BL3byOopejoifSkvlds0J1h4ItL9qJJq1IbHsBOgNpkB505flutOuQkCnV6eJTpWG2C578JL8UsQdfaax0uM8RKXULC99J1lmy26Wh9XuekdbVRe71VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vo73kriv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vo73kriv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso12741818a12.3
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156590; x=1770761390; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpRJJ9G8q3T44zX9+oPHRq/pJ0xN8Ws+kTYVqjDiXOU=;
        b=Vo73kriv/NlAbv4DS+3T1MphP6bSALxd+8zgJ2sTVWvJlL24tdhFERAEi2oHcbPk2R
         I/hTw4B8zFitvYOZENiGSuHv+iG8uevPvhNEgbxmtw7n6tjP48AseFZg4QXCKPdlqEuF
         Ukuemmgm1q6pNT1iaMfTQ6BuDVOitDnjqVM1zbb1J2IFB3ujhoAG7h3hJU/G2nH4uJrI
         HDfmlucRF6fz8q3D5G4N+ar74/AGxDvr6YwMalC5SkSaSsvo3qTTA67N5da+T0v2r4tR
         zrn3OL9KxKkSB523p4MvJr3w7Rfm8TP1Oorar0AFOolnX63rcmhnloYhwp/KBhIVxzsF
         AcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156590; x=1770761390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpRJJ9G8q3T44zX9+oPHRq/pJ0xN8Ws+kTYVqjDiXOU=;
        b=DwxI6ZH57PrRE1Vd8yex33b9FhkbMQoHR1sQmkcDjWenpk6E1JuzJgmkrdIhd8OkMM
         9kWuRWWP0EYDbYjWL40NYhLzCFXIBDM/pJJdvPH/fhsJrJTJz+Tp8FzI3kpcQO5I0XYH
         KWZ3MY/QzHYcKbjluAgFaerG5xtxFbu+PJzVoXV8YPhlzvHczE0NWZauZAqO1diZqHjB
         UYXvma6LaZELGoTrmFdrjII7DTTYA9alt9IWA6/SZx1KTOhLUqNIrdNl7yVaEzXgxn+e
         NlT9Mly3DeIDkaWbsrSWp4Yt9WcvN19EKZf9VcmNy8LoyprgGIF3wg4iB8KeSn+B0OuH
         owxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVu52Ocza8cXkZIfFGfz2PO6L/kdxTbj8/8gvwgb2V5HiEmJMOGcf15gdUcPVjus4T8gmeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMjSHfkfj1JF5RtDr3MKki6uYvk5Vi8iCNAzBYPGLt8gbDDpZQ
	QPh4vTKXomO7RBWKI7+ops2UxXdOhrBFO1NqcDiKLjuKs5It5cs0L1o770Du2AkkMqxibutEqMz
	FNp5zpw1gs9gnyQ==
X-Received: from pfbds4.prod.google.com ([2002:a05:6a00:4ac4:b0:824:1bc7:4d11])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:32cf:b0:823:1c5f:1c43 with SMTP id d2e1a72fcca58-8241c5f5e6amr800774b3a.36.1770156590345;
 Tue, 03 Feb 2026 14:09:50 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-1-skhawaja@google.com>
Subject: [PATCH 00/14] iommu: Add live update state preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This patch series introduces a mechanism for IOMMU state preservation
across live update, including the Intel VT-d driver support
implementation.

This is a non-RFC version of the previously sent RFC:
https://lore.kernel.org/all/20251202230303.1017519-1-skhawaja@google.com/

Please take a look at the following LWN article to learn about KHO and
Live Update Orchestrator:

https://lwn.net/Articles/1033364/

This work is based on,

- linux-next (tag: next-20260115)
- MEMFD SEAL preservation series:
  https://lore.kernel.org/all/20260123095854.535058-1-pratyush@kernel.org/
- VFIO CDEV preservation series (v2):
  https://lore.kernel.org/all/20260129212510.967611-1-dmatlack@google.com/

The kernel tree with all dependencies is uploaded to the following
Github location:

https://github.com/samikhawaja/linux/tree/iommu/phase1-v1

Overall Goals:

The goal of this effort is to preserve the IOMMU domains, managed by
iommufd, attached to devices preserved through VFIO cdev. This allows
DMA mappings and IOMMU context of a device assigned to a VM to be
maintained across a kexec live update.

This is achieved by preserving IOMMU page tables using Generic Page
Table support, IOMMU root table and the relevant context entries across
live update.

The functionality in the previously sent RFC is split into two phases
and this series implements the Phase 1. Phase 1 implements the following
functionality:

  - Foundational work in IOMMU core and VT-d driver to preserve and
    restore IOMMU translation units, IOMMU domains and devices across
    liveupdate kexec.
  - The preservation is triggered by preserving vfio cdev FD and bound
    iommufd FD into a live update session.
  - An HWPT (and backing IOMMU domain) is only preserved if it contains
    only file type DMA mappings. Also the memfd being used for such
    mapping should be SEAL SEAL'd during mapping.
  - During live update boot, the state of preserved Intel VT-d, IOMMU
    domain and devices is restored.
  - The restored IOMMU domains are reattached to the preserved devices
    during early boot.
  - The DMA ownership of restored devices is also claimed during
    live update boot. This means that any attempt to bind a non-vfio
    drivers with them or binding a new iommufd with them will fail.

Architectural Overview:

The target architecture for IOMMU state preservation across a live
update involves coordination between the Live Update Orchestrator,
iommufd, and the IOMMU drivers.

The core design uses the Live Update Orchestrator's file descriptor
preservation mechanism to preserve iommufd file descriptors. The user
marks the iommufd HWPTs for preservation using a new ioctl added in this
series. Once done, the preservation of iommufd inside an LUO session is
triggered using LUO ioctls. During preservation, the LUO preserve
callback for an iommufd walks through the HWPTs it manages to identify
the ones that need to be preserved. Once identified, a new IOMMU core
API is used to preserve the iommu domain. The IOMMU core uses Generic
Page Table to preserve the page tables of these domains. The domains are
then marked as preserved.

When the user triggers the preservation of a VFIO cdev that is attached
to an iommufd that is preserved, the device attachment state of that
VFIO cdev is also preserved using an API exported by iommufd. IOMMUFD
fetches all the information that needs to be preserved and calls the
IOMMU core API to preserve the device state. The IOMMU core also
preserves state of IOMMU that is associated with this device.

The IOMMU core has LUO FLB registered with the iommufd LUO file handler
so the preserved iommu domain and iommu hardware unit state is available
during boot for early restore in the next kernel.

During boot the driver fetches the preserved state from the IOMMU core
and restores the state of preserved IOMMUs. Later when IOMMU core goes
through the devices and probes them, the iommu domains of preserved
devices are restored and the preserved devices are attached to them.
During attachment, the DMA ownership of these devices is also claimed.

Tested:

The new iommufd_liveupdate selftest was used to verify the preservation
logic. It was tested using QEMU with virtual IOMMU (VT-d) support with
virtio pcie device bound to the vfio-pci driver.

Also Tested on an Intel machine with DSA device bound to vfio-pci driver.

Following steps were followed for verification,

- Bind the test device with vfio-pci driver
- Run test on the machine by running

  ./iommufd_liveupdate <vfio-cdev-path>

- Trigger Kexec.
- After reboot, try binding the device to a non-vfio pci driver,

  echo <device bdf> > /sys/class/bus/drivers/pci-pf-stub/bind

- This should fail with "Device or resource busy".
- Bind the device with vfio-pci driver and run the test again.
- Test verifies that the device cannot be bound with a new iommufd and
  the session cannot be finished.

Future Work:

- Phase 2 with IOMMUFD restore to reclaim the preserved vfio cdev and
  restore the preserved HWPTs.
- Full support for PASID preservation.
- Nested IOMMU preservation.
- Extend support to other IOMMU architectures (e.g., AMD-Vi, Arm SMMUv3).

High-Level Sequence Flow:

The following diagrams illustrate the high-level interactions during the
preservation phase. Note that function names in the diagram are kept
abbreviated to save horizontal space.

Prepare:

Before live update the PREPARE event of Liveupdate Orchestrator invokes
callbacks of the registered file and subsystem handlers.

 Userspace (VMM) | LUO Core |    iommufd    |  IOMMU Core   | IOMMU Driver
-----------------|----------|---------------|---------------|-------------
                 |          |               |               |
MARK_HWPT        |          |               |               |
--------------------------->                |               |
                 |          | Mark HWPT for |               |
                 |          | preservation  |               |
                 |          |               |               |
PRESERVE         |          |               |               |
 iommufd_fd      |          |               |               |
----------------->          |               |               |
                 | preserve |               |               |
                 |---------->               |               |
                 |          | For each HWPT |               |
                 |          |-------------->                |
                 |          |               | domain_presrv |
                 |          |               |-------------->
                 |          |               |               | gpt(preserve)
                 |          |               |<--------------|
                 |          |<--------------|               |
                 |<---------|               |               |
                 |          |               |               |
...              |          |               |               |
                 |          |               |               |
PRESERVE,        |          |               |               |
 vfio_cdev_fd    |          |               |               |
----------------->          |               |               |
                 | preserve |               |               |
                 |---------->               |               |
                 |          |               |               |
                 |          | iommu_preserv |               |
                 |          | _device()     |               |
                 |          |-------------->                |
                 |          |               | preserve      |
                 |          |               | (iommu_hw)    |
                 |          |               |-------------->
                 |          |               |               | preserve(root)
                 |          |               |               | preserve(pasid)
                 |          |               |<--------------|
                 |          |               |               |
                 |          |               | preserve      |
                 |          |               | _device(dev)  |
                 |          |               |-------------->
                 |          |               |               |
                 |          |               |<--------------|
                 |          |<--------------|               |
                 |<---------|               |               |

Restore:

After a live update, the preserved state is restored during boot.

 Userspace (VMM) | LUO Core |    iommufd    |  IOMMU Core   | IOMMU Driver
-----------------|----------|---------------|---------------|-------------
                 |          |               |               |
                 |          |               |               | Restore
                 |          |               |               | Root, DIDs
                 |          |               |               |
                 |          |               |               | Register
                 |          |               | probe devices |
                 |          |               |               |
                 |          |               | restore       |
                 |          |               | domain        |
                 |          |               |-------------->
                 |          |               |               | restore
                 |          |               | reattach      |
                 |          |               | domain        |
                 |          |               |-------------->
                 |          |               |               |


Looking forward to your feedback on this.

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

Samiullah Khawaja (11):
  iommu: Implement IOMMU LU FLB callbacks
  iommu: Implement IOMMU core liveupdate skeleton
  iommu/pages: Add APIs to preserve/unpreserve/restore iommu pages
  iommupt: Implement preserve/unpreserve/restore callbacks
  iommu/vt-d: Implement device and iommu preserve/unpreserve ops
  iommu/vt-d: Restore IOMMU state and reclaimed domain ids
  iommu: Restore and reattach preserved domains to devices
  iommu/vt-d: preserve PASID table of preserved device
  iommufd: Add APIs to preserve/unpreserve a vfio cdev
  vfio/pci: Preserve the iommufd state of the vfio cdev
  iommufd/selftest: Add test to verify iommufd preservation

YiFei Zhu (2):
  iommufd-lu: Implement ioctl to let userspace mark an HWPT to be
    preserved
  iommufd-lu: Persist iommu hardware pagetables for live update

 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/generic_pt/iommu_pt.h           |  96 ++++
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/iommu.c                   | 115 +++-
 drivers/iommu/intel/iommu.h                   |  42 +-
 drivers/iommu/intel/liveupdate.c              | 304 ++++++++++
 drivers/iommu/intel/nested.c                  |   2 +-
 drivers/iommu/intel/pasid.c                   |   7 +-
 drivers/iommu/intel/pasid.h                   |   9 +
 drivers/iommu/iommu-pages.c                   |  74 +++
 drivers/iommu/iommu-pages.h                   |  30 +
 drivers/iommu/iommu.c                         |  50 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  69 +++
 drivers/iommu/iommufd/io_pagetable.c          |  17 +
 drivers/iommu/iommufd/io_pagetable.h          |   1 +
 drivers/iommu/iommufd/iommufd_private.h       |  38 ++
 drivers/iommu/iommufd/liveupdate.c            | 349 ++++++++++++
 drivers/iommu/iommufd/main.c                  |  16 +-
 drivers/iommu/iommufd/pages.c                 |   8 +
 drivers/iommu/liveupdate.c                    | 534 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c        |  28 +-
 include/linux/generic_pt/iommu.h              |  10 +
 include/linux/iommu-lu.h                      | 144 +++++
 include/linux/iommu.h                         |  32 ++
 include/linux/iommufd.h                       |  23 +
 include/linux/kho/abi/iommu.h                 | 127 +++++
 include/linux/kho/abi/iommufd.h               |  39 ++
 include/linux/kho/abi/vfio_pci.h              |  10 +
 include/linux/liveupdate.h                    |  21 +
 include/uapi/linux/iommufd.h                  |  19 +
 kernel/liveupdate/luo_file.c                  |  71 +++
 kernel/liveupdate/luo_internal.h              |  16 +
 tools/testing/selftests/iommu/Makefile        |  12 +
 .../selftests/iommu/iommufd_liveupdate.c      | 209 +++++++
 36 files changed, 2502 insertions(+), 34 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c
 create mode 100644 drivers/iommu/iommufd/liveupdate.c
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-lu.h
 create mode 100644 include/linux/kho/abi/iommu.h
 create mode 100644 include/linux/kho/abi/iommufd.h
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c


base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
-- 
2.53.0.rc2.204.g2597b5adb4-goog

