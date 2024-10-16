Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25018C351
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061550; cv=none; b=lzMWWjIb4b3wKmiKnKRvL7ZCSpBwqNWfVmWMO3XXB1rghHTv0VlIq4a9ajZrRhoTQHlp1NUPBPomSVEMCbsUC2zXFHxisJT7V3BOcpLaE60Fgx2JX/i9YCJ63nXk1liEtRPNZ8BENPyufYm7d8TmsH0xJqZLT7lBFQeuTMwnLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061550; c=relaxed/simple;
	bh=MkWfXMUGA1Oq5dX8D1nuLXWEyvxOfaGw034/IAEqVdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OCHPs0ILf/QtI5w5Ip6w+QM7pMkQ8hoRvVhOCjAKYh6PTFqFXfISHLxMxoMwLvPO/Q/TZwXuQIi+xz39YvrErn2OJF2J4saTJmfRg2aU3/1zEjcSsywg9L/Nhk9p4j24Vz3OKN6nLEw7+NX1CM10w7a9THnJETysWu8gmXbyu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DgxmG2Ce; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DgxmG2Ce"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c77459558so49456525ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061547; x=1729666347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edrP7O7a6NncjkyeVVAJ0jiJhAYB2+mktJx+SnmTMmo=;
        b=DgxmG2Ce0RlrJ+sKXtO4qs0nAsg5BGyC03Ux3yGIBBCyw/JBul+qBqLwFBdqasI/Vr
         I94lPcLNDAEfaLE6t7nd4fAz7VaPwbH5fw77B9aYBstze6WT6eM35TudMWSu3dlG/2Vy
         hkUPePpIUVU7M6WzgQWlgc33IacwfmxXTx6vq5Sm7z3TVHvEYAM4Jhhn6NyL6H+Nqu5r
         J5N1IO+AdLtGAosng5X2BXe5PkJzruhh/z67zFAwTpIPUsEBs1FJX5sZ4hHeC6E6T3ct
         1ixbLk4Bt99ZCxiR+ry1kLyPCUIOvLnhOS0XjFahgh5Um0QdINvSJnR7M4oHvIfKS5ZO
         Pmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061547; x=1729666347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edrP7O7a6NncjkyeVVAJ0jiJhAYB2+mktJx+SnmTMmo=;
        b=N0HP41X9jLYIIb03kNArWqa7uvXJFcGaJw7DtfIHSMEO182UQdaqAHs9zMjs2OJo0K
         iekzs/eaiHyuNQmBrF4kZV6datHgcwaVfXqINZutbZg4foY9vIduxAGekkA7/hnjSmeo
         6lv6h2XC64otqql4cFBMcr/isSPf4fjZurDdyye49MQ49jg2zyAr3FcZ4iPbKnSKoWJ3
         tg3XUiD8PJiKAAYoop7SPmynCq9BBBYo9nuylgZVc/yk8yRB/fAPIhC2N8j4bhe3xd/y
         U5cffZfbEoKBQobZwla4GOYU/5TOu1jM1VHFGoiWmWzZ7dwIqZVo4XJ20cG/a2qLz5u5
         OmLw==
X-Forwarded-Encrypted: i=1; AJvYcCXr5tkzSBPKa8WdXnsoif35B52R8A7IkMUqRKbPu7PO9tNo5S50W+XcCcFalJdRi10Qw9IC8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJXP8Kjtwhq0mtujn++JoZmFMoaQrkrfecMo4tjPcj/TTQv1Oa
	avHZ821iW02DPc0XYX9XwP+7YdykJQPOrEmzMER95N3QKQeeFnvpN6HN36xc0Ho=
X-Google-Smtp-Source: AGHT+IHFpMiQBbiEBTkmPNQuDjgrwQrsX5LcLAK0wa6OKlIr/7npj2NUGYvuYiUcx/vU1hhIAlG0YA==
X-Received: by 2002:a05:6a20:c888:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d8bcfaa0ffmr23847001637.39.1729061546751;
        Tue, 15 Oct 2024 23:52:26 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370a83sm2410762b3a.5.2024.10.15.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:52:26 -0700 (PDT)
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
Subject: [PATCH v10 0/7] Linux RISC-V IOMMU Support
Date: Tue, 15 Oct 2024 23:52:12 -0700
Message-Id: <cover.1729059707.git.tjeznach@rivosinc.com>
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

Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
with published QEMU RISC-V IOMMU device model [3].

Changes from v9:
- rebase on v6.12-rc3
- #6 Memory ordering fix and updated commentary, based on Will’s suggestions.
- #7 Remove riscv_iommu_device_domain_type() and use head-less kfree_rcu in
     riscv_iommu_release_device(), based on Jason's suggestions.

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux/riscv_iommu.next
[3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
v9 link:  https://lore.kernel.org/linux-iommu/cover.1728579958.git.tjeznach@rivosinc.com/
v8 link:  https://lore.kernel.org/linux-iommu/cover.1718388908.git.tjeznach@rivosinc.com/
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
 MAINTAINERS                                   |    9 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  120 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1661 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2926 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.34.1

