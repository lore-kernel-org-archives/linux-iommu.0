Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF52857FC
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725237; cv=none; b=q/7RlFfzy4+tvPnFhe2HIeTesuDtCML16OPyfAdaW7m6apGgelHgr/NLoLOyUEqD++NqGcI3sk/7wbpfKOpojuFmoz+xAFr07S8Wh9TGiUGlbp8P6ag/uN6EHT2YhJrGjsamH1iA2/u4VKOsIff9OVao82b2IDIgU5B+zBLzn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725237; c=relaxed/simple;
	bh=VVOrsFbGRBkP/Cgu5yvTZfQ/hDlv+X9NpGTP1yTKhio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/4Mk5SWmld9nt2nVq8qRatUMZdNDTXJ9Tf0XlOKTMEkJPJO5KgEt+ansvkt5p3gkgIw2Z4eFTsMAhV11ncA2ahNlghXXGtANcYyFi8rJrX+eVC7nOG/ycoLhLxrrTSQPjTdaq5ihzZg1eI+Jsjl5zb8g8oGR3lIbfQT2VJTp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZtXKdcU; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZtXKdcU"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso1667672f8f.3
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725232; x=1754330032; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUJpMDg7+jrfduLQADckxGjuFStn70Ay5xAwWuNr1tg=;
        b=YZtXKdcU5ZRdZb0w9FuVNMENwgsUJSut6ZBwbvre2MquJGXtuBlvSYjZGYXpRC+ET4
         zlhYRjlvX+csgJuQeeTTf8Ef8f1mK7ROn6rzfcOtt4AmApacQVtYLR2NETpoqYMxsFhr
         JeIKenPUd4YGngTowGITCjrkiFQOEJAUF2sNTSpjDGiLkCL36Bi5ellQTvIoFM7NaxoE
         z3WE731eKH05iUI+rS8KnSSaS7h1NiVCx7LKWhzLE45adYuw41okIeOHeLhqCK8Bcofp
         J+b/zSVXTcmzdGU39r4nN9+AAqzxyqb+bmQV+oHDfZR7QxPOa3/1AJU55oNk3Iz/H64O
         hmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725232; x=1754330032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUJpMDg7+jrfduLQADckxGjuFStn70Ay5xAwWuNr1tg=;
        b=WLSqDfnYTdnOpCKUobaKAlhE4Ram2CBrHByYc8aEEFtpia2ab2Ik/Ls1ZXKQNt+3GK
         nc7lit6pgod4y8v7xDuBfFjPTqBEKfEaOpiLZoC5gp1WEYs+4zsckp+YtWEW/6TZPbr7
         slBzSPIoVjJs+KPq0sIySSu4CzzAUq5Z0BMtVAJN6ZRZZip9vscrrUay6V1fhIj6VnQo
         O/654hDeg/wfPfFQKskFb8EtbYZvdGUDUPcgEh0CpoJSdCfgQ6I8UyM4qOtZ8RpraARl
         /sAdSXYY6GxOb+gVVbzP/u03ADb+FmKJDropuHE574MxXMKnGVMToK0SZaz4peF8SYcA
         18ng==
X-Forwarded-Encrypted: i=1; AJvYcCXoQnv18TIeR9xWx/aMt0dQaqupXMhMgiq+qu4l3bo8m3Bfcmt0usNfGMSTRARleUZlghVh1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAXMCkPp4DaPtFdSA8T0RjB/hVKJ6mZ8Y8OCoHwpcVIo3GgWiC
	THzetM8p1jAsgMLjapOAzDVJoESToFWQIJyCCi6C7KlDX+Td1MNSup0JENbkInNZHgRmITLbLZG
	/IKbDMqhqZgnyaA==
X-Google-Smtp-Source: AGHT+IGDhfh9EZSr8jP5okRTWnaalP3+f821EZxOUa7CIqVojw478qp+8MJe9Yk1pfl+ivqJv6Pn45G8dO2iWQ==
X-Received: from wmbay2.prod.google.com ([2002:a05:600c:1e02:b0:455:fdc1:e6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40dd:b0:3b7:8362:fed8 with SMTP id ffacd0b85a97d-3b78362ff93mr5355358f8f.2.1753725232196;
 Mon, 28 Jul 2025 10:53:52 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:10 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-24-smostafa@google.com>
Subject: [PATCH v3 23/29] iommu/arm-smmu-v3-kvm: Support io-pgtable
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement the hypervisor version of io-pgtable allocation functions,
mirroring drivers/iommu/io-pgtable-arm.c. Page allocation uses the
IOMMU pool filled by the host.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |   4 +-
 .../arm/arm-smmu-v3/pkvm/io-pgtable-arm.c     | 115 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.h                |  15 ++-
 3 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c71c96262378..d641a9987152 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -34,7 +34,9 @@ hyp-obj-y += $(lib-objs)
 HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
 
 hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
-	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o \
+	$(HYP_SMMU_V3_DRV_PATH)/pkvm/io-pgtable-arm.o \
+	$(HYP_SMMU_V3_DRV_PATH)/../../io-pgtable-arm-common.o
 
 ##
 ## Build rules for compiling nVHE hyp code
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm.c
new file mode 100644
index 000000000000..ce17f21238c8
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Arm Ltd.
+ */
+#include <nvhe/iommu.h>
+
+#include "../../../io-pgtable-arm.h"
+
+void arm_lpae_split_blk(void)
+{
+	WARN_ON(1);
+}
+
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+			     struct io_pgtable_cfg *cfg, void *cookie)
+{
+	void *addr;
+
+	if (!PAGE_ALIGNED(size))
+		return NULL;
+
+	addr = kvm_iommu_donate_pages(get_order(size));
+
+	if (addr && !cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(addr, size);
+
+	return addr;
+}
+
+void __arm_lpae_free_pages(void *addr, size_t size, struct io_pgtable_cfg *cfg,
+			   void *cookie)
+{
+	if (!cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(addr, size);
+
+	kvm_iommu_reclaim_pages(addr);
+}
+
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg)
+{
+	if (!cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(ptep, sizeof(*ptep) * num_entries);
+}
+
+static int kvm_arm_io_pgtable_init(struct io_pgtable_cfg *cfg,
+				   enum io_pgtable_fmt fmt,
+				   struct arm_lpae_io_pgtable *data,
+				   void *cookie)
+{
+	int ret = -EINVAL;
+
+	if (fmt == ARM_64_LPAE_S2)
+		ret = arm_lpae_init_pgtable_s2(cfg, data, cookie);
+	else if (fmt == ARM_64_LPAE_S1)
+		ret = arm_lpae_init_pgtable_s1(cfg, data, cookie);
+
+	if (ret)
+		return ret;
+
+	data->iop.cfg = *cfg;
+	data->iop.fmt	= fmt;
+	return 0;
+}
+
+struct io_pgtable *kvm_arm_io_pgtable_alloc(struct io_pgtable_cfg *cfg,
+					    void *cookie,
+					    enum io_pgtable_fmt fmt,
+					    int *out_ret)
+{
+	size_t pgd_size;
+	struct arm_lpae_io_pgtable *data;
+	int ret;
+
+	data = kvm_iommu_donate_pages(get_order(sizeof(*data)));
+	if (!data) {
+		*out_ret = -ENOMEM;
+		return NULL;
+	}
+
+	data->iop.ops = (struct io_pgtable_ops) {
+		.map_pages	= arm_lpae_map_pages,
+		.unmap_pages	= arm_lpae_unmap_pages,
+	};
+
+	ret = kvm_arm_io_pgtable_init(cfg, fmt, data, cookie);
+	if (ret) {
+		*out_ret = ret;
+		goto out_free;
+	}
+	pgd_size = PAGE_ALIGN(ARM_LPAE_PGD_SIZE(data));
+	data->pgd = __arm_lpae_alloc_pages(pgd_size, 0, &data->iop.cfg, cookie);
+	if (!data->pgd) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	if (fmt == ARM_64_LPAE_S2)
+		data->iop.cfg.arm_lpae_s2_cfg.vttbr = __arm_lpae_virt_to_phys(data->pgd);
+	else if (fmt == ARM_64_LPAE_S1)
+		data->iop.cfg.arm_lpae_s1_cfg.ttbr = __arm_lpae_virt_to_phys(data->pgd);
+
+	if (!data->iop.cfg.coherent_walk)
+		kvm_flush_dcache_to_poc(data->pgd, pgd_size);
+
+	/* Ensure the empty pgd is visible before any actual TTBR write */
+	wmb();
+
+	*out_ret = 0;
+	return &data->iop;
+out_free:
+	kvm_iommu_reclaim_pages(data);
+	*out_ret = ret;
+	return NULL;
+}
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index 2807cf563f11..c1450eca934f 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -188,8 +188,19 @@ static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
 	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
 }
 
-#define __arm_lpae_virt_to_phys        __pa
-#define __arm_lpae_phys_to_virt        __va
+#ifdef __KVM_NVHE_HYPERVISOR__
+#include <nvhe/memory.h>
+#define __arm_lpae_virt_to_phys	hyp_virt_to_phys
+#define __arm_lpae_phys_to_virt	hyp_phys_to_virt
+
+struct io_pgtable *kvm_arm_io_pgtable_alloc(struct io_pgtable_cfg *cfg,
+					    void *cookie,
+					    enum io_pgtable_fmt fmt,
+					    int *out_ret);
+#else
+#define __arm_lpae_virt_to_phys	__pa
+#define __arm_lpae_phys_to_virt	__va
+#endif
 
 static inline phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 					 struct arm_lpae_io_pgtable *data)
-- 
2.50.1.552.g942d659e1b-goog

