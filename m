Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF370270EA3
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493112; cv=none; b=h0SMO13eQPmac6zakakIyN1Q2ZuMBSNegiEg7UDBJPDpe0MVbZe65HO15LfsgQj6z3UBSe8qJ+2eI2+RQd/J32av+JV35z1ylH1uPHi2Q/5X8z6dDiTxWy3wzTjjOYIUVSTBwAfn6Via3BY697qljzkRBRo2qQ9bc7goV6kftAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493112; c=relaxed/simple;
	bh=wOw6JV14X14ffQE6SMj0By+YxAglNmvsry080ZEuXl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zljhn91+UtnIBuIuJPIxs9YaDIvkaScrdn07/xnmrdC/7nwqA56e1H7seYPtsUKuiWIrdpt4R9r16AonhOv9/i1+SjngnaC9b5Z8uBP/qFCElIfa8jrcOcjJKTtNnM5uCflWTR9h/aYsgJuMfzqx6FZ+OvBx1rtFPFLq8kThlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ICl2n1Lc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ICl2n1Lc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so2714594b3a.3
        for <iommu@lists.linux.dev>; Sun, 17 Aug 2025 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493110; x=1756097910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTa6xqW99KKtlVHpIkJtLfUt2l8dIJi8RFcjVe+ZZ0s=;
        b=ICl2n1LcPqk4Ek9UTJWkCv/0YOiNs/yiUntL2b8yDJKeQIWailRZF5KAKddygSYGGa
         uJNOctJ5x2pg0vRA1WErzJ+mp1FGen8Cm9+fPSPE9R1IcFUYX0GnILGu3/YsDYK4K0uV
         EWI+DTgeJzidZ1UkjAwxDnsVkGMDsJSPXexvtyNOxWoYoyhftqR9EyNYfWcrLPdres6K
         YOKx6hiizyrW9RG0eOXeBgluBw4xhMEfS0iGuahJDXYmUfapBvyYQsSJHkH1oUpeV0XN
         Xr/lpr4cO13BNas1Q/KAqDn2oHDnLQEbjwg3UTagMLSjg+x+hq1IvM5D0dyV88eP1HPg
         CjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493110; x=1756097910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTa6xqW99KKtlVHpIkJtLfUt2l8dIJi8RFcjVe+ZZ0s=;
        b=LbNKhgqZBlwWTUQTYXbWamep8WytpWCa0Dq+G1swqdu1WP6tI1DkvdlAQjZpHqX1yr
         tWMXptjuSAReyf0YuCikGAazUtTNLJtdtyo7sInSvUO18rPJWnJLLP3UVVpyS2cDKb/u
         jvyfEnHHFhJy4vqz+8UamLUJYKytkGiudElQZxGRNdYBtSh7wHc7KUr3KW9T+FXlsJbe
         T2b3F0A1mzoX2nuEGSugMidwViowNBu5+0+z2xAhF1oOf25Vw/uFIG8VFUfktU9cLYAP
         h1FO+5mLlaGBSsyEs7nDcfSfU6pOd4AGRjR4ItkFcijuMfu1NCjWh2mBC0I3mMt9pbDe
         DqWw==
X-Forwarded-Encrypted: i=1; AJvYcCXnS5Hmkw0A0z0HTtMBWV8UHwfFoL9sixVxAFtyTELFKxDcQf9G1+bRmgWfjmuTRsd3tizDuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywnmvun3JeUIOES442UG0flp3Vp21VNkzj3jwdkAfZKEHknGvNa
	6Gd+ZYkHGNgtEN1JmzaSeDjdc6QQes41/hZJJK5Tz6H4CFmRGxJdJhwFnCQELAuhhXU=
X-Gm-Gg: ASbGncvo7HC6qX/ZTPdSMVtRZzifDLwwDiCEBqaU8CwYd2d1gzO/L4pNv9Os18/UjQr
	NsQ+L0bxEab7xmo7DX2wWyzxd4uhWHKmEY5SDvCPmnZqsnbz4v0uJm/pVhC+nH/WkxP9UBIkKvR
	7FVIZiHsEXZf8N80Eps1bp1zG0ejHOKRcrKyK/fcb0WrOhj0ZZsZ1LFSbGj0lfhM4dufXyVmlF4
	thXdozp1Govjc6Qeweq9eKtgcYb2+k6x0OseD141+Ip/BVnP4qjmSP+Jeuu9z4m1ChbMafD7Npl
	vIosOKhxHFDJGEc/grIJv8NwmmH1SrzfXxjOyzMbVia0lAFIE9K2yz383hr7L5ihKFmdnmrmkBz
	V+va6DaHH3obizWVZZTAuwBIfFX3yVJjm0AzY70nt
X-Google-Smtp-Source: AGHT+IGBQAQ9QouKj4M7l+2CqoGFg6HgZE82/OKBnQvuZfjFIYQJQta7bAXmxzrYRho/3qFml+C5sQ==
X-Received: by 2002:a05:6a20:3ca1:b0:240:265f:4eb0 with SMTP id adf61e73a8af0-240d300688bmr17338262637.4.1755493109991;
        Sun, 17 Aug 2025 21:58:29 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:29 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 3/3] iommu/riscv: Add ACPI support
Date: Mon, 18 Aug 2025 10:28:07 +0530
Message-ID: <20250818045807.763922-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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
Acked-by: Will Deacon <will@kernel.org>
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
index 2d0d31ba2886..7d9370aa58f0 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1650,6 +1652,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
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

