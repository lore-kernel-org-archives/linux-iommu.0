Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADC25F784
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493097; cv=none; b=SjS/4ToqfRl2QjyFPWr19iJbPVObSJpPJbQ+7z3dbMDT1ejRcG1PVTRwmYl71pm6/QgWeEVrkMN+5GsfHybQx2J6/aavUBMTQzhMkGF8Q6Rs86IDZiXh8nBKiQJf7GbH+iR4Csf1rsFziQyrxNXNpJAZzwNBC+ji7PLrR7dDG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493097; c=relaxed/simple;
	bh=uWmg/md3Uur5G0azfupdlm5O0QlvtlmbG7Yvpw9yQX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzV+aRvGB9JqERGWSa0BUPnexm8NKK/b8kfcuipQ+JUk39OkmKj9EkZ3wKFk+F+Tvr3GyA9t2HyXUTqlJrY6HSyp2dB/MuOqEsaij3FNx6yLoh9EfOwxsMeIF8FTl2dIAm8kwAoH7vOVaH4/rIwMpZtGVQuxO46naXK3xuSEEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TTY+0+Ke; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TTY+0+Ke"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244581cc971so44551285ad.2
        for <iommu@lists.linux.dev>; Sun, 17 Aug 2025 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493096; x=1756097896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=TTY+0+KeFUjHGZBqhdnWI3i/5omWVqrUGEvCUqv0xpd2rovZ9phcSB149rI7huaUVV
         itWKfbjwp4e+GEyDajYGQNP/3cilj/ow+muHVmFrs4/SD2k6infuPTPPpy+ygO7YPrdi
         bAg0P/CKQS8JngWGV46Ey03lm4zK4rDQM5hF6fwhwDCoME3avn2fUU6EjPgrB1rc8z+k
         zcRcPa7r5qtzY4i3Vq6XESwh3liBMcW35qw65a868MZ1qTKWnPeJvcdNrVN2EO6fHeiM
         woXhEe/7l86PCjUmtp9TF3X+K/li0yQSg8g4uJOCRrLzdTF1g9w5UvQkKuY3qWkmDJbO
         m3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493096; x=1756097896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=VYeMZv6p0dyhUVbddMvM5bwCSG8uBfPr0qJ5uv9ltHVVdy4ehKQ9AN3WJFul4nyaT8
         6PCMj1JIdFM6TXF4TIFQO3KELuE3uxLZ8yyeEqIKjnQ6pxThOS7mW1SvMPeI+moO7GZa
         aRe68O+EumnuSuGcwPfnJowE/f+3G2VnTjPX5VWcJiODqs1prrt6MUturDY6dtfLbVYr
         VY8Qyi79iO0GMu+WbmEwVxP9vnlSPWRL5B5voVTn0FZ9TtouDzQMuZgKzw5Jkiq2x5F0
         VK8lFf8DWdBEKVZUN1O/KwovKp71RAw0Ct8zJkjyKVFAjpegECgNbyPnNLu1GUiSm9yv
         CEqA==
X-Forwarded-Encrypted: i=1; AJvYcCUSAJIOCa6xlwXIix1OkPEqFItmT0URNV1MfkOF2YrGSeVImqkMdMsh79K2ptck4k0F5Goc3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHclapkQTG9xP/IAp3vcikdYMNqJUJxtuQ7h/ey65k4o2vBKGV
	P6Ur4/v7AbxMZwTsBa6r6P+cMUzywVTxuIYUtbvrLj9QN0CDxDXRgDQr4dDepbQkWco=
X-Gm-Gg: ASbGncs+DOUqR7lIZxlhrdfPoJ26pSqKUqu3t/E4H8QfL5i6URMo1mqlXjgZ9/ElazT
	sEiWLZh0wMfkcQIJfeqJ1faLwF39M0z59//llL3+x0tbZSH6kFhASvrl2ZYRpJ99YgpXwGGi572
	Ay2VGvI0p+1rQKxh7v/iHR0WGr8e0hlKdDsz4F08wtSVr8Jn1Cm42wqmd5geYc9QVbx1VDPVZzC
	XIb54a+aAIeApqxWu1ltwOp8e6A49x0GcOswA54OZk6X7VXXYoOacAswZGEUKgHHwIXwiXSO/qe
	vcLouaQMbWA545nObfljk1ulHdgAzCqxj5dpZYiPSOfJCy9/AXachz7QV7lau5OAKFNwpI7dqi8
	dokdNsiviVfeAjVGzPiX1vKiVOwVoMw==
X-Google-Smtp-Source: AGHT+IFCk2BSwqNgThH6PEkau6i2nlNB+untLX8ay7e+tXj4jOXYDkG8+9f1odmZ7Mh1rjQjGkHVpw==
X-Received: by 2002:a17:903:b07:b0:243:7cf:9bcf with SMTP id d9443c01a7336-2446d71ab96mr143054605ad.2.1755493095547;
        Sun, 17 Aug 2025 21:58:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
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
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 0/3] RISC-V: Add ACPI support for IOMMU
Date: Mon, 18 Aug 2025 10:28:04 +0530
Message-ID: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf

Changes since v5:
	1) Rebased to 6.17-rc2
	2) Fixed incorrect id_out assignment (Reported by Xianliang)

Changes since v4:
	1) Rebased to 6.16-rc6
	2) Addressed Anup's feedback on formatting.
	3) Added RB tag from Will and Anup.

Changes since v3:
	1) Rebased to 6.16-rc5
	2) Addressed Drew's feedback on v3.
		a) Reordered calling rimt_iommu_configure_id().
		b) Removed unnecessary inline.
		c) Added pr_fmt.
		d) Removed redundant rimt_iommu_configure_id() stub.
	3) Added Drew's RB tag in PATCH 3.

Changes since v2:
	1) Rebased to 6.16-rc4
	2) Removed Anup's SOB and link tags added by mistake in v2.

Changes since v1:
	1) Rebased to v6.16-rc1.
	2) Dropped ACPICA patch since it is already available in 6.16-rc1.
	3) Added Rafael's ACK.
	4) Fixed few issues found by bots.

Sunil V L (3):
  ACPI: RISC-V: Add support for RIMT
  ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
  iommu/riscv: Add ACPI support

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   7 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   4 +
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  28 ++
 12 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0

