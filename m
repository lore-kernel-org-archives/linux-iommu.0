Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA078F4E
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255293; cv=none; b=BjFXCl3gvlkI2iTQb1mhNLJxFfIX5DrSFpqqbosUtcPF82UYqXLjwuREm+gsaAjYOOyC759ybSRpBd9X/0L591d83nimw9lB4rRATWknGT/oPpB6rdRTvF80U5r6GyROMI9zzCxPT/qr9MwCvdJBzIposzytAKdu2ucPsuNxxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255293; c=relaxed/simple;
	bh=LBM4mSRpBpLLuf5KUL4CdOdRDoNegAjkYl+r+qplyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCQJgbN8BbFkluV64wMGokGFMh8BnRqv5GzJuu/0ds3XTAibi61ol+GzoCXUtZ2eZZiWzuOArAOWhoMXw1eCZ/yqog6BfxHC7BvdOHsBURv7KQ7s9Limv/DkVhgNuLmkrmXXW6sifNvlYDvCxilJfUQE/2nAvAnRoOE+hcB22/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cAOpQsJS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cAOpQsJS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7481600130eso2119873b3a.3
        for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255291; x=1751860091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFeBhYBHOrC/0c43zTo39sGlheeTzLpojcRGicgsOS8=;
        b=cAOpQsJSVJyL4U54IbWcM8y7OiocL8F9JxAZAQMekDzkVVpGp7zvOhiQy8L18nOTwS
         AUtbzUpKMF1lepkrZzSWLLychYTIkJdszmpHN7UGLV6YQdICmkocgwJrNcqnzFqFdAmz
         Q/pv9RH0+8vUwBFnhI6f0iGhiHu31Fligoar8xWk8H0H493IvzpDIakpNYbfQzmkBLs/
         RHpdwX4CnIJ1NA2+s6JCKOvGarzhFDMs0iaiOnVxJZbl7bU+yp3g0AM8DqZy99kB0ut9
         dorD6Viz4gjf03+ioEre/Ng5QqKo6m6MrWtgQXoAxgvrBebKxFddVc7WaNVhHKZQe0fa
         qQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255291; x=1751860091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFeBhYBHOrC/0c43zTo39sGlheeTzLpojcRGicgsOS8=;
        b=MUq7pYqapGsZg+an2KyZE1cnGPUi1J2Tv4+1uWZu0De3upL6FhE6vA7Eb4EUAeLe5p
         bcznXOmZpjkJ9lqwcZWQjT09IHtpvH4I6TYS6Tgo3WQUrUgYa689RjkPkvbP2VZjd3Xl
         B44RORfdiofhQgRfOi5GSddO0Z8xqIegJzNtURRrOeGLlovhrPUjqhS6C/XG8t4UdN+A
         RMLJgPFOUELagIz6BR3ShsH7AuoyNcXTEgivfn6vRMkK/ToSM8nKfFLLkd2ucOFo8NIO
         SnHSHggueEiBGa1kAhq4B2XUf479zPG2BuOPD+0/qkNjHBUIsqpHA6ZLQPWAEvhmkF8E
         FNbA==
X-Forwarded-Encrypted: i=1; AJvYcCUvOapy1AQS8fWUG4ViftvYs1oSQSdFct4vErWILpUWOdFaZsJNNwfU4bwy6fflD+gQLYsIew==@lists.linux.dev
X-Gm-Message-State: AOJu0YycxdKmm7+dZkE8y+pQzRbAeaDtfNt5h7vjQN9IRZSGdVYzsae0
	Ej2z1FhVr9iYHoEpfM8BAu6+3banuR9mMjzEKNlCmcMQGeN47r8OrNurJjpEx0jQPio=
X-Gm-Gg: ASbGnctrHixLYNLXX9ke3yh3Tj4oUZ2s4o2gSDVC5zXgxm6ExaBdUACifWqe9HIv8Kv
	e6wR5V+XGXtxIfg3eCuHvJWN1Sf7AXNWKRdK/LeRQKwMJnj1QqwPgEEffWlHhTnsuGBfWxoQqxt
	Waa9aFBu2QHOJ+ckOCK9rYNlCbCOyq7DjYPRczQVdktU/8KuevHEI8p+OBxNwZTNPnsAiQkkltq
	aHNDD1lzDXwqkJJb8pBwga9jV3wHPaK/rtMIKFRUv1RrFSH5+NaFgHk9uKfNKhGg4B8wnc1bxhm
	FoV5Uh8iUWDhA23HS3E5aHD7EtYPgq6zZVsJ8C/tZTCgk8l+kCr+xAkqeTrPIBm4iV9glfsP
X-Google-Smtp-Source: AGHT+IEzTTqz9HI75CbRtfblsCPZ+bl54XYhiD9/Nlz3V+rIBZOaNxNzGv638imyLy83nUUnGEXiUg==
X-Received: by 2002:a05:6a00:3e25:b0:748:2f4e:ab4e with SMTP id d2e1a72fcca58-74af6fcf67emr16315764b3a.11.1751255291494;
        Sun, 29 Jun 2025 20:48:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:10 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 0/3] RISC-V: Add ACPI support for IOMMU
Date: Mon, 30 Jun 2025 09:18:00 +0530
Message-ID: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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

