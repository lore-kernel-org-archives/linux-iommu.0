Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B211BB3D
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 19:34:36 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso4219807a12.1
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795276; x=1690400076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUXvXbLuP8wDy1OSCml3bGjGEs0jCX+1NqTNk6KKpl8=;
        b=yJG+r2hMaEM+aliN8AVg0otRKaB4Z8eB26rded4dmVlMEf7QPzs7oXMfpQmJMKL++k
         pDvxPqx/ZqxGapQ8WSH3D2kxHKnBm3x9Q5Nio4OahuUSf/B/GgPdLMDrg7z5Sq1B3ikz
         UeH/z3vVIqFc2rMrJ9TpbVfnlAuwcYXAo6tCGKDkTZV8bY/H0jQvKdPnhjLxXacZpTy/
         iW900N9T4LgH9r16t39SqEYpRVL8dfRWtJHsro1fR6D0IcienUrOo4o6hxfggu3gqr6G
         4XvpBJFV2BHbmMGsUPaauELDeBsOihKwyQFkYQ1vNuTpXydFhJ5707WI9dxod6GTdPZl
         oKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795276; x=1690400076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUXvXbLuP8wDy1OSCml3bGjGEs0jCX+1NqTNk6KKpl8=;
        b=ASb8UsopZnk8haaaZe53fVNxWjUZ/erth5y7jFXs2dkVJoy2HSk+f6I9jqfyQwR+f/
         jKKPKBBBut6tlG7QbpMUnShw9gmr/GZ6m+tgpD4IOAP8wlbAeg2CRfGcNIjG3qr1UkXG
         skK0vRsYeYBKSFQrEV+MpDo0lyuQNbHbOCTeiJy8gHi4qyUaJZHcqomF7hBEhEcQoXaF
         u/6JuzWx6vRKKfaLTpiKWsZjV9GaDBIuy8mpr8qiYP+G/PILPKoS6YaKkXDYaSTgx8nC
         O1k0qlbGsNozvY2674Cpsf91TvsGIoyeuNBo6l+ZLF9tj9pQn/vSTEQDkQFVuQ0neiMn
         5k+A==
X-Gm-Message-State: ABy/qLYKZcm06R5D1wdgI8VVe3mmqJyDUv6RyogPpdm+Od9OSfQmCrbj
	ThDW9O83Z3/uTLGaUul9pmBv7w==
X-Google-Smtp-Source: APBJJlGbDD5aTGEi40JcY4RNgasjfgy48ieoko/t1uTH9H4BvKdLkbsHdSPwZCOuiw6bztkQOdloJA==
X-Received: by 2002:a17:90a:aa04:b0:263:f776:8ba3 with SMTP id k4-20020a17090aaa0400b00263f7768ba3mr197600pjq.9.1689795276298;
        Wed, 19 Jul 2023 12:34:36 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:35 -0700 (PDT)
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
Subject: [PATCH 10/11] RISC-V: drivers/iommu/riscv: Add MSI identity remapping
Date: Wed, 19 Jul 2023 12:33:54 -0700
Message-Id: <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change provides basic identity mapping support to
excercise MSI_FLAT hardware capability.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 81 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  3 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 6042c35be3ca..7b3e3e135cf6 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -61,6 +61,9 @@ MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
 #define RISCV_IOMMU_MAX_PSCID	(1U << 20)
 static DEFINE_IDA(riscv_iommu_pscids);
 
+/* TODO: Enable MSI remapping */
+#define RISCV_IMSIC_BASE	0x28000000
+
 /* 1 second */
 #define RISCV_IOMMU_TIMEOUT	riscv_timebase
 
@@ -932,6 +935,72 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
  * Endpoint management
  */
 
+static int riscv_iommu_enable_ir(struct riscv_iommu_endpoint *ep)
+{
+	struct riscv_iommu_device *iommu = ep->iommu;
+	struct iommu_resv_region *entry;
+	struct irq_domain *msi_domain;
+	u64 val;
+	int i;
+
+	/* Initialize MSI remapping */
+	if (!ep->dc || !(iommu->cap & RISCV_IOMMU_CAP_MSI_FLAT))
+		return 0;
+
+	ep->msi_root = (struct riscv_iommu_msi_pte *)get_zeroed_page(GFP_KERNEL);
+	if (!ep->msi_root)
+		return -ENOMEM;
+
+	for (i = 0; i < 256; i++) {
+		ep->msi_root[i].pte = RISCV_IOMMU_MSI_PTE_V |
+		    FIELD_PREP(RISCV_IOMMU_MSI_PTE_M, 3) |
+		    phys_to_ppn(RISCV_IMSIC_BASE + i * PAGE_SIZE);
+	}
+
+	entry = iommu_alloc_resv_region(RISCV_IMSIC_BASE, PAGE_SIZE * 256, 0,
+					IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (entry)
+		list_add_tail(&entry->list, &ep->regions);
+
+	val = virt_to_pfn(ep->msi_root) |
+	    FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE, RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
+	ep->dc->msiptp = cpu_to_le64(val);
+
+	/* Single page of MSIPTP, 256 IMSIC files */
+	ep->dc->msi_addr_mask = cpu_to_le64(255);
+	ep->dc->msi_addr_pattern = cpu_to_le64(RISCV_IMSIC_BASE >> 12);
+	wmb();
+
+	/* set msi domain for the device as isolated. hack. */
+	msi_domain = dev_get_msi_domain(ep->dev);
+	if (msi_domain) {
+		msi_domain->flags |= IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	}
+
+	dev_dbg(ep->dev, "RV-IR enabled\n");
+
+	ep->ir_enabled = true;
+
+	return 0;
+}
+
+static void riscv_iommu_disable_ir(struct riscv_iommu_endpoint *ep)
+{
+	if (!ep->ir_enabled)
+		return;
+
+	ep->dc->msi_addr_pattern = 0ULL;
+	ep->dc->msi_addr_mask = 0ULL;
+	ep->dc->msiptp = 0ULL;
+	wmb();
+
+	dev_dbg(ep->dev, "RV-IR disabled\n");
+
+	free_pages((unsigned long)ep->msi_root, 0);
+	ep->msi_root = NULL;
+	ep->ir_enabled = false;
+}
+
 /* Endpoint features/capabilities */
 static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
 {
@@ -1226,6 +1295,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 
 	mutex_init(&ep->lock);
 	INIT_LIST_HEAD(&ep->domain);
+	INIT_LIST_HEAD(&ep->regions);
 
 	if (dev_is_pci(dev)) {
 		ep->devid = pci_dev_id(to_pci_dev(dev));
@@ -1248,6 +1318,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	dev_iommu_priv_set(dev, ep);
 	riscv_iommu_add_device(iommu, dev);
 	riscv_iommu_enable_ep(ep);
+	riscv_iommu_enable_ir(ep);
 
 	return &iommu->iommu;
 }
@@ -1279,6 +1350,7 @@ static void riscv_iommu_release_device(struct device *dev)
 		riscv_iommu_iodir_inv_devid(iommu, ep->devid);
 	}
 
+	riscv_iommu_disable_ir(ep);
 	riscv_iommu_disable_ep(ep);
 
 	/* Remove endpoint from IOMMU tracking structures */
@@ -1301,6 +1373,15 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 
 static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_resv_region *entry, *new_entry;
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+
+	list_for_each_entry(entry, &ep->regions, list) {
+		new_entry = kmemdup(entry, sizeof(*entry), GFP_KERNEL);
+		if (new_entry)
+			list_add_tail(&new_entry->list, head);
+	}
+
 	iommu_dma_get_resv_regions(dev, head);
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 83e8d00fd0f8..55418a1144fb 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -117,14 +117,17 @@ struct riscv_iommu_endpoint {
 	struct riscv_iommu_dc *dc;		/* device context pointer */
 	struct riscv_iommu_pc *pc;		/* process context root, valid if pasid_enabled is true */
 	struct riscv_iommu_device *iommu;	/* parent iommu device */
+	struct riscv_iommu_msi_pte *msi_root;	/* interrupt re-mapping */
 
 	struct mutex lock;
 	struct list_head domain;		/* endpoint attached managed domain */
+	struct list_head regions;		/* reserved regions, interrupt remapping window */
 
 	/* end point info bits */
 	unsigned pasid_bits;
 	unsigned pasid_feat;
 	bool pasid_enabled;
+	bool ir_enabled;
 };
 
 /* Helper functions and macros */
-- 
2.34.1

