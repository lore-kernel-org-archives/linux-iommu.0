Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80291A38F0
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507368; cv=none; b=nEmQmOzjM16+By0DUq5QyX48Jla7L4BOmgo5vpIiH9QGiCGUxPZloT1HIGIM8UB5ygeo6ze843i32nVanlbAmd4KaYG1blnB4pwKMMOMH2UqAw/c1jpWrYVXr2rQL+wYhsROZ+3PlhL0efk+70tXIMCraGcNgXSDlBBVOCRyQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507368; c=relaxed/simple;
	bh=LhLhw4bea4YTAJnwj6A9BWGlpcgoGr12CUOji4lNSfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKnWN2oYjp/QYA/dnunTjcX6YecYoFDYRa6CJdafV8lJ0MuZNZIrMb2/E57UOonO/wq3R8mjfq2PHNBQMJjO3a0AXvQkBqNN7LSywQVpm4SSraYQ2w1hMzKuWfU4LBLfaeUQznyWxctWSJgtzz3FAMM8OCZBUtORnI1hGyhYpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QpvhU44L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QpvhU44L"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c9300c65so52082235ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714507366; x=1715112166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KfkX2coDIYxHK7IeteKYtlpeAwqJsH66Gz3p82MjVU=;
        b=QpvhU44LFn0TKBoQcMjNkrxhgD2boZcTvLOzKFoUB+7sxt6pUiGyWGSC1wzTjVMJAf
         aeK0vCaaGFukIM7s9h7izs3HZ0A5o7Q5TlpKp44Hky4VSjmOvECIxQwvf2PnPZninEpf
         A6jis+LK3GFDULx1jmjk9mVeph8bXaZbw/FqYPnf4rU8RrDJZ8v7/OxEnX+kGD73ydAl
         LXGQqUiMwDkTXZ8asHpn5m8lkRNcQEc/DBA/MKmdarvp2x6USskGSzMYwRVDAj5ibAnT
         Wky584q6tYpqjnrOI7vp8YCCXlQ15CdZOSXHz7u6AO5VIXk8e/Df77J1s4XYpIsa8Wus
         0dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507366; x=1715112166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KfkX2coDIYxHK7IeteKYtlpeAwqJsH66Gz3p82MjVU=;
        b=KExhDOup8Yv0jc5xWvVguQnxjqeKL0dibwipUrc3OWB1vQdAVhpSjNnf0Zcaea7d2L
         FydZxlgEjh19Do6/QW4g4nFl8UItXl4E/m4my6IlwYnxAjZ4X6w4bg5hWGnCGQ6jKhR3
         oQIBRIuH4wALWw9RV//9qlj3aXwF2bpzo5Wzrofnzb1IBaYjiYe+aQB4FS+MV9Lo3Wke
         8YSckqPwkC0NOqyAYM8k4lcvfKYYNHdxpKF/3SEFah/PmJvVhLdcBquRCEVNhZd8EToF
         er3cI00cLH4MDeCRfmoPEX9o/PoVpBnV19hh1MZyYVWpf7fR4SvoeS/mCk9GSfZuSsnM
         dwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4dCkQNvx1Dzh6AmA0FcKnIpL+BC73yV1P9IvQThYGzoOmfn4lQywwYieytKG6+CwUwGJf9ipbB0vXOOWZN86Ybf0sFe0=
X-Gm-Message-State: AOJu0YyPsHzslSWcdOo7Enjbt2mcLtOLaMWF8yjNCDY34kFsat/KP7sc
	jUTOmx1mf5hNW3kKh0i+Dsbz8AOjY0cWWdxzo8BXrUek4BDslXHw6mdOBrIo0c8=
X-Google-Smtp-Source: AGHT+IEowGVg3Eqknf3Al/Z4DshsuVQulgWG+lvIcIxZjDaV8J5h3onGGQksmulabRBZQqDlJV7n1A==
X-Received: by 2002:a17:903:58d:b0:1eb:3e13:ca0b with SMTP id jv13-20020a170903058d00b001eb3e13ca0bmr448656plb.37.1714507365982;
        Tue, 30 Apr 2024 13:02:45 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm22809820pll.249.2024.04.30.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:02:45 -0700 (PDT)
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
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v3 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Tue, 30 Apr 2024 13:01:54 -0700
Message-Id: <f9c9e5dcdc1457da4af70302e85c0a7be532f650.1714494653.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714494653.git.tjeznach@rivosinc.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise IOMMU device and its core API.
Only minimal implementation for single identity domain type, without
per-group domain protection.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 07c2bcb08afd..17dc6431fd37 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -36,6 +37,60 @@ static void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
 }
 
+static int riscv_iommu_attach_identity_domain(struct iommu_domain *domain,
+					      struct device *dev)
+{
+	/* Global pass-through already enabled, do nothing for now. */
+	return 0;
+}
+
+static struct iommu_domain riscv_iommu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev = riscv_iommu_attach_identity_domain,
+	}
+};
+
+static int riscv_iommu_device_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
+static struct iommu_group *riscv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	return generic_device_group(dev);
+}
+
+static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu;
+
+	if (!fwspec->iommu_fwnode->dev || !fwspec->num_ids)
+		return ERR_PTR(-ENODEV);
+
+	iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	return &iommu->iommu;
+}
+
+static const struct iommu_ops riscv_iommu_ops = {
+	.of_xlate = riscv_iommu_of_xlate,
+	.identity_domain = &riscv_iommu_identity_domain,
+	.def_domain_type = riscv_iommu_device_domain_type,
+	.device_group = riscv_iommu_device_group,
+	.probe_device = riscv_iommu_probe_device,
+};
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
@@ -71,6 +126,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -96,8 +152,16 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_sysfs;
 	}
 
+	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
+	if (rc) {
+		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
+		goto err_iommu;
+	}
+
 	return 0;
 
+err_iommu:
+	iommu_device_sysfs_remove(&iommu->iommu);
 err_sysfs:
 	return rc;
 }
-- 
2.34.1

