Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16666DDC4
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 14:29:35 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-64388cf3263so3207902b3a.3
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556174; x=1686148174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E+vPnkV/6+u4KNq32vBTTiL8TGRt65LegkILCc8n2k=;
        b=KT3ZEhjc9ES8ZVsBr2ikNMw73wtSWzh4Z47d8zPtu1lgyPuFMqA7VwwV9vGZ5SW37y
         MBSQZQzUOXlqyAH/WPlhJEruUeA6vRH09JsKCeJloRHHdGN+44VRCKznMVlqb6dAACEX
         rY4QqvEig87kN7V+kDf9uNihu9VwP08GNpbHcAv0sxuZ3WEs8RWfd34N6igOBg/yTMoe
         7GNzMzfOxpE93Y/1poLdOn9sU0wwciXW+YTUPjnu+jExlWcVkXq8tQ5iwF61Ewdy1p/y
         7+yJleoMtrVZAc9UDgmKmrkwOMZww8DaLoH7t7SGqTiSON85DurBae5XHh9Q+JFPQp27
         qWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556174; x=1686148174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E+vPnkV/6+u4KNq32vBTTiL8TGRt65LegkILCc8n2k=;
        b=GI3KqiqMgHR4pHSt/LkUctd6BNX32nbmSzeyZvV7mTZBV+Bpj0qRb/hS1jTQN8uDZc
         BjfUjCahKOhqr0QGLYNNwdaSE03XANELr2him7k3w6UeeD50y5NZN6bIJG+d193afdM+
         96LyIpmthX3PTxw2rYCgKSVcNQ24TS4gfpWg9vMgEKV8yoYuL0VQpsRe1iW2tiH+L/X8
         xUlp2SbBx1FlUb54UwcwEB5SfO8Anf8vlm5aWiH4jiKf+MWzkzI390Bz7T0RVy2BJi56
         KNdKKMha9JiAY+fM6K53kOwRWYWP4C9+KFZ7OW9oSNdI0WDoW5knlihyKkd0AUwfTCND
         S/0g==
X-Gm-Message-State: AC+VfDzhtVmxcaTz9Qd5MQShLmLUr8mhmANyDZhqZsaqEvacqcv41emy
	uVM3ntyDx6oBhXEGF8g/9eJV7g==
X-Google-Smtp-Source: ACHHUZ79hH5wFhuoEuXBKu2QARKi88tLOJJxJ8szDy+oplzBOr9aNkt51Kezumakz3nwNJJ1uxt6YA==
X-Received: by 2002:a05:6a00:b8a:b0:646:663a:9d60 with SMTP id g10-20020a056a000b8a00b00646663a9d60mr2974528pfj.10.1683556174393;
        Mon, 08 May 2023 07:29:34 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:34 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v3 07/11] irqchip/riscv-imsic: Improve IOMMU DMA support
Date: Mon,  8 May 2023 19:58:38 +0530
Message-Id: <20230508142842.854564-8-apatel@ventanamicro.com>
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

We have a separate RISC-V IMSIC MSI address for each CPU so changing
MSI (or IRQ) affinity results in re-programming of MSI address in
the PCIe (or platform) device.

Currently, the iommu_dma_prepare_msi() is called only once at the
time of IRQ allocation so IOMMU DMA domain will only have mapping
for one MSI page. This means iommu_dma_compose_msi_msg() called
by imsic_irq_compose_msi_msg() will always use the same MSI page
irrespective to target CPU MSI address. In other words, changing
MSI (or IRQ) affinity for device using IOMMU DMA domain will not
work.

To address above issue, we do the following:
1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
   using iommu_dma_prepare_msi().
2) Add a new iommu_dma_select_msi() API to select a specific
   MSI page from a set of already mapped MSI pages.
3) Use iommu_dma_select_msi() to select a specific MSI page
   before calling iommu_dma_compose_msi_msg() in
   imsic_irq_compose_msi_msg().

Reported-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/iommu/dma-iommu.c         | 38 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic.c | 27 ++++++++++++----------
 include/linux/iommu.h             |  6 +++++
 3 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..07782c77a6eb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1677,6 +1677,44 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	return 0;
 }
 
+/**
+ * iommu_dma_select_msi() - Select a MSI page from a set of
+ * already mapped MSI pages in the IOMMU domain.
+ *
+ * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
+ * @msi_addr: physical address of the MSI page to be selected
+ *
+ * Return: 0 on success or negative error code if the select failed.
+ */
+int iommu_dma_select_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_dma_msi_page *msi_page;
+	struct iommu_dma_cookie *cookie;
+
+	if (!domain || !domain->iova_cookie) {
+		desc->iommu_cookie = NULL;
+		return 0;
+	}
+
+	cookie = domain->iova_cookie;
+	msi_addr &= ~(phys_addr_t)(cookie_msi_granule(cookie) - 1);
+
+	msi_page = msi_desc_get_iommu_cookie(desc);
+	if (msi_page && msi_page->phys == msi_addr)
+		return 0;
+
+	list_for_each_entry(msi_page, &cookie->msi_page_list, list) {
+		if (msi_page->phys == msi_addr) {
+			msi_desc_set_iommu_cookie(desc, msi_page);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /**
  * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
  * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
diff --git a/drivers/irqchip/irq-riscv-imsic.c b/drivers/irqchip/irq-riscv-imsic.c
index 30247c84a6b0..ec61c599e0c5 100644
--- a/drivers/irqchip/irq-riscv-imsic.c
+++ b/drivers/irqchip/irq-riscv-imsic.c
@@ -446,6 +446,10 @@ static void imsic_irq_compose_msi_msg(struct irq_data *d,
 	if (WARN_ON(err))
 		return;
 
+	err = iommu_dma_select_msi(desc, msi_addr);
+	if (WARN_ON(err))
+		return;
+
 	msg->address_hi = upper_32_bits(msi_addr);
 	msg->address_lo = lower_32_bits(msi_addr);
 	msg->data = d->hwirq;
@@ -493,11 +497,18 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	int i, hwirq, err = 0;
 	unsigned int cpu;
 
-	err = imsic_get_cpu(&imsic->lmask, false, &cpu);
-	if (err)
-		return err;
+	/* Map MSI address of all CPUs */
+	for_each_cpu(cpu, &imsic->lmask) {
+		err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
+		if (err)
+			return err;
 
-	err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
+		err = iommu_dma_prepare_msi(info->desc, msi_addr);
+		if (err)
+			return err;
+	}
+
+	err = imsic_get_cpu(&imsic->lmask, false, &cpu);
 	if (err)
 		return err;
 
@@ -505,10 +516,6 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	if (hwirq < 0)
 		return hwirq;
 
-	err = iommu_dma_prepare_msi(info->desc, msi_addr);
-	if (err)
-		goto fail;
-
 	for (i = 0; i < nr_irqs; i++) {
 		imsic_id_set_target(hwirq + i, cpu);
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -528,10 +535,6 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	}
 
 	return 0;
-
-fail:
-	imsic_ids_free(hwirq, get_count_order(nr_irqs));
-	return err;
 }
 
 static void imsic_irq_domain_free(struct irq_domain *domain,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..41e8613832ab 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1117,6 +1117,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+int iommu_dma_select_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
 
 #else /* CONFIG_IOMMU_DMA */
@@ -1138,6 +1139,11 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
 	return 0;
 }
 
+static inline int iommu_dma_select_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	return 0;
+}
+
 static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 }
-- 
2.34.1

