Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF59172763
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457961; cv=none; b=idfvM7WNxStrXaTR0y/stZSOV4RBGHQqJhPu9tMeneOPYV3SvJr+rxIgEC99J+EtenvR0DfQ6ngMotM7+BxQ4WcVrfDoxZ7FAllswLwAuFzN9Ng+qKUvPWtZOCc7zuzRA6rJCHg+iaPGgxcowp5T4TvKALUClrVwG3MYtDbPB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457961; c=relaxed/simple;
	bh=zyf5O3P9oEu/Imgz64wtnsPjVe1+RqGXAF5Ettibd6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9GtTEe0dJ1+3P8+3u1NKBtUbJrvNUBE46NEmGRbmEidxpIeTkbjTxmS3ZNccdDYM7DIbfloGWFxqTkXQJhkGvn7rOGNMIr9Dc9M0r+Dz3HN6R5kKdiUqpAabQVFQs/TTfnpXrgT4BHRB7en99V7qtV4UtQt6t8wjI7IrBdS89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fx74SD75; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fx74SD75"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f00f24f761so1008812b3a.3
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713457959; x=1714062759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClrhxH/v7i3t8bwZbyxYzN1k2YxvVKno6GgPljZAZHM=;
        b=Fx74SD7597u8HZ1jmePvKM2/db5ZKk4uC4WCd/XYwB8mh3CRHdH6fSqfTLL3QiJgyZ
         VN3GRnNsMvXhisDbi18fWcbcWKKzQWE+mYdZrnF8DmyldOY/2ie/fhsi96DGgwt2JuPN
         JyWnpkvy8BdWJboSw9LJTt6lCxV5qYURd+GG5Q61o+bt93MTCciPjsgbPkhOEv5wwKBN
         T0wfzY3aS/qnp1Ith5i2autNcw+iGoIsviJAzHZC0iJ4FeD+SUqjOszjQUVdmL3BybzS
         XXhxT9CjLO6HdYgktC7beH4LaSMRV+35bpPhCidstgF28xKTpuZgSXC+Jetn6GRBx4DC
         6yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457959; x=1714062759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClrhxH/v7i3t8bwZbyxYzN1k2YxvVKno6GgPljZAZHM=;
        b=UK0yEU45+N25PSvhSY3g/vo/oaoFW2vxHqL/H81MKyzDEpAYWmvewgWjl8IVXzCLpr
         h1pIi5J7xfc7xIazDPo9E1dpKaJDvnep8keNQ+1rB3aaXuGhQ+uRrmKnWg1nRERi7G5a
         Q2mAGsOZT4KvQRnGtUxAqYpuVuKDRUHm8jA3fuyoW9xp+iYGpOlG08//QSB75jj+9sGV
         aUmwIE2yynuN0tMsb1Q8EHHxMftN1U0V/mx5jbxC4JQm7GNW5Nul/AxB5tAEWnJaBTcA
         Hon5+PComuw5QzZfxGjeYO8de8NJSNcZebm1hknsQlsaPQCZYEx2ddrKa60xfQ30WkzQ
         KLPw==
X-Forwarded-Encrypted: i=1; AJvYcCXHR7RvN0lJ3TrW2l13pwnJTf1OeTnIeHVzrrKbdISawj4a0gVJDfy7jYaGfNhqS5bBlye2gKtJSfREpCrIsnq1ivsg+Vs=
X-Gm-Message-State: AOJu0Yzlt+MfAEgTkm7z8vEIFnzNg0R2Dcsp1KCVM6/6C2e1HqxNzQHn
	iDlJLlqHj4HSfL4OtXxmS3PtgA3tjRjcf8wHkWnxm3dB93LsSYHa1hHJfqmrgGU=
X-Google-Smtp-Source: AGHT+IERN6e0yVXm7jt86/mFHrIhsHHA2BKFeOAgx+SKZn+2UN/ngzedc29EmyEbV1Y4ZmH/DB5nrw==
X-Received: by 2002:a05:6a00:4d09:b0:6f0:bb90:26b9 with SMTP id gr9-20020a056a004d0900b006f0bb9026b9mr142485pfb.5.1713457959459;
        Thu, 18 Apr 2024 09:32:39 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm1674755pfl.31.2024.04.18.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:32:38 -0700 (PDT)
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
Subject: [PATCH v2 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Thu, 18 Apr 2024 09:32:22 -0700
Message-Id: <c681ad581ddf644a288cac44ed4f7fdfd1acae0a.1713456598.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713456597.git.tjeznach@rivosinc.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
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
 drivers/iommu/riscv/iommu.c | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index af68c89200a9..d38317cb2493 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -30,6 +31,67 @@ MODULE_LICENSE("GPL");
 /* Timeouts in [us] */
 #define RISCV_IOMMU_DDTP_TIMEOUT	50000
 
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
+static void riscv_iommu_probe_finalize(struct device *dev)
+{
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
+}
+
+static const struct iommu_ops riscv_iommu_ops = {
+	.owner = THIS_MODULE,
+	.of_xlate = riscv_iommu_of_xlate,
+	.identity_domain = &riscv_iommu_identity_domain,
+	.def_domain_type = riscv_iommu_device_domain_type,
+	.device_group = riscv_iommu_device_group,
+	.probe_device = riscv_iommu_probe_device,
+	.probe_finalize = riscv_iommu_probe_finalize,
+};
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
@@ -60,6 +122,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -82,8 +145,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (WARN(rc, "cannot register sysfs interface\n"))
 		goto err_sysfs;
 
+	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
+	if (WARN(rc, "cannot register iommu interface\n"))
+		goto err_iommu;
+
 	return 0;
 
+err_iommu:
+	iommu_device_sysfs_remove(&iommu->iommu);
 err_sysfs:
 	return rc;
 }
-- 
2.34.1

