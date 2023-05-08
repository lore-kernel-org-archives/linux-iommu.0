Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF7DDC6
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 14:29:30 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517bdd9957dso3058245a12.1
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556169; x=1686148169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZx8pVyFJqTIpr4BnDr/88VmIIeD0a98LNl1bXs4aCI=;
        b=dTnj8jF9WIu+jQo5yru3eJjRqiAEHZBZJ/aJ7cgeYj1zF9lv1xflSCfcl+LSKqGaIV
         jfZ1+t1HwtTt4GwgZN4XIOqbWYNhXDuQf/JKZTk9qPDhdLmaU8lezhkQeblu/H1yu1E1
         Cv1IzlK841t90PK+K6bgn9E61JdlrFKX+7uMjSs2uLq/7V3lN2WDOAc3v3Pzwoyzqp7f
         QnN2moOnjD+ijPu/4+Rjz6CoJ+FC/Gg6vZ2w9ps1LXA1H50BzOFIWUUp2TeV+G3C3cjD
         w+2EcfAuNkf2HweC4ChcYrYIR7rD9bHgJBlMPvEf31IwarO+gcTz/fKSUPbeyqTAuUBL
         2ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556169; x=1686148169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZx8pVyFJqTIpr4BnDr/88VmIIeD0a98LNl1bXs4aCI=;
        b=ME1NgL3QK6BaKUI1+PrYpfCfZXyjDMZUKvJ2xcl6s9CIYMnznAuWy/DputpyDLqEd5
         Hp5ByUA4RbEHSxTOb2WFn20F6qKuaZwVPewZ1cZQZCi61LX/ddKUftvwWFuzCb9NzoNm
         OCUz1CsxoP33aEk1XwIQBUq6+EqvW59ABwZF1lzWVQYpmLjXw5LEs20XO9y3pls5/gNw
         zL9ymNGPdhMFCbwVX3z6Pa3commXMy46jnf5T6bokwy+FDfMtIZTOEpFb7aOSNVmvP+U
         LVD6uxZwCyfL3e7qPSaXh6Hi9eXSVgHXXEkcRvu0jad2F3FI+gJr+5VvHy/bvUhTtJ/1
         2UTA==
X-Gm-Message-State: AC+VfDxYUz2NuT+h4Z1LkFvyNzRnxyT7pyQBgd40gFxwl+B08fh7TKrW
	YDWsMXWa2TY3Pgs41vmixPwWvw==
X-Google-Smtp-Source: ACHHUZ7uHyXdoGyRXbKaY6kklyMIWJI3o768YEmZqRcW81svn5/B1xtVVAkqcXoSxAkeEozUbYGp2A==
X-Received: by 2002:a05:6a21:339c:b0:100:2c5c:8e69 with SMTP id yy28-20020a056a21339c00b001002c5c8e69mr5992538pzb.49.1683556168895;
        Mon, 08 May 2023 07:29:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:28 -0700 (PDT)
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
Subject: [PATCH v3 06/11] irqchip/riscv-imsic: Add support for PCI MSI irqdomain
Date: Mon,  8 May 2023 19:58:37 +0530
Message-Id: <20230508142842.854564-7-apatel@ventanamicro.com>
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

