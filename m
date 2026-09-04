Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4943B4BB
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513716; cv=none; b=gHk7kVBAPl0ux+98rhG2bwgZojaU248dbjn3VjNlypEzV7SErAPGfiq007shRUceD3FzA1TALo71phO6QtnJ8E7grblmDx7CW2ZMTyF27byCGAAmablzKZfGXq/LaRfyB7wvdqsYsAQ3AGec8tUpt1fjfmn1Jag+03qEfQT6ltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513716; c=relaxed/simple;
	bh=0OuilxAE+ThUNxpU1Gxpqy4nbLhkHMBngSRff/ONKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEL/5Ma89TvknE73+/9lVhELBtWSRyh/l9t+6PspDbxLRvvjkp9JuBwEQtRAtO4q78Pjsoi39HkDV3oO9wkq2pNF2tvuphR6Y3XKSMm6V0tj5p7h3moRaemQhM9WF0SPpaLBUBqndPnb40pt7RwsNCqBdKE8LzbBGaFMQRsDte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GNArAXer; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GNArAXer"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a483a552efso338069b6e.1
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788513704; x=1789118504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=GNArAXerjg+QlKHGBm+ATIc1zOuh6b5xPNvToAdAQKQGxab2KXfXzWSRtRKongnL+U
         qJXwNyuH1MrPPLXA9j1uSc874d2i2FdYOfXC+/zEiUvds80Y0mbF+TXIxD41kF4AJphh
         NUMnVJgGobtE4UJ6CKUDygZ02ziGvAQDbt1+RhT/uXh7kpysyDcPbSBJP1zCluRIyPj6
         SZomXpSACVp7x9/PPCG6VFAqOMoJyGKIy/xqrdMzHeJJgv4IM6KJtGyddCzvjD98/VGE
         79Vkl1OvF37IRL5cGrTtxjFM+JCfNEXOxdXUjk4pqC7qhHcWzREtg38AuDG0/uJgmtGf
         rjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513704; x=1789118504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=bcM0O2W924Oxi+tYcxmDhWLSGe+DjiqlNxNqTjBzSUA/YYqbzuDKLERuNUMagmPuaQ
         By+r8jB+6vSDLX3qK+NBRcLjNReU93jfsYP/ojIeb3PrIUEZF3+3GCUYvlZZM7jcY3Y9
         lfZXdov8CDwBfT4G1NrszMQvbbgMHjEClHVfJLgA6IILCg81QbQz2Ec/jqqYy9DxzCIg
         iK8DMsG0hsoeZTj3zOPCBjsQvPF4/QLRwK+OsvkxZgtr0dbyVya2UeX7EGNvZWTWx8AX
         HRK8zES9U/7FgCStwtkZhWRly+J51wOShgknzJJmbQ30R4atambzaWvy81S7R4yK89G8
         GVDQ==
X-Forwarded-Encrypted: i=1; AKwUvByBSSZW+49rTI+Q5U3u75MwC1e0s2nOSYgDmeg83rCmcxxGNj8Jz4z1EK5+v2rO6Al09rLj1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nPRMQmk7RttpKfVe3zs3oyj3LYADZm66R+0QjRUL/bTQF4gTZf
	y7LG8RjZH43IdUa5pPdV6EHdzE/3eJPRrr2byAPYd6lXtlCDYYypCpjPN/9TwwFIbis=
X-Gm-Gg: AYBFou38C6gPrdKLWrioMA4ccvF/qpEN9njkQdF49TOFrxYXcwThUwtNq1At63mruIn
	9xn+Jny9cMwTHkkUc7tM++JjgGkDMN+lPcNRcOYa43ZOPpEs5yIbnzfYzwgD962P5E7P901kVlZ
	aflqGo7teP9vnYpXXQLgPW7olFMM/KSF4vPicDD9Z/Xg+iwDS3vzqi66NuoGWetKMgMPVvqqe/F
	BiTbPzPhVLNHgiC+KoIvSlUnQtMJWmU70HlJg8ci/TWXSuBbqicTMprQgLc44P+cEwq/cdb3JIK
	U03kBueGvejYMX2N0ZAAUggCTRidCllx/pBC+7QzgvPp8hf1CVdPa3H8vYHYPIvQxuZnzqCYCBQ
	2UzHiTLsTKeGts9jW9ivS0SYLc9THkW3DF2Tj+FYEbR91Z97Z4Bq2suHKEPsECmrWguhhZ33R59
	EcixaVwJ1DCETIhk0uAWOkzDM7NTlDcKecjffcraRGlMrKCZlLyIcyYd8mKF+x7O54JFVejiq2
X-Received: by 2002:a05:6820:1c91:b0:6b1:2843:1312 with SMTP id 006d021491bc7-6b6f788e384mr2940609eaf.0.1788513704577;
        Fri, 04 Sep 2026 02:21:44 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432438497csm5275575c88.8.2026.09.04.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:21:42 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v8 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Fri,  4 Sep 2026 02:21:33 -0700
Message-ID: <20260904092136.113321-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260904092136.113321-1-zong.li@sifive.com>
References: <20260904092136.113321-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..8025bf0fb67f 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -10,6 +10,7 @@ config RISCV_IOMMU
 	select GENERIC_PT
 	select IOMMU_PT
 	select IOMMU_PT_RISCV64
+	select AUXILIARY_BUS
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..7f619971bb70 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -48,6 +49,9 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU PMU auxiliary device id allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pmu_ida);
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static void riscv_iommu_pmu_id_free(void *data)
+{
+	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
+}
+
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+	int id, ret;
+
+	id = ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ret = devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
+				       (void *)(unsigned long)id);
+	if (ret)
+		return ret;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
+						"pmu", iommu, id);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1647,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

