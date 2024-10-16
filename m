Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99412161326
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123114; cv=none; b=iGnnoapdNMaJ6MCLRoz3YWCdKrbv7mVbQAPb/Qa1V6Ax0Zrh0XKaUyG6lWq42Kks5Raecu0MW/r53h6k3hBPK0zOAF+6kDFTlETOXlxnax37fh14ei6o60WgH9UOW64hf6ispRRHZ33DliRSIWSO2gXSmgdy/O47bT51bQgV510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123114; c=relaxed/simple;
	bh=6GlrRasXkgggJDU5M8kuorXKCx+Dss6wjSj3jcDAxRQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=mUaWl22dIrhNK1Cu0NACCgW/Uia47yYWZsb2Z9Dbs4GAv3z9RlqobOWcAY84V9W2QA14GCoi28YQNt6ikuDTZHfoFL4ZUrfMRz1YDgnVounTp18OpIhz/ieoh/7fv9xEsMUWX/5r2fGXhlI2LdaeLLhH5jsMjSeLUgyJW5EIhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=c323BJvo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="c323BJvo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so4073555ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729123112; x=1729727912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWOcAUhy/aqpDz553u2L9UKjBpofwGpehOSYl8woQYo=;
        b=c323BJvoc/OS6uLfBJzd3D9sqbBQebgkhwOKZtDOE9W0YtEPME7hBPqDSupjyT3Bl4
         1JB2JKP7dGUg3wjDoHEbP82Rtuzi9hPbL8bHEj7cW7BvmCnQu2tgWtFtuz8+hstI8jN/
         6AQSXXJudLwAxhO/wWbp3NEv1ZJ/Z2U0xe1WKTLRl/bOyUvZ5/BTERiDA/ljOkf1xPs5
         hd5ZyLsHHf6nq7Cx89GIwhotdxIc5AmloUy2ffj5ERXi9Zqq/Fb1RniUhZg6AeL6/qfR
         uTwHlhIp82hggFQhYyD5j94I/CfB9DBpCAGbwwjiaQa/YRxVqi5csyaTtHyfaqR+nm44
         B6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729123112; x=1729727912;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWOcAUhy/aqpDz553u2L9UKjBpofwGpehOSYl8woQYo=;
        b=ixvM0EjfTp4Fz8nCJACrqo1hxT1Tj82BvYlaCNaj2fkQtK5JbBul2zPPswDHgxvFyM
         /n0bKv2OeV23nfcZgme9HngsVapGbYWd8JNcfTcVYiS1u5G0XPIKOLEYwQ0u//bziYab
         DVQ7UMCaB6mLcHHIKcbBSe3nEtX3haIwpq6W0id/wb8begwdw8ZGW4IjjSQhj2uY5iZB
         AFHtI3zyvVUB0Mv2p1X7mJeZz/bBhGBZEOvSG8HpPTM2aH0Ba57vNhBoz1GFZKSVZPEu
         pDkinqN++UCnRT4MIi3AJR4qLjPc5llpPwDPDAkgDHMeLoBBjSJcH4joMg2p6a/7nQKz
         bycQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUomfi7vfevUTHcIlfnNnWZ6MVu8PXR/hX8tXeRiHisE6VYx2qBdQGces8+tOATalACUgHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ/LkimNLUSHceTWN3AJNMPAjL2Axdzh+0jqBgQV4ENtXOXPy5
	pOvxRickiNMRbUlhwMrmT0DhGrgAnHP4JVRWdK3mcXXjoWzlDRY/MI8+dVx7IKaAb8OrFHfDfLq
	H
X-Google-Smtp-Source: AGHT+IHKYKyt9hGNbG2NwFr4zrQbPdHWuysp67AwdzLwlH9R+yyQs6J1fjS1SLIc3JC6hBrMbrmZMg==
X-Received: by 2002:a05:6a21:3511:b0:1d8:ae07:c02 with SMTP id adf61e73a8af0-1d8bcfc38cbmr28048215637.47.1729123111761;
        Wed, 16 Oct 2024 16:58:31 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d2af7sm3345158a12.40.2024.10.16.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:58:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:58:30 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Oct 2024 16:58:28 PDT (-0700)
Subject:     Re: [PATCH v10 0/7] Linux RISC-V IOMMU Support
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
CC: joro@8bytes.org, Will Deacon <will@kernel.org>, robin.murphy@arm.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, apatel@ventanamicro.com,
  Sunil V L <sunilvl@ventanamicro.com>, mick@ics.forth.gr, seb@rivosinc.com, robh+dt@kernel.org, krzk+dt@kernel.org,
  conor+dt@kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, tjeznach@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tjeznach@rivosinc.com
Message-ID: <mhng-31f89051-f430-4d85-ab27-23e5e77e008f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 23:52:12 PDT (-0700), tjeznach@rivosinc.com wrote:
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
> Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
> and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
> with published QEMU RISC-V IOMMU device model [3].
>
> Changes from v9:
> - rebase on v6.12-rc3
> - #6 Memory ordering fix and updated commentary, based on Will’s suggestions.
> - #7 Remove riscv_iommu_device_domain_type() and use head-less kfree_rcu in
>      riscv_iommu_release_device(), based on Jason's suggestions.
>
> Best regards,
>  Tomasz Jeznach
>
> [1] link: https://github.com/riscv-non-isa/riscv-iommu
> [2] link: https://github.com/tjeznach/linux/riscv_iommu.next
> [3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
> v9 link:  https://lore.kernel.org/linux-iommu/cover.1728579958.git.tjeznach@rivosinc.com/
> v8 link:  https://lore.kernel.org/linux-iommu/cover.1718388908.git.tjeznach@rivosinc.com/
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
>  MAINTAINERS                                   |    9 +
>  drivers/iommu/Kconfig                         |    1 +
>  drivers/iommu/Makefile                        |    2 +-
>  drivers/iommu/riscv/Kconfig                   |   20 +
>  drivers/iommu/riscv/Makefile                  |    3 +
>  drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
>  drivers/iommu/riscv/iommu-pci.c               |  120 ++
>  drivers/iommu/riscv/iommu-platform.c          |   92 +
>  drivers/iommu/riscv/iommu.c                   | 1661 +++++++++++++++++
>  drivers/iommu/riscv/iommu.h                   |   88 +
>  11 files changed, 2926 insertions(+), 1 deletion(-)
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
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if anyone was waiting on me.  IIUC the plan here was to aim this at the 
IOMMU tree, but I'm happy to look closer and take it through the RISC-V 
tree if people want.  Just LMK, for now I'm  going to do nothing ;)
