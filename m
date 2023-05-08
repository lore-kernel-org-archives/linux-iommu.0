Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9720F4
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 14:29:49 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-643a6f993a7so2198399b3a.1
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556189; x=1686148189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib+AURYSmjIxuoqk+PR8Eg/Z3fYq7w+OW68J7DC1sRs=;
        b=lhf0yTrL5foE3dgkCXYnbKFaPVDfELgWh9Qfu/YV+eeRXTgmNBLamrISJGm/kf8awb
         /Q+x7COPipzhN8O060faYDbfE9mfR23SP9HjXYhGusmHffrOHXqsmpI1CeuvtIza3iJb
         D2HJTugPooWWFNeSmHWphhPLl9HTV5glDX0ktJXkQfOxo9GqBoI+XQwkhqqVu2fbXa++
         7IVbVAbG5rwHmJWxdfwxWkg8E8AvJFCGWiFL1GD/XfG5ng5yS3gQtpftU4y0mQXFcrjF
         WuX4XDgTcmDX0aYWje38GHBLesDKvbasYOydQcOSSX1etOg97JceszynFQC+Wv6vzJdq
         tXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556189; x=1686148189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib+AURYSmjIxuoqk+PR8Eg/Z3fYq7w+OW68J7DC1sRs=;
        b=WA3iAW09czyNWS0yq2QrhYhnFDlg17AQYOoAmpm26U4Vzp1IaxDc0p/78uPtaquayH
         9tKS/u4HxASqKCmXuu0xBhWa5+mzGUtJvlLWi7JPAGgSSZ21U3N0Yr2GqBR9STzYvyx0
         Iwy5hISZi8Drxf4uLVTbt1xvetaBznJnH7tSn9Hx6eYqRJZWcCde2CruTxyZaT/dzpJm
         9VAMCy6DUpvxYxvoQkbFst4GPNhttqvdi/WhHKi7rx7jJoVMwODmeOGwLl7k9fMS2yCk
         FNLpmokMaf36liSYuyLGU578hh4Q0ycXwTzG+TaOS6ur4ms0qC0/RZS5wxBBSIEGwzd/
         RiKw==
X-Gm-Message-State: AC+VfDziccYzVw0IRvNXiC+lCq7lfUJIHkHW0l9nSE+Th0DOzuAIDsq3
	Xbpklpj+rsw2Oq7H7zFHpsKVww==
X-Google-Smtp-Source: ACHHUZ70ix2zTrDE9s+rnkB6ZVqKqawiFZ9UB6Fb2s+oNTDZtIBezM4K/5LRvwmXZR9QE5qBhwN0HA==
X-Received: by 2002:a05:6a00:b8a:b0:646:663a:9d60 with SMTP id g10-20020a056a000b8a00b00646663a9d60mr2975346pfj.10.1683556188702;
        Mon, 08 May 2023 07:29:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:48 -0700 (PDT)
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
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 10/11] RISC-V: Select APLIC and IMSIC drivers
Date: Mon,  8 May 2023 19:58:41 +0530
Message-Id: <20230508142842.854564-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508142842.854564-1-apatel@ventanamicro.com>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
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
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 491ecd7d2336..1bc2c7659b7d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -135,6 +135,8 @@ config RISCV
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

