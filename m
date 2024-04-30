Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167C199E96
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507361; cv=none; b=BoDp+0eV4Ii0jgqelX1F3RWGZAjrXJA4kBpGwdF4iEjDFhya15B2KECJI3X5udVAjBfNBXfpnOzgSjRRZV7KSpclZc5y+64PQk32v1tk5M2i3Q6CnXP9bFOLvDF6T5m6L3thRry9G+FgXyNj8Ov7sYDfGObQwp5X3hXbiHg+SQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507361; c=relaxed/simple;
	bh=TDXxFegYkw4+4OrumwbrZ+/KjG8pndncc4mQ5lrFXqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V7y1n6QWnworlbElveSmktf7O+6UL2DHT0GxCbx6s2pbFPh1n0gCpJVTLgr6JSFHMb++8jdC2mprmcitsAaEZeV6aK+/F3IHaOTp2EpN2fcS/5oblUBoSl0Jav/bPff5JKWJB1yz3iRu0kY5GsSky4ME/y0gUXD6GD1LaxXWTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JGRN2KJw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JGRN2KJw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so38800935ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714507358; x=1715112158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LJjm/pyF2zhjcSW6gvyrQ1WLiqOQO+GuJphiWriDpw=;
        b=JGRN2KJwDrvBZD8e8h29tpp6O+Q5LYc9Ed2qDUsBsOk4g2eAVcasvdUOpyEEA3fwdd
         mWGIwQqNcKIedWPHrDE8v0y3FQB78f6EuvS1cVT4lw/ryU4jyeqGe23b1Kc0cr41AxSq
         WHcp2vIGkBs6+OIhJbYxq8EKTdmGQYpdFliKP8wrC/hbpyXIZUEWme/Fndrb+yzIhTa2
         9bBOf807JTAwUCw3vZn6yUTIlFE51hWazfVd3yhl16Q9CnVA1kWA32bIw05Kd+KCWQUB
         GchU84/V9+lENpXggl7NzlIvCY6y9RYkDCjR4CGjDwdHSrZol5pR/yZgT4W0mIX6lCXK
         oKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507358; x=1715112158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LJjm/pyF2zhjcSW6gvyrQ1WLiqOQO+GuJphiWriDpw=;
        b=cB+3fIdhuyPH4EpZWXuDF6EbdcFmvUOoJdfTZcjo5hW2MCQBSf9qb5paEiDqVnak+Z
         nh791ovvBNDezrXbA4c2IMlkaNBmhcZYeIiOlcI3wlbpA3HjOEz9mhIBN7YhBXJ4F+Tp
         u4CP6oSXPW5vRqXjgx9xS+23jK5LNXzO4UWoVCDY/bJHT/gGm7tVv+dV2YjAe9R5BjlL
         Y8/d4x9TPDCtqcZXlwknconQA4zu+XE6Rb3KHKyKwaTmYA7WOOZjs66KwOyoOYqh2UFV
         2/C9oOAkqTef8+DX0M8c2/07Fz0tvu+z3/XBaQe1Xr67eGPj3rPdWOWuGpqLJZVmNwPh
         qUxg==
X-Forwarded-Encrypted: i=1; AJvYcCULoaQALn8zkjSrm27Qg6hmEi7JTYp8zTH2zU0Ey7Jm7SElMG66cb7Fw8dlHaIu6W0swZZ8jkLNymc+VmkO/v7iTKbPZjs=
X-Gm-Message-State: AOJu0YyoxgkJN10uJ0TvaH1TKx0IYf9mduCxiLchfn6IRrbipbcKRCST
	8f578PIVekicrQ3aXdvMDuRJoAxuSvB981O5OyFIEX183ChA7GdJ3NRdBGuTFZM=
X-Google-Smtp-Source: AGHT+IGJcxkSCDzhcED+yMnX8Jj7+cRN1MgU3WMk1uF7uem/IatFkUZ3shWdYdvdr5tHyr9TaD2REw==
X-Received: by 2002:a17:902:da8e:b0:1eb:e5c0:6459 with SMTP id j14-20020a170902da8e00b001ebe5c06459mr534811plx.8.1714507358141;
        Tue, 30 Apr 2024 13:02:38 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm22809820pll.249.2024.04.30.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:02:37 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Linux RISC-V IOMMU Support
Date: Tue, 30 Apr 2024 13:01:50 -0700
Message-Id: <cover.1714494653.git.tjeznach@rivosinc.com>
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
Patch 7: Implements paging domain, with page table using the same format as the
         CPU’s MMU. This patch series enables only 4K mappings; complete support
         for large page mappings will be introduced in follow-up patch series.

Follow-up patch series, providing large page support and updated walk cache
management based on the revised specification, and complete ATS/PRI/SVA support,
will be posted to GitHub [2].

Changes from v2:
- rebase on top of v6.9-rc6 and applied series for iommu-next:
  IOMMU memory observability, v6 [3]
  iommu, dma-mapping: Simplify arch_setup_dma_ops(), v4 [4]
- dt-bindings: compatible string
- Kconfig: optional built-in driver; removed module info
- kdump support added, interrupts and binding fixes, pcim_*
- use iommu allocation accounting wrappers
- use new dma-mapping setup, removed probe_finalize
- release domain added, memory allocations moved to domain alloc
- updated domain attach flow, fixes for domain to device bond locking
- fixed alignment check, fixed non-leaf page release
- driver warnings cleaned up


Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
[3] link: https://lore.kernel.org/linux-iommu/20240413002522.1101315-1-pasha.tatashin@soleen.com/
[4] link: https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com/
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

 .../bindings/iommu/riscv,iommu.yaml           |  150 ++
 MAINTAINERS                                   |    8 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  782 +++++++++
 drivers/iommu/riscv/iommu-pci.c               |  119 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1549 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2813 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: e67572cd2204894179d89bd7b984072f19313b03
message-id: 20240413002522.1101315-1-pasha.tatashin@soleen.com
message-id: cover.1713523152.git.robin.murphy@arm.com
-- 
2.34.1

