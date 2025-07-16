Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93332F4A03
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662489; cv=none; b=S6JW1DBexpnbYmuA6ebqzHpcxsYP/GbN0eikO1yOxjtHZLQeRN55P4EfVLqUHe60Sq7DdvVm7tqYBNKij1Y0pxIaSZW9+ULc1IqXmQc+5ECofPlyBxu2LXCfy3Iq5yaBKX4LRT/QvXc5zVluAAQ7TTPO9nUJfBDvjbFXyog4Ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662489; c=relaxed/simple;
	bh=TiMCJ1JIsrrw0j8yUw5lr7+dQqDn3hFgscmUJMRLbPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL63NPACYig+yJIggAm8KrN1Dt3iF3l4SpeKel5zUGqQXtfeTZUZtpfigArD9BwN4Xm1vAqWX0Qk3tR405lW7XtcMi1RljUI4lce/kkd7ozVzgbE77f+vYTciuADXDYqLqkTFozbWx8cIb/KzE+eWKgw1NrxqHjPc3Eq1KabDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HWWL7YBB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HWWL7YBB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so747540b3a.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662487; x=1753267287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZUWpBwM0eiM3bQczAhHsGr1w4CoIgRijBa2HvAnStE=;
        b=HWWL7YBBfc5zWLxwDWbJULpCeyZmR3luLLiyccmGqyYxKbIcz5C90rY55Haka5EJ/L
         YptmFtjlXUY69ZKrJ2JDDTzL07/Anb919s0D8jxKGGkmseuthoLI5yyYDhTGqL3zcTLw
         VhM5dimiJzeYmhlz0safi5wjCH0rNBQj3gdJp6cM8k95dlLjeEZQgOWq+hpFVpGot2mx
         injbUV0zEtAKxgQ4beb39sR0Yhu+awcUilw8XJF7zDl9OHU2L8dyYtoDXyADfBHo+UEl
         EbR6gLd4+toh0hCZvc8uTze1g93TDmI1mVv/BOcGizTaCOHeGdQ/PBwvocNQ8f33r6jx
         HmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662487; x=1753267287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZUWpBwM0eiM3bQczAhHsGr1w4CoIgRijBa2HvAnStE=;
        b=rRdKqL8/8v1dH6gtJH5voUdu5ghpVQJZ7olwq+kDKwkTrBRwUVR+F1HTCAsL6jJMft
         aSh7+qosCwLQxxVvUPLBefthNSiSkgbWrjuPh++sbp0Ljur0DT+g5qPw9Y/Udy6LKTz0
         8xhDODlqIEdMdhJdpKRr0tyL9UWzHwCWZHK5c0L4t5gjHujTHMwz7R6l2CbTa8jP3fUe
         gBVBXVASogfCTVXyKpLAVDPt4SYoL/RhMAtjR1HC2pfiZyQitY8Ooahifxy3dQxkC5PI
         7/eUY/VoRVGLv6zCyvdJEq64z5A4/IsD3HspU5SKhK2xgABZ31cbwsclrR7T9ovcJMvr
         /wYA==
X-Forwarded-Encrypted: i=1; AJvYcCW3a+Y428EnFr+hPgF0d+lJ9ILb0HemgD7f65AIAp4QruX3qI7dL8iAi+F3DDurtWI8mEXidA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZffFrzgLLwO+tBLhm2gyLlDAzjU8Eyf2AWkKk+9Hd3jbwfNM8
	R29P1ikEMQmjWgJWcn1iqSHw4IVqiCHQ2eMWOa48GnGXctkNL9VZOF7OM9pHwb172nQ=
X-Gm-Gg: ASbGnctNnJVyB8L492gHqrEjtAHhmC2s2wYIR4IR8XYJlwejLRMDhIUrq6yYLnEt8Po
	tazuccqYKuFVM8+6r2kavFnvz3ZUmAXDjR3xkVtxoajuZeEVQLi1gVlqzYKsivEDmRpLZ3itOhx
	8MDRHyl6gMlV8Q+l6EKPWTgXDe+PrHCclZukUUnY1MoFD1YtQpjUOS1lY4hQWZXfh2X09HOXNvf
	LbT/22x5hOnqXkC4eRk0ghS+cBFcbLpJxEZLNy10EVSopXuyyLB0+o4xQpDxBHbhDH95zhyKqpF
	LC+bHJi4KMlAl8QWpqrcv0JGogRHDN4p3VkVVne85VKFbTf/HI25proQcIU1nL/wiF7WDT48czM
	oVzUY+Cs9M5fiWL8d0mjpmNrNMX0wACjK
X-Google-Smtp-Source: AGHT+IH/Lk91h2N/FwA9EAOD0yJlQtTfyDy3TLsMiePhmK16NWxXzdzTp0ubA0n3RaF6EsVZf8LtAg==
X-Received: by 2002:a05:6a00:ad0:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-75584eb932emr9392926b3a.10.1752662487002;
        Wed, 16 Jul 2025 03:41:27 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:26 -0700 (PDT)
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
Subject: [PATCH v5 3/3] iommu/riscv: Add ACPI support
Date: Wed, 16 Jul 2025 16:10:59 +0530
Message-ID: <20250716104059.3539482-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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

