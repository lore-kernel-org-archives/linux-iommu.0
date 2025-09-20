Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FF2C2343
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400736; cv=none; b=tQYe9xEYJFL0U0vqz4U3C3gKWv4vFZYKtvi/19umGPrXLn4rAX/nSneYCWHyTsN+EchgEspLyV6OGEdAJbRnmcwaVisKTvwR9slEMoqSZUrOBo2/hiSTvPDbGrxjJ9tn/WplsNc61kR08EuF2hOVFKxAg54YyNPr5vME070Mvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400736; c=relaxed/simple;
	bh=2Sx9zLC5MnnSHjXWv4RQRnUE5L1eBh4YFr1Q8/QsiLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAuGv1GlwzAkL57I6KxMKeSosqiAjyxuvwsAnuLP4FRy3aUW8kU6GoQRyOkmLH2n/2Qw6b9d9Go5Qqwv2IhQC7K00uaSwDJ2BrHAi0+YV/3gE9cAPHMPQoEMdPzBvIZIHFMNDMftecpJRBSVlBwdzsKWNjNq+nAsn3icdjzfj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J5htSMZI; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J5htSMZI"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42571642aa7so1017335ab.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400733; x=1759005533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhhBAyqrQkktxGVEvf+eNDaA1KtGAPXA3DGbaEzOigo=;
        b=J5htSMZIFd9OwANgf3BpxwHdSBo0w515y3XqFmQv3XaJyrE6+bY8pQLOgkspNkuse4
         u7hr3QkAJGsVkG7Ql7Cj01d2ofM39ysJ8XYJcqtz0XDyZqo9+cKKSE9s9hu+PAJMoNd+
         DhVgpsmO5XGj3t+Zpo0nIfiHNmMIwdk2iSMEzWplk1+y4bpaB8jb13jXfs1C6uNzvJ3/
         dve97RvG9X0oC1X2VvUCcZKXUqnaY0kvVoMOpuWr+MXbO1s0MSiS8BOy5c2zFsuh4ue5
         ioEXBW+at4YAX2F7YQVvHFgq8b39DucrdFxac/G0XrBdYqyPBEIotf1yN2d0zP30p3ok
         0g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400733; x=1759005533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhhBAyqrQkktxGVEvf+eNDaA1KtGAPXA3DGbaEzOigo=;
        b=K0AQx9bWPSmD2y9mflWPWcsVBBp6BtoqCJStfvupt+a+o2cXKxMJ+K+qbjug4QL7cL
         kScMGjerWYOC/6i9t572VUknQmKo1HYydtbk/++cjjxevSiDbTT/iLyINmyfkCnBSIUk
         EsKemi8ef12DwH4u1loygvvjqekz64YbTdUd8xDFhISqSzmAURQ5HZm+uuL0LqrmqivF
         MXYyslwexLL/1KxoCeCV12sKHfItcrYNR9DEb/q5x5H9sGj+wpvALy/UkBr3CnHsAwKd
         KEMUTCcyRZElo//oLUS5iaEZazu/5rT53Ht6reiz+WjyVu06tARRkfSWcbWV1WiIvtgG
         Cl3A==
X-Gm-Message-State: AOJu0Yy0tLH5KHgffBuvbxAeBkAEtHH0Ue8vCDjoJSQ/lucdstTfym1O
	rjhx3a9n95wyyKVOJMo0J5E/GMom1R1oXH4B7JM+j5fdl7+Ca1CafORiDP6E8NaGFMPMt5V9uHT
	llGdC2aM=
X-Gm-Gg: ASbGncuxOcfdO634cH4jaFjkBwPEdYa4fie0cH25LV3nDPyIbzeXw5sZWN6ReCUqWLI
	XMdHRH+UbSwj0t4LRRAWlcXS7hZ5pevzZuHUbDymDzC5i8dI365peHZLrViLKENvI8Pj0dd0B4b
	cBHNKqRcnwVP/zRS4MeM+PO5JByxOU6BLHOiHFyW0a7smCgQugtsdZ9HOnk6NgRtO8jSIdvPnT7
	7+OIyTltYoApvAbtQTqM9NilSsVjZ5iopNuBMRJ/DOBcZhLiJnIDLLe7HGW5SMfwt6m22lbicfi
	gui2yzi9/jcSfDZfFPAm9mZugFyp5SzETT9pipcD/fWYv8iDFv8ITyvhxAuPAr+sPnpEeOKGRT+
	cSBf/2YUqIVJTQEZ0SBQwQ4A3
X-Google-Smtp-Source: AGHT+IGwK4PrAd7CyoBUGRZ3PUQqWIF5Zj/5N9zpz7O49heeJaggKCpHt+afTDzWqXDEvIoleQehPQ==
X-Received: by 2002:a05:6e02:12e9:b0:424:bec:4a01 with SMTP id e9e14a558f8ab-424819743bbmr104189845ab.16.1758400733061;
        Sat, 20 Sep 2025 13:38:53 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9fbfsm39814525ab.26.2025.09.20.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:52 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 00/18] iommu/riscv: Add irqbypass support
Date: Sat, 20 Sep 2025 15:38:50 -0500
Message-ID: <20250920203851.2205115-20-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
---------
This is v2 of the RFC for adding interrupt remapping support to the
RISC-V IOMMU driver along with support for KVM in order to apply it
to irqbypass. v1 of the series was discussed here[1] where a couple
large design flaws were pointed out. Those, along with a v1 TODO of
referencing counting MSI PTEs in order to track when they may be
unmapped, have been addressed in v2. Additionally, v2 is based on
msi-lib, which didn't exist at the time of the v1 posting, and on
the recent KVM irqbypass rework.

Description
-----------
Platforms with MSI support (IMSICs) and implementations of the RISC-V
IOMMU with an MSI table can control device MSI delivery, including
directly delivering MSIs of devices assigned to guests to VCPUs. This
series enables that control and enables IOMMU_DMA in order to use
paging IOMMU domains by default. When the IOMMU doesn't support an MSI
table (it's an optional IOMMU capability) then paging domains are still
used, but the system does not have isolated MSIs. For direct delivery
to VCPUs an MSI table is required and thanks to KVM+VFIO it's possible
to determine when and how to map guest IMSIC addresses to host guest
interrupt files. The RISC-V IOMMU and AIA also support MRIFs (memory-
resident interrupt files), but support for those will be posted as a
follow-on to this series. Also, additional work will be done in order
to take advantage of the RISC-V IOMMU's second stage of paging. At
this time, the series just uses the first stage which allows testing
with unmodified KVM userspace and VFIO.

The patches are organized as follows:
  1-4:  Create an irq domain and some function stubs for an initial
        interrupt remapping support skeleton
  5-9:  Add MSI table management to enable host interrupt remapping
        and enable IOMMU_DMA
 10-13: Add IOMMU driver support for directly delivering MSIs to VCPUs
 14-17: Add KVM support for directly delivering MSIs to VCPUs

The last patch is a workaround for a KVM bug not introduced by this series
which is needed to enable testing of the series -- I still need to debug
and fix that properly.

There series is also available here[2].

Based on commit 39879e3a4106.

[1] https://lore.kernel.org/all/20241114161845.502027-17-ajones@ventanamicro.com/
[2] https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v2/


Andrew Jones (13):
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  iommu/riscv: Move struct riscv_iommu_domain and info to iommu.h
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Prepare to use MSI table
  iommu/riscv: Implement MSI table management functions
  iommu/riscv: Export phys_to_ppn and ppn_to_phys
  iommu/riscv: Use MSI table to enable IMSIC access
  RISC-V: Define irqbypass vcpu_info
  iommu/riscv: Maintain each irq msitbl index with chip data
  iommu/riscv: Add guest file irqbypass support
  RISC-V: KVM: Add guest file irqbypass support
  RISC-V: defconfig: Add VFIO modules
  DO NOT UPSTREAM: RISC-V: KVM: Workaround kvm_riscv_gstage_ioremap()
    bug

Tomasz Jeznach (4):
  iommu/dma: enable IOMMU_DMA for RISC-V
  iommu/riscv: report iommu capabilities
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
  vfio: enable IOMMU_TYPE1 for RISC-V

Zong Li (1):
  iommu/riscv: Use data structure instead of individual values

 arch/riscv/configs/defconfig     |   2 +
 arch/riscv/include/asm/irq.h     |   9 +
 arch/riscv/kvm/Kconfig           |   3 +
 arch/riscv/kvm/aia_imsic.c       | 143 ++++++-
 arch/riscv/kvm/mmu.c             |   2 +-
 arch/riscv/kvm/vm.c              |  31 ++
 drivers/iommu/Kconfig            |   2 +-
 drivers/iommu/riscv/Makefile     |   2 +-
 drivers/iommu/riscv/iommu-bits.h |  11 +
 drivers/iommu/riscv/iommu-ir.c   | 698 +++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 158 +++----
 drivers/iommu/riscv/iommu.h      |  75 ++++
 drivers/irqchip/irq-msi-lib.c    |   8 +-
 drivers/vfio/Kconfig             |   2 +-
 include/linux/irqdomain_defs.h   |   1 +
 15 files changed, 1063 insertions(+), 84 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.49.0

