Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715B28E56A
	for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552429; cv=none; b=pLsbXc79hEHq7FpwcGSqD51sOvN1so1vfJOGkmyeuvqX0NNK7Ojhjeps6hLKMga7yxV3jOPJkRr1+h2DoZBWrUY3s0vsScaCeZHz8GAlw3hZcFBkP0aju9pqmqiVJb52/YnTKfLmbxAUJ9/mQXfdbCBsli3JAqPew/gHiFtGNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552429; c=relaxed/simple;
	bh=ApG+TqazgePfngwgF8UcC0MB1PI19Gz6v9CqRzVQNfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCBDTDqqJeLKCxIKvZiWV7neJjEvTEBFqEOPp+uGfucNQls7w6HQcB/mLC/3oH3lKQ6nQDRlGB2dhXBtcLodvBr/ehxvBBzORO3LzpQjmZmq65vH/8J0LinEyuCqFJ56724GaW5injiyiJB9feSbIfNgY88iqxLrgrUeZjcPkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IrC19+MW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IrC19+MW"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so4539573b3a.3
        for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552427; x=1750157227; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP3kf43rac5NeyS0tfBg63Ga8H9gH2daKAu3CycI9m8=;
        b=IrC19+MWubvSzt6o4+724tD3+OehHq2SuiGzChruj6Yh2Qzn7hhAqqVa4XFXUK5XVY
         s0CbX+vdyogrY8tGA0x7g6zBDVh5ZzfK2pJN8yokxJDunkmBPfYkof9M4ZMc+AAqJe7F
         qzNA3n1xXFkp3CCtHVtcFeQzG1Y1VAzCZdzNmjAOfK4UvIcDCtlCm7kMUjRBc/EymlAZ
         /gvg5fy7GChT0iHiE8pbvPSR6kMajpBjvIVtLjFDHAYuCJitGxcMFX3DVsbC/4BMDL6n
         oeKfuHXANxHLZMH8IDgi9k27XmpDLvr7uWMVq1WDiAz62rua31I4vCxBgbBNXk7ikow3
         ruDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552427; x=1750157227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP3kf43rac5NeyS0tfBg63Ga8H9gH2daKAu3CycI9m8=;
        b=nQKOUQx4Pl9x61J2GC/ahxmxcg8LP0nQkz2m++N3NWrGPOUAIn0UC4i+a4zcGVD0J3
         Ef55gemcR+R9dbKWWAVWlvTE3q8yuWCG4EIdgUcRZdXek+65Q5x61KYC76DUfvOl6ZZt
         JAlR9/pmfcBc2ult0uFzRdKJlLNNEqKF/D9qyO97VL7kYt9uSEo/EJ3YFiYxe8j7Tg3F
         NIgchiNbDcRfGunnp08m0h1iGpZlTLjUFiU4A9C+zz5/zZy4RhAdPAYl41c/FCh3hJfK
         Ztp+xhZnbw4CydxqHHdllx4ghhpMX20PSEHfYrNQprP8YfYCxuNwiFrD5/5AlzJyi5NI
         PTgw==
X-Forwarded-Encrypted: i=1; AJvYcCUV1+SDVRz2JC61Z6ZHf6WkbTI0NhKtRf978dZIF12e4HyERf7ZzavmUh7pn/sDMMtT/l1F7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVZebR5IU3M1aoU44pAeiEkavjEglYb4ywTKXg2D5ewZHQ6+4v
	E4lOyTGHIUCk7O2VnnGQffo3kT5Nd66l3h7GCoxK4pT48aIpJLiloI3+ZhAyWzuEVa0=
X-Gm-Gg: ASbGncu6tcf3GpuVLHi530wdfrer4SNg7XN9u15bUYeTpHJu/6G8hKikVAo/VmNrsmx
	uiAqMcVkn63t/aAZ/r7PhZoD4KUBdPx0sdcFHcpZhxZxiHfXuShHVuhtNL9eTv3gQa3kRmr2wNV
	GkqBQ9kRZtpqZ/1qaYQE1fXMC6xRIhr0NT6Nhb4T19HwyAzWMb+NLRcLTxtvTG3M1nkestwdqUg
	/Q6yLquQvA7/ImMVx8woXupSqwK2RybS74MVEEKQymU+m0LQvx0uYjG+P2SRVarspA96T0b17J2
	94KorgAaWTSB9ad3TjKm+4HigoNzMbnCQi3Cxfjhes7aleCwdE84rpyOu2O/HEtYyuFVEbt6
X-Google-Smtp-Source: AGHT+IHO3whMIsadT1gQS1uvXLzDhfAzklgArmoSaPyZ84SGmfZlfdnm+MiFoYtdG6mfvNnmI8Mwbw==
X-Received: by 2002:a05:6a00:194d:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-74827e7faa7mr22225344b3a.7.1749552427592;
        Tue, 10 Jun 2025 03:47:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:47:07 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 3/3] iommu/riscv: Add ACPI support
Date: Tue, 10 Jun 2025 16:16:41 +0530
Message-ID: <20250610104641.700940-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610104641.700940-1-sunilvl@ventanamicro.com>
References: <20250610104641.700940-1-sunilvl@ventanamicro.com>
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
Link: https://lore.kernel.org/r/20250514055723.1328557-5-sunilvl@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
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

