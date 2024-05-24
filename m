Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB05824A4
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579309; cv=none; b=aZhOlO0mOlHMb2reY0bruEExfXofNovxtwf91c+5GjLvumVK4RT1ntRLsyBC0FY13zF4sRyKE1DGPJZe/buWJBO7Xedd9qn/Q+aBhKzmbLlSxrf+7v7UkVGd35mQnIe1kA73GQjQSl8xucEh1oJl0KKqIqEzBij9L9aHVC6gayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579309; c=relaxed/simple;
	bh=oKJItKnsBP2MoFoXF4GEbrlNHgVit/cPojwa15Gmbkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZ6NtislaAfDb+2rzqFgh+S/aoAkS76/qcZ0IfWN4NF/7kOHzUd9B2Rt5C1ZcrT+7+P/koa0IDnEb3QgKZHniJ38AjaaqBegLM+/Aqn6IIMUETlVKyHLIpCYOa0atRASu2KNHPfLXt2ysAd5x+zqicuCJiNT97wn5dx8eND9h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wUPf6S8i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wUPf6S8i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8e98760fcso1102612b3a.1
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716579308; x=1717184108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxi9dSsEt2UtDDs3loOHfKu3ofWZQsX1GUiGzyjfiYM=;
        b=wUPf6S8iFwA1AAX9jn3TH5F6jkLg592GaMs4MlnA6CN0tpPmFd2/Z3yie9Pfjgrysx
         P9aDcQ/uUfBgFou38n4Cjj5qgkMdUU6L7FscpyX3JP3XTcEz/IMsLHTJ0Tr3L+8DG0+T
         S17cQG2MNlvzONSScHeWQ5aE9OSgKm/n/SIeOvUSFRmzFg56zF1aRob5SpmDrX9JZ9pQ
         XHM4lqWrGFXKKlSC7Gh9rGaMhoe6QrqFGWmTDXX1MFLXsYrgeNeINr4KHmSfP4jk+I1Y
         TEJRjhxuelks2YrdDUBDa2L63PTnWHaGhKXkUmFTCnB+aUR84nO9qM50eX6YemZG1kOM
         0CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579308; x=1717184108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxi9dSsEt2UtDDs3loOHfKu3ofWZQsX1GUiGzyjfiYM=;
        b=kIAMbMq/7DvSqvm2RaEeswhwoPE7CD+uO4X87+mkqLDmlm7tcEHDq2TFRWZV1JcVj0
         ih3+paHdbJfQaEmlRevtcgAH1dV21ynR1gB5VJlgMAdZY5vxsj4eyrT6Zpp8H0f/Rj0i
         0rmOauA9HXXX2mL3Zk94/L1S4hfP9DlLj2BrCD/GA5T98EOyFcEBQQBevyAA/e6ges07
         s7m/vM1lJIQAT159HzhV5cIekds4OcXVeG8pGo7eh1e0Ad2/XXmnayx3+DoP3AnJjBnm
         XzPBLO/2rG1ubUOglHpOxkIWT5+wAkCExlRTtJAlTFOLLdLJdKOGOMMjHrF9lCmyMSxJ
         BH+A==
X-Forwarded-Encrypted: i=1; AJvYcCXHI1S7cAsY70BEYcoypIP1H2nx3i6afyZdNefEZQwoCKad7Z+PI4LtWVdBw+h0kA2GsMN1oBMqNbBOIOjHIaYvj8YSwOc=
X-Gm-Message-State: AOJu0YzgSxi5Za59MNk5rYyf9OhsFO5vQCplXdmcLQEfLaVWf+R8OAcD
	oexBBrKn2qQ97/5VUBREQrstc6gVlhBHdQPCUMm4IvsA0ZCJ9kFT2fD3Lp747fE=
X-Google-Smtp-Source: AGHT+IEKtH6lrV41abiEeh8RWadoLdBF/iUtxB4SdAAAJTxupc9rXQotcI4G9k/vIwOqmlUrKhX+fA==
X-Received: by 2002:a05:6a00:2a0f:b0:6f8:b1dc:d980 with SMTP id d2e1a72fcca58-6f8f3f9074fmr3718630b3a.31.1716579307705;
        Fri, 24 May 2024 12:35:07 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d878esm1441684b3a.190.2024.05.24.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:35:07 -0700 (PDT)
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
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Fri, 24 May 2024 12:34:44 -0700
Message-Id: <0a2b572a22247cf3af3a790dc9277cb48ed37430.1716578450.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716578450.git.tjeznach@rivosinc.com>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3c5a6b49669d..b8e0e4b62585 100644
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
 
+static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
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
+	if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
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
 
@@ -95,5 +151,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		return dev_err_probe(iommu->dev, rc,
 				     "cannot register sysfs interface\n");
 
+	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
+	if (rc) {
+		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
+		goto err_remove_sysfs;
+	}
+
 	return 0;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+	return rc;
 }
-- 
2.34.1

