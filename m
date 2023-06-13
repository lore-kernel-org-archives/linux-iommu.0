Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE923DB
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 15:35:43 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-39ca0c2970aso3101843b6e.3
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670542; x=1689262542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Xd9VrBwLbHtLKIQskpVMxqXuUIvC51FdoSD93zF58=;
        b=eoDG88MPohQdD8mTy13OLdX2W8nk3lkOY7N/bPjxNBYi0Vv3N8OVnfd0FU/nsMIMgl
         SsXoSqpVhq1E1lHktImYF6Ehvf6+LfsX8r6QWsdCWYRsaj+2kssVdlR4E75yiArARoFg
         VGPCHUGwSy7HUO3GHtnxBWwPoJx1RDH73dD1JWRZ4N4cifO4f3bDmNZ9aZrlm+mpA0pq
         GaFzQyLnUrf3j3rtMEjbzkGSRXFzWB/rI+GCfKBoPjbsC5mbpHv9ulNqZ/BxZEM3NSgy
         LUrS+4dmRel9oWXxqXUcrEGWFBMZOhtLij2yXuQovR7xCUgw+kubX5ePh/gS4vnvwEIC
         LmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670542; x=1689262542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Xd9VrBwLbHtLKIQskpVMxqXuUIvC51FdoSD93zF58=;
        b=KoB+d/pOr0ZFMR9AaC3ULpzKOVAnOBEZhneaOIR0Gd+7F8eMAs7AQvCYZZhtlFLuW4
         GSJlHciY69b6FqilpfTcTdfesPn7RLsOhrtr2LlyJmRQ7h7I8q4fXHiZVlalZRfniHGZ
         Vwx3mc7162P+J3PyycV8S2+MtfN3jibpMKAsqoHM9p3yUbZ3nqH+J9KhksO1NPXSY4xk
         8vwFySAQnjrDaLb0fEzkcabB+kmI7myAxefn/ZVkkZtyYFSTaRvXPfDv9i0LIn+KktGI
         4ys8SWOqrb5pv+3VmOlTEGKAcQg/rX+RtWyjX9Poq3P8h6oOjqsTVEkX/wrLWSgLiPb2
         htAQ==
X-Gm-Message-State: AC+VfDyvV6vAjumMI6mXvkvuJaxrWGL73i4gmCrdcXC4Ai9NPKKNUzxT
	Ad0AoJkVNowoSmZiayi788ufag==
X-Google-Smtp-Source: ACHHUZ4fGN6+pLsSEZtbSZN+RvQPBaMKXCh9QusFq41gaS7bI9BEqNW3PdifLeNjp8b1Uwl6EKWtOA==
X-Received: by 2002:a05:6808:1448:b0:399:169:75d8 with SMTP id x8-20020a056808144800b00399016975d8mr9406572oiv.35.1686670542358;
        Tue, 13 Jun 2023 08:35:42 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:35:42 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 09/10] RISC-V: Select APLIC and IMSIC drivers
Date: Tue, 13 Jun 2023 21:04:14 +0530
Message-Id: <20230613153415.350528-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ff37d8ebe989..19233d59be37 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -136,6 +136,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

