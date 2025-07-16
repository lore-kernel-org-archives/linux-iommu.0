Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F76239E62
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662471; cv=none; b=AARgPZwNUUbtt8QEvqJ2+8A0I4HR6ZWSUlTlnAVorpK58Tzs1x22pUABXWIVpk66GMt4UsT6d8IEaQFb+ltAnqnDJw3Wq3JcAlrz86Df+Jtl6bWjQhXXtNi/PtodBXV3wvmamkon7d3uS1OULNXr3t8vW5es0r/+k1YM+DNrKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662471; c=relaxed/simple;
	bh=eEuw9YtoJmJDZlsM1s2G9AuMfudEACJhCJfjNjUaCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pyj+hDnLlGbkV8p5rorn/bZ2p6xBDTnTXgu4U54K/wO9JBy/QmnyMPtJumwebdC7xleT+XDpdXF3FT9hunjwqbvMZaGkIXzJvvTPaE09LFzElWRWCYw5/neDFq0qhkbqZq6imxfm4FLu5eSZkIzPWpjfWlOReHGhwreR7MeOOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BRLRuUpX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BRLRuUpX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b52bf417cso4088297b3a.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662467; x=1753267267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=BRLRuUpXl18uu62q5mswKqYe9qaAk3AKraMg0ZVxBqdqSSqbhOLTIvO0p+OPhObBwO
         gppA6olu0jqaPDgdt1xzu63vKD2PiA+yIMVXSD6BV8ky5TVLXZu0vKKXR7UtdWL9FB70
         3jwyHyydfmyYdQrwny+JSYM1WQdZDZAgXGHKxQq3+vlilTQn8WDjrUF0E0sz7wSk19Ew
         MI34w6WSw83h5FFr0qmWRapW9YeExNEJPxsjHq6efkD4Gs1FRp5KjN+tyiRyW9UxzLix
         KoMWwJtVIW1E2qzOGg/o4gK5onGXSKGIfxCJpuwkzRmfPvQWgOItrEG7PXyDm04Y/B/y
         x/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662467; x=1753267267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=bsxSjl4wblAtPjCJdEh0dMNanVYfMKxZEtmHq6ySedkrATnOBSWtChClOmNjq93xfU
         SN0KsUUHL9v9lbfkOUu5ssIxd/vyLQ+jF41RG7zzxE0utm93eiPPKLrCkoIsF2Qx4MpF
         kAxpkWdXFuVAye+4UygMfkFmZ8/LbZ7yZD+g5WmaToOme/jVeTbqfN9phEoqpZ3KzJgy
         so1Mh4FznsSKPwUklOCPlXsR1lv2LwJ9FIGEm+PU5l0jBAuMnA/gk0ozZm3bNQZhKtBi
         +CUOAmutEzO/3McBY3hkUU5YuUWXRHrAwh06CPwqT5cU/ZN3gQPJfjiSOS89HaOZf9o/
         GGWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z5UTGp+EaYWMQ9uUXlIQSIbfCgJL5r/PzWYwPj5vA6fcB6Gq90ewOAyspd8wZUwsXTUBvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcYh4CUvulvXfr0wA2y/1bmTY33zrX7C1UTHHJ6+FNU84uERCL
	0K32Dl5SgNffOxCUaTNM3Db7x6FNiFTzABXOOaff/dalAyfYUjndbz4YBuwZS3Lay/8=
X-Gm-Gg: ASbGncsikar5ALimEZR0Htr6LhnEjo2kTpAqzP1AJ4opKIac3PoD4UHNvQxxXgV1sNE
	wd9MGMlaaxk9VRI6610nNTXNNaHHUmlknMAbuSUumtO344Tz6j+0olLnCHKl2d31v1Jt8mOyuJJ
	BCqQ5ngMfdpw8Xz3Z6aZaC3W4IuRApKdCOxSRfsOX56mXqGk4/T0FT+QeKbu88XEQRMYsypcH+k
	auluTupok0fK9hyqAAnNkfuCU5H0HKeaYWNpWn8G9mMG17R9/UOuiTk+xQ8f6IhBeerPk/Rn0CB
	3wIX6Dhf1Ta86ympgx0GfL+S8Whs+A7GW5048EWCXFi0RNDM9dCi+WOnngEW5qciMebQ46QGhsU
	ltqm98sWwMVTsfnNEO1WUlfJlyNHBVmrv1NRy1tx6mU8=
X-Google-Smtp-Source: AGHT+IE3037YRMGIAaI7C47Ttp1jNsxpPaygBpXftTBTzmjePBr4Bv4yntp0VcQZcAzTwEwQx0RJ2A==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr3013646b3a.23.1752662467352;
        Wed, 16 Jul 2025 03:41:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:06 -0700 (PDT)
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
Subject: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
Date: Wed, 16 Jul 2025 16:10:56 +0530
Message-ID: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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

