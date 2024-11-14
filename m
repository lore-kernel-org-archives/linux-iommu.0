Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5714E2D6
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601130; cv=none; b=pkuiAyVyNJZvv+bfza8GyJA69r6EK4XIfvv4IF4BYbnUskouANOfKV48aG3tG9jVzRqdOFsHmNYVNZBfUKatGZrY7um7klIXAJPlXIUJU/+Db5huKc0lacaabDXHRC0Y88fBZ3kTBbBwPaBwIIw9ipJa0Lbo4C+RLApkqD2Kb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601130; c=relaxed/simple;
	bh=lyZC4By9Ar4lY6HLPHxQpNiCLgIv0jeWjlSxPE9suGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovfTAZGeOkuWHgxhkKoixlyW4Wfn8lM91jzbBi/Ezse1+nNU6FAwPagz3d9NtgAJ5RG9KWJPb/HrS5AP3qkJJ+3mwqW+zMhr5uoJRBfPn9miotveu+7g4RGE5NohvSmp0Lh8Eu0HlYgXx6P4248y/3b851qdin5yvUbGhbpW93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LNfKItJ6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LNfKItJ6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso7179145e9.3
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601127; x=1732205927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7BJqdeVq7UVKuF/HMX90zKjA2XSvBJJooO0qYOgVYo=;
        b=LNfKItJ6B9t8tMwafdcBOdOiB64U/BJGbosZhdWfznDF8+i8F9WNP0+x2vQ73JGaVJ
         ujqZ6qjjDfU5AEaWsrlC/4FJycFoLWF6Odadn0x+lz2onJ3zglFbvy6BpDrIkfCmn6+s
         gqsBHDzITe+CSB+dmW817mrCvg4GxbpiCFntBHBcp/1sciIN5u+GxSWMsNR4waVkWqZT
         HALjy81+ZmVRJEprNP87K0W9PN4n6XPo1LQr9k8Z26bDdDp16EPVFwlKI7GVjkEdRjcY
         MfDXTAEaVZu5/J9efS70FsHwCoZ6+mv9YcHCdeuLU/SIJFiY5su/L3VXRt4BVJK5rJq2
         lgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601127; x=1732205927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7BJqdeVq7UVKuF/HMX90zKjA2XSvBJJooO0qYOgVYo=;
        b=tJcptXRy1oRwyxt9zRTvgB3TFLMD6eDh0hgT2ANyrKuuxkcCNc1zEzqoNYAB+UY0Es
         /u0QFnRVa7CgowouKAbMMMZAdKJQiFiVYiVgMSLAIZRR9XqF+VIQJ5sAOYillt5xkyMv
         THqDkhMAmEGcikPmpCNSmrrHZmZim342bYVwxWQLEh9TT9KVnnY1ATJV0EMgiqBIep9s
         4dCVJ+S21hIVqpHomNZAJ5ZirDqA7+CjNNCnuH8818kM8XILJBDN6U32Ab353PK1f+WF
         I4K0DHLbrTpRvKjKTZ6zTwfmOnwFKVC2gevtmIIJv0Jrta6nEkAdCMAKWm0zegYNRY/p
         o+FQ==
X-Gm-Message-State: AOJu0YzYPY8gTGL0/BNK0wZ3oAXc+lCwdugjnBlfEXpKEMeNfusyygIc
	+klPY+FXGIoGHSycQDO5ZCXWB09idSf1v2RpFN53eIka0wmyF6E9rl98ZoDaKJWfGfgayi/X0sU
	XTcM=
X-Google-Smtp-Source: AGHT+IGmsJWy6Z+mGpYkwKc89nKAhzRkstEPPTX+iWcGxi/SAriHdno919nTAwdEP/fS42LcKsW+QA==
X-Received: by 2002:a05:600c:1d88:b0:431:5a27:839c with SMTP id 5b1f17b1804b1-432d4a98364mr70171705e9.5.1731601126807;
        Thu, 14 Nov 2024 08:18:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265f28sm28998355e9.17.2024.11.14.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:46 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 00/15] iommu/riscv: Add irqbypass support
Date: Thu, 14 Nov 2024 17:18:45 +0100
Message-ID: <20241114161845.502027-17-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms with implementations of the RISC-V IOMMU and AIA support
directly delivering MSIs of devices assigned to guests to the VCPUs.
VFIO and KVM have a framework to enable such support, which is called
irqbypass. This series enables irqbypass for devices assigned to KVM
guests when all VCPUs are allocated guest interrupt files. The RISC-V
IOMMU and AIA also support MRIFs (memory-resident interrupt files),
but support for those will be posted as a follow-on to this series.

The patches are organized as follows:
  1-3:  Prepare to create an MSI remapping irqdomain parented by the IMSIC
  4-6:  Prepare the IOMMU driver for VFIO domains which will use a single
        stage of translation, but G-stage instead of the first stage
  7-8:  Add support to the IOMMU driver for creating irqdomains
  9-10: Prepare KVM to enable irqbypass
 11-13: Add irqbypass support to the IOMMU driver and KVM
 14-15: Enable VFIO by default

This series is also available here [1] and may be tested with QEMU recent
enough to have the IOMMU model.

Based on linux-next commit 28955f4fa282 ("Add linux-next specific files for 20241112")

[1] https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v1/

Thanks,
drew


Andrew Jones (10):
  irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  irqchip/riscv-imsic: Add support for DOMAIN_BUS_MSI_REMAP
  iommu/riscv: Move definitions to iommu.h
  iommu/riscv: Add IRQ domain for interrupt remapping
  RISC-V: KVM: Add irqbypass skeleton
  RISC-V: Define irqbypass vcpu_info
  iommu/riscv: Add guest file irqbypass support
  RISC-V: KVM: Add guest file irqbypass support
  RISC-V: defconfig: Add VFIO modules

Tomasz Jeznach (3):
  iommu/riscv: report iommu capabilities
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
  vfio: enable IOMMU_TYPE1 for RISC-V

Zong Li (2):
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: support GSCID and GVMA invalidation command

 arch/riscv/configs/defconfig               |   2 +
 arch/riscv/include/asm/irq.h               |   9 +
 arch/riscv/include/asm/kvm_host.h          |   3 +
 arch/riscv/kvm/Kconfig                     |   3 +
 arch/riscv/kvm/aia_imsic.c                 | 136 +++++++-
 arch/riscv/kvm/vm.c                        |  60 ++++
 drivers/iommu/riscv/Makefile               |   2 +-
 drivers/iommu/riscv/iommu-bits.h           |  11 +
 drivers/iommu/riscv/iommu-ir.c             | 360 +++++++++++++++++++++
 drivers/iommu/riscv/iommu.c                | 183 ++++++-----
 drivers/iommu/riscv/iommu.h                |  78 +++++
 drivers/irqchip/irq-riscv-imsic-platform.c |  18 +-
 drivers/vfio/Kconfig                       |   2 +-
 include/linux/irqdomain_defs.h             |   1 +
 14 files changed, 776 insertions(+), 92 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.47.0

