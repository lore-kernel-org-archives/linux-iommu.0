Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9161E7C01
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589710; cv=none; b=VG9W52ypSqI4OYvGw4vUcirUh3p4laFnfV3y05uuWebQL2niGKGXBLmddisPgSSCOtUkZqIn5T6gm8me3TkHyrS5P7mlX1XL1OWWlF2rlKZ0k+W3yZs63EpJ4zQtwucymYiLQMuoPzQQbY9bptSXMrqWfUiAfsiamn2aHFLPl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589710; c=relaxed/simple;
	bh=2sM7o6LGBO7ap0Z5O50Lq1X46/SGK9tk5/PV2obuWvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mq9J1ykJ7UHc94ojrh7iD0tCiqmcwzZC9a8J1NoJvzy+krNnTKTSSyTLYGNRGEoqf3rTjtXbMFuPw8zbmBN1L7vY2usRU7NNqfzvH5kYHpaWrQx7yH7oSH63+oZ9tVqNk6A+ewuejISJFMICP/gCLmRWkZxE8SZi0faI20RX8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zKCoX0o0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zKCoX0o0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so687626a91.1
        for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728589708; x=1729194508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B61VLO+BRSEyfmIsrGmAx21/fZCaGHpfFXaCOhd6vL8=;
        b=zKCoX0o0IgiXFDz3RA05u7rKzWfS6tkMRV8SDvFAM1gSsYfuBC+rfjFRjj53+WYR+c
         Q/5LKuZ5Hh6v5Jvq8AVC17vsKwkF1BGZwOhZ8MCXLQdVEBeBtxd06VA/hck/d5y1EVnR
         RggbwLZ7jpJ/neef+Nt4FgIgLZFtE+IBs3lJ0rS7n4DASn2TELCcEOm81x3VPMxvmzVg
         1FS9COmiJp8x/41mEnBIaWy3Ga0GnVSuKhBPiVStZ9J27bFBW1TaeYoZk06v7lR6SGV9
         8+Dh+/e60WgRf7nqReYLuhSwbtuSZ23sRqyYxyId5V7OlNh3RTmAAoY4k+5oUWblX3y5
         gVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589708; x=1729194508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B61VLO+BRSEyfmIsrGmAx21/fZCaGHpfFXaCOhd6vL8=;
        b=JC6T8HJu/esXcQHWPokye8jspRxU89WDvyO0cPSXtkIWcqx4Wtv7m1crHBPpR7bz1V
         fahq2JoggDGRhzs9Y5ahzfoyPOCgCdwLq0bck2jBwC8pg22mg2D0YpRjN01GBvUL/IUA
         /mhPeFQ1BedABKFbkCYcLUhOUiIH+fQAfPltPqiDGn7rWw+3xzA0FIZA7iB6bDtnu+9g
         AzlhaFP8WnHJnDyz2jPUIiVg4lKyiERQwzB85/J7Z2oYosikO1vRTLgimYPvblpkiSSQ
         +kF21z3QjyJnQBtCb6kfF1mxWMNHt+D4Fape1Uz6vvCptTKpWYdQqx8PMwQc/S6P8pVF
         iPYA==
X-Forwarded-Encrypted: i=1; AJvYcCXhDBeOPiXOoCELM5eFAhPzDwZrbF1sO0ae8UC+Xt60+ImfF60SOlrHLwN5IB0W636ruMatYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YymIrqhrIXXLKU+MVDmCKG+OEU4aIurOzcexWx5jKzCwHIYjp1P
	WuCwJ6RTpCGk4NqYlP4UW+/tKCiOz/jLMVnJCGLCF8WeQpH+7RIULPAKcPC+Mgo=
X-Google-Smtp-Source: AGHT+IGhMyUe9CQbTggLp54HZtGSVOanaEnnb26ySY+CMmJkiGcpjx4Ar0dmYh7j+BEdl/j0GACsgA==
X-Received: by 2002:a17:90a:eb01:b0:2e2:8d33:f79d with SMTP id 98e67ed59e1d1-2e2f0ae8d45mr332736a91.19.1728589707698;
        Thu, 10 Oct 2024 12:48:27 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm749135a91.49.2024.10.10.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:48:27 -0700 (PDT)
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
Subject: [PATCH v9 0/7] Linux RISC-V IOMMU Support
Date: Thu, 10 Oct 2024 12:48:03 -0700
Message-Id: <cover.1728579958.git.tjeznach@rivosinc.com>
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

Changes from v8:
- rebase on v6.12-rc2
- #1 MAINTAINERS file updated to point out IOMMU subsystem source repository location.
- #3 Update PCIe device IDs, use Red-Hat assigned VID:DID for QEMU RISC-V IOMMU model,
     Update Rivos PCIe IOMMU hardware VID:DID.
- #7 Fix incorrect pgsize calculation in riscv_iommu_map_pages().
     Fix supported page size reporting for paging domain.
     Fix boolean type for riscv_iommu_domain.amo_enabled.
     Remove workaround for dev == NULL in ops->domain_alloc_paging, no longer needed
     with domain allocation interface refactoring patches [4].

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux/riscv_iommu.next
[3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
[4] link: https://lore.kernel.org/linux-iommu/20241009041147.28391-1-baolu.lu@linux.intel.com/
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
 drivers/iommu/riscv/iommu.c                   | 1656 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2921 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.34.1

