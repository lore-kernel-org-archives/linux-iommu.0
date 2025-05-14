Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B791F4722
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202257; cv=none; b=GTEe+2PT/VbyHGzslZWc4N7fkK+zzk4S6u1XAGZK69wghqizmR6Hxw2Z6Nje7cxUuhzAb3E+XEY2CoPRLSD0WRm5G83nbxp8iFfdOWDtfsL23DUrM88/aDbrYGlWtVoAnqjLlQxuv4WpPAP5X86MI6D2kmE/UkaUNOo/A/MF5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202257; c=relaxed/simple;
	bh=k9d4wVwHo5YZav/2fiCXaibFEPXpZ3HGlFkqOL063qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkI5EVpN2Qohz51h5Uh8gkKoOF1V4CLJUc3A+ZRGnCaVy+NPNUJNkhdOa5c+ENmtaf5NqFbzepcujn10y4io2GflYdfm17H4+dloSbdWMoQuBjyyyUWqph757KJaY+/tLQMBcIz+959GpT58W519NpHzb3DWTkAezsYIYYuN7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FqsAt6hd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FqsAt6hd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e6880d106so44876945ad.1
        for <iommu@lists.linux.dev>; Tue, 13 May 2025 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202254; x=1747807054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7VBon2ln4fM6kR0PL6UdXDhBglynbmL1e31ZWLd3nM=;
        b=FqsAt6hd8fzAZPxCQXLHoVXUAqgkgwauEPzGZAUANMiNVJv6u3Y/JK+aE2WxyfLcWP
         mVbLmvekBI2MfEeAh0dSLIxA9eTNqHS71JlDnROjKvcmzbYq5E2uQL5VxIQfwjfMGJiJ
         2zEnPaOjVptjA0PEEjtNpsAp2oBB3QNalTPuq86qE0ItkYMmwDmiNlPfbpTUpCMTA4tN
         KryfMDyTrWNqQwwl3RL4BmaFUsMb4NB3lo3aVLFNqWqwxzObMjhpV0SSC9uPxC/xQngD
         tGNxu4XOHAR7uvWTjiEVnURj9FWn6CfBnd7DHQB6xxk9yfXVMZtaAIp4WgxDPjzy/Jcv
         J+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202254; x=1747807054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7VBon2ln4fM6kR0PL6UdXDhBglynbmL1e31ZWLd3nM=;
        b=cCrNT7tPiKgIGgZl4/Pw4QQXRh6bpYcb8n98OIM8KL+Z8QJpxrhRGzBFaQqeDmQCut
         aesPmvY8ZIjANRVZkXVq9M7FMrM8mCMnlGr469o7/3Ze0Yq0e//UlECtYlrS40n/5NLv
         X1nokhCiA3xIXoBHmSuuxaMG/31kjOA1Fi4TegJdDF8kLNZyC/VFrQnzx5LdI2jjMnP4
         M8s/YSD9338hJFxAtlnGD543TbuTJpm0lsjSpK4wqgaRP2beoIL4RapE1pByGrr2befk
         ddTBvOVZtMuHL47Lw0gLfsW+wAuoXuphHhxaPRJ0GPvL3UwBy299em1gj4NtcQeRXYvV
         u37w==
X-Forwarded-Encrypted: i=1; AJvYcCW3tRgFAXQlv+su9z5XqBDAquIrt0rVr8fVnWpze3icJsihxURGOtsuukg7OcaI9L4UVDlWCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7+Y1pDSsTKvkha1kJLDmj6pSzhUpgnRP0Y8pBZXM0GKd4ZqeY
	q00MNpC8Ru8+kNOp1Ch7R1rMeu0xfjoMd4jynFogn1YpaECAGkteK8O98Y48Jzs=
X-Gm-Gg: ASbGncuRqDvUcKJtRKiPpS35ktPfilzrpCtqQxhsAIhzQvcdVJOXF56Fa+vVIRuK6hG
	RqsMlxXlGQtOOti/Ra38l4EAZc8Snxx6gYCkQFWp372CwZztSBDopulkoGqpueH1dNSu725/4VI
	bNbgDYAQ661aGloWGdkxe3vXDAygET9ox7JLRWD9YzQraWpnmh7jSEvO4gjwcJep9XMj0+tvBGC
	razbzjhWk5a+8JK5PKlDGwX+2drDAVVmsJcH2BZKAQf2J2LjkLoFGnvXDZhKQakMAlUegZ+jCar
	abyubRN1nzY3r/otwLVn/k/Y/0W8eOiJbeAKQGc2u8R0LN9zQyO8SVBJ0p95QA==
X-Google-Smtp-Source: AGHT+IHXp/JfgXqigWBcidR4kq8OP+kMXnDiqEfkci8MHcvamvdKxF9wFw2bKIstdi8Xr6ptuIylqQ==
X-Received: by 2002:a17:902:f644:b0:21f:7880:8472 with SMTP id d9443c01a7336-231981c8d93mr39801485ad.35.1747202254322;
        Tue, 13 May 2025 22:57:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:33 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/4] RISC-V: Add ACPI support for IOMMU
Date: Wed, 14 May 2025 11:27:19 +0530
Message-ID: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for RISC-V IOMMU on ACPI based platforms.
RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
to communicate IOMMU information to the OS.

The first patch in the series is a ACPICA patch which is already
available in linux-next but included in this series for completeness
only.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf

Sunil V L (4):
  ACPICA: actbl2: Add definitions for RIMT
  ACPI: RISC-V: Add support for RIMT
  ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
  iommu/riscv: Add ACPI support

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   8 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 537 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   9 +-
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/acpi/actbl2.h                |  83 +++++
 include/linux/acpi_rimt.h            |  21 ++
 13 files changed, 692 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0

