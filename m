Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0183D349E
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900874; cv=none; b=qHIXfwxguxE+8y+VYWVOcnXRk3jEVl/irrBRPm/9Iz1qYptu2j0YgO4moSEXCURKkpsEpy6aTdCYkuIAz6o+19HiBHHed14jItdwsLhSOaeIyuoX0tzC3la1tp7gFpssiCblDhxUvza6jgaD4Cv0at8HkoCU+4Xea2DcfzZ10aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900874; c=relaxed/simple;
	bh=0OuilxAE+ThUNxpU1Gxpqy4nbLhkHMBngSRff/ONKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9N0qGmW57ccw6ZxdsAmur7M58adhwAYu9s6G3XK38EFwPEJdOe6vLf+3pAAsJHYzeq2HVeep9oSIt+D1Nug49bpzUQXoorxXyDZLJq8lnsJ72IRsZXbs33GbU31/iUPHlUJmb4OJETEa8V4+0i+6m9Gd5KgjoV5pAMQ9ZXo+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nrZ3lhQX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nrZ3lhQX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so710486a91.2
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787900872; x=1788505672; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=nrZ3lhQX1TU6gwANiFXR3SazucPedTtoTOBoOrWfuG+6I2ggCOJnYVyH9Dap3/1TQX
         rildSdkgWyrRVo/vlTFBirVMt2JU5+yYE5H5wis3/0MtvFNz5z+hUqQ5r09UXXQ2a2Hf
         R00DCU0GztjdmU0l008op0uIpCs0a5Ui6IKRiHrgDBNLgH17kMz6MtMz59zFUkD25Dbg
         CWVqHBxvA/4ZdttHLKaCjhj3rggA7duCwUsIJUwhZ38EMZaX5CIT7V9mXPMEsgb4I2Uu
         42d+70yB1chaZRaYqw3Zz5NpPmv4ZzXV0HYwmUGdAqG0ImW2H1loGUV1wOIhYI15Ew2H
         KlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900872; x=1788505672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=shlij+RfLTbYA4qkBs0tG8ygJ0S3Jz0dM86iid0nGnBY1QO+TH9LcGORGPPGsTaEBw
         ergzWOE+rocPidI3cKluArOt1GsVuHNioA0f7lc7xDYi3Zb2zNqb/FWP98w19RrGk9Ro
         dQ280q3X+fw6KN7oh9EZmmoVjnuTjVpA/uZVlbm5f2/Z7scxtp6tmqDUDri5HO6CqUaU
         7u8dqsegwkR/NoLfeZ0S6qKTilUTY1QVbDapVVV4I5tItm0usRG++aXXvpbMzGT/D7Fe
         SrAof54/yUu2hDTq4A80doBvDXRQWoWmZFOxG6GCkTwlcb1oz9YONsm6bNf3XdCFanPG
         /GAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWvDXWkZkAae25ZcuiN5zsEpSyU3VRm7UuvP3Z4J7SDCkP8HKnsTbFjoskRpGtQAWN0jJO2g==@lists.linux.dev
X-Gm-Message-State: AFuF++lXko3vD1NgrjQYFbfsiUcS6mH8zG/nUZU17yeTlljjMV2mbIUY
	KEb7gJkDCEM35rNRjIW+oJeexyb1l3I5nkkYht56agGaIx4p6LTYUxUq08w440J7mec=
X-Gm-Gg: AR+sD13gxY7GBF/6/OmBW0LbSFAcWo9SEs24Z/c159LTMtM6xpJxtNbmBk/1npyoEFM
	mKWAu6nbhPsiXTQLnDEnbfFo5zX5y1gnBntfBfr/EplkYTWE5zYRDExGv8AMTEHdt9+akNYJGAM
	kd+baYbSYPWQdFMWJYfKWdcZ2vSIrd4i2NSXffgYlicChNJ7I/GA0Fy4/P0hF+F/D7mfekt9llL
	5bgQ51e5dDDniL3HAT/ufIG/2lplM2d74Dwk5ErVmadlniKTcXmdegFGfyz3vou+sHBe7IcIZR6
	90l8K+khebTryHA/XFd0Uia1GhqMzsGPZpb5LnMWqPhrpORThHCNgQ51vW9jyjmEikw/FgdQ9J0
	EhGq+Um7hwUTqmlxPQQ3rY6Wrmelb1g3AUMuBvp3rtyFO58VT8hAqHpcsbc2lnrcM4xtYbeR9bG
	zrhJxZO9MiZlXbIAD9f9UWIuN6i7H/ywozLgz006swAwv6QlGmzXsLism7hk1RPjU+WH407N0R1
	08TOjNiTVM=
X-Received: by 2002:a17:90b:388e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-396d0eaabfamr9040736a91.1.1787900871742;
        Fri, 28 Aug 2026 00:07:51 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm3156610c88.3.2026.08.28.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:07:51 -0700 (PDT)
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
Subject: [PATCH v7 1/2] iommu/riscv: create a auxiliary device for HPM
Date: Fri, 28 Aug 2026 00:07:46 -0700
Message-ID: <20260828070747.4009519-2-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260828070747.4009519-1-zong.li@sifive.com>
References: <20260828070747.4009519-1-zong.li@sifive.com>
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

