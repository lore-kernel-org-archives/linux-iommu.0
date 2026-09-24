Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678C3AFCEC
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244089; cv=none; b=qT4YEz6eQgz4auXBZve0aFlg7ZJ1PYdufpIN0eyyvMNtMx6hqu4LtIW2TqbrhpBVqBM+uZuyWgYcoNpH/4RjtGdqRGpiLXt25L7KcEq96CnmsSQJF076ZSnmEYXhOz21AFivOKWEvEl1mCQ47AlABMkqfUArFpljgd7KSY3v82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244089; c=relaxed/simple;
	bh=yYqekLJ/G1t+rbxU0H1jBCLzz7cJv7e+IWYJeGIMiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDoQqTtGu7kr/c37t23qdGozonVORRnwJcf5Dwq9VdudpdDD3u4AC2IUawd6qhtFGlVCqEe0O6K5FX8tbIwPWrEYW1vojpwXk+puACUGdlB4oxX1Go//PEZ+K2xTBCYn8VT1fbb2mNIDWsfGyyCWJanoTW6pnYZ6hPwuiQexwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X4S0xxcs; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X4S0xxcs"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1437b77c274so1162487c88.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790244075; x=1790848875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=X4S0xxcsfDaKcJqJ02sEWNZo73tISAOK+wugB4vLudUuJYry+Ior/PNcYL9b++27DJ
         diGd2VsvDTh4MT678RKI+cUdbRrCz3swvDlcJ9bY65KJwlGNzQlcjoUwl0DDsFoRaz7i
         xEw2jEP2CjiY0797vEiJFX9G076QoBExeFfzmMEGKEful/TM5IK4GBftp6JksimLt/Bn
         r7ayaWLVVGmYUaa2VnPDUdbAnjvobwLiGgJ+HyluMvLBH5rwdqIdriQZ9Z4ScMHEnuBU
         j9RuetJqyQtUfC//+FampdpcX7RnDBslcUTADOUMdYo3D/rBPIA2nqO04T2ENokpWlzz
         tGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244075; x=1790848875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=dmTBFonoUQSS7v/LcEfLbazqopUKyLupEQ/PuZk6YH0olV+38DR5fQjoQmFZLvoP42
         ehHcVpyPJesgOrjFlbbRtBEJTUz5Rc31ScSdiS2AMLmABbSkqBuNsasJqM3oUXi5FUOa
         v14N9MvBecQL1foJGYvs6dw+hfLX8iBgvCyZqEiAIfcV92NZ3plVOlM7OCu1ciAToG/A
         NOW5O3TIRZCkFQGYgqrIkR+B1QTxfl6bhKKqLnuxPVoSCSmPe8gZ0oZ1IdiyVkT9R64L
         pQQ7VLDZvGnRBYBI9HBa8nfH7PbXuew3wg4WYgJS+8oTrRTTrhyh+kw1DqAF9zvexW/r
         NVig==
X-Forwarded-Encrypted: i=1; AKwUvBxM4fVGuwQujSQXcYmc4Pq/OayvgkRwhYHWJ1BJD1jLK9VDA4cjZl9MAwvRJR8VicbKtUkZ8w==@lists.linux.dev
X-Gm-Message-State: AFuF++lfxC2HRwjt/I2UjMa6vtHGQswwRfQDC5qAbkmE1ihKZkFMd+Fo
	XiPG7MPQd8R+toNP6/sxY97DgbkBB8obox1DlHIvlGCvkh55ZvJEDpig8Rs8hOwHb9k=
X-Gm-Gg: AYBFou11+QJiU9HWnYYC+nPmzvpNzVndiDR6eqpzYvfJ2QJZbRKjrkoeFbUpDTzZZmg
	V829MkhXz0NY1AP2OE0PW1Dnqk+dcZ7zKj9w7Rdkz2lFs0NIV/C86naXlfjiAQEjA7MdHo+hNGm
	2JpWLkZXtu5cW70+wRi5OApTZ9PyCUTmdM24UZgPrXFn02x5aAE+TPPEdhMPCHdqIUY51LGPZ+E
	U/lpg/Rdti4YLcwMZ/medPvxFUMHxPvEfArDceUCYsRGKYXHxlVg4rYoVtCDdDpNqelb6YSDKuP
	3rbuU59CfSlCVYm90Fh2wRIEFjzt+pyM+sB7N6sTW1DbWB+UtHn/CkNhkwGAifRZbzB1X9XOnok
	GxE8QAwDoiNFjpDVVHpnLDVsHdoKgFoaM68V60p8OFUwT07kFJ6l8tztH60WRwks4i/9E24sbYE
	rerJSexZABnrL0zFl+zd4qT5iV2sdUjWO/vMJhkthAdvRzYt61BL/bfywl6gh47mEjL2WGR3yAm
	hkVci0qTerEPBM39R0dTA==
X-Received: by 2002:a05:7300:561e:b0:333:b6d8:c2fe with SMTP id 5a478bee46e88-3400439cfbcmr1465583eec.3.1790244075027;
        Thu, 24 Sep 2026 03:01:15 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e498f0sm11649975eec.27.2026.09.24.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:01:14 -0700 (PDT)
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
Subject: [PATCH v14 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Thu, 24 Sep 2026 03:01:05 -0700
Message-ID: <20260924100106.2054127-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260924100106.2054127-1-zong.li@sifive.com>
References: <20260924100106.2054127-1-zong.li@sifive.com>
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

