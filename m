Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C634D4CE
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538042; cv=none; b=aUTeJaZQF48kXXO9IQUa6XY7GG7BTNK2ui/8EZnzj+KgxgRNwe4mpr+30V/hGeiRCNcQ/VooiEx9mFIy1u8cAn/nEFxXPTZA13vsduq11VeXwaelCj72YHwEEmBs2+sMww37v0GgRyntoZzKCLqIAlKkUU7Et1thmVsBAv48+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538042; c=relaxed/simple;
	bh=pTsBIp44Zh1FrmMiQvMfehgKLSU0k4F1puuNVXnvO9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMh8dc6pcnXmcyjtD6F01+vvI5A4Yz+/UyWTV3F+ymvgJp41SnBtK3jCEs1Ev+c0ZkLMAmR5qOezPaTqrXuY5aRzEMRfS8jnfSzJ5vAyNF2oWV97crZWYvcRYGdP7p6fNrzIgBLyMY269WqFKDuU8VC5mT9iRMNL2bbM9uM44bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KLqznR9B; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KLqznR9B"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1694445a12.3
        for <iommu@lists.linux.dev>; Sun, 23 Aug 2026 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787538040; x=1788142840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=KLqznR9ByBcLW1rVo3mzp0iVEdpw0Y/AqsHgsgetvVSlEZUDzutq/02HZBAfVFAz2k
         OA/hC0tOrou900hzIgdBhaoqhmOA2yy0Rr9w+C2TTDKsiLRZ26rgnct+tTNqLy+fvLkS
         sJge0TGXV+HBbbqy7fXuvQ5wPbFGAsfh0U5SP8P9ORAN0COa+uFM9ac3empuyC1Mfub6
         GRYp66PAOO2RkgX/k0Y5DUf2ff7C211z0RUicIcvtMDvsdA1Zj9eXKDE/2At2yqbw6Ay
         jZBSVRrvChoGzUXN8XqiN5kjpGHDZB8cOlySWBmuvRJjF4fk2gEg8qA3mKMTk5KCWyJ0
         MN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538040; x=1788142840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=NaFXxgMXa1rXXE//CztM20OVexYyuo65z6wV3bK31vkGVD2NTfvtBtK1OppJHBj7+d
         Km/meZHdxjJV0kJeHDpB3m4bza+8jWh+70fE0kIhJFrMmL8pZy7zm1UlNyNVnO2tHdQc
         xE2sDcAvk7020koozKGhYzOmbNapkaMZkqtqcqwVJTaZiraAzNjxeK0pjByGqUCLPR4/
         NQC87ozFIDeW0WwGAyA3hXQrCYNm5mRTZgmcKJukTrhVkTnoVajZglgMdHzZu6d6MdCB
         GMAMvDBB7HQ+OEiD5Td91sLIklfYK1RsD8A0AO92bfVs3L/TWCN5mglkDgSiMCeoZM5l
         kavA==
X-Forwarded-Encrypted: i=1; AHgh+RruNqhs8PmG1q9IQVWh9ko5y/4IrgZU1zlAD7liauGsvkGyiVEL/QH7hOUgn7mPVMS/wCVhQQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mIO/8T9BvwwrodsZu/b13VHHOvvJ8LpChEuT9P4YZMPdVUlWhz
	AFQILVN7dnIwkzcuL6Bf0chYNduAHpqKZc1MHefYbwODHuXxzgxteFc7kpmwWH5m2oo=
X-Gm-Gg: AR+sD125XtjjXz2klpRmtE9tUDKns6l7EZdgzN1bRFQ1tnmlhxr1B6TllJFbT46kllz
	40k5YG/W4nQRjWsTltfIbSx7FU8+185r0wY234wa5JPiqW0hPfKs+5kp73FQ8+DJ20IFi+gVMKk
	xVi4JgSZASFMKDPFWqN48zVxBp7Ou3QImbT+8dhtW5q7bzu/Kto6LhExVXOAwG3wFAmUaowQOXN
	JQyvXmjjg2XMMvbB9eQhZhP2xs+gfjuXhe/M3hL259gHcaVG1yYzrZouAGKUy1u/CDqPX0O0Iji
	PY4q/ltETJv0LK4Ri2uMr8MJQx5aDrf/c345x1RsSapYRx6efDbqnW6xKRMp5wKq86eK1V8NFYl
	RaTRfcnhZ/h4hvsY5MDkq29xLOXVWDXPWmO7y0HxWE7JovdQQoIva2NjKGyHxzxqZP05DX8Bmgm
	Lrud4UsnOOc11k8Zv+8NzBLEkKWALoEw37ueEqx5VkyvwX+OHaBiNbNQU93iTBwrpWsoYzFJJw
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-395c354da4fmr41782461a91.10.1787538040293;
        Sun, 23 Aug 2026 19:20:40 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm31175869c88.12.2026.08.23.19.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:20:39 -0700 (PDT)
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
Subject: [PATCH v6 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sun, 23 Aug 2026 19:20:29 -0700
Message-ID: <20260824022034.3916570-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260824022034.3916570-1-zong.li@sifive.com>
References: <20260824022034.3916570-1-zong.li@sifive.com>
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

