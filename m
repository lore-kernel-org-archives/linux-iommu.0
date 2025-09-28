Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6D23183F
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086459; cv=none; b=ARrtXstd4mb3b92zmz1F2JN26A3TdHCU8mtNmrB0ZOgqOwFBzA9oQDyG0aZTZEdU+OS08MwWJqhZSjS6baSivZ2f1w2bMD6/DBStdwd4JWFYUbNOkM4fS3gCGLbNKAPLWPb7HbvYZ2RyY/Srwi3kcq2bnOht/xu/tiuImve2gjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086459; c=relaxed/simple;
	bh=H6Wm9ozMmZV2pb3ZG6RNK4gxFNnU5cfXK0YmgrPvVBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SCsZp8hUBEh2rDK4HSkv86m552FnV9PykbXqDf4iHcqPHr59F6RnDP4u9uGNM2Sm0XKK7NhtwAtglyG2UyDL2XnzaKemIPjMhiVEE2AbSYFN/yly1HxXYHGjtwEycN/7Hfx41hn6peSn4SXqBqAr15wRRSAZZjaIssMLj5XzXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWoMKBGR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWoMKBGR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781171fe1c5so1793868b3a.0
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086457; x=1759691257; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GB3kGFNim4Mm7zWG7PONZgVbhZKzbAMqfiGB/R/xfhA=;
        b=bWoMKBGRjVoo4J16YqWOywe8uv7Bi+NTqA4S1EHyRX2R4774MGDqTsTwbSxcx8C/tn
         piI+v6uPDArLQb2pTgB2vPDh7dpAtdfs4vZirOAFdwmtTBGmkgOO6s82yhdF9sIovoJl
         LdQFU+xkYtQu8loGadM+fwvGhtbjRCDOYOEZvugpZtEoG5O2Zn0v127UdmI7RZIe0/Jf
         Euu+VZZY42oBSwMrx8xjioukNsc/8WEsrcAYFXd7/3cMfTXZMUOIC7LnjHosF39pk1rQ
         9AIRs1SNgKd9pp+SEGLr+A7sbivTLadRTZShRNYEq4y7cYdpTjmcPzFgN10VftppF/tQ
         lWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086457; x=1759691257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB3kGFNim4Mm7zWG7PONZgVbhZKzbAMqfiGB/R/xfhA=;
        b=KunY2ptnsDITYqkNPqscn2ROy4pR+1bLcYYPT291xECEN9M8dUxvVG3hspb9sPE0o8
         eaBumVbYhBtH0sOkW/ByUo5sre9z9pjTd0SxtEPDK96NYdV/pY8JwyYxqpqtpCuZE0v+
         s2yg/6Yx9PBNRBlYwKyP2EHtqI4KeNaRG/NCBOy7WKJxZxOYpGZhXwlFAV7LRn8/8eCU
         Le88gb9oyyvkMY0knCZpsPMKit7c3LuHQcuQusmY+y1Wg2c4da0copoLxgt64pa4H0IB
         ktVUUho/xU46ehvl3wmFZChuJeTzq0TaFIh5dk5CNlqM3HNFniZoKrAS8LkIIwmoR2k8
         FfDw==
X-Forwarded-Encrypted: i=1; AJvYcCUvQpwfkMwuUAQVNdogTxgKFHN/2WXyjiUckRmf1URL0Tv030sib7IUysCYYHa96gsvt8wzdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7rxKl6gBi49kVwKwTw95dpmjJPI43BPzjDpUBfSJ2vkg0XXVD
	+IwOEbxgsdfjYmcfYUBwATtIqkUKQFD7I3jbQ1MI1LWg1wi6E9Fo3NiDUhKH0USqPluTjSPycrF
	UhqUNMvUGrN3hew==
X-Google-Smtp-Source: AGHT+IEfLwPi8l+BMF32ZHs+xLB/dePFHjMOHkrgXkLOgW2974cQQUCNMewG/1nxl9UuUE/7LK8bbJvx8GT7Aw==
X-Received: from pfdr8.prod.google.com ([2002:aa7:8b88:0:b0:781:178d:8149])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:180f:b0:781:1562:1f9e with SMTP id d2e1a72fcca58-7811562213bmr10853721b3a.32.1759086456836;
 Sun, 28 Sep 2025 12:07:36 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-1-skhawaja@google.com>
Subject: [RFC PATCH 00/15] iommu: Add live update state preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

This RFC patch series introduces a mechanism for IOMMU state
preservation across live update, using the Intel VT-d driver as the
initial example implementation and demonstration platform.

Please take a look at the following LWN article to learn about KHO and
Live Update Orchestrator:

https://lwn.net/Articles/1033364/

This work is based on the LUOv3 patch series listed below. Please find
the details of various live update states, file descriptor and subsystem
preservation callbacks, and memory preservation mechanisms in the LUOv3
series.

https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com/

The kernel tree with all dependencies is uploaded to the following
Github location:

https://github.com/googleprodkernel/linux-liveupdate/tree/iommu/rfc-v1

Overall Goals:

The goal of this effort is to preserve the IOMMU domains, of devices
marked for preservation, managed by iommufd. This allows DMA mappings
and IOMMU context of a device assigned to a VM to be maintained across
a live update.

This will be ultimately achieved by preserving IOMMU page tables, IOMMU
root table and the relevant context entries across live update.

Current Implementation, Scope and Limitations:

This RFC provides foundational mechanisms and demonstrates the
end-to-end workflow. It only implements the preservation of the minimum
IOMMU state, which includes the root table and context tables.

Specifically, it includes:

 - Registration of the Intel VT-d IOMMU driver with the Live Update
   Orchestrator.
 - Registration of iommufd as a file handler with Live Update
   Orchestrator.
 - A subsystem-wide rw_semaphore to protect live update state and
   operations.
 - An API iommu_domain_preserve to preserve IOMMU domains for
   preservation. Currently it only marks them as preserved.
 - Implementation for preserving and restoring the Intel IOMMU root and
   context tables.
 - A selftest to validate the end-to-end preservation and restoration of
   an iommufd file descriptor.

This version does not yet preserve the DMA mappings (page tables)
themselves. This means that ongoing DMA from a device will not continue
to work across the live update. This is a known limitation that will be
addressed in future work.

It is important to note that the preservation of the device state itself
is outside the scope of this series.

The series also does not yet include a versioning scheme for the
persisted state; this will be added later.

Target Architectural Overview:

The target architecture for IOMMU state preservation across a live
update involves coordination between the Live Update Orchestrator,
iommufd, and the IOMMU drivers.

The core design uses the Live Update Orchestrator's file descriptor
preservation mechanism to preserve iommufd file descriptors. During
preservation, the LUO prepare callback for an iommufd walks through the
IOMMU domains it manages to identify the ones associated with devices
marked for preservation. Once identified, Generic Page Table support
will be used to preserve the page tables of these domains. The domains
are then marked as preserved.

The Live Update Orchestrator's subsystem mechanism will be used to
preserve the IOMMU context entries and the associated root table.

It is important to note that the preservation of the device state is
outside the scope of this patch series. This series focuses solely on
the IOMMU subsystem's role in supporting live update for such preserved
devices.

Critical Design Considerations:

After a live update, we can restore the IOMMU domain using two
approaches,

1. Reuse the preserved page tables:

During boot the next kernel can prepare the new domain reusing the
existing preserved page tables and reattach the devices to it. The
restored domain can be retrieved and reclaimed when the iommufd file
descriptor is restored.

2. Hotswap a new domain on finish:

During boot the next kernel can setup domains for all the preserved
devices without updating context entries, so these devices can keep on
using the old preserved page tables. The userspace VMM can restore the
iommufd, create IOAS/HWPT, attach devices to it and setup DMA mappings.
Once Live Update Orchestrator moves to the finish state, the context
entries of the preserved devices can be updated and replaced with the
new IOMMU domains and page tables that are cooked in the new kernel.

I am inclined towards the "Hotswap" approach, as it involves restoring
the minimum state from the previous kernel and lets user space
regenerate the mappings. This provides a clean way of discarding the old
kernel state and using the new kernel data structures. I will share more
details on the specifics of this approach in future versions of this
series.

High-Level Sequence Flow:

The following diagrams illustrate the high-level interactions during the
preservation phase. The diagrams also contain parts that are not
implemented in this series.

Prepare:

Before live update the PREPARE event of Liveupdate Orchestrator invokes
callbacks of the registered file and subsystem handlers.

 Userspace (VMM) |   LUO   |     iommufd     |   IOMMU Core    | Driver
-----------------|---------|-----------------|-----------------|--------
                 |         |                 |                 |
Preserve iommufd |         |                 |                 |
----------------->         |                 |                 |
                 | register|                 |                 |
<-----------------         |                 |                 |
                 |         |                 |                 |
                 |         |                 |                 |
  PREPARE        |         |                 |                 |
----------------->         |                 |                 |
                 |         |                 |                 |
                 | Call FS |                 |                 |
                 | handle  |                 |                 |
                 |--------->                 |                 |
                 |         | Preserve Domain |                 |
                 |         |----------------->                 |
                 |         |                 | Preserve using  |
		 |         |                 | Generic-Page    |
                 |         |                 |    Tables       |
                 |         |                 |----------------->
                 |         |                 |                 | Preserve
		 |         |                 |                 | Domain
		 |         |                 <------------------
		 |         <------------------                 |
                 |         | Return phys     |                 |
		 | save    | Address of      |                 |
		 <---------- state           |                 |
                 |         |                 |                 |
                 |         |                 |                 |
                 | subsys  |                 |                 |
                 | handle  |                 |                 |
                 |--------------------------------------------->
                 |         |                 |                 | Save iommu
		 |         |                 |                 | state
		 |         |                 |                 |
		 |         |                 |                 | Return phys
		 |         |                 |                 | Address of
		 |         |                 |                 | state
                 |         <------------------------------------
		 | save    |                 |                 |

Restore:

After a live update, the preserved state is restored during boot and/or
when userspace retrieves the preserved FDs.

 Userspace (VMM) |   LUO   |     iommufd     |   IOMMU Core    | Driver
-----------------|---------|-----------------|-----------------|--------
                 |         |                 |                 | Init
                 |         |                 |                 |
                 |         |                 |                 | get phys
                 |         |                 |                 | address
                 |         <------------------------------------
                 | Return  |                 |                 |
                 | addr    |                 |                 |
                 |         ------------------------------------>
                 |         |                 |                 | Restore root
                 |         |                 |                 | table
                 |         |                 |                 |
Retrieve iommufd |         |                 |                 |
-----------------> Call FS |                 |                 |
                 | handle  |                 |                 |
                 |--------->                 |                 |
                 |         | Restore         |                 |
                 <----------                 |                 |
                 |         |                 |                 |
Attach IOAS      |         |                 |                 |
--------------------------->                 |                 |
                 |         | Attach          |                 |
                 |         ------------------>                 |
                 |         |                 | attach          |
                 |         |                 ------------------> Attach domain
		 |         |                 |                 | w/o context
		 |         |                 |                 | update
                 |         |                 <------------------
                 <----------------------------                 |
                 |         |                 |                 |
                 |         |                 |                 |
FINISH           |         |                 |                 |
----------------->         |                 |                 |
                 |FS handle|                 |                 |
		 ---------->                 |                 |
                 |         | Hotswap context |                 |
                 |         ------------------>                 |
		 |         |                 | Update Context  |
                 |         |                 |----------------->
                 |         |                 |                 | Update
		 |         |                 |                 | Context
		 |         | Release old     <------------------
                 |         | page tables     |                 |
		 |         <------------------                 |
                 |         |                 |                 |

Tested:

This series was tested using QEMU with virtual IOMMU (VT-d) support. The
workflow was validated using a guest with virtio-net device bound to the
vfio-pci driver.

The new iommufd_liveupdate selftest was used to verify the end-to-end
preservation logic:

1. The selftest is run for the first time. It opens the VFIO device,
   attaches it to an iommufd instance, and then uses the
   LIVEUPDATE_IOCTL_FD_PRESERVE ioctl to mark the iommufd file descriptor
   for preservation.

2. The test then triggers the LIVEUPDATE_PREPARE event, which in turn
   triggers the preservation of the iommufd instance and the IOMMU
   state.

3. The guest is rebooted using kexec.

4. After reboot, the selftest is run a second time. It detects the
   LIVEUPDATE_STATE_UPDATED state and restores the iommud file
   descriptor via the LIVEUPDATE_IOCTL_FD_RESTORE ioctl.

Future Work:

This RFC is the foundation for a more complete solution. The planned
next steps are:

- Implement the chosen page table preservation and restoration strategy
  (Hotswap or Reuse).
- Keep the IOMMU translation enabled during shutdown.
- Add support for preserving PASID tables for devices that use them.
- Implement a versioning scheme for serialized data to ensure
  compatibility across kernel versions.
- Extend support to other IOMMU architectures (e.g., AMD-Vi, Arm SMMUv3).

I am looking forward to feedback on this initial approach and the target
architecture.

Samiullah Khawaja (12):
  iommu/vt-d: Register with Live Update Orchestrator
  iommu: Add rw_semaphore to serialize live update state
  iommu/vt-d: Prevent hotplugs when live update state is not normal
  iommu: Add preserve iommu_domain op
  iommu: Introduce API to preserve iommu domain
  iommu/vt-d: Add stub intel iommu domain preserve op
  iommu/vt-d: Add implementation of live update prepare callback
  iommu/vt-d: Implement live update preserve_iommu_context
  iommu/vt-d: Add live update freeze callback
  iommu/vt-d: Restore iommu root_table and context on live update
  iommu/vt-d: sanitize restored root table and iommu contexts
  iommufd/selftest: Add test to verify iommufd preservation

YiFei Zhu (3):
  iommufd: Add basic skeleton based on liveupdate_file_handle
  iommufd-luo: Implement basic prepare/cancel/finish/retrieve using
    folios
  iommufd: Persist iommu domains for live update

 MAINTAINERS                                   |   2 +
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/dmar.c                    |   9 +
 drivers/iommu/intel/iommu.c                   |  15 +-
 drivers/iommu/intel/iommu.h                   |   9 +
 drivers/iommu/intel/liveupdate.c              | 401 ++++++++++++++++++
 drivers/iommu/iommu.c                         |  24 ++
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/iommufd_private.h       |  27 ++
 drivers/iommu/iommufd/liveupdate.c            | 236 +++++++++++
 drivers/iommu/iommufd/main.c                  |  16 +-
 include/linux/iommu.h                         |  22 +
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 196 +++++++++
 14 files changed, 956 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c
 create mode 100644 drivers/iommu/iommufd/liveupdate.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c


base-commit: 454219033bd8093293af8fbd4de47142530bdedc
-- 
2.51.0.536.g15c5d4f767-goog

