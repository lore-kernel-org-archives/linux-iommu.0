Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB423DB
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 15:35:13 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3909756b8b1so2344349b6e.1
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670512; x=1689262512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZx8pVyFJqTIpr4BnDr/88VmIIeD0a98LNl1bXs4aCI=;
        b=bobahJF8kidzPjUWHZY+LrqiNoPUHXIkK9UI+jd9QvV+X/+mrS/m2AnbefOsXv4q81
         dF7lTH/FeOOmnMTBgVnEA+m24ozLFeM9ocJc3P/P/b/K8prClc66SJnQnrBrH0eT2Nd9
         CeDAlxeXbZri6qrvKwsY+z8khr2WY13NbPXANr0n3a4YLwU4yrF57x8TrL3sZhLB0EAQ
         slT9whhsVY5gtQMvB5menspdXOYQqMX0tA76imnLnBLQVDJftIxhXbaSOqna+i8mCHex
         fOzUiqKCDm1M36J4iGTJT5SQlzDqf19N1w5INZFS5fhWeZMY1V+gZzeEi7UX/PMUQs4f
         zY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670512; x=1689262512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZx8pVyFJqTIpr4BnDr/88VmIIeD0a98LNl1bXs4aCI=;
        b=g10TDIGeLlfLVE3WqgUP2Nzr4LdwT6GIKwGFKWRZuK0gKIjQewBj2dja+HVzguD1hA
         1EQdKGaw7YuVQYTx4fbtM21JVSd+S+HosL7EKJt3cbeUwb3tYFUK3X+aDjQAeThRrCZ4
         RYdFVQI+RqMYxm7XGqAePlwFKtROwY2d6wrwTPy8wJ1O0v+tInSf6wszH6neP9sox4zL
         ygkh97xst0zWi7qw9m0LtvC08TPcFNbj92YB+0JjpiwYKbhM3olh0V0KMi4QNlSgj1sD
         67Dvif1yCJMUePYZJ+tqJPoWSR2BOcPXIjB4Icmv3omRBc+5FNtyeXA3AYnG5b4gNFaC
         73Uw==
X-Gm-Message-State: AC+VfDylZeC0QfLkA+HSlH6Q4RFaOp7gbHneVe+7cgw0etEHFD3uCkGG
	2di7EcrqOeaiY6v+LKTN/3kASQ==
X-Google-Smtp-Source: ACHHUZ4RbSBoRkEKSHPgVAtKK5OZ3eD2vb3A5rLfAl+gm4q9/BmEvai8MXNvxWtLM2OjtVY53qfU8g==
X-Received: by 2002:a54:4486:0:b0:398:462e:5068 with SMTP id v6-20020a544486000000b00398462e5068mr6841916oiv.43.1686670512028;
        Tue, 13 Jun 2023 08:35:12 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:35:11 -0700 (PDT)
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
Subject: [PATCH v4 05/10] irqchip/riscv-imsic: Add support for PCI MSI irqdomain
Date: Tue, 13 Jun 2023 21:04:10 +0530
Message-Id: <20230613153415.350528-6-apatel@ventanamicro.com>
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

The Linux PCI framework requires it's own dedicated MSI irqdomain so
let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig           |  7 +++++
 drivers/irqchip/irq-riscv-imsic.c | 49 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8ef18be5f37b..d700980372ef 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -550,6 +550,13 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config RISCV_IMSIC_PCI
+	bool
+	depends on RISCV_IMSIC
+	depends on PCI
+	depends on PCI_MSI
+	default RISCV_IMSIC
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/irq-riscv-imsic.c b/drivers/irqchip/irq-riscv-imsic.c
index 971fad638c9f..30247c84a6b0 100644
--- a/drivers/irqchip/irq-riscv-imsic.c
+++ b/drivers/irqchip/irq-riscv-imsic.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
@@ -81,6 +82,7 @@ struct imsic_priv {
 
 	/* IRQ domains */
 	struct irq_domain *base_domain;
+	struct irq_domain *pci_domain;
 	struct irq_domain *plat_domain;
 };
 
@@ -547,6 +549,39 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
 	.free		= imsic_irq_domain_free,
 };
 
+#ifdef CONFIG_RISCV_IMSIC_PCI
+
+static void imsic_pci_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void imsic_pci_unmask_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip imsic_pci_irq_chip = {
+	.name			= "RISC-V IMSIC-PCI",
+	.irq_mask		= imsic_pci_mask_irq,
+	.irq_unmask		= imsic_pci_unmask_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+};
+
+static struct msi_domain_ops imsic_pci_domain_ops = {
+};
+
+static struct msi_domain_info imsic_pci_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.ops	= &imsic_pci_domain_ops,
+	.chip	= &imsic_pci_irq_chip,
+};
+
+#endif
+
 static struct irq_chip imsic_plat_irq_chip = {
 	.name			= "RISC-V IMSIC-PLAT",
 };
@@ -571,12 +606,26 @@ static int __init imsic_irq_domains_init(struct fwnode_handle *fwnode)
 	}
 	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
 
+#ifdef CONFIG_RISCV_IMSIC_PCI
+	/* Create PCI MSI domain */
+	imsic->pci_domain = pci_msi_create_irq_domain(fwnode,
+						&imsic_pci_domain_info,
+						imsic->base_domain);
+	if (!imsic->pci_domain) {
+		pr_err("Failed to create IMSIC PCI domain\n");
+		irq_domain_remove(imsic->base_domain);
+		return -ENOMEM;
+	}
+#endif
+
 	/* Create Platform MSI domain */
 	imsic->plat_domain = platform_msi_create_irq_domain(fwnode,
 						&imsic_plat_domain_info,
 						imsic->base_domain);
 	if (!imsic->plat_domain) {
 		pr_err("Failed to create IMSIC platform domain\n");
+		if (imsic->pci_domain)
+			irq_domain_remove(imsic->pci_domain);
 		irq_domain_remove(imsic->base_domain);
 		return -ENOMEM;
 	}
-- 
2.34.1

