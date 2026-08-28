Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA03CB56B
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907508; cv=none; b=B5QD8N5KQ1vs2RMMNaNSZbp+z1YvIe5fpZt8XsQ6Wk8tPkgCGrhfGS3HfJQ0AMXC1uIouJUyRktgGCVx1Spm2xTaj5limnArzcByE16Va9Xk9SI4We0pzYLKK2HWspJcdz1wr1DeZtnV1gnh/EQbf4w07OBQ1RuXlMcn2fGx6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907508; c=relaxed/simple;
	bh=0OuilxAE+ThUNxpU1Gxpqy4nbLhkHMBngSRff/ONKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQGiI0o/eQSXhxR03h+5XmYM1pY9pSfz0YcmrkFct4VI8gNYMzh61aLILs1KzI6MPn1nQcgDjpsppnfmxiAWFfGodnpgmu/4zPF8tc6XPsnsMU/VNQf34W214QwMrOEiH+QsLTWM4x8o1Oev8QCixTdtSdgu7dnW82phkI9QNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RYtqkQ4W; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RYtqkQ4W"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso967803a12.3
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787907504; x=1788512304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=RYtqkQ4WSRBbbm5FHU+wgbZeUBYFswb13Qe1qWi91k6fBc7yV1fnMZ5JRvba2ORW5d
         bk9cxcYzM9iFz7GTtp7oVWrVX2DvtD/OiDStD3+pl92G+Itogm8Vvm7qTGlPyB69/ZzG
         FtoyMQ7G78G1nR8oyjSfLyElRCqxY+b4NWuKgCTUyH9YwB9sSHgvG2zH2bCv2qi3MPnX
         Wwp6HkGszzHwrRaD+0ovf5b9KdtuN6GA8hhCW+AFErzg6VQ/Z5z1c0p4WcD3pbduycnO
         8HMxtUNcp6SKMNslNddJWTen0zAn+NAJOiv7B+vVKKyTKvxP+ufU56Yv7jnoKYXRtSyI
         Ho3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907504; x=1788512304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=Di1eULoSrVSMrKDTvpsBZ3HbP5sFMul0ClTFOIVAtL+I5X4S1yqDltgD6hURwWoslD
         0eakKuxyETQ9ffqiBzg9BPICUuH/TBaTNLYBt3BlnYYkp0XdO1/mT1JM27thmUlorUl0
         fvyJKKlryZ10EhRgAdvz26OIvop8WDJvm2E5SkTUcb8+XSZbPkW3Ba4U82dbLl1Sb0tQ
         hgqdY4cmzL3Xw52YGgsA8b7CqERHXTJ94uMHa1R+LWhFLULmXBT4M1dWV1IL4j1L+/Bt
         7RPWn6mmfRskxQ6FiGGQQKjDMrTPxETmy4RN64mf87tGU14sO6X8Fy6aAeqtXVPqaW8x
         NlEA==
X-Forwarded-Encrypted: i=1; AHgh+RqrhpGp8JxOHedB8CKTJQvIobK6D4J0rmiufRNjvVo9M5ps11FlgJ1H10X6Qwc42/pqi1dt8A==@lists.linux.dev
X-Gm-Message-State: AFuF++nnRg+9XI1CAtu2iwmSmPNWgtPEvYIMMzSZwz/jJKgcbJRDDrNF
	gBfmAMidb81Nexdfrru/PcJ1GiJ0zeGWgJpaEQzyP3BvW+YhKlformaNygydBHIyIjE=
X-Gm-Gg: AR+sD135v/dNfKNZ1ft2LF/6/5kLXXzWrfg+DnYgklAkwe3qMuIgM8Do+Itm0pKrQer
	vsrhcgIur6joCGnTxKNDcgMPzLXYKPzcVBszLfftD3xWu8/abwRpkzErEJKv4rnVdFhOPAsxHfX
	KWiazf5EUi9OVU+jBA+77LzU91hD2+27S+eo2SGziw9i45SWXq3//syaOi1p8BVVwscEIWm1c7i
	fZ7opfA9ZlsUbFW82UoKQDWGbaRQBxaKM1pouWKYirqTGPfEihwFweXa8MyfCq0EzKsuAa40IpH
	gk3bNJWKw1V7ZqcWq3QayNvptaejYPjZ9Z7ECRRkznoRv8QuAeSpKxGIQpBvN5a6l7O851hui5M
	HQi4awho9+qqInytzMHdVuCTNF7vcCbh/jS1/bAVR5x89C+TsWT6Oq7pvTYpcnuifJNU0KyRJrT
	0XeLJzsnRU0c9YqcTw9QWiYaNsU1HJvB19c92GPD5ifJs8tqvjN0oq4WdfbEBPQkeaDNNPW445
X-Received: by 2002:a05:6a20:7345:b0:3d1:7238:33d9 with SMTP id adf61e73a8af0-3d26532756amr10426288637.3.1787907504506;
        Fri, 28 Aug 2026 01:58:24 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9ecaa9sm3838814eec.26.2026.08.28.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:58:24 -0700 (PDT)
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
Subject: [PATCH RESEND v7 2/3] iommu/riscv: create a auxiliary device for HPM
Date: Fri, 28 Aug 2026 01:58:16 -0700
Message-ID: <20260828085819.4076449-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260828085819.4076449-1-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
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

