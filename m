Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A371C84D5
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255309; cv=none; b=OMiFSatqYrfA4fOEsHpJ7HXVpxHhWHws1eRF4BgHP82daRWo5Gu7KdiVW0p0caTChQxZwQkGKTKuBAdQy7v6iaJwkNO1GkK7jmypHYbNBEznTI73b+ECiFwarOax7VrwqckGgIegCqySVZv2ySA2Cji4nVr0JtxuNX35gIz9Mxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255309; c=relaxed/simple;
	bh=zBDL8jl2yYKCOKeT2sHBQjAT4aZWYWRMcZe2xu7lPsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aabZo5GuzKjNH2kE2cpwA4YeJRjRJI/F2+rn+4PLB+eJzGJOfh08C2isuHhG7eWCzFJU1Gjofll5r3G2Y7YY+8x9WyQZEBVyYXO2LDl7YkIKl+70aR5ZYa+4BV/9UXGempHbKNpglz97STXQyggNpr1YO2yHCRBAGEuo+rp4fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Zv2abSYa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zv2abSYa"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fc7506d4so1407168b3a.0
        for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255307; x=1751860107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFQsxLCkN/yrCHNlyEV/dF68pPJedJM8kd/qOCB51Kk=;
        b=Zv2abSYaZp/1/EK0lWz/NrYBIBWq0OgnZwZhE/6KWr2F/LEZjSILAwhTXpLp1UXcEy
         JklVskmtzQbIrgH0Xj/GHo4mkZie+Y4luhXT+wZnsudYjaVlJERpUPV+GUvJlbEX+Nq4
         pw1oNBT2K/uNKjGKHif58cMM7OXt02n+hLm02WMNMf1+DokOQI49QYaN43zSWnCi7XoF
         424BcxT9/Tv0NZX29+N9uwYQ0+Sl/K1YvzcIEOgrrn9k8n2c36J8plwvmMUM5z8s9U9z
         7XolUoiTQA3zQnqfa3C45pThR0vdf40W/ybxGOhW2kn3V06qG5AFopgU4rlhiedbsn/M
         R94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255307; x=1751860107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFQsxLCkN/yrCHNlyEV/dF68pPJedJM8kd/qOCB51Kk=;
        b=SaaeBmXwxoodF1GB63DSU0bzVBA75c0Zp2k/1nVy6Wo7l1jlZoH1WdgBhITBj23DQT
         k9/jcydAbvrLga2HDe8BYU+72CaewNEcNGmxx+GHLsmLEEDOVAsrdDTxbPLwnvsyO42D
         sC2gZqWD93EC3quXcXdE/FAtBSy7Qz61SyjyKHO53CRhhT51819AcyDe0BoNr+2JnNU5
         /c/aI1wS+dfZ13LwWe57AD1iNqNIJCQyUIRdjlf8ju2SfxpIEYiCN9EpVZ0PoXhfUwJ8
         ADPN52DYD94f5HbmCs2IqLWgdn4f/y9V0h+VzFzD2uHgpWqwk7MfxUClfEct2qvKAQBG
         yIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXspKIWKh6MG9XbFwKSpbj4qUdLXI0zu3jCw9CGzJdGIcZwxyAd5PBTqRYtanRlNSsnTMuoiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/WDnQTKvnmuGtcJ473YK7GwRri6Rk7dL3v/mT7UmJ4/LW9q4F
	VT+x28dQZx4hp+RcUU0cJs+k45RtlgaP0TzUh73kAGh/jloJaMvm9FuDnZrLllMuVUQ=
X-Gm-Gg: ASbGnctyANfrWQqE+c8uujDoOGxCyg2P99bNVTT/tz2E7WKOdgURl7mpy1tkIJHwoDZ
	/obQjQX3TMdKalxJ0R5pcaYHcht/crW/F3wWTHZeV679LDx0cJnQplIAcQsDMWLs2iRN+tPUYX6
	r30oMGPFhEjgpbOOqFaiX4QxfWfpfSslW1BnzR4wTEje/NM404Nl0P3Aj6gxzC8j2dOsv4psYcv
	fHdx4Xc2E0IRAfXrkK5h+pSdVhLEKkMVE/eYsY5myfEkk05tDrW+UA2CGl/jaJBjkTdyNEKMVX7
	RKfvgWAjYDmtG7LrPPq66MTg6yTqPLegMItu5xbwUXQ0e//qdxDRgzUAKaTIEd8e1p095Rr3
X-Google-Smtp-Source: AGHT+IHpHBjPFAAATJQptsjtLS2j6ZPZrkAWrRRMr3WRaNURjmZvw7lQa5uyyPBco66LK582kKThmA==
X-Received: by 2002:a05:6a00:b4b:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-74af6eab8cbmr16901576b3a.7.1751255307612;
        Sun, 29 Jun 2025 20:48:27 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:27 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 3/3] iommu/riscv: Add ACPI support
Date: Mon, 30 Jun 2025 09:18:03 +0530
Message-ID: <20250630034803.1611262-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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

