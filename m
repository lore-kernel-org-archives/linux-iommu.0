Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B298370D77
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358251; cv=none; b=JL181lnnFUtEOXsN1v4YnvN9XG7pdyyjPU8CckTlVM7zo+hv9fMZoIcj5M0RK6jApAw4OUkq+c05RTNKyAbBZKW9tGvHy5lGF+DPu4YyjmhNpU7IAcuu0SUyMJmEDMtq1QEjlcLTbNZAVUFLq90B1qnafYdfU8z+xyy1DX4+Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358251; c=relaxed/simple;
	bh=+mUVJVoWTcwSihXFsPS/Aaf+9RE6k59au5BpO9JogMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCiP0axw5F8SjjBqU9YqNteqtCxMEC6WiPqBnynJZjQQ6PnWmGfCRHTgX9PA47IcmznODAcz0SSLFfQlge+a2HayzJ7XGqSv3eiOVLj5NaJuDfGpyIZ/p4a7Zuig0+T7VgFYqGFoMRzHEsxgGBaL0nwcbsxteR5myNghByIgu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hjHqt9+p; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hjHqt9+p"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2802438a91.3
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 20:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789358249; x=1789963049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrvUvXmaXknLZjg6fXvk/ZHbd24dkX4SY4AyuffyclQ=;
        b=hjHqt9+pR1glrziggP5INfb+oE5oJoOzA2DKVGyFMwmmDZbCud/ipn7GGlUfA3piMS
         00BKhzwxOUph4YOhUWkUClgjvXKLzWPYaItZm7g0EV2ktACJUVruGSwIHyc+kIcnvm+W
         is7SU2V/TeqWGT1btbC0ypL9S6gCie5rskq5M3sZ5d87Yhd8Gqj1OAZjnMMYrevPvgCl
         5doliEQj7LW0046v1o0A4BMfpUOrV2Iz4f6+tY4I9wTrVcs/1NTzrIrEFuRxBqgtqeCx
         yz8pEN7WaDpF7OwiFKQkn/XHW8jt7H8UaC8z2tHSj+WCIdwmCKPPiLOpXcBtVKFOyl0Z
         AO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358249; x=1789963049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrvUvXmaXknLZjg6fXvk/ZHbd24dkX4SY4AyuffyclQ=;
        b=niYrKuDdcY6oeWXypIjhUg8H4FlmlRggvaPWn5un27FU2DJxjYXf7qHFoN66rOvIW0
         u+ZwDcUIJGVXccsfXpQIj4nZODPTQX1+WdGg1FYK5MPIxXMwSmmfMDXBhmfbWQHh8ftW
         jdVqVc3+4MQ4CG2uMPlgGexGowQCQ7ig+4k2D7N6VFYC0kT1oBkuvQ35UNfpaZjK1gJu
         XstdC1JKOyuZALdpDIrqKY+VsnXxAv2qSXgcxokr27KROQz+KCvXoqHf7Ke50PTmeNmO
         7ZGrgCXkFvDp6ifEl+YuMNXmGjVYa18PcLBJIbq0yNq6/EsUcjcpME5EXWgWoBwgTJxN
         uRgw==
X-Forwarded-Encrypted: i=1; AKwUvBw02MuKbHJsxmDarLT6OEJC3Q8ueh0JaQlMp+IVuYIY/Kg4g53cJF8Kwlhhkwl9qHK3H0CCvQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kjJ2JRMIavLMqSV0a2SPfx2uORzLiFHPMCXICSRggVTIkoTg/0
	TO3o6US3PA3j9l9MmZBkuMvvVFUHx4Cipj3mv0I+GtVwhVlf5OsWAjHILM8z1s5Fu7o=
X-Gm-Gg: AYBFou0dHxm5dnZTX/sFHXwyIcJD6wbuZCaxNNFe8gpROXPlMnz7hzCUHCP/LjgpQcP
	9vIC/W2pV4UVzvCc64qEWs8KTJgXcV2b3qtKAWRHnQTeWJafdjSxgvYdjK+/YVBRXZopZAOGehQ
	lOmeMU5hPfHzYsTh1cd6G0Nsa3ysAvUZB30G8RX69zenUCbBkhvuuK7hnn1DFvozTOZKdgHmFKz
	ufPJ+7bP8PCenOXlWjzywli7RJ0ou297wFFq8uiNqAuXrm7of4qgOC9AcwjmFE/qmlB8v1A+rv7
	CP9LR4gi/6hTRYjTSvp+k/i8c1OQnsPCUc9upis5jyZpApjX5/Cgv91Cq168BaWPhd4PztzcCAd
	I6mMRD4PAWBF8E/CFfY5bWa0+dZ/M7J1Mf/SER9fPaxOFhx1orHoDZ1pti2hZ0s/lcesvVlg3Z4
	8KsyZMaIUxqNs3z8dSkjxe0ujjtEMU4ip1AGdpl7aD/JyU09KrRgRfolTm636G/VSpFiMX2g+40
	7ucX+gz5WPC
X-Received: by 2002:a17:90b:5827:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39dec0bbe04mr2006194a91.18.1789358249365;
        Sun, 13 Sep 2026 20:57:29 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm22862554eec.12.2026.09.13.20.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:57:28 -0700 (PDT)
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
Subject: [PATCH v11 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sun, 13 Sep 2026 20:57:22 -0700
Message-ID: <20260914035723.2922057-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260914035723.2922057-1-zong.li@sifive.com>
References: <20260914035723.2922057-1-zong.li@sifive.com>
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
index fe8e6d0f8a23..c7495cc57720 100644
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
@@ -587,6 +591,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
@@ -1636,6 +1670,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

