Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5327F72C
	for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552414; cv=none; b=cWlGABO7xoT/MiCpZzWQHpYJ8ZdhDIDj1aHAvBz/cnDLqNe9rNMNuQ0t9R282VBrNM3LCXWo6e8jDhRrf5fsHm8AQ0XEYJqbRyd27ZEXtN6OzBfvzSOZSofZmYltYeNqEQPIItU+mHtgs4QJU7wz2VIwPQf6RrljLIsiRufT1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552414; c=relaxed/simple;
	bh=rFU2UJPmZv4id90emePuWsRP9dfAuwHCWZzl/IU3wDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5+Om4p6tCNl48N0BQF58Emg43k0ZVCwV6ZJ7O2BGdySMkdoJ6hh1MvA7ech0d4PbWdNlRzLBJ+qv/s2R36DlWRxofaymredXf/CtX0omAC8fDYIs5gag1OCCC3dUgDT4zYY1cJmYg+63p4S9vqUK5guluX/Nbv07/9UBuyQre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cvcConTj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cvcConTj"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7485bcb8b7cso1029882b3a.1
        for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552412; x=1750157212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MV4ZMTiUsINwR8be14xviGNX2303UWr44QeNbdncU=;
        b=cvcConTj4zzW5Rpqner4b7EopnoFyfujNyXIQMM86fUjpTUUIN2fLYtiWPws0JQEjD
         hm46WJ8MAgjee+ZEEjAr+vXHBYCcroheF5JUR864L/+HJVVW+IGNf9IAcgxA0un/zoT5
         QbhTOnbCGkXMZ9wBVpTvMWkYRrnYggtIvwCIrK8U5Lt5GSBMhmDLJLvY3PqmTaQ0PENw
         Nq8A2UWwD0ZO4XIIHoAlhNcOXk7xUVThCI12RSEQ2gXvMh2ytzCtEdle0f9QM9ZaKBXu
         TMnJJHUIXQXSqKCaORJpEBNEG4+RXSOyg+K0ypDioQ2g9AlFBAVtiRgqa5CV/K44Ymcs
         eyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552412; x=1750157212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7MV4ZMTiUsINwR8be14xviGNX2303UWr44QeNbdncU=;
        b=PfHa93USJ2O/fMathSUFyjcHKz3X/ialLOLqsOAKOiQiW/COGd5wT3r+SKPqYth4X1
         Q1hCRqBgVShlJUwLMtLAfHKQUMHAM0DKfArynaIQbsrQvonA3TDACdVGIk5+mYCSPGDJ
         wSa7LnDq+uILBq6yuD0gfR44PZ5oL8y8V7oOLvVxyo8jnmH5NaICJaJQtqBYGFKROpeA
         gu+gUBNknQkdSB97JQcrZLMqjoqcTpyD3yi9yXcabLYHks/Vcs7EaRj75ESa8X08HiCk
         se2NP7Le1LfcmHmEgt6bVBP+myqgpHUr2Na/LGL/jFnD4aKAQyJqZHwiPoc+31iCKRQM
         gpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/cMUA4tisjeheoOLwGLOMK2yq9po/Fu5eMsYkkTd01nNw5V26/xdOHLz96Akw8kMFPQDXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvIn9TnhFP9BFE6HeFDKhS1hsY/cXxTJrsKxi46S+DWuCEL1Af
	LDKM1/dYEAzrcwECzGvEo4+IgD0PIknQ0YYbh6m3kjk2/lt1Pa/W6m7lJr0ElRU0K50=
X-Gm-Gg: ASbGncv6FB8YNYK3L3iRBSjmepLv/kfo60l21PJ7zxYQEc73BX5OrYovgaaJlndyFBa
	8qlSWvLeDo+o/4N45Baib7eJMVyBq7h9dr1pveFfkcRTtRD0ZuhiUqZlraB+IUp5S1ioxVQfZUS
	4FVadur/WPYK4hsANdqqrzMX+/7ARuKQEBOq0A5NNk0yFB+arl1bY5PCrY2+PUf01bkzb206Uj/
	IRLN9KPkhKEsIoo0R5lbSesh0JrTCinMZ2mA+fSdaGvtqQouplb8/YZFd/S9zvEcX3bymGoQprs
	wqWzP3u9+vFu9zBrjgGkySJZf3J8fHazlGwVoftRH777gAfZ+udq16Q2cITC/DqNN5/GBBGEj4N
	3vuw0r2A=
X-Google-Smtp-Source: AGHT+IHiwomQ11rrELOJ2Yf8/Tcge6XeBMEJudTG7v72UH6QPTwRLqU3OkHUxntGY1aE+8OCZaxGTQ==
X-Received: by 2002:a05:6a00:10c2:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-748618a8e87mr2593505b3a.15.1749552412214;
        Tue, 10 Jun 2025 03:46:52 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:46:51 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
Subject: [PATCH v2 0/3] RISC-V: Add ACPI support for IOMMU
Date: Tue, 10 Jun 2025 16:16:38 +0530
Message-ID: <20250610104641.700940-1-sunilvl@ventanamicro.com>
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
 drivers/acpi/riscv/rimt.c            | 523 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   9 +-
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  26 ++
 12 files changed, 599 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0

