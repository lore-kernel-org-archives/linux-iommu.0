Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F328C842
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137832; cv=none; b=tbomgx4qjocPOTZ4iEemZ0L2QGkRSgefu1Q5md6lBg0xZXN0S3VZQB4BAOaY+jhxMddd8zmAT3yf9Aoq+vExeNfCWp1i5YZ6zOnGhM/B4NSA6bpmXyKDVNjXXHv/6v1WxWO/XYxYcgKDG0fyG1Dxe7k9nnc1pIxJuT3n75mqMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137832; c=relaxed/simple;
	bh=Gv1WJClC1tC4/sg2T2gWmouJ8BsKHIBADGTH0c7EWHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gembFypFoufy/XkE6702zNDXzZj4yJj5+Yu7ek71UkXVkRJsPWfHQ6uIqXnjUzuffr/h5ZZsYfg68R2yvIkG5a7OdqWduFlP8CPEw5KhBTB+r9qrTF/ug4hK6pZdxNrAJz1mZa5w0QoGe1jATbo6IyiE6fIeSzE7O5x9ayRHWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kXpt1W9c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kXpt1W9c"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e63d4b05so482943b3a.2
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137830; x=1752742630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlwOdpvqm2WGBMA6L87u6T1227AEA6wpnUUMMQcTASk=;
        b=kXpt1W9cS+naZqy9YGjCpF3X51XIY++H3BNMvSwGThqT/obNZ1a1Q/hLT5gA0WPAng
         XGSyVC8omEchoXtNVRG2zNUWIfyxYq/kqelTUCv1NxMrpuVQcmasmvh9zbBlT3ASmb5x
         tbpF1B22m1eYVjcbfB3G69Rw18C3/oQnOKc8sX/067dioEpJOIubA0h72SxJIK+SMbwY
         oDNchOObeIbMmw8lbWoU2rkV5+VSVLbTTefFIxw1ra3RPHXk+eXGUqk2MC428PEya4NM
         KqAPwrVAsx15gjwt2RE4L7egUBDrOV8KgCKDSJGLh591jBH3Dqs1pVj7xP0fqyGOV4HD
         adEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137830; x=1752742630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlwOdpvqm2WGBMA6L87u6T1227AEA6wpnUUMMQcTASk=;
        b=Exa1nAr7mOsRW6Q6XlIq1jv742OVWbHy71kN94GEhLKfcVbX1nBz7ts5+bIN86g77h
         A48dxhXyiVv/trAn4FZ3wrR8wJG9tygNKYuQnUs7KN1CrQjOkKlsED+K7O8IOqHYsMXn
         5P63iRFNHTBiKQe7yPtdNh+Txe046W+NAb5yhCna/RamgCqnbuRZMdr0/arI0oBN3Et2
         /uuEXgRavYI8uW6cddOwyioN23rSx4J5+Q6ZgRRg8qPrCxpRfhqE+Ls6Y/l5aReviMml
         v81rdUrSXKxCPAJBRcakMGimxg/SqJ0S8kidb9tlBHnWtkecQjwEnVQLIF6nGy8oZhxL
         nVSw==
X-Forwarded-Encrypted: i=1; AJvYcCWsLGfwa77yRHN1dhZxaQYuB77McIDQPeV34xNWSTyhkfvyncMAanQ4aYwWbuKeOkwhzl/4fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZilz4m2Wr3mCwrx0xRWfgRBtv6R9jqaucQG8Yf0tafcfnfLU5
	ogn3hCXqVlpFTeRo1b6ZErF1ndBhNx745PzRNckVZf+s6AfrS3cGOMeo0nMiqJg4ECk=
X-Gm-Gg: ASbGncv+m4/E0FPnL6OmiQpX1lrPyujlRGXwsMe+VroZXjUSTl+NhFHKbxgS8ZZowU/
	nBwukDxWXuarIDz5vQyKIPMVgdnHvzX3Nrdya4ucx9V7APH0911ATwZ26fVK0jFFJxgghRrLiti
	OyxpgPPz0SDMykno+wX+iTRmaObO9Kme+Y/YMdUsrLPejbfbLrPbCt2Kv0W7gZxN0Ka31mOBP5P
	J+VwtBRN49gL8WGEbwdZaGllxCP1SmyUy+iV/GsAPZJVAtLNs9zKAtNYtrx+6PfgIxJQJtjIT78
	qsuNjkAiaNaOB65N91Xi7uzVouPVvqJ/IVsU+R1B+ozQaaWZtbkL6QetXA7lCD7RdYpgZEhY
X-Google-Smtp-Source: AGHT+IG3AYRQgNXjyXFYNRoL/ZLuNKUvG5hVCj8blaqb5ns3MkUlB3z7gJs1Bhkd61noA6Imw9KgzA==
X-Received: by 2002:a05:6a20:e607:b0:216:1476:f71 with SMTP id adf61e73a8af0-23006851993mr3438087637.39.1752137830282;
        Thu, 10 Jul 2025 01:57:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:09 -0700 (PDT)
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
Subject: [PATCH v4 0/3] RISC-V: Add ACPI support for IOMMU
Date: Thu, 10 Jul 2025 14:26:54 +0530
Message-ID: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
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

