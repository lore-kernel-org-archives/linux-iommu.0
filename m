Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE01802C6
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710618; cv=none; b=S8B+TKePAxVlsyIi35OCf5shPQNzo/gJ9+Yn2gHWD49ICMlUczUsFHxkUEABx8vrGgpaeWX4ro59GuL9Ca2os59Dbd8dggH7pYtZSQqWmadcA9dFcvYB361Shek+/LsDWQmDvHPFATGweusMdvWU+qO88KsNbXUrSutkGo8Mi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710618; c=relaxed/simple;
	bh=x+Atk3DiMapW/Melhk78iDr5WQKQzY7RYGtz0jm1788=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F7L2F86zP9lDk4nH/bmXOaUlrSFHz7GyWI48BKcrVTWBF0XbeBxGju6b7Fj2D8Z3Br9YVmZdN7fg2MN5PqUYXz4y/ILRzRTityA/rBNt0ymeswWMUC34VxqMD9hRLOnORy9SpLqHaIrf3yhp6kfHgmbcV7SBkmxZsklsv6x57gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tUNZh0iE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tUNZh0iE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so45300275ad.1
        for <iommu@lists.linux.dev>; Tue, 14 May 2024 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715710616; x=1716315416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntO07EHzeIxaUBkro0cUslEIHaRtwBKGDIWKPBR2eTs=;
        b=tUNZh0iEROJPjk73bjtDPTXQK7hbJXLF0DWL0taRWYjLVe/lJx9afgQO9+qZe3/DE9
         G12fzz1fdwITEEK8pX2O+g7e8J/eVlPsjEZ5o+85meNO8gdVvUE3r1HQ4ZrkC2CST0Zx
         J38Rol1LtIVlh0jC1yrnGK02Y9IA6F/sjsGHQj+6UaKcnIRb+GlPEcaTFWKyZDMlyDCf
         WeTQrPN6YecUcNC8z7J5OZfOHf7dD+d1FL1nBc7eWjIsdvDIVIuWn+mMyfxOtTyKUPCn
         VPHcvZCU9pEEu2TuBKjzKG5lOeca8fQwvvjSHd2CvbL6w6Ivt6IZf0EquFC56OZqv9Fu
         bOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715710616; x=1716315416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntO07EHzeIxaUBkro0cUslEIHaRtwBKGDIWKPBR2eTs=;
        b=i7YTMvGkf+DpwUTAW6xLvl6lntd5CDc8MM0weuH0Rok0+En6X2GO9qDFFLeAL3cn8V
         dhYXJMz2ZrVAHoD0Zi2PB8EZflD+a51YDNtPhGbivDTtQzv6oWMVpeOEy2aVMlCzR2/Q
         svCZ2Z7+b4xKRymoRwB1yk6VGSu/xwiGU2XBt08pOgP4maphnoHcR//VOdjSlHropxFJ
         eLqmyMtMfarxpW4NapZSekKILJVwj6BRZG9uaOVT3eY8DDQi7vdfTI4x1AjzBXFVgtpO
         YBGZVv5GJwX/XYR6+mNbM8O865gP0zWYNFaLHBhRMvv1DDx6XEE2Waa9Cn0155HJkBsA
         stjg==
X-Forwarded-Encrypted: i=1; AJvYcCUGhgthbo6zKWpHRDMwRJKfpDGyltsiGxk1iD9C6po5CsjXKQtl6SfHWdN8lz8uzidTdpmNqcu2vq3HD9MH1a/b60+VAI8=
X-Gm-Message-State: AOJu0YwUyvxA78X3DX8bKG+AkfV8SKLft1s5aorCTfdSibZXGsdMKRjQ
	sM2Va+1SKsiJSkzychv7s2BrAaI4ykzcVMSnuB400jDDx3rPfYpgrfOKptDO5fQ=
X-Google-Smtp-Source: AGHT+IGqGcf03rTwtWMBdNE4/haqu6VFE+kKrC31BtqQAytwyc6gPRJ3RofHiXGCTNvKefmCls52yQ==
X-Received: by 2002:a17:902:e5cb:b0:1eb:63d9:8d85 with SMTP id d9443c01a7336-1ef43d2e27bmr175023605ad.14.1715710615977;
        Tue, 14 May 2024 11:16:55 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6386sm100993625ad.80.2024.05.14.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:16:55 -0700 (PDT)
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
Subject: [PATCH v5 0/7] Linux RISC-V IOMMU Support
Date: Tue, 14 May 2024 11:16:12 -0700
Message-Id: <cover.1715708679.git.tjeznach@rivosinc.com>
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

Changes from v4:
- riscv_iommu_iotlb_inval(): barriers, domain attach synchronization, comments
- riscv_iommu_bond_unlink(): invalidate IOATC on last unlink call
- riscv_iommu_cmd_sync(): separate IOFENCE.C call with optional timeout
- probe_device() fix: check dev_iommu_fwspec_get() return value
- editorial changes: s/IVEC/IVCEC, phys_to_ppn(va)

Patch series depends on (applied to iommu-next):
  IOMMU memory observability, v6 [3]
  iommu, dma-mapping: Simplify arch_setup_dma_ops(), v4 [4]

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
[3] link: https://lore.kernel.org/linux-iommu/20240413002522.1101315-1-pasha.tatashin@soleen.com/
[4] link: https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com/
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
 drivers/iommu/riscv/iommu-bits.h              |  782 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  119 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1674 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2935 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
message-id: 20240413002522.1101315-1-pasha.tatashin@soleen.com
message-id: cover.1713523152.git.robin.murphy@arm.com
-- 
2.34.1

