Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6449D5BF
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716044; cv=none; b=cuH+n+epPShllcJtFw/RxXwrKEFSn6QKFhGE3KaCPRtbVW4NjUIRWznEj3bj3XJliAGTHVDfNGPn6jrTedTmmvI9IzJSMIuqtI6C0jZcYT9Esufgq1N+wcgxxwHtxmPuIGOZedf0Jb+rgsvo/INYdyUNvt6hbmAcc7+xByZkF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716044; c=relaxed/simple;
	bh=yYqekLJ/G1t+rbxU0H1jBCLzz7cJv7e+IWYJeGIMiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIZLhFvbybxvwMHmM5BIOwZheOGny6AbSkRbkAsuGBOt9lGdrBBlM1MAE1ZWsiIzQAxACOauEEhncYkPMAcZys2nl5XPrx2pkHwfs1UvlmUuEPkG7fWUNR7d+ORpU2DdOpkNvtZAdHB//4Jyx3BvnwnVNIw/k9GMSBZTVqL5YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZQz7GE+0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZQz7GE+0"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so297576a91.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789716040; x=1790320840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=ZQz7GE+0EQTuRhxnzQ0Oh8XOi8jOHG/76oM3Xd/REZukMl6Rv1gGJ8gHprZZ3qEsrf
         RuFiC7dnEJ3UYRYFVOR03iNiIQ6aFArDIl/OYWY7hfq6SBCdbYuWQnztCVWiArMjSd+J
         5Te0/uZyrJI/eNwjT82An3nPNvHPpLjuKqEU4wgmnH6Qqy2dnMi6259+fMI49qaEMrsG
         yQ3QAHPp0sX2ubp8c3ICMFv6zjKGaLlgbBtjGYIBu6M1CH7okUxEF2Jwq8j8jqVEivMp
         SVrBmOgIbPx/JQVIfEaXUaZrlVIrP3yhmx9NATbwff/+kW/TcoDultJ35nGM7eXnRTuM
         9IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716040; x=1790320840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=dBE8a0TyCG7rhlLgNHB6vtUDTB6yVrLQjLoghENhNpLEmbb8GrUPIGyFd9Mre8RwzZ
         /+dv64tfcwfF/NF+XOJaAB2msXM1qTHsbi501cRV5ueSFCU0Z240voMBWqgOs5EnlNQj
         keFivOYKjzf+Z/pQla+6rLXsP96x6fKBu5UwAIfAWsuh9xl9ZTLakTcuEKt7bj2e70YT
         CsgbfjmnmuaLTdXK+YjiqB86sqIfeXFREa4WFMVN1OaPi5t2RuQEEdh6O/0MwQ3R/AB7
         b5Rr6PjEFRYGslK0G5GhsKj6fPRM36Gvs3pcJrqCCb1YH+0lp+EH4JMmIsLyjIxqRnTt
         0MXg==
X-Forwarded-Encrypted: i=1; AKwUvBzTRvrr2hL1IVh5HF4L3ydCu/QuNnyecV3BTWpz0+C/4SLy9oQi6p7MhlijSueT/SUuPvsHVg==@lists.linux.dev
X-Gm-Message-State: AFuF++kXwXynUVEA6KHbxJQcL4nwAvUDUgcH6jMylwQINT7JuAGJ/NDR
	3uELpbbTtnKiaC7ZK6qtiLFubKhj1SHDeTsKqJvawH+8B235jyyX0j/oTu4PMfo3JuE=
X-Gm-Gg: AYBFou1xVJkfd5lsqULAR4kNpUMC/xbmPGfpsS+gpns5tdvldG8dOPjf+gwVK2w8q6P
	w2rM51p+XwJ/x+gzGHZjSzI0DEZ/0zyRTI9aCodzwEV8sliqlApvZjdSSwsvXNMOcbo2HFLKSC1
	Yc+j9my5Qg0gp2n91xLnNxQQixn87oqQy8RuWsCWHNRbrF2n8chRW19dOWHnftnNzT7ikoScnwo
	3TnYpi47V4GG+jXa1wuFB78vlSV69GfSepRNEVNIwbWB9M+cN7xgChyPGINdhH3VgJ+veq8QXXt
	X9hX+MuBNdpF3AZvesaW2iDLRgzMhOLKQK3NUu1aeAZxQDDC/LvQb85RLUgLvusgFJqlTkKlci2
	WR8Yuwu3j0GX3CaWizLEZDByDVJ9ONtLWjnK2aPRd3mF3ZLVPtc30IhUZ7G7AGSWVMZjtjTSulQ
	tT8BRKKGRlPK8Xksk8srMf1s/7a0rNhpGsQNvDoImT18DlPfM8nDI7AfzcloiH6zKfTWkfQfdYs
	OVaUIMre+A=
X-Received: by 2002:a17:90b:17cc:b0:39e:135e:130e with SMTP id 98e67ed59e1d1-39e54af6a0emr3710326a91.3.1789716040219;
        Fri, 18 Sep 2026 00:20:40 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce03c682sm4416046c88.10.2026.09.18.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:20:39 -0700 (PDT)
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
Subject: [PATCH v12 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Fri, 18 Sep 2026 00:20:26 -0700
Message-ID: <20260918072027.639239-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260918072027.639239-1-zong.li@sifive.com>
References: <20260918072027.639239-1-zong.li@sifive.com>
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

