Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D244F562
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978564; cv=none; b=cm4ziEPGyH5UlfmUJ7weLtI97z3Gk53yYBahxQpkHw90m6njCPSjMeQFiNeluLEhawPgnppEOqOlRIzCkNwzqFpXW1VR4F9ZgLX1VV548w0reKOzlMCbmCLgSzrw/btjU8LR1XFRPKrAcYP/5XnbSk99E+nd9HnXq99zbaJtWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978564; c=relaxed/simple;
	bh=yYqekLJ/G1t+rbxU0H1jBCLzz7cJv7e+IWYJeGIMiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9qmScRg6s9zhrHfEDuRkZ42EJ+h+5mpW+xEQ6x3NclDqo4rJDAPKNVoVyTkqpZoDnv4qWcPY7iTzMZzhcXj0+snCX+tnw1//ZGzm3ij1taXKt9Hp0WBZa1DoMo3aclr18txbOL/NvUbAb0K1SF7UiMxYMzhSV2UJAoqlDwNyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RWkRs4di; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RWkRs4di"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1891797a91.3
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789978560; x=1790583360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=RWkRs4diYEjWp7GcbShA0WG2+08blPZwF3esnATo2t/EwftoXPvpTF9KmVQJKpeTBA
         nH9XpHkwX/n+Y6ULXgoDBLxvTdDfSiRuRlBGZ3KLus80juaS1MsrLyBRS8PDtdWZbRDY
         jXC5HLLcj4Dzvb/mn70RnosTQEqx1Pme/uz3kiMd2270zfS5kN0EK6s20G0+J4u7u2ag
         oYgpqRDfM11ZeHmL6Ay9YMzT4VPAwdE6SOVletJq7SFHvIz07zwuv0jSIYdC4mLHqOP0
         xPomgji6MxV57EBA1DAhT0pYZ5txqqAT4NqXYt2COo02Bmhln6YffSdgbLzFPOOBFlQ8
         J58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978560; x=1790583360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=zo4CPPbEZh91KgpdTbVVB7KVTAtv2A3bQGMk53CI8xt9S4ESaX9inz3vhqfQ3wi284
         tkLo8iGskIsw2QPcd3cMFcgVg3YF8jpTtslkT2SsnLZ8oiHSSVDIReKgQTTuako70iwL
         ADTqnvKV1RpcLUb/1cbisoAZhL29ErUugwspxpeyr43LAfexkkKTTOgaI98fLcdcIkCe
         YKO0oQHszMQPbMFzYFiC/Mdx2KnbO/e7ebyxvAd+eHxpNo6zeBW0ZAWfv+RU96lS7AUr
         QoOlVvWsuLaLtcJdnPlfGeXtH6oNyJRM5H5MCmDRu38/Kze0h4zLd3CaU9H5eVmta9tL
         FevQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJYLNebKdIFqJWzCMw7gxvERqk/nS1Hf66gxSPKedXg6nsqB+w6Zr4wX2CgfdTYoaSacTHEg==@lists.linux.dev
X-Gm-Message-State: AFuF++nFNRZZEQnhiMV8/5vPiH2je9NeyEC0+Z+UPHyF0CAeersAJY38
	fFYL0wrlW1W3tKK+BBbsqNo6WCLDqUGozfQ+n1jrYsqaJP8Y2SXug3+Xio8v4Tp4YSA=
X-Gm-Gg: AYBFou3JCab/XKyXVJYvPD1uMEcisYBbUP7IkLKE8kg3NKWOAcB7BtPoprhisM9G8/1
	+7rqAlOCqAg429IzHkXsuO4EMvgtezbRDZeNJnK25PGMiVl1F7ZKgNtNPLThwlIQ4E9jqQORjCU
	ey6B/NitHg7EeP2YBpGEVa1Wt1Kz6TDvo2pHmtTXOtKmjz97aPUA6IvTBzGG+2MVrIE7mkmmsGg
	o3YpuimIZaNypxWqm3lp2MAaJ6BLZoEkYSXxn6dbtcA4c8i4Cl57xF7zkgOUOBDdcLP+OYX7dRT
	iRWLSBzJHFnnPU+dSINraiM7U8JyxUk6vfV8/S/kM7u2kkGUJLPX/SBcqsT7LHXKVQt7LksJ/QG
	ZNwxDNuHXBWrCeZMvXFzWj15jW5+yyIzi+/XUCZkvjJe03l5AaXqAb5+9plVY8LpVex1x7NIgE+
	+WOtOQREOSBkbmf0CgdQQdf/xk5UHU26oDSo+zf2N8BhYsvm9O/9EVx2rus91R0BNdfSOnY07gQ
	3nGbX164X8=
X-Received: by 2002:a17:90b:57e8:b0:39e:6c69:f472 with SMTP id 98e67ed59e1d1-39e6c69f4e9mr9704408a91.49.1789978559556;
        Mon, 21 Sep 2026 01:15:59 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32f16f9csm17151344eec.2.2026.09.21.01.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:15:59 -0700 (PDT)
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
	nutty.liu@hotmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v13 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Mon, 21 Sep 2026 01:15:43 -0700
Message-ID: <20260921081544.1797510-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260921081544.1797510-1-zong.li@sifive.com>
References: <20260921081544.1797510-1-zong.li@sifive.com>
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
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  4 ++++
 3 files changed, 53 insertions(+)

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
index fe8e6d0f8a23..3c8f8adba647 100644
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
@@ -587,6 +591,46 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
+	auxdev = auxiliary_device_create(iommu->dev, "riscv-iommu",
+					 "pmu", iommu, id);
+	if (!auxdev)
+		return -ENODEV;
+
+	iommu->pmu_dev = auxdev;
+	return 0;
+}
+
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!iommu->pmu_dev)
+		return;
+
+	auxiliary_device_destroy(iommu->pmu_dev);
+	iommu->pmu_dev = NULL;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1570,6 +1614,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	riscv_iommu_hpm_disable(iommu);
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
@@ -1636,6 +1681,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5676001548cc..7fcd79fa47c8 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -19,6 +19,7 @@
 #include "iommu-bits.h"
 
 struct riscv_iommu_device;
+struct auxiliary_device;
 
 struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
@@ -62,6 +63,9 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	/* PMU auxiliary device; torn down explicitly before MSI teardown */
+	struct auxiliary_device *pmu_dev;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.43.7

