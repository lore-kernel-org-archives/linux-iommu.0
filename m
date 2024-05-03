Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00878156868
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752778; cv=none; b=YEDXTJtxUYD7UxobJCM8GEE6vNnToCBrLlAGlkL2WJ4ZMyfEv8+2lXIzNREHh2eaS7Rs2QSea9taICQBmZPHUbiMvDH/du//tXAjuquE1n/+TamUNfT05B79ZbTsryEbiOgTzfxw8stMXyAzgoZcX9yZH2sMoMskZYJ5eo5PGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752778; c=relaxed/simple;
	bh=8LqWk2PswmnChhhUetOpAzFFSgQeTTrDnH1lYjgOlVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXXXXwV1YGgLcVOC5Aev3Hc7Z9L7yM0HMGyOAe4X0dAos9rVQ2ci209A9iAfnNEDgAj3JCFPPHyPLoSr1rCWRjpCn9iMCbb3S4HIec6VhRCvmohgpz1vTTB2BDmCUeKpNz9Clf3lkQqmHy5qWxAaWbEfCHq0maW/aJ7m1bIAA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zmvtEv2C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zmvtEv2C"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e65a1370b7so86105685ad.3
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714752776; x=1715357576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OthrTqg6LXWJRDRi7J+vnyIlyTmVXygveqUsFn3DIAE=;
        b=zmvtEv2C7mBQMNryOscaletvyba+TSlGoFv0UagfYAgO1CVpga+j5JgjN8kxBf9svf
         rO1coDaypYErC1M+OkNXRCIJDQgROFQIkDX1yjgP+RxYze9mBZT8rcVHL4ipdoieM+dR
         rqOWLGVS2d/RL9sNmzEp1tZxxE3iTy7xhW5MTHCq0WRYWV5MdoKx0CaDEqnORyK3c0rV
         ws7AF2ydPFUBeXYlQc6H9DCQE9+5ZDjjr2YvuS/FNYb584ZZaaOOqsdz+ucqXOGtlP+V
         XvzgNeR3LEDIhmLZhifvlw+jlkMwfxsWtwNvooPbnyDqtMi9O4vmKIPU17q0jyxjvxG7
         PwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752776; x=1715357576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OthrTqg6LXWJRDRi7J+vnyIlyTmVXygveqUsFn3DIAE=;
        b=ig4sGLHHHzecK8T48kuiRbAK6b8q2ljthZd4JUCq7hinzGu/mkosbSJJIzkt+eWA5n
         cj7DaKBhHW5HWcQwkNQ2WIqg82jMgWfugaNyXd6VjTGXAwryur5O3v5TOOl9osU9Eu6R
         /5xw6Hy9h7YaPLx1LCLD6Bd5an2T9WZNQEy57S6z7fTaEO1RqhyMyTLLIdHm1T8RJ1qZ
         g0J57saVUxtOFaFOymCV348HF9WlAOaALHzXv6XFl6O6N+2wqQ1ULzza96wQJwQHwg9w
         ziXSxRXnHEpxSs2BSRV8l4lOxJ5ZrfeoFI/BL2XjvvHG8sFjht1VUqUmTFlsI9nJ6DWj
         VqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXSLWEhYgpLUL8OC6I7n7sQ7+GYx+OOhy5wBgcc+9cA/MTuqtIDD+iQMOwAhNhDPyezeNckxpt+phGaDVzlW2y2NjdgNIc=
X-Gm-Message-State: AOJu0YwlWGLX7+OvuaABzhxzUQuOKGXaxyMkL5FkGlalD3LTIUJqTdkK
	OGq/fWEJiKeMwmUtR+vDaZvpyvfPU4YsvmHYhZaWOeAyqohvO//HIuZpkiqMGcw=
X-Google-Smtp-Source: AGHT+IEe9+jERc+PZd1HuCQGuHlYnZgRnt8bq2rrZoOIlZj+FGWtKK0fIlJ9akZituuFwd+i4siSHg==
X-Received: by 2002:a17:902:d4c7:b0:1e5:4f5:7fa7 with SMTP id o7-20020a170902d4c700b001e504f57fa7mr4576771plg.21.1714752776311;
        Fri, 03 May 2024 09:12:56 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001e2086fddecsm3424746plg.139.2024.05.03.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:12:55 -0700 (PDT)
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Fri,  3 May 2024 09:12:37 -0700
Message-Id: <b28d4fe49c5fe4e3ece9de789cfd92cfa5b3c16c.1714752293.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714752293.git.tjeznach@rivosinc.com>
References: <cover.1714752293.git.tjeznach@rivosinc.com>
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
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3c5a6b49669d..1f889daffb0e 100644
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

