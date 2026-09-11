Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B7419FA6
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108259; cv=none; b=TZIodB/zfb0sFt8iWa+obeZZ6yDNi5v1UJTpwtkFZb/XdSV/LcSBhehg1pfBdKMYsor4udAyIpABLGp+c+63pl1ANYimD19PV/EnDEXTVMCo6phaNxVRNKmRKyKupZ9t5RAZO1fNX7l9hWBsgYJB3NwlKQJzhU+0EF0hD+Zz4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108259; c=relaxed/simple;
	bh=1N0u4QGDF0E8zTrVUubLP7yatSB6NAmP0HgLOmukhmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2MOjmA2N4JwDAE+5oHhnrE/yThTCXiDt2cQ077b0CESK5VwoaiJvG8yfa7EgYm/LHfmcyPAN32FZQRx9hQOHrm3xHTzThqqE95g5OiKoQk8bOudcAJyL2tDnI9pfw8MnKGF7bo4jnNMCifXNKHhCYEukzzpdmB63SFMkgpWffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gCFq8t81; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gCFq8t81"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4d03f95dfso51234a12.2
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789108248; x=1789713048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Db3wlFQ7tWb65H2cUA6T2ug5PcDOcaldDbKEP2DhiPU=;
        b=gCFq8t81/D6PsJVKy78HWKOfRcWzdv7A7bC1z22JGKyxdiOZ/PIBPDq0dNd4A1GqDL
         +IyA0qt8nyw0yiN6gdxCCIM8QVSCDQ9PQ28OxX/ujZD0ITeBkd3QAHMCL9AkVsp5TVmE
         c/FTYPnrsaBTP53JUMi0S8tMKFgDRVHeRhiRsAW+hj9T7dolA/WXG9bUBB+smEyWRBSu
         2wOIOzrXe9Kb5/EClAwP8EuGSCHjs5S00O3DCCZr9EXoxmvKCOEXKlXpXctgvnBQIJ+Q
         zzAw7ORbG85ByaMIAIuvLgNoxuPofOjOF6A9R/wtIC+JeXhb/Yd11pImonG/wCfBv246
         Neig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789108248; x=1789713048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Db3wlFQ7tWb65H2cUA6T2ug5PcDOcaldDbKEP2DhiPU=;
        b=HdvknlS6Wa8CF5DvyftlxUD4rG9pFCgmTjW22Ky47WHwIAB3UubVGvk7LtYoHG4o3w
         0Ix1WWJxMyk5gugjincYs/UqTklZl3etCQ8mRUSHzam0+JhS9TvSgn4p+mTQcEAbiWM2
         vPGiksiAdUYKi5cKnztfITphJFClV22ydakb099inNRuVaUJ7ZssmhCnu7+i1NrSMVJt
         bYf+0u1JU88dFs8Z0MOvKNoTwqkPoMATo9Ja2WwjvDkR2lo3y7i8LecjDDGMfdcz9rxo
         y6yiuxf43L7s+Pe2lacxvdkO91Bb6U9SuyRY6c9q+Ryubp+T5r5xO10v2XVVb7pGvvJ1
         Zj5A==
X-Forwarded-Encrypted: i=1; AKwUvBzdO52Kq14/9VmXWPtDtB43NWgqDjxWgv5ljNx9UZRxVHCIz9OT67tCcOs73mvXN2O6d/n1Gw==@lists.linux.dev
X-Gm-Message-State: AFuF++kM1Vmm5eUp56JSTJXZ5sIrax7KdT2e5etXEprH+osW07Mysjzr
	42Hduqhnjiv2xvU4UW8srSL4atBPjOUJMvnwOrP74DbpnythGZZ8dTTYlbuDvZbZqFA=
X-Gm-Gg: AYBFou2QWBg9Unu2D1LbnP27mO86w7I7ehoIlLxSvfqQzCbpKY8/r9RTR5fab01IM0V
	hdkt0f9VuRfHjO7IdWZYkpdZ+EfjfjEBflreA4TIPrw4mfABGVJVGCoNpoOYwTUjShS0N+UO5cU
	cjeV0ABC/3O3fgCqjWEe8jcGVO71K1Q0K1dnYLdCcGBHUATMqd3m5M63cPl0fPga/BNZNN9/4ck
	ekzCaPqe/2wb5Rbfc6Lb0IiV7Fypov6cPfGSR1DJtWo0G9GkgaNxkeHOiolog52u8Pf6Uy89KH2
	wwpBZyxTGg2ZIG5Ysqtz1fgW23KvPRuKi5flqzltwsNqA+3s6zs2eX/go9KEQOn+v+jHHDESQfe
	6Luvp1WymPCfeRg52CwcUf8xAaLyLP2TQIL6UliRqDZOSzdVytt3gOPb/HO8OlV2ncHUSB88s2W
	GPu30dk7JdI3xVN1Sk5BZFrVzPAepjfYmhFZ8gs7mGAl6Dw+MN8bbRUzmh7EijPE7lP3vlD94Lp
	9VWX8WTisA=
X-Received: by 2002:a05:6a20:3c8d:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3daed3c168emr5513943637.23.1789108248408;
        Thu, 10 Sep 2026 23:30:48 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm331152eec.8.2026.09.10.23.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:30:48 -0700 (PDT)
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
Subject: [PATCH v10 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Thu, 10 Sep 2026 23:30:42 -0700
Message-ID: <20260911063043.916844-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260911063043.916844-1-zong.li@sifive.com>
References: <20260911063043.916844-1-zong.li@sifive.com>
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

