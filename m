Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9B3F822A
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018207; cv=none; b=pQB1GUwiLKKjSBHdW1zzym+P9LputJqrjRESz9b59/rKsmVw3LIt6XvC/fNsyVKrVQ3Uuwxqs9iiQyAPNfck083xLrBs8H2FF97FC1OnxmRcJcRcyJzUY/fO+yd5E6sI1H73kO2mhRLCsds10iRYJQwCKj0uSDWcC/oI27CYa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018207; c=relaxed/simple;
	bh=NQOBvsBZy+DfNF/ir0u60/1P4/x/thiv2MfnshEydEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFfDfULKpwnKLz0t8qln+r9XSL3IkfwpxoApo1Pxs7DcVvaLIYAXHg7QtOvsW8GLOshlouDEjCyaAw1XCNzKwLb71KdHL6N60eVsU+v7+GxUxFeUZhzRR43nqgPYDydcUnonrQ0/5OmYI6/0czQmieW/9BAES4UvISmcOlFczWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XsYvZtYb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XsYvZtYb"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so490312a12.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784018191; x=1784622991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wk16cXvhCfpgFzGrnK8+fTVVUodSt/9s9ecoWwXHbTE=;
        b=XsYvZtYbWLYW9z/pJVS+SD2rlzUQ6rFEEoyA76ngGIhxLzPmM3hTobpdTejB+Ytma8
         +2BGEiaDMXIT6pk460H1CNGYUf9lZeQEmHq5KWFMyZE+Z70TD39Jvq40ke5xJWtXnw2N
         b3iSuZiJ8VXcql4vdDS9sEkrhWgt/CpCrkFF30lreJpMsWa8lkddjzzWvTIj7PjYjaWx
         n7nqjHjIreIW8pTs7sSSplziMCIa+VOwN7IpneyMwovBceOM8Rjr/FnaQg1tBetnUVrY
         EdpAdxi6Lf4hEV6dbl2Kub/hAwYGtsfX5Pzf3+FXKBmOCVdot2cE9jEMUcQjx3RO4kfy
         4WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018191; x=1784622991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wk16cXvhCfpgFzGrnK8+fTVVUodSt/9s9ecoWwXHbTE=;
        b=EOMqGFeQ7ZKA2+GwwaoiEOeid0fatOFjvUMtcR2M1vLMszhvchBfpgt+hFQI4aHJIT
         kAmBXTUaCtEauGl5AxRIPlzhC+QIi7qe9v2UhUNK78olWJhHqb2qgncSfZSOEYpIAqAt
         ZWHo7Y4ghbpwhAsEBtAW7psBTV1sY5C+6WRz9h5f4D4lMVAUMlB5KBKY8t+0IluC6wdG
         qszRM74tlSmlOFvfhzxXxYIrKLbYT3EGDBONaBO55L5iPcrJltRXqRuFkJTwIQzzy34x
         hbFAoDUdqOzKajLG6f/aBF9TFlVFksc6zvYOyka/w5q4YFQ4lKCn1iyWd+q2LwI8ICZL
         +qCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHcAjqL3ceDIPE/8RXy5w5ZNFI4NmK3xxd2XFju06jCjTnGYObzMSRwLmCOSCxuuBOO09OfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhQbu7b4DbMIN6yVjQTF/KJR8U+sG4Y3HYOF9PyHBN5pK+pcod
	++H7SfdI3kGqmvX164fpA8S6RChOHA1zSTbyQuUIhHOM6n8J/TAN+JTrU0z5qLcOBBY=
X-Gm-Gg: AfdE7cmn9IeshSEmBkjrSG4ECGYI8yXI+LYuVkOFKLrJy44+uDnG/yHXl/OrulennW2
	vTHPOtwR8+VgUgaOmh1x1x+ZjLgKa4+ZcHuyJ4SbDjFsOR2fY1AsIFlxhDDPx7jB6u9iZYDTM5O
	jaFJ2Akx9UDED7iu12YiHTwHZYTVnvnLuCkv9OGcro0ydj8p4yKMa5YjPLSDUNuPf1+JRCJ4M4u
	UPNV3XfgGjFFouXwAgNDhESCADqc+RRSoz5z3+ZPYPGmv7sL75+XklPp47MgpuN0YjkFfU3o6Dc
	tvxm0NnkzI6gIcNd7iDqiVShEYo5IS8dQ6M2ycJrQZhZW71+Bt00eP/WETMQ+A+slEWQbI8SJ8o
	1DWfJ6fqjvJ5/dmUl5QSIS8eqTYL760EFB5dnBTgezvYbgDcru7tCvtLuiuShF2BKw7ToWVZ3Dz
	EUM2xS+9kTABKftcH0ItdYzG3A
X-Received: by 2002:a05:6a21:511:b0:3b3:3852:6663 with SMTP id adf61e73a8af0-3c0f0ae8f4amr19643932637.24.1784018191116;
        Tue, 14 Jul 2026 01:36:31 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm55932938eec.8.2026.07.14.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:36:30 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Tue, 14 Jul 2026 01:36:22 -0700
Message-ID: <20260714083625.1083606-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260714083625.1083606-1-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Use the physical address of the device directory table as the
unique ID for auxiliary device in each IOMMU instance

Reviewed-by: Guo Ren <guoren@kernel.org>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index cec3ddd7ab10..186c22c3ea6c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
+						"pmu", iommu, iommu->ddt_phys);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1629,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

