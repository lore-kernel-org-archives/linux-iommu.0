Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E079381EBE
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277418; cv=none; b=UqmvLu/mSENYQkG2R45TAkdiQDioRJDc3E+/COBhrUqAKjhAkvu8sF7F7sxz6GlyUwla6df+CYOdLIOMh9LRhV+c8+ySTSBtfVTnaO+nUtjdVsnh8iF6OzT1vluJCYwKEe/FF3fD3Br4mKy+EnUg0U+zYyKVJwmBYomqktjYTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277418; c=relaxed/simple;
	bh=PLPnw7RkYT+ECav+oxnXsGHYbLorD/rJxmBO/n+hXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcOtoxByD77SRNB9568PvUxwohBkiBJfbtu0+iDUibLxYTG+YbgDz/gZBblDmXJ2urYok8xKDh8Tw9CAmjWGj+xIFWHS7UOXDDsmLdJZ5dU9H8x7NZZgHrQc4AixFENDliwlbl194vju4U12Kz/8XiZ304/+n5vzbTDmEkJJOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=it9Ovw2T; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="it9Ovw2T"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35115b52125so327787eec.1
        for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791277415; x=1791882215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsQCM1m1fnFkJf3mOSpgytxAYne0rV7bfE6IaOdnVKQ=;
        b=it9Ovw2TNXasRdKX5wwhkJfyl/V4HMofGTuOdHPVTiJf2Mynjm0CihcWorSqeJq4Qf
         qvLSNeM0cPRcNwtcUVIBuWFSAZWjZqrMBptfEkY8J/eMwCQulEX2hGC2q53pVLABD/7+
         IsdH93wmQDpwdpv4KYUMFov7oBEojobbO9ftvjoiYkPQYtCG2xajcMCBUQi/Pk0PApy+
         xEJJCQCnmkV8s5VwsiPZHrsMpvNWRPWVRgRxTfr9HwoDLX/YhyTXlcxwkrCPYVlXwNty
         q+z7RzEt2yO3Zhp6Dxi3fLAi80EWjvWzBuFVSfu8pEfFSKtzFSAT+zIX1637ELUAd/H2
         +bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277415; x=1791882215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsQCM1m1fnFkJf3mOSpgytxAYne0rV7bfE6IaOdnVKQ=;
        b=iPZvpZE2TFet0XHNRpFgHVm52eWn0FkyDQUU3qrXTEkXV1NEBiCI2UBLwZiYhiJZaF
         sjsLoOf597131T4Q6/Wb7nprhPVK7DWYDuMwkHJddYqNg3YeqYgzxMEj5LZN6LQ+nTGP
         mJ2GJw3BpBxr5q0FJri6idhtziWUvJykfDZEaB1J3o/8vJ8BROPxpR8JoT+kLWyMWVN2
         Us8hXuOlTXLiN72UBzIZXnJEJ4YyTupxgDwjhf3DxlTLYXyuJ5ZKo7ckTj4av6ytK8AD
         bw4E5C2JdDDWh4Lm9Ad0Mf3L/ENEx87WJ/Sdel8MK9EfDdNavmOrz23cVTPqVSFKP/06
         y1zg==
X-Forwarded-Encrypted: i=1; AKwUvBwyfJnGPwAnKP6UQmrfaE+LP0QZSGJ077CQanbf06p+aPfwYYdm7rfi0rlxcd6cuDRBjAzuFQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lROYHVVEuHlk9noZnX370WOIK2MQKq3z9GiNdvasmXIkjlO5Cr
	JOieJKff5HU2Pc7mzV8OtTdfGv4GlycZR88ZYGDu4X055T3vqD8g6G5ZmLM4M4HYINQ=
X-Gm-Gg: AYBFou17afA+ivBbhRDDZHoLN6XXWPfeLIC/zPadlfLS3l66ZlASdjJPvLKPZNIL3yh
	TDkOvsuIAN6GQ38tLA/WJBdYJDLLCr7RdG4/riosz4EnFRgnLvi/mNPAIa09p00obbm9vaj+nDB
	4yseBFUhy0cPTUDe+5DDSQ6XjPkioAp61d0qN2XhKfHA5Qn+UXvC7NLcvSQ3lwSHAglOzDxNVHy
	wtMQfc2AK0PTZkoZy76SdD2yXu3a8FkDiIej08xsMK+r6PfDFr0yreTc0Yz/MaKMCOLY9mtaA5j
	r2CtTKWkWMgCQdCtuZ2XXXZ4w9W5xSjFc9FbLVk+9SCFpfHVW06hHFX7Xcb0e5bg+FQjX8+eb36
	fi3jSJ55JU6dIQVkcKI2+6z0m/0SBeMTy/8gWX20YniAfqudY7Huljc+GgbHxxQHRqCpNhA056n
	rkmLNtas8EW54DTECVORjsqJwOh/Zngn/SfP8KX6L00xUZyJCX6i5WS36/CnZY3COtXNnQtOFBS
	KUNtDLKDlI=
X-Received: by 2002:a05:7022:383:b0:143:298e:459e with SMTP id a92af1059eb24-15eca269faamr1150735c88.41.1791277415264;
        Tue, 06 Oct 2026 02:03:35 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d82d04c31sm5891353c88.7.2026.10.06.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:03:34 -0700 (PDT)
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
Subject: [PATCH v16 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Tue,  6 Oct 2026 02:03:25 -0700
Message-ID: <20261006090327.309550-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20261006090327.309550-1-zong.li@sifive.com>
References: <20261006090327.309550-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  4 +++
 3 files changed, 63 insertions(+)

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
index fe8e6d0f8a23..1cb7369bd962 100644
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
@@ -1636,6 +1681,19 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM) {
+		/*
+		 * The IOMMU is fully functional without the PMU, so keep it
+		 * operational if the HPM device cannot be created - but do not
+		 * leave the failure unreported either.
+		 */
+		rc = riscv_iommu_hpm_enable(iommu);
+		if (rc)
+			dev_warn(iommu->dev,
+				 "cannot create HPM device, PMU unavailable: %d\n",
+				 rc);
+	}
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

