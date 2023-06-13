Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586D23DB
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 15:35:50 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-39c7f78c237so3592703b6e.3
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670550; x=1689262550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjPmtbt5dpp3nV1ppkSLOwXIjTqZCsmy4toORZe/818=;
        b=Swu4hszULQzPuPzBt7iqf7LrNn3pbjBkMCsVSv0eHYkgdWXz+ssLl7XTId4Nr5rzC+
         8a3/nOLQ58HBh1itV5d3Zm1Q5o/F/sG56/XMn/lM7XnGldDZFhvJaLBGVX3ct4r9PaUq
         5xO2UMfIQ8LB3/+IweLxBeFM5jNSHy8V6LJ2QcsPHefylqBWPP/Fg76wn8cuwCSZoYE0
         Hn3w6RKopilic4uboB8qNvybBC/uHDgpVqXXH5WZGqI4sWPZATWZqmo2PQA7vdOSKVnH
         ZyKKq+H3CDcbycD+IazyO/GnO4bAGuQlmH8rMA4VeTT5U46wMBVBwupa7M1pKv9PNj6p
         5Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670550; x=1689262550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjPmtbt5dpp3nV1ppkSLOwXIjTqZCsmy4toORZe/818=;
        b=WYpO/PqjWKmundzyJ8bF0kPFzxQgLCqhQ0X0kl+CGH0g5bJPKfS2kmrXYhazoFZrYE
         EbUmChzyLgvKjwnL/RX2wtFeIuS5QGlu1Buc1x5N+Z13dJ7qJXsDQ1gJqflXcW8rEkgq
         zkJdrCLNg1D5gOEBhM8E6auufjb+wXHOVMDfkag2KkGj63TyIvXLUId00uDrCpkKDa1V
         EKDLvHWxpNmaiHNvVrz981e+J44RbBmv8C7nac4rR9qlV/wXWMS9O+WVpgpWYzrqUmNB
         Ln/XZZUEiRvfU25YuWd1kFAXxuRuz8zkN4ClHcV4R/bgNqnaAbFOB51NjVZCHt2aO5rm
         3aPQ==
X-Gm-Message-State: AC+VfDyygB2N1ecQNbAi0ebjodoce/Zs3Y1nf7szew3JO98+jzd4yCCs
	nvzNCEu19uzzNW2K6oLy3IaluA==
X-Google-Smtp-Source: ACHHUZ7Tg1xp84o5UNsIGFouFyCklTip/xPfGoAYw3cqzXxDnJEowsGdk1gdK+IhU0wBCwPu3ab6ww==
X-Received: by 2002:a54:408e:0:b0:38e:d739:6f3f with SMTP id i14-20020a54408e000000b0038ed7396f3fmr6723088oii.56.1686670549823;
        Tue, 13 Jun 2023 08:35:49 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:35:49 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 10/10] MAINTAINERS: Add entry for RISC-V AIA drivers
Date: Tue, 13 Jun 2023 21:04:15 +0530
Message-Id: <20230613153415.350528-11-apatel@ventanamicro.com>
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

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51da90e60004..2d474eb902fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18136,6 +18136,18 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic.c
+F:	drivers/irqchip/irq-riscv-imsic.c
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

