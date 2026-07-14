Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A124657DA
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034437; cv=none; b=H3FrAYuLGToofVqzWP5HkxpAbwgzZv5CNRSf74l4+7/qM/x5+oDvx0dl3TqbjaQbxfgYXIiV/AWJV6eAvG1xPdWmbTNnTRwQFe9joNcVWq3pjJk+ZBb+x/mZ5chxNGi5Al10K7i1gdrTObNtOMtXnFPiiPsi9tZohQtMaXZCq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034437; c=relaxed/simple;
	bh=aWDiGhV/lDLqtQxlDd4E/xz/jeCA3Oakf6qbhhaXsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UU/VdZDprRPsAv/qWPIgljG4Y9EX76mbzlX1dAaMltjwjc7BuFwfQP1lLPP8zbCRUTr/XQdCEpeQZl55oG0ryzRfezh0lovDtFeNhHds4YZacisamL/JBh67fpW2c0FVwIn78wLbeEMFU/sa9uKz+dqYFoa0rupwAboYgu6R0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RiTLAZJg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RiTLAZJg"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso1675162a34.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034433; x=1784639233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zu2x7nRWgqnkpJB6Jzio2t+71M646t61MeaMLyeHe/o=;
        b=RiTLAZJgyBe7VbpK3w+lD4FS6Angz52RAXYYtMvnfW0VLYT8MKpz2khr4B2RuaRioL
         71ydZgMb0EGK22gkDF0dCIZZ/8E2vp/8l+8Sts2hETbyor9SpBV9jGyOcnpoC6RBY8BI
         mNplUE2brz36chjnlZOct7TXcfTXnBTgdUY2CnVnvvGqQRmQGNclzIrQthonRn9NvPx5
         GV5TqA6Iw1YYcoLQFntVVzStmfCsKfaoNBf0R66idAnTovT/4aSvmPOhsP2pcy+ZZUlW
         yPPGfKmMGDiFVfklycQkJ2V5cvOnTO2ImrBUhkfSgLUdULzdkNkFQCkv18MVHtqYXshX
         SibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034433; x=1784639233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zu2x7nRWgqnkpJB6Jzio2t+71M646t61MeaMLyeHe/o=;
        b=WWwbPqFukNzrBbKdBDCrwlvI8Ajju54f9F6I954DhrJ+ZSUU9j1etY7TdDn98Afpme
         i0qdriYAnLShuh/On8h9ZCYBQhxCl3tcqkwDKyQ+3grgxuqjZkvewI9vHhpEgAsaR/HF
         xi4i9zuuwT5dPta/6PsMRh/6pHSH5Vgc+buRMKtCmJpxWy+dDFM3uhixzC62jCoouYbk
         c6zV/BGs3c+1qAzIivzu3Pw4ggtPALLO+f2uhc3xg74rW329M6ifPN/8KzOgkDWcI0sB
         Klf6Eps9tAWJb6p87ZPhdKz+jqsGlxUP2JPVxSw7Tc2/H1ouOjmp6YhPGnaO7tBbx12W
         OMBw==
X-Forwarded-Encrypted: i=1; AFNElJ/k7zA2aT0xBaUCay2e9pK/j2jC98VYu209lZQI9wM2rnnROnctfFQll3DM8Ph9zH7iUI2qHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytk/jAQNdt/3VZGdPj15diEQGUYD+l0/Y6+jxDei33zHQy7ZdH
	YZEjsE7NlN4WNMGKQoEbK4abcHQiC8DvQ8XgxHLYR3uD1/Caep647ybraFgx52564/c=
X-Gm-Gg: AfdE7cmySDI8DcaRFY8gCtwYcX6B6fkwVqe29Y7qOmxqoRN7/Py+56zs9O3caOxb8I0
	n91gc4A4mGzr1zdk+M79jZlewkdfxA2F0vJiPpOoGqjZjRmuBkAvj4z3JslxAqaVdvsjBXBKhlx
	VFvOBAHrXjDlfFXm0E5+dB//Ar5Xfkg/bb3kKjj6PX6aZHkhlLW0VvyK4CABhNEaI05WyCTrVK6
	OJ2Zg/LBdK0x+cVtX2aO+yQ2kWkGL9MzyoPJ+E2lBFhFTIZw4Z5WbDue9uVRVECAn/TAWAAGm4d
	cCOxQ7JMUVvFPIWf3ppXmmH5sPtZzLGlZb1E/NKZgKLhNlx9PNc93eosWBfSJo6pSEuU+zs72PZ
	m1djow1JnZoNydnao24u6saF20EEsqSLlYamhKvPZs9fO6IeYLivv4Ak8wDMMe6Jvmvu+MGtijr
	+JHWOUiJhK0qRqYdfshRbBXcyRbyfSyQflNQe2I8cJ4mwJrRFijEGLnslwJiSGXA==
X-Received: by 2002:a05:6830:4412:b0:7e7:45f:ce3c with SMTP id 46e09a7af769-7ec096ac473mr7449408a34.14.1784034432564;
        Tue, 14 Jul 2026 06:07:12 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.07.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:07:12 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	fustini@kernel.org,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	corbet@lwn.net,
	shuah@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 0/7] riscv: iommu: Add QoS ID support for resctrl device assignment
Date: Tue, 14 Jul 2026 21:06:50 +0800
Message-ID: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC extends RISC-V CBQRI/resctrl support to external requesters
behind a RISC-V IOMMU.

The RISC-V IOMMU QoS ID extension associates a resource-control ID
(RCID) and monitoring ID (MCID) with IOMMU-related memory requests [2].
For a translated device request, the IOMMU obtains the IDs from the
device context translation attributes (DC.ta) and supplies them to the
I/O bridge after a successful translation. The bridge and downstream
CBQRI-controlled resources can then apply their existing allocation and
monitoring policy to the request.

The series is based directly on Drew Fustini's v4 RISC-V Ssqosid and
CBQRI resctrl series [1]. That dependency provides CPU-side QoS ID
plumbing and CBQRI-backed resctrl support. This series extends the same
resctrl identity to device requests translated by a RISC-V IOMMU.

The RISC-V names map to the existing resctrl identifiers as follows:

    resctrl CLOSID  ->  RISC-V RCID
    resctrl RMID    ->  RISC-V MCID

Userspace first creates a resctrl resource group. The new "devices"
file then assigns an external requester to that group:

    userspace
       |
       | mkdir /sys/fs/resctrl/<group>
       |
       | echo "iommu_group:<id>" > /sys/fs/resctrl/<group>/devices
       v
    generic resctrl devices file
       |
       | (closid, rmid)
       v
    RISC-V CBQRI IOMMU binding backend
       |
       | (rcid, mcid)
       v
    RISC-V IOMMU DC.ta.{RCID,MCID}

The "devices" file is an assignment and membership interface only. It
does not describe a new resctrl resource, schema, or monitoring domain;
resource policy remains in the existing schemata and info files.

Common IOMMU helpers:

The userspace ABI names an IOMMU group by the numeric ID already used by
/sys/kernel/iommu_groups. Patch 1 adds iommu_group_get_by_id() as a
narrow, reference-counted lookup for that existing identifier.

Updating a group also needs stronger iteration semantics than separate
iommu_group_for_each_dev() calls can provide. All devices must be
validated before any device context is changed, and group membership
must not change between validation and update. Patch 2 therefore adds
iommu_group_update_devices():

    lock group->mutex
      for each device: check()          /* may fail, no state changed */
      for each device: update()         /* non-failing callback */
    unlock group->mutex

The helper contains no resctrl or QoS policy. It only provides an
all-or-none validation boundary for a group-wide update while keeping
IOMMU group internals private. The RISC-V IOMMU QoS code is its first
caller.

RISC-V IOMMU programming:

For translated device requests, the per-device-context QoS IDs are
programmed in DC.ta. Active contexts are invalidated after an update so
cached translations do not retain stale IDs. BARE mode cannot safely
represent per-IOMMU-group assignment because only the per-IOMMU
iommu_qosid global default is available, so group assignment rejects
BARE mode.

The RISC-V IOMMU also has a per-IOMMU iommu_qosid register. The series
exposes it as:

    /sys/class/iommu/<iommu>/qosid

This sysfs attribute programs the global RCID and MCID used for
IOMMU-originated DDT, CQ, FQ, PQ, and MSI accesses. In BARE mode,
device-originated requests also use these IDs. It is not a resctrl group
assignment interface.

Open questions for this RFC:

  * whether a common resctrl "devices" file is the right ABI for
    associating external requesters with a resource group;
  * whether iommu_group_get_by_id() is an acceptable narrow common
    helper for resolving the numeric IOMMU group ID passed through that
    ABI; and
  * whether iommu_group_update_devices() provides the right common
    contract for checked group-wide updates.

[1] Drew Fustini's CBQRI v4 series:
https://lore.kernel.org/linux-riscv/20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org/
[2] RISC-V IOMMU QoS ID extension:
https://docs.riscv.org/reference/cbqri/qos_iommu.html

Zhanpeng Zhang (7):
  iommu: Add group lookup by ID
  iommu: Add checked group device update helper
  resctrl: Add a devices file for external requester assignment
  iommu/riscv: Program QoS IDs for assigned groups
  iommu/riscv: Expose global QoS IDs in sysfs
  riscv_cbqri: Assign IOMMU groups to resource groups
  selftests/iommu: Add RISC-V IOMMU QoS smoke test

 .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 +
 Documentation/filesystems/resctrl.rst         |  26 +
 MAINTAINERS                                   |  12 +
 arch/Kconfig                                  |   6 +
 arch/riscv/include/asm/qos.h                  |  28 +
 drivers/iommu/iommu.c                         | 140 +++-
 drivers/iommu/riscv/iommu-bits.h              |  15 +
 drivers/iommu/riscv/iommu.c                   | 419 ++++++++++-
 drivers/iommu/riscv/iommu.h                   |  22 +-
 drivers/resctrl/Kconfig                       |   6 +
 drivers/resctrl/Makefile                      |   1 +
 drivers/resctrl/cbqri_iommu.c                 | 276 ++++++++
 fs/resctrl/rdtgroup.c                         | 206 +++++-
 include/linux/iommu.h                         |  30 +
 include/linux/resctrl.h                       |  45 ++
 tools/testing/selftests/iommu/Makefile        |   2 +
 .../selftests/iommu/iommu_qos_smoke.sh        | 649 ++++++++++++++++++
 17 files changed, 1886 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
 create mode 100644 drivers/resctrl/cbqri_iommu.c
 create mode 100755 tools/testing/selftests/iommu/iommu_qos_smoke.sh


base-commit: ab754eba620f5a66e7277b7b2d0e706aa7743e8a
-- 
2.50.1 (Apple Git-155)
