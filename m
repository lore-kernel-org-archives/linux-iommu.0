Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009E158DA7
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831332; cv=none; b=KD4A81us+ZKao/Yi11qIGqNK2k7cqFroD4BdfOeJf01UVG/NCpL8QjrY9SZUoy8XaCEicWfZwTExjYAU7gS5/ALUQG9tYFelqP+SJkuvbbU9N5COUIRCuTblwRfaA/8eKbBVaNi7FV8oEwbeyq9FPa48C5Np9sjvmD3lUaVt22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831332; c=relaxed/simple;
	bh=EMA3jmgRvVq0a7YipedppduacqjNjMeLpz4RLYvfPXM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=H3R2XP8nzgIzTBEYjbmFAgXQdbUs0k8Y/ay4G4AC+Doda1NoyCB+YOjeaHnNal9oEDDYTopLecMpezKAH923LV5NwDB+knO7y2BqT8xA4z4/eTU8t4S8s5ymI4/LvyuDsTFWbU2w2lBiQ3xP3j2lq69bAWnHGxnZONPVy+TyTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=p8otsCJ9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="p8otsCJ9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc569440e1so17554105ad.3
        for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1721831329; x=1722436129; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3nqH72VDw8RmqB9fqgozAQLD4BBtCtnc7ICMb0pdqo=;
        b=p8otsCJ9HOBQff3WMrmuwe8pz1wmIhaj9S5z4k+p182TqxoBSSzWc0ulmnGu3WO68S
         H9nsERTshDmrUDb302MLUzGXF9jMBre9d25Xo0sq+8ButWRy7fdtpxpabKS5XPKlk5k+
         E6dA3VacweZgXsVmvCtljoIv6RiRCG0dnxnt6LmNi7Xq1NtMBQriL/K928pFD+AVaGIH
         8ffathr3yrQECLylq77+sfwsWb4FpEYtaJ1Lf7XMSWWRB/zYty7xg6BN8/hucAz7Xn30
         RkRGn5MAHwOSEYE4kRuvcepQYiB1B8e3kdqo2jsxXPjVzwMFEa0qIu+5/KXvtRLUsoQj
         caTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831329; x=1722436129;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3nqH72VDw8RmqB9fqgozAQLD4BBtCtnc7ICMb0pdqo=;
        b=Mx0Yu3cf8zT30mt1MXFKNdUAHQbSCSpga5D1exp32mGD2Vo//Xf+lVikfPjjEdqZt8
         Li/cdEA0lnhKVOC2PeNpiLKUfMIXicEjC/loscbRU+DmfuI80kqjk/CDqhFjR1AZB4Jw
         GjytiPYO/HZu1CXvDCbcDfb2hhcTaclbYpS0JgbpYIdfXElzuhlR4oXpC6Qudd9iB9AO
         RVKQj6fQgXkz6KI3oybeglqUyz+2H8MPH4VnYvbyWeDnm2uOT6LvL8PTc7pjx9fc37dJ
         jCOvE7sNmFm2hTG8qwo8JzfaFqhGMF+EQ5K7wxRjcLVZj/wh6qKCaOly7RRr9TyN2yhy
         c5pA==
X-Forwarded-Encrypted: i=1; AJvYcCUUC1TvH/Ns+4j9Rh2/2+LVrICS+wuWQB6xxPBSs3Vxk0WrZpAkLjeawmjV1gsBDUVjT2fEG2QK8M4utAwmqiebV1/HyA0=
X-Gm-Message-State: AOJu0Yw1IFftjJz6TegmbJRyfMQwpsjaxgWVP1gvoJ0IejIMpVbmoDHC
	W0QbGICptzv09Ixg7dUp3B8S0oah12BTC1Ip/o6tIrdbRIfe/KrppFGdbdoKmJI=
X-Google-Smtp-Source: AGHT+IFi9T6gbkXmV6M0gUQxgPzjIznneNDGAuodoVLIsAjbkzHFshyyaJKmfCemmSEUumBxU+lXIw==
X-Received: by 2002:a17:903:1c7:b0:1fa:4b9:d00f with SMTP id d9443c01a7336-1fdd558b54emr23328495ad.53.1721831329437;
        Wed, 24 Jul 2024 07:28:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd73e6868csm91370235ad.96.2024.07.24.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:28:48 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:28:48 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2024 07:28:47 PDT (-0700)
Subject:     Re: [PATCH v8 0/7] Linux RISC-V IOMMU Support
In-Reply-To: <cover.1718388908.git.tjeznach@rivosinc.com>
CC: joro@8bytes.org, Will Deacon <will@kernel.org>, robin.murphy@arm.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, apatel@ventanamicro.com,
  Sunil V L <sunilvl@ventanamicro.com>, mick@ics.forth.gr, seb@rivosinc.com, robh+dt@kernel.org, krzk+dt@kernel.org,
  conor+dt@kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, tjeznach@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tjeznach@rivosinc.com
Message-ID: <mhng-7ec26af6-5347-4d42-b1de-696d2b7628ae@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 22:27:30 PDT (-0700), tjeznach@rivosinc.com wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.
>
> The RISC-V IOMMU specification, which this series is based on, is
> ratified and available at GitHub/riscv-non-isa [1].
>
> At a high level, the RISC-V IOMMU specification defines:
>
> 1) Data structures:
>   - Device-context: Associates devices with address spaces and holds
>     per-device parameters for address translations.
>   - Process-contexts: Associates different virtual address spaces based
>     on device-provided process identification numbers.
>   - MSI page table configuration used to direct an MSI to a guest
>     interrupt file in an IMSIC.
> 2) In-memory queue interface:
>   - Command-queue for issuing commands to the IOMMU.
>   - Fault/event queue for reporting faults and events.
>   - Page-request queue for reporting "Page Request" messages received
>     from PCIe devices.
>   - Message-signaled and wire-signaled interrupt mechanisms.
> 3) Memory-mapped programming interface:
>   - Mandatory and optional register layout and description.
>   - Software guidelines for device initialization and capabilities discovery.
>
>
> This series introduces RISC-V IOMMU hardware initialization and complete
> single-stage translation with paging domain support.
>
> The patches are organized as follows:
>
> Patch 1: Introduces minimal required device tree bindings for the driver.
> Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
>          registers layout, and minimal initialization code for enabling global
>          pass-through for all connected masters.
> Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
>          architected hardware.
> Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
> Patch 5: Implements device directory management with discovery sequences for
>          I/O mapped or in-memory device directory table location, hardware
>          capabilities discovery, and device to domain attach implementation.
> Patch 6: Implements command and fault queue, and introduces directory cache
>          invalidation sequences.
> Patch 7: Implements paging domain, using highest page-table mode advertised
>          by the hardware. This series enables only 4K mappings; complete support
>          for large page mappings will be introduced in follow-up patch series.
>
> Follow-up patch series, providing large page support and updated walk cache
> management based on the revised specification, and complete ATS/PRI/SVA support,
> will be posted to GitHub [2].
>
> Changes from v7:
> - rebase on v6.10-rc3
> - fix address shift (ppn -> pfn) for queue base register read
> - add invalidation after DDTE update
>
> Best regards,
>  Tomasz Jeznach
>
> [1] link: https://github.com/riscv-non-isa/riscv-iommu
> [2] link: https://github.com/tjeznach/linux
> v7 link:  https://lore.kernel.org/linux-iommu/cover.1717612298.git.tjeznach@rivosinc.com/
> v6 link:  https://lore.kernel.org/linux-iommu/cover.1716578450.git.tjeznach@rivosinc.com/
> v5 link:  https://lore.kernel.org/linux-iommu/cover.1715708679.git.tjeznach@rivosinc.com/
> v4 link:  https://lore.kernel.org/linux-iommu/cover.1714752293.git.tjeznach@rivosinc.com/
> v3 link:  https://lore.kernel.org/linux-iommu/cover.1714494653.git.tjeznach@rivosinc.com/
> v2 link:  https://lore.kernel.org/linux-iommu/cover.1713456597.git.tjeznach@rivosinc.com/
> v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/
>
> Tomasz Jeznach (7):
>   dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
>   iommu/riscv: Add RISC-V IOMMU platform device driver
>   iommu/riscv: Add RISC-V IOMMU PCIe device driver
>   iommu/riscv: Enable IOMMU registration and device probe.
>   iommu/riscv: Device directory management.
>   iommu/riscv: Command and fault queue support
>   iommu/riscv: Paging domain support
>
>  .../bindings/iommu/riscv,iommu.yaml           |  147 ++
>  MAINTAINERS                                   |    8 +
>  drivers/iommu/Kconfig                         |    1 +
>  drivers/iommu/Makefile                        |    2 +-
>  drivers/iommu/riscv/Kconfig                   |   20 +
>  drivers/iommu/riscv/Makefile                  |    3 +
>  drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
>  drivers/iommu/riscv/iommu-pci.c               |  119 ++
>  drivers/iommu/riscv/iommu-platform.c          |   92 +
>  drivers/iommu/riscv/iommu.c                   | 1684 +++++++++++++++++
>  drivers/iommu/riscv/iommu.h                   |   88 +
>  11 files changed, 2947 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  create mode 100644 drivers/iommu/riscv/Kconfig
>  create mode 100644 drivers/iommu/riscv/Makefile
>  create mode 100644 drivers/iommu/riscv/iommu-bits.h
>  create mode 100644 drivers/iommu/riscv/iommu-pci.c
>  create mode 100644 drivers/iommu/riscv/iommu-platform.c
>  create mode 100644 drivers/iommu/riscv/iommu.c
>  create mode 100644 drivers/iommu/riscv/iommu.h
>
>
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670

This came up in the patchwork meeting this morning because people 
weren't sure if it was for my tree.  I'd been assuming it was for the 
IOMMU tree, from IRC it sounds like Will is OK with that.  So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case that helps any.  No rush on my end, I just want to make sure I'm 
not dropping the ball.
