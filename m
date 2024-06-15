Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65754101C5
	for <iommu@lists.linux.dev>; Sat, 15 Jun 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429270; cv=none; b=V5hagWxQU19thFKoaeUmmJj4uJVRjfcTcLHmoWhp9TR9JelYhi+soQQN9fou7Ps9HAmTnRLp/8CEskmX6t58ljx36Ht+nD3/rPnD+HrJKAq0Qv30VHCbjBaMfjSllHP1Kqh+30SSZhmPmQMP0A4aUjWBUvZnkCB9bxtlmRadhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429270; c=relaxed/simple;
	bh=mA3Hhmq6fqwvMPCKWI5U2Cg2yOiBjniZrh4w8wHC9P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ilwuHS5Aj/rJLROFc09pGsbRIdJzCyib72cY44lRr3KkLmuwM4PtxIWFWFbioerZFRN1hIAPoA4Ih0WNBedGglDcf5b/5tH8b7P4n6Z+/F4yP7OK+clwk9PCu+cRand1VX73b6RLdQZGdDkEiVHpQtvp/uxueH59kS7nEghQ/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Huh/kx+f; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Huh/kx+f"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f977acff19so1314910a34.3
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718429267; x=1719034067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HWY3DwYhS1DC6ssfyK/mGNM91IszoPLT/Xd+boZpqg=;
        b=Huh/kx+fVpccATV8JqR6hpHv8YDrD2v4pfAAldFK3G7WuGbLRre9w9T3sxvEVMXrSd
         y/oB5iOR29Ai2Lkok6gbAyVmSrDAvhy+Y5MJujGrNj63Oxj9Ev09zoI1267pAxpffBxj
         jCdpPHkHrkF/RvuZFgbRhC6ytSY8799HgytPiq57Knk/EBgFMAEVGGwi3bvp84eoD/Oz
         IP4UxazPmlz2/LOS4tpf1DrCmSiPoe0aQil081jErn4DrOz1PX5/etqGRla/L72WSs02
         tDwBSQAJxmoFN/hfzv6t1ATdo3F3tbB5PPuBTcbFK11J6VbeuHrZbqBoIdps4vFrcx7I
         r1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429267; x=1719034067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HWY3DwYhS1DC6ssfyK/mGNM91IszoPLT/Xd+boZpqg=;
        b=oaTHDn+sJrYIuXhEBjCfy+Twhv+C8dCQ2CZqajFMOclKMM8UnGpzvsuk6F6sVYtWZM
         kgYJVwGaJ239DJJpNJDsFN9qrEAe6TOKyhQwW7AS9PLKeuETXJ2iVY7fzTbhgm+gww1H
         JxToqEGIUO1zzkRKLKoqUkXApGcVaOL2RTMcOpSuJEPWrK63OXIMHkB6Cex4ko3PJj52
         r5JlK72gt4ILsLO47or+HzsS6nFE/jvcJn1+Q1mD1CoXuLUnuluY+NDuIMRmrnLrbAep
         jkYxPT4pVnaUfCSQUmUwwYXvSW3uzOhvcHWfgHC4WGeb7VA74WhKcKKFwE370GGAG34n
         Yy7g==
X-Forwarded-Encrypted: i=1; AJvYcCW1RpgLLGIvuxErramM6B5EwPuyEyNpuLSk/UJbV+H7UhtyC4+DrKTH5RqRM/s53adVdnzBii964YbnyKuDwiDQhulntF4=
X-Gm-Message-State: AOJu0Ywsnur8hbUiGDDSAnP7PaNpDxvzM16A/jj7JLCh8ZEtWUZ9AAe9
	MfUQizkJlk7C6FCRfTe4q8GHQFrGuYjbdtNuR9fmTBSBm4Vc4Go6ik8WAxy5bDE=
X-Google-Smtp-Source: AGHT+IEkw9bzoLUdXSiey6gWd/rfVSdgAg0oVru00fWS+E2CLByqzysRddxec15KuDMJ9oecqX3IyA==
X-Received: by 2002:a05:6830:3443:b0:6fb:8193:85dc with SMTP id 46e09a7af769-6fb93b07c46mr4566313a34.30.1718429267234;
        Fri, 14 Jun 2024 22:27:47 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b99bsm4081578b3a.143.2024.06.14.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:27:46 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v8 0/7] Linux RISC-V IOMMU Support
Date: Fri, 14 Jun 2024 22:27:30 -0700
Message-Id: <cover.1718388908.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces support for RISC-V IOMMU architected
hardware into the Linux kernel.

The RISC-V IOMMU specification, which this series is based on, is
ratified and available at GitHub/riscv-non-isa [1].

At a high level, the RISC-V IOMMU specification defines:

1) Data structures:
  - Device-context: Associates devices with address spaces and holds
    per-device parameters for address translations.
  - Process-contexts: Associates different virtual address spaces based
    on device-provided process identification numbers.
  - MSI page table configuration used to direct an MSI to a guest
    interrupt file in an IMSIC.
2) In-memory queue interface:
  - Command-queue for issuing commands to the IOMMU.
  - Fault/event queue for reporting faults and events.
  - Page-request queue for reporting "Page Request" messages received
    from PCIe devices.
  - Message-signaled and wire-signaled interrupt mechanisms.
3) Memory-mapped programming interface:
  - Mandatory and optional register layout and description.
  - Software guidelines for device initialization and capabilities discovery.


This series introduces RISC-V IOMMU hardware initialization and complete
single-stage translation with paging domain support.

The patches are organized as follows:

Patch 1: Introduces minimal required device tree bindings for the driver.
Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
         registers layout, and minimal initialization code for enabling global
         pass-through for all connected masters.
Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
         architected hardware.
Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
Patch 5: Implements device directory management with discovery sequences for
         I/O mapped or in-memory device directory table location, hardware
         capabilities discovery, and device to domain attach implementation.
Patch 6: Implements command and fault queue, and introduces directory cache
         invalidation sequences.
Patch 7: Implements paging domain, using highest page-table mode advertised
         by the hardware. This series enables only 4K mappings; complete support
         for large page mappings will be introduced in follow-up patch series.

Follow-up patch series, providing large page support and updated walk cache
management based on the revised specification, and complete ATS/PRI/SVA support,
will be posted to GitHub [2].

Changes from v7:
- rebase on v6.10-rc3
- fix address shift (ppn -> pfn) for queue base register read
- add invalidation after DDTE update

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
v7 link:  https://lore.kernel.org/linux-iommu/cover.1717612298.git.tjeznach@rivosinc.com/
v6 link:  https://lore.kernel.org/linux-iommu/cover.1716578450.git.tjeznach@rivosinc.com/
v5 link:  https://lore.kernel.org/linux-iommu/cover.1715708679.git.tjeznach@rivosinc.com/
v4 link:  https://lore.kernel.org/linux-iommu/cover.1714752293.git.tjeznach@rivosinc.com/
v3 link:  https://lore.kernel.org/linux-iommu/cover.1714494653.git.tjeznach@rivosinc.com/
v2 link:  https://lore.kernel.org/linux-iommu/cover.1713456597.git.tjeznach@rivosinc.com/
v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/

Tomasz Jeznach (7):
  dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
  iommu/riscv: Add RISC-V IOMMU platform device driver
  iommu/riscv: Add RISC-V IOMMU PCIe device driver
  iommu/riscv: Enable IOMMU registration and device probe.
  iommu/riscv: Device directory management.
  iommu/riscv: Command and fault queue support
  iommu/riscv: Paging domain support

 .../bindings/iommu/riscv,iommu.yaml           |  147 ++
 MAINTAINERS                                   |    8 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  119 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1684 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2947 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1

