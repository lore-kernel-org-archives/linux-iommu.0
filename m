Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57209145B39
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457955; cv=none; b=HeZPcNEYnBJv0OGorROcX1Na00tEztXeExRWoyehAD0nOrJS1d6SYJ+9vdopqplAcITeBXp3OldSPMYG5C6utw/09WBLFYzQPe1Xry9NI/VzYUHuq/ynN4NdplXCt2BxOTyjRDguEyu8r4gLNitdQn+iBM5DpoGYbj9F/4yzJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457955; c=relaxed/simple;
	bh=dg7kiyLQdxJDu/DhZjBYy9+fyv9Ey2Xh3fyL/js/tQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YnnfWiUi0O9LwTWUOeedIqAlG8KW40y8YCpzhCrcC+gKl+nY2eCJSGt8P5kIjb3QcLSQ2MsmSgXm7eRsf5+htQrXMr2TDkOpYHXm2ptCmqKEAaybKWaU66es7Nl1P5XJSeu43aLOXEM+hKeWafsnxd0nivIlqaq2VJ/NFUeo/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dxiRrlIc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dxiRrlIc"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso880411b3a.1
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713457952; x=1714062752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qw41A+dZx7I8Diykai2FpeK5mNXOqfbEJEaS+qGnKM=;
        b=dxiRrlIcI2VBEXwb0Z3lvSoRZ/+KqQV6DllEjUW34Imrb9FLEay3vZ0/1/c4yTdm42
         JH403Xl079hXjuLQdR6c/Jw9EVJi7bydNkiJOvw2jbWR/rokIJiPI+b88G6VhIw5SHIm
         9YnvIwSKsK+9zfO1gic9zXsYgrbOYfO/jo+QgvY87N/OaDRRM26v3ulcJzx7Ta/krxGn
         tyX/GKx13kv0PII4pYQ2jGvsrPVciUMYNwLUhMUCoEP5Fqfwh6KIoiezuFwFFGdDkOLo
         DmL6lWwILF7LPIm25a9P5rujTKGKHg+Z/dZ959yUSIvE06l96BqdcmH0v7MdeF+Zm/gg
         G4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457952; x=1714062752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qw41A+dZx7I8Diykai2FpeK5mNXOqfbEJEaS+qGnKM=;
        b=QF03a9koyBmBCzkuNOkNmKml+BXRsSHMknCN7SaQj4i5nmF9EXV4pJp9NrPFZk7D9J
         NLenr22jda0Fzg8lZ61Ao0qdk57SmtfQWo4z7uxcMEzGMAcx5FUrcqoroEGN/1mUAObM
         meMISwz7oQO5sbyEZxJZoSqqK8KHRDIKtuAbZ3hUDurosgW5DluvpomWN77p5m+8Mb/b
         UUcwebwrGYnILxGSywCVEXLYVi+IAzIfi+QEx3ksXOXxkcULWOQFREZvBXwggq4Hav0h
         TOqdPLKS8d921/GGMQZyW2NRtA9ZvV06NkkXFbutuMnLmOJHN10aZc4nqaPSMwGKXThe
         3MMg==
X-Forwarded-Encrypted: i=1; AJvYcCXTSJel4NDW41pC4Rj3LQrQB0W51Uvp9oZgROsTxWhTyk2MW7IRhL8H34HxlYK4m6nQiksw+7+6BsdHOrz0gNRtbolDXaQ=
X-Gm-Message-State: AOJu0Yys9N31dMlbWeQ6DautqvywL3uWuZebKdjvm36lVnd28LJHZ5na
	SNPaiL4m+Lif2MfS0oT3i5WKAevD0SSeccklvWQZz3OQdspinYkIvSANBmPGoD4=
X-Google-Smtp-Source: AGHT+IGrx2JZaOHUbHgOAjjqs5+H2ptnSIVhy93nY5s3x5VPcvniqdkm0SstG8X7B934i3pyGqk/Hg==
X-Received: by 2002:a05:6a00:3a1d:b0:6e6:9af4:409a with SMTP id fj29-20020a056a003a1d00b006e69af4409amr3933457pfb.33.1713457952604;
        Thu, 18 Apr 2024 09:32:32 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm1674755pfl.31.2024.04.18.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:32:32 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Linux RISC-V IOMMU Support
Date: Thu, 18 Apr 2024 09:32:18 -0700
Message-Id: <cover.1713456597.git.tjeznach@rivosinc.com>
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
will be posted to GitHub [2] in the next few days.

Changes from v1:

  This version includes major reorganization of the code related to queue
  and page table management, removal of all ATS/PRI/SVA features to be addressed
  in follow-up patch series, removal of unnecessary checks, and adoption of new
  interfaces for identity and paging domain allocations.

Apologies for the delay in sending v2 series, and thank you for valuable feedback
and patience with last patch series.

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/

Tomasz Jeznach (7):
  dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
  iommu/riscv: Add RISC-V IOMMU platform device driver
  iommu/riscv: Add RISC-V IOMMU PCIe device driver
  iommu/riscv: Enable IOMMU registration and device probe.
  iommu/riscv: Device directory management.
  iommu/riscv: Command and fault queue support
  iommu/riscv: Paging domain support

 .../bindings/iommu/riscv,iommu.yaml           |  149 ++
 MAINTAINERS                                   |   14 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   23 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  782 +++++++++
 drivers/iommu/riscv/iommu-pci.c               |  154 ++
 drivers/iommu/riscv/iommu-platform.c          |   94 ++
 drivers/iommu/riscv/iommu.c                   | 1441 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2750 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
-- 
2.34.1

