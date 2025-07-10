Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD528FFF3
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137848; cv=none; b=hdNaDr4608tprdYvTNBkvYd9aFYS1IwZgG8DYfKktrXC78UKAW6mD8223iy2L8TqaPIrBEcNFW3MjWjG3y8dhT+yqqhUMFqKHV/01hXa2RppwSaaEjTl2epIJt6dtFlzKijgCJ16J08TFA4xhuRfT7qpQgIXw5vVOoNu5h1rmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137848; c=relaxed/simple;
	bh=2e7cipO2Wjm9I6n98Mbg+M1DHcoWVB2Xyn33ipE5d9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0WSva659WjO24PnMaUaGIlghQl1UPI2covrXSkgmBckLMIBiJy/04tKC9kdQQg9kBHJm2/MWC+FE7NLGGDuaTr3FHLVkjI4GM0F1+ZIQmzvzllZE4G8GqO/9gyu75WpMJOtyP+ubDSsJuL+wFcceWYXwPfUVcjgfgzvJqYYba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RZuSaYjw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RZuSaYjw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1612888b3a.0
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137846; x=1752742646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=RZuSaYjwDeOFebyyWNay2OnqPGt9wo3vLujNahDYIEhiDqLoWlG83l7kZmBscZVWUr
         MYNuiWJTuja+IGUpgAlnLkSGTm978QdBUZBglrgTuWd4z2vgE1V+FwW9iaDvTESKJI4T
         Bfq3p6E+rtNaDm5jazFkKpVc9xIzmp3wSUDdiD09cmzpc05MjbmmvvKehY8UQxPfr0Bf
         lhPYLLJZOemXDBNkFIURjb7wrmwhRWdtZROsWR3WHtzTMqxiDGGLeZ/vvVxTZwKlJLPO
         uLkQ4EAJIr2z4VYxZ7cd72vDwExtUDYEALKGF11H4CEA1JetPlHOlT+cNbQzqudzBvj8
         ynIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137846; x=1752742646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=Po3+lbp85R1PTXN4/Z5gAYc/lTmRU7qieUYBPxvW0TKeLjE2eCgYCvnFYr8p62gdQl
         CJ4fPDEEDtLlDGZi2DbVBN3rsDmTXcD7XpRStyLnQHp8VlKqOkpMhgvYgMPgwZy7U7b5
         LivIUOOTNLrvMxG3S28EBfqK1y0RJWUqETrjMUOocRtpoJOtCEjwJu/DuMINW2+xXBjq
         y6G/BWxvcOeaZC3JAHyt+cc5XMhY3QNmfH7b0kNoCePOHbksZABy8+ZNMD8As0vZ9+9w
         4gfZiv0c10N+RWbiKvDoWDT5gWvzy2g1xK8gk9GcpEyUmgR0p+0/PVqy5vxKRUEuD16z
         bDGg==
X-Forwarded-Encrypted: i=1; AJvYcCUVh9fPAgThWhKk6c2tfZ8SbdzquOmsNCUZGlrIMzAjMzkYhtT4ppk2YsYrgRPjoxK/e04HsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK9MDZqAyVbC49qBowBhcUyQLpT96IQEXvqmh2KPD0VB+Mp3Zx
	B6wmpDwmHv8KEiTfJ4iz9D+fXVA9qjtcGBeHambD3ow9owKjGP4OlIO0e6B5llvHBkg=
X-Gm-Gg: ASbGncvA6/tTfLI6ger9Q+e9xJ7Pc6aELCT8wwIGTb+Dd3zlFYnqQqZovQERMRyZsYK
	3goTjNATJaRasLkPilGxE9rjYDNHbz1jvncItad9vig5LrU+giIxKfsvF0/5LpIhdr7Xj1GiXhg
	s9N/NoY5I0DNzyVsBVcCO6QRzdJ5SUwAHrAkTEX7GyL+x0COU3LOxp0xsvtfXgn+22Trfaqo2zn
	8pQSUFe14VvHv448U8bsFxNGHN8IaF57UzS97Ail/X2JnVj7Se7mJzqkN5qiPZmOWFg8kTD3xCX
	uDFFeSMFa25lpvzDBwQutFJRb6Ri6VdSiruiCulBuO3qj3kV/nDzowEyeBjIKHWKqHTYVtWES5S
	y6qOM2tM=
X-Google-Smtp-Source: AGHT+IHUdOd3Xm2iDHKE4tkW13G5yAQLxHKJQpWVcXGjXWDJYkcMmbOblQIeJliUDTeryLpJLtOVqQ==
X-Received: by 2002:a05:6a21:69c:b0:222:c9d0:7aac with SMTP id adf61e73a8af0-22fc4dfafddmr4472974637.15.1752137845826;
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 3/3] iommu/riscv: Add ACPI support
Date: Thu, 10 Jul 2025 14:26:57 +0530
Message-ID: <20250710085657.2844330-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
RIMT data.

The changes at high level are,

a) Register the IOMMU with RIMT data structures.
b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
   for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
   the platform IOMMU uses MSIs.

[1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
 drivers/iommu/riscv/iommu.c          | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 725e919b97ef..83a28c83f991 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -10,6 +10,8 @@
  *	Tomasz Jeznach <tjeznach@rivosinc.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -46,6 +48,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
+	struct irq_domain *msi_domain;
 	struct resource *res = NULL;
 	int vec, ret;
 
@@ -76,8 +79,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev_fwnode(dev))) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			dev_warn(dev, "failed to find an MSI domain\n");
@@ -150,6 +158,12 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 	{},
 };
 
+static const struct acpi_device_id riscv_iommu_acpi_match[] = {
+	{ "RSCV0004", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, riscv_iommu_acpi_match);
+
 static struct platform_driver riscv_iommu_platform_driver = {
 	.probe = riscv_iommu_platform_probe,
 	.remove = riscv_iommu_platform_remove,
@@ -158,6 +172,7 @@ static struct platform_driver riscv_iommu_platform_driver = {
 		.name = "riscv,iommu",
 		.of_match_table = riscv_iommu_of_match,
 		.suppress_bind_attrs = true,
+		.acpi_match_table = riscv_iommu_acpi_match,
 	},
 };
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bb57092ca901..45a263c9e0d5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1651,6 +1653,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_iodir_off;
 	}
 
+	if (!acpi_disabled) {
+		rc = rimt_iommu_register(iommu->dev);
+		if (rc) {
+			dev_err_probe(iommu->dev, rc, "cannot register iommu with RIMT\n");
+			goto err_remove_sysfs;
+		}
+	}
+
 	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
 	if (rc) {
 		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
-- 
2.43.0

