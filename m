Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E841FB3E
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 19:34:24 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a43cbb4343so34131b6e.1
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795264; x=1690400064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=898LnY9cJ7dwalJq3UYz/mDCfelRokl75v2pZe5QKSg=;
        b=tMmyEGaoPTP9a//tyRq8ynyPcoPNJdciVKPWijs/mHL/jvUK6t+mofl3RDIRUrqhHH
         6A/Bgjz2ykqJKTI4hg3/XFEN7w4lXR5J/KP1u8uT/YTr6Z+6jXCc0FUOD+0HnKbrdq0h
         j/v+Lliv5+aYmrGP/O3nneO/w19BZwcbfi2o8LKoDxmKmwcbs3q02CZjSMkjuIizzTqx
         kBe5/+rvpVf3k8KLJ8u+xQ6vhFwDqSNyCkQdHz33+jKYYJ53toPXjTQJUP638HtzYjtG
         /JWV9aAZdC4MEkhGhyqQfUsKtc8nGwEeNKSA5xeoRVY+a3ZhjczWtNCXH+tJRdEwAUq2
         u8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795264; x=1690400064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=898LnY9cJ7dwalJq3UYz/mDCfelRokl75v2pZe5QKSg=;
        b=AG8+YTeo/0xyaQMpx7Qb4fpfwmFj3eRseqavLnjl/wi3+b1DQSZXPuvUHaX9l7mFcL
         jh07pstc6hmUYGdnCk3AUFThmN7U4EkTOMQmX0M2h1+T3iNEEwemDk3du6kuX9bg606I
         90CfnhiZ9IaSn5wlSIF4GGP3YTXsdVby3PDKbAoNEmNJcIs8UwViM23rWPXEkQ9/+Ts2
         5d+15V8ptRnG8Zdp7cgWewtNT1Ue466p7LpTPi9QbHzxrPfcfvSanUhFSf0yACgOGbn5
         R3yFInCAI1EZpeCAUzrYWknziEkddLbK0utV5eGJluQ1/CRsItq2tdADtRi/lqqdhA2V
         6mjw==
X-Gm-Message-State: ABy/qLbt7H83f4/2eTtwxSiSbXMGXDqiNzshL+Jc1LnvckltJB8uR+Gg
	aH2YdqqxGgl9mnUYp/SsUP8mXA==
X-Google-Smtp-Source: APBJJlFS8kYmxrMQdI6vVbg8tjqWVgqnH6tvKbzas7Xx07kyU9Ed8nJU/Yakj0txh6GAxjHkYRUqBw==
X-Received: by 2002:a05:6808:19a5:b0:3a4:6cc2:893e with SMTP id bj37-20020a05680819a500b003a46cc2893emr488344oib.56.1689795263740;
        Wed, 19 Jul 2023 12:34:23 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:23 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 00/13] Linux RISC-V IOMMU Support
Date: Wed, 19 Jul 2023 12:33:44 -0700
Message-Id: <cover.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

The RISC-V IOMMU specification is now ratified as-per the RISC-V international
process [1]. The latest frozen specifcation can be found at:
https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf

At a high-level, the RISC-V IOMMU specification defines:
1) Memory-mapped programming interface
   - Mandatory and optional registers layout and description.
   - Software guidelines for device initialization and capabilities discovery.
2) In-memory queue interface
   - A command-queue used by software to queue commands to the IOMMU.
   - A fault/event queue used to bring faults and events to software’s attention.
   - A page-request queue used to report “Page Request” messages received from
     PCIe devices.
   - Message-signalled and wire-signaled interrupt mechanism.
3) In-memory data structures
   - Device-context: used to associate a device with an address space and to hold
     other per-device parameters used by the IOMMU to perform address translations.
   - Process-contexts: used to associate a different virtual address space based on
     device provided process identification number.
   - MSI page table configuration used to direct an MSI to a guest interrupt file
     in an IMSIC. The MSI page table formats are defined by the Advanced Interrupt
     Architecture specification [2].

This series introduces complete single-level translation support, including shared
virtual address (SVA), ATS/PRI interfaces in the kernel driver. Patches adding MSI
identity remapping and G-Stage translation (GPA to SPA) are added only to excercise
hardware interfaces, to be complemented with AIA/KVM bindings in follow-up series.

This series is a logical regrouping of series of incremental patches based on
RISC-V International IOMMU Task Group discussions and specification development
process. Original series can be found at the maintainer's repository branch [3].

These patches can also be found in the riscv_iommu_v1 branch at:
https://github.com/tjeznach/linux/tree/riscv_iommu_v1

To test this series, use QEMU/OpenSBI with RISC-V IOMMU implementation available in
the riscv_iommu_v1 branch at:
https://github.com/tjeznach/qemu/tree/riscv_iommu_v1

References:
[1] - https://wiki.riscv.org/display/HOME/Specification+Status
[2] - https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf
[3] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-20230719


Anup Patel (1):
  dt-bindings: Add RISC-V IOMMU bindings

Tomasz Jeznach (10):
  RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
  RISC-V: arch/riscv/config: enable RISC-V IOMMU support
  MAINTAINERS: Add myself for RISC-V IOMMU driver
  RISC-V: drivers/iommu/riscv: Add sysfs interface
  RISC-V: drivers/iommu/riscv: Add command, fault, page-req queues
  RISC-V: drivers/iommu/riscv: Add device context support
  RISC-V: drivers/iommu/riscv: Add page table support
  RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
  RISC-V: drivers/iommu/riscv: Add MSI identity remapping
  RISC-V: drivers/iommu/riscv: Add G-Stage translation support

 .../bindings/iommu/riscv,iommu.yaml           |  146 ++
 MAINTAINERS                                   |    7 +
 arch/riscv/configs/defconfig                  |    1 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/io-pgtable.c                    |    3 +
 drivers/iommu/riscv/Kconfig                   |   22 +
 drivers/iommu/riscv/Makefile                  |    1 +
 drivers/iommu/riscv/io_pgtable.c              |  266 ++
 drivers/iommu/riscv/iommu-bits.h              |  704 ++++++
 drivers/iommu/riscv/iommu-pci.c               |  206 ++
 drivers/iommu/riscv/iommu-platform.c          |  160 ++
 drivers/iommu/riscv/iommu-sysfs.c             |  183 ++
 drivers/iommu/riscv/iommu.c                   | 2130 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |  165 ++
 include/linux/io-pgtable.h                    |    2 +
 16 files changed, 3998 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/io_pgtable.c
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h

-- 
2.34.1

