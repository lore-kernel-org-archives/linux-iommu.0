Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C813FFC
	for <iommu@lists.linux.dev>; Sat, 15 Jun 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429277; cv=none; b=O+wSdjnCTkVm3JSNPdyObbuXUnXzOoDd5QKHiTeWGoATDtq2rkgzHQjywHxNfR36qzcfyjO3UgsuCywDhx3ariydom6433cKlsUNAyQsJg6iy88lqLCVac5OmTIToyorwU7AWyUw5h2obkSp+p7gjtFUaABhcdTcPsGt/QFa2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429277; c=relaxed/simple;
	bh=AYdXzOi/+3MhvKkKsxvMYJSyqlyNTjNbRw7I9TePmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPw0ILymamf4OCwKOCl5KFBpwg881ylg+c1uRjGxf/X8WmxqKshbhmDPXi0VfHy4W/rs8nOxxf/N3R1tr+gBTT7tDlEZrSOVMf26Ufuia0CuWGkaquHH2Ui6/rruJQZkklsPuHkF5/9QqcZ7tLY7rL+6wfipGkj0zGxCSYtDLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OVE38iNP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OVE38iNP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso1192488b3a.1
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718429276; x=1719034076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=OVE38iNPf3mz7Ox7ZnrqyMmqHiM6RS+l4M/kvD6CIvppntGHeZN1t/36HGPpgnslr1
         pc1in6Qt1h/8xdERb0QEIbsxVCHZ3iULYmIczZR+qjPRkwGVkwpCpXy0bDBwnfk67D9I
         G0rIupdN9C+QBtOdNYYFtyRu3dt/qGwapOCZ8U5sYkD4cFbEy+4twHuP7KCxp3n3LmSg
         cZE+pOG6ayg3HS1rpwbFntmojIFAqXH4ogW8O4z7Eo3p0XXeW9EauXtM0biI2Dm94Z2R
         ijUoRyR4DHdwoemmTpiwBeXQbxG1FgqtMRNBa9/06UmyEQ7v0GCIqNbK1ScWX/aq//pY
         FIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429276; x=1719034076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=LonKp5voBkq2zD0A4HVg0bpOzjV2MREi71AvARve3CS4tQ3UduNGnLhwTis2X3pwk0
         10SDbOFknJgVrsYkdVD4CwKhacVR3ba4ceKckziqb2upmArRMN0iwLG+pQcsEIV0IQOR
         SiYTru6lQH4BT31ou8qWALVzzv1HnmUrzIHMCD4Pj5M88G4Hvs+hqfBALEZGIQ1ZyuUL
         iB4Mwd8jFdtnAU7WIbuPHX4N/GEFocsfg3HuuM0S8QQ906pzipY+w3y7ZNFEjZP0p8Fp
         dm6tGN75ofTOYU3NCIrbeOGZ58WEQSraX8MS5WBw86x353Uc8wtkvFCg2xFGBKRerkMV
         xW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxJUNKORPVFYb0dv0tGtgNw/yK/lsiOybEKQTsVY16qA1cOK1lPNClKkVFh6coZv65L/2t166EzNEvzcwd6tzkBkqTNl4=
X-Gm-Message-State: AOJu0Yx7Occ9TBCfJWmyTJR1Hf10HUp14iDkyhbEUUlWVU1w7Rl0BHn/
	RYe6Ydw8O39rl6tNJfuDysX1qeN05sLEpRQZWHYHMIRE51NC4GdBtZz9XZHx/4U=
X-Google-Smtp-Source: AGHT+IEKpMgRh5o3BPdhB1zSaaF7P6cYldcO4nlZCU/wDi4yPmPqCBmYu3hIUuni889NHwpJ7VajVw==
X-Received: by 2002:a05:6a00:4d17:b0:704:2f2b:a2a9 with SMTP id d2e1a72fcca58-705d721837amr4438399b3a.32.1718429275577;
        Fri, 14 Jun 2024 22:27:55 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b99bsm4081578b3a.143.2024.06.14.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:27:54 -0700 (PDT)
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
Subject: [PATCH v8 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Fri, 14 Jun 2024 22:27:34 -0700
Message-Id: <f2158ca381e04af699ab4c66dc7168269df1f95c.1718388909.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718388908.git.tjeznach@rivosinc.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
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
index 223314f7ed0a..c54088bf138f 100644
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
@@ -74,6 +129,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -99,5 +155,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
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

