Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70C190462
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716587; cv=none; b=Q+BIYfNIcznbdYaY/rXITgRjF9XHRsqW6FZ8M1YO5F1U23l4+1KwcAeOUAJL4pheMs3tbnSAQ6f5k5VawHMinCcd/V9zN9X8Q3q0lYrFa+kozkMp1D36054pz3q9bbcJqsocjQEU1K1UdU8r/iLz1qxUfoAUdANgCCR7+52d+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716587; c=relaxed/simple;
	bh=9Gsv6oakUWVIyaD0ipG7SsZ8duV1yyO1pG8NESidX40=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KEB/Ya+ZjSZf1j4UMQMI/FFymFK0fm3B/drLV7HJprGU08hdthXkaPb9BDJOG5BX56irXPk5MrslqKUnKSFYNx5VE0LY501QUH3WFt4w95V4L2Hb/Qm2nc3k7vTRnEaLzYP7Q6leTp0ME5+VvocQsJw1NZfGoEZYUhy0+t576wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1n00LHEo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1n00LHEo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so7824173a12.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716585; x=1765321385; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9KUOgD4n38xlwmLnnaQRMn+qGCOFSQ93ow41X3xe4pU=;
        b=1n00LHEoFWkVzX6tdWfhzSIotIKT+cYRe65x+bAr6B7B4qadPi7nFOEEiqJnPnTR63
         0lcrH9OEc5vWnMZGTCujNk60EwPKorpQwm0bk4LRZU6lf64AwmdjK73XtaUP1EIn2Glv
         Q9s0qdA5eVWhHWWvUxM/W7XukJtUoyl0QGd4XY4kom8G3417zj8OE+br6gXCTUQetgUt
         5jfouXLBb+MfJblxVKw0pSo3bOwX6TJBquCXgb3f7CtepwiAdHTPPAfMsd8TA1X0o3Z1
         5EC9zmKDdHo1YRWNMLx+0uaht6iAz37HUYQbYSUByFSTH9VHZqiB2IfwPX9JT1JL2g1Z
         ohJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716585; x=1765321385;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KUOgD4n38xlwmLnnaQRMn+qGCOFSQ93ow41X3xe4pU=;
        b=D7g3oJ+qKNp8JEVTqS+EEVhM5G/RYQEUa+LYpRx0mTBkrGQwiySCHTXvaEqu8i3fQI
         3snBSeOLayEBCm48pa7WcWJhQRFNrB3/ILywhYlqk5oxcpKHFMnR+rIwvhc7jJwSPBg8
         QncYP73oZs/4n+9nymBq0F1JvwfhqGDUi828IQdSEPWxxgP+qhi0OcYQfryKVDXxZ2b/
         HE7lOERiTbV63PuPn6spH4AcInjm64l77rJ51pQKcEdviQ5nOc80c85pcwAnYdfdmtFN
         a0LkFXVCI1QbYf1qnWAj4yOFbEW2OSNphs8wyJ8RKOFgmvFZE/N49qOaFzSWGDo12rqT
         2WkA==
X-Forwarded-Encrypted: i=1; AJvYcCVxwtxH0/QPcN8E6ujZRXWK3IZPvjTFLV6+lQwCKARVxmDE5yHDKKiCkJbd6mR6pLP796sYpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxD6YTjhVSfaBF79KhX+MTefZUsC6VwY4wgH3LU1ftFK4hzZbQC
	Eg82v35TnJfAkT6kSlKpMLilBeyFET7GEAZ5n6z/52YHJBvL/mD947eF8qwE275OPJRvGnEtFw7
	BbUqPAdF3zNV3/Q==
X-Google-Smtp-Source: AGHT+IH7M3gnhr7XpldBdwjSyiIkr/vfyO3/RfYaMdhMRTjVRihE9olZyl3rCq2Fury6twe90Dm0apJXlyfYrg==
X-Received: from pfbga5.prod.google.com ([2002:a05:6a00:6205:b0:7ba:f1ee:f7a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9f:b0:35d:8881:e6ce with SMTP id adf61e73a8af0-363f5d738bamr484556637.26.1764716584850;
 Tue, 02 Dec 2025 15:03:04 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-1-skhawaja@google.com>
Subject: [RFC PATCH v2 00/32] Add live update state preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

This RFC patch series introduces a mechanism for IOMMU state
preservation across live update, using the Intel VT-d driver as the
initial example implementation and demonstration platform.

Please take a look at the following LWN article to learn about KHO and
Live Update Orchestrator:

https://lwn.net/Articles/1033364/

This work is based on the LUOv8 that is in linux-next. Please find the
details of various LUO sessions, file handlers and FLB preservation
callbacks, and memory preservation mechanisms in the LUOv8 series.

https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatashin@soleen.com/

This series also uses the VFIO cdev preservation support series v2 that
is sent out for review separately:

https://lore.kernel.org/all/20251126193608.2678510-1-dmatlack@google.com/

The kernel tree with all dependencies is uploaded to the following
Github location:

https://github.com/samikhawaja/linux/tree/iommu/rfc-v2

Overall Goals:

The goal of this effort is to preserve the IOMMU domains, managed by
iommufd, attached to preserved VFIO. This allows DMA mappings and IOMMU
context of a device assigned to a VM to be maintained across a live
update.

This is achieved by preserving IOMMU page tables using Generic Page
Table support, IOMMU root table and the relevant context entries across
live update.

Current Implementation, Scope and Limitations:

This RFC is using the newer LUO as compared to the previous version and
has major rework related to lifecycle management.

It includes preservation and restoration of the following states,

 - IOMMUFD and its HWPTs that are marked by user for preservation.
 - Iommu domain that is associated with the preserved HWPTs.
 - Iommu domain page tables associated with the iommu domain.
 - VFIO cdev preserved device context and domain IDs.
 - IOMMU translation units associated with the preserved devices.

It also includes a selftest to validate the end-to-end preservation and
restoration of an iommufd and vfio cdev file descriptor.

This version does not implement hotswap of the iommu domain in the IOMMU
driver. That will be done as a separate patch series.

The series also does not yet include a versioning scheme for the
persisted state; this will be added later. Currently the structs are
used and defined in include/linux/kho/abi/iommu.h and
include/linux/kho/abi/iommufd.h

Architectural Overview:

The target architecture for IOMMU state preservation across a live
update involves coordination between the Live Update Orchestrator,
iommufd, and the IOMMU drivers.

The core design uses the Live Update Orchestrator's file descriptor
preservation mechanism to preserve iommufd file descriptors. The user
marks the iommufd HWPTs for preservation using a new ioctl added in this
series. Once done, the preservation of iommufd inside an LUO sessions is
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
so the presered iommu domain and iommu hardware unit state is available
during boot for early restore in the next kernel.

During boot the driver fetches the preserved state from the IOMMU core
and restores the state of preserved IOMMUs. Later when IOMMU core goes
through the devices and probes them, the iommu domains of preserved
devices are restored and the preserved devices are attached to them.

Later during iommufd retrieval, the preserved HWPTs are restored and
associated with restored iommu domains. The preserved iommufd does not
finish (returns error from can_finish) until all of the following
statements are true,

- The iommufd is retrieved.
- The preserved HWPTs are restored.
- The restored iommu domains still have attachments.

Hotswap:

The userspace restores the iommufd, creates a new HWPT and setup DMA
mappings on it. Once the HWPT is fully setup the device can be attached
to the new HWPT to do a hotswap. That is the underlying iommu domains
are replaced. Once done, the restored HWPT and the associated restored
iommu domain can be destroyed using the HWPT ID.

In this series IOMMU core allows replacement of restored iommu domains,
this way attaching a new HWPT doesn't return -EBUSY.
This can maybe be avoided by using the existing hwpt replace logic in
iommufd by,

- Using the replace code path if the vfio_device is restored.
- Reconstructing the vfio_device<->hwpt association during vfio-cdev
  restore. During vfio-cdev restore when it autobinds with the iommufd,
  it also re-attaches itself to the restored hwpts that it was attached
  to before. The new attachment is immutable and can only be replaced by
  a new HWPT.

Tested:

This series was tested using QEMU with virtual IOMMU (VT-d) support. The
workflow was validated using a guest with virtio-net device bound to the
vfio-pci driver.

The new iommufd_liveupdate selftest was used to verify the end-to-end
preservation and restore logic.

Future Work:

- Implement IOMMU domain replacement for Intel IOMMU Driver.
- Add support for preserving PASID tables for devices that use them.
- Auto bind VFIO cdev during retrieve using preserved iommufd token
  fetched from LUO using internal API.
- Implement a versioning scheme for serialized data to ensure
  compatibility across kernel versions.
- Extend support to other IOMMU architectures (e.g., AMD-Vi, Arm SMMUv3).
- Only accept memfds that are SEAL'd for iommufd preservation..
- Keep preserved memfd immutable after retrieve.
- Make HWPTs immutable after iommufd is preserved.

High-Level Sequence Flow:

The following diagrams illustrate the high-level interactions during the
preservation phase.

Prepare:

Before live update the PREPARE event of Liveupdate Orchestrator invokes
callbacks of the registered file and subsystem handlers.

 Userspace (VMM) | LUO Core |    iommufd    |  IOMMU Core   | IOMMU Driver
-----------------|----------|---------------|---------------|-------------
                 |          |               |               |
MARK_HWPT        |          |               |               |
--------------------------->                |               |
                 |          | Mark HWPT as  |               |
                 |          | lu_preserved  |               |
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
                 |          | Get domain    |               |
                 |          | iommu_preserv |               |
                 |          | _device()     |               |
                 |          |-------------->                |
                 |          |               | preserve      |
                 |          |               | (iommu_hw)    |
                 |          |               |-------------->
                 |          |               |               | preserve(root)
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

After a live update, the preserved state is restored during boot and
when userspace retrieves the preserved FDs.

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
RETRIEVE         |          |               |               |
 iommufd_fd      |          |               |               |
----------------->          |               |               |
                 | retrieve |               |               |
                 |---------->               |               |
                 |          |               |               |
RETRIEVE         |          |               |               |
 HWPT            |          |               |               |
--------------------------->                |               |
                 |          | get domain    |               |
                 |          |-------------->                |
                 |          |               |               |
                 |          |<--------------|               |
                 |<---------|               |               |
                 |          |               |               |
                 | ... (create new HWPT, map) ...           |
                 |          |               |               |
ATTACH PT        |          |               |               |
--------------------------->                |               |
                 |          | replace hwpt  |               |
                 |          |-------------->                |
                 |          |               | replace domain|
                 |          |<--------------|               |
                 |<---------|               |               |
FINISH session   |          |               |               |
----------------->          |               |               |
                 | can      |               |               |
                 | finish   |               |               |
                 |---------->               |               |
                 |          | has           |               |
                 |          | attachments   |               |
                 |          |-------------->                |
                 |          |               | return false  |
                 |          |<--------------|               |
                 | finish   |               |               |
                 |---------->               |               |
                 |          | finish        |               |
                 |          |-------------->                |
                 |          |               |               |
                 |          |<--------------|               |

Looking forward to your feedback on this.

v2:
 - Reworked for LUOv8
 - HWPTs are marked for preservation by user.
 - Use GPT to preserve iommu domain page tables.
 - iommufd file handler cannot finish until domains are replaced.
 - Device iommu context preservation is triggered through VFIO cdev
   preservation.
 - Use LUO FLB instead of subsystems and preserve state synchronously
   instead of staging it.

Samiullah Khawaja (26):
  iommu: Add liveupdate FLB for IOMMU state preservation
  iommu: Register IOMMU FLB with iommufd file handler
  iommu: Implement IOMMU LU FLB preserve/unpreserve callbacks
  iommu: Add iommu_domain ops to preserve, unpreserve and restore
  iommu/pages: Add APIs to preserve/unpreserve/restore iommu pages
  iommupt: Implement preserve/unpreserve/restore callbacks
  iommu: Add APIs to preserve/unpreserve iommu domains
  iommufd: Use the iommu_domain_preserve/unpreserve APIs
  iommu: Add API to keep track of iommu domain attachments
  iommu: Add API to preserve/unpreserve a device
  iommu/vt-d: Implement device and iommu preserve/unpreserve ops
  iommufd: Add APIs to preserve/unpreserve a vfio cdev
  vfio/pci: Preserve the iommufd state of the vfio cdev
  iommu: Add APIs to get preserved state of a device
  iommu/vt-d: Clean the context entries of unpreserved devices
  iommu: Implement IOMMU FLB retrieve and finish ops
  iommu: Add an API get the preserved state of an IOMMU
  iommu/vt-d: restore state of the preserved IOMMU
  iommu: Add helper APIs to fetch preserved device state
  iommu/vt-d: reclaim domain ids of the preserved devices
  iommu: restore preserved domain and reattach
  iommu/vt-d: reuse the preserved domain id for preserved devices
  iommufd: Handle the iommufd can_finish properly
  iommu: Transfer device ownership after liveupdate
  iommu: Allow replacing restored domain
  iommufd/selftest: Add test to verify iommufd preservation

YiFei Zhu (6):
  iommufd: Allow HWPTs to have a NULL IOAS
  iommufd: split alloc and domain assign from iommufd_hwpt_paging_alloc
  iommufd: Add basic skeleton based on liveupdate_file_handler
  iommufd-lu: Implement basic prepare/cancel/finish/retrieve using
    folios
  iommufd-lu: Implement ioctl to let userspace mark an HWPT to be
    preserved
  iommufd-lu: Persist iommu hardware pagetables for live update

 MAINTAINERS                                   |   1 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/generic_pt/iommu_pt.h           | 100 ++++
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/iommu.c                   | 111 +++-
 drivers/iommu/intel/iommu.h                   |  15 +-
 drivers/iommu/intel/liveupdate.c              | 168 ++++++
 drivers/iommu/intel/nested.c                  |   2 +-
 drivers/iommu/iommu-pages.c                   |  70 +++
 drivers/iommu/iommu-pages.h                   |   8 +
 drivers/iommu/iommu.c                         |  88 ++-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  56 +-
 drivers/iommu/iommufd/hw_pagetable.c          |  89 ++--
 drivers/iommu/iommufd/iommufd_private.h       |  44 ++
 drivers/iommu/iommufd/liveupdate.c            | 424 +++++++++++++++
 drivers/iommu/iommufd/main.c                  |  39 +-
 drivers/iommu/liveupdate.c                    | 500 ++++++++++++++++++
 drivers/vfio/iommufd.c                        |   7 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c        |  24 +-
 include/linux/generic_pt/iommu.h              |  10 +
 include/linux/iommu-lu.h                      |  92 ++++
 include/linux/iommu.h                         |  36 +-
 include/linux/iommufd.h                       |   9 +-
 include/linux/kho/abi/iommu.h                 | 119 +++++
 include/linux/kho/abi/iommufd.h               |  39 ++
 include/linux/kho/abi/vfio_pci.h              |  10 +
 include/linux/vfio.h                          |   4 +
 include/uapi/linux/iommufd.h                  |  41 ++
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 291 ++++++++++
 31 files changed, 2318 insertions(+), 83 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c
 create mode 100644 drivers/iommu/iommufd/liveupdate.c
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-lu.h
 create mode 100644 include/linux/kho/abi/iommu.h
 create mode 100644 include/linux/kho/abi/iommufd.h
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c


base-commit: ef68bf704646690aba5e81c2f7be8d6ef13d7ad8
-- 
2.52.0.158.g65b55ccf14-goog

