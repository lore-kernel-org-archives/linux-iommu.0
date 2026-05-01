Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10C39EF21
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634418; cv=none; b=L1pGWJ+ZDhxjOAKfayenDVouOpz2rILj5z8gdZESjbU12aECwVl2V6R4efi0bRqIig3XK6nSRZ4LnLX2WIcIjDqBJkM+Nf9tIRC4vrFJGzVTa9TkPXHpRp+uqPH8UGy29ZNimKxOBdt4Rjf3mU6PxTqipmHd9K1C7pmvFRGiPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634418; c=relaxed/simple;
	bh=OJF405qqToDaQYlnDrTfIPaZ3ERCsQQsEZlpDMFs1BM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=juEcdjakxDSEt0koROXOhEs8m895HhR3xxjMGa8kPIpMB4H+oHTzjXZaYJatujSovDA5BgGSnf9oq9/r6EFgtvPfoMOst/dcE8VFSgkBSDWpck1BPRCRwz15+RY16y3SVmB0BUvGKKx1Qlg6UPCedu3VkdrOotmAZ5LgNcTLAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCznwZOT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCznwZOT"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso16294725e9.1
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634414; x=1778239214; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzYlVYNpWMosnl9oou+4ebeG+lgxbNyORXDEfv3bAUM=;
        b=lCznwZOTiOt10Sh2Pjj/2ZfERUC9apv27ikcYJaHvJL8NsWSy3BFaoZXDfJIo2/EWD
         E20MmEruH2gApwvKbThemfO91Q0A49DlqDzHcIEZyWIAi5gbyLyZUMQi87bUqFnVyssQ
         sxqM0IWCMeQFfDkaR0z8x3UcXdU5XWlzdegxr8LCvbRRkhAms8OqhIlo5wqDT/86Smil
         joCW1P/XbNq+c73O9lC3L7sH+0QfFsYVoJVhz18donK+YmfR9SL8a+fso61MsXcicBBB
         vyEkc0RXrNUQM6hzmNXa3Yzunn3S71W2LNZPxRgmkibN0F8YVe05KwfskOfXAibhla75
         oijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634414; x=1778239214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzYlVYNpWMosnl9oou+4ebeG+lgxbNyORXDEfv3bAUM=;
        b=sdoxHQsz8Tcd3S5RutFVCmo81nQAGEpdX6D6GKy3lioJ8naBTEsmT6iROCcv5m3+S/
         ibFB1F3YBo05H0zQIe0V9INJES0x7BfrKFSJ3BeIJPdU8Atv2vR15alRTSkrxN/cKwfo
         ElcRWNEFsNqKuIxelK59InhnNlmRencOKk5oJMiJpRfOC/HgZFruJQFum0sHDneUKc66
         mfC6VHnOmgLRo8tcvrXNsVhI+vfvyn4UhTqO7RQV3QQiQ3nIEYz9GPOjhfAWqCTYQwbZ
         CUF5/8Hdg5E8ATnJeUq3qX/oA7IcNuY4cHqOtKrkqKrPglO2ZxIcvp9UPHMQoFdZzcvx
         GIFg==
X-Forwarded-Encrypted: i=1; AFNElJ9akTNMC5btMAIl+6LnNWAnpN+5ZI0EvY4/qGN5fCRPAiD6IJyivs3QJ0atqI3OxK2w7N6BdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHGZk0a/sVJpGstbNV/74LssR+Qg8QIStGwzlErGsj+LrcTkZR
	/xKwOd8BXKNjITRpWd614TZGsdDjOok9oZZQezXnB6NPUEV6GHxJwRQ9W4B9kY+ZbktqQ337H3V
	kvNDbTd+DAJd0XA==
X-Received: from wrut11.prod.google.com ([2002:a5d:690b:0:b0:445:168d:28b6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c10b:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48a8445876dmr93780755e9.24.1777634413385;
 Fri, 01 May 2026 04:20:13 -0700 (PDT)
Date: Fri,  1 May 2026 11:19:13 +0000
In-Reply-To: <20260501111928.259252-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501111928.259252-12-smostafa@google.com>
Subject: [PATCH v6 11/25] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	mark.rutland@arm.com, qperret@google.com, tabba@google.com, 
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add the skeleton for an Arm SMMUv3 driver at EL2.

The driver rely on an array of SMMUv3s on the system, where at
init it will donate the array and the resources of the SMMUv3s
so they can't be changed by the host after de-privilege.

This array will be populated in the next patch.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |  5 ++
 drivers/iommu/arm/Kconfig                     |  9 ++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 87 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 27 ++++++
 4 files changed, 128 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 606c0e1b7bd0..8a75739db947 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -33,6 +33,11 @@ hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-$(CONFIG_NVHE_EL2_TRACING) += trace.o events.o
 hyp-obj-y += $(lib-objs)
 
+HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
+
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-lib.o
+
 # Path to simple_ring_buffer.c
 CFLAGS_trace.nvhe.o += -I$(srctree)/kernel/trace/
 
diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89dee..916f4723238d 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -141,3 +141,12 @@ config QCOM_IOMMU
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
+
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64 && ARM_SMMU_V3=y
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
new file mode 100644
index 000000000000..9afc314d0acc
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM hyp driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_hyp.h>
+
+#include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
+
+#include "arm_smmu_v3.h"
+
+size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
+struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
+
+#define for_each_smmu(smmu) \
+	for ((smmu) = kvm_hyp_arm_smmu_v3_smmus; \
+	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
+	     (smmu)++)
+
+/* Put the device in a state that can be probed by the host driver. */
+static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	WARN_ON(__pkvm_hyp_donate_host_mmio(smmu->mmio_addr, smmu->mmio_size));
+	smmu->base = NULL;
+}
+
+static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	unsigned long haddr;
+	int ret;
+
+	if (!PAGE_ALIGNED(smmu->mmio_addr | smmu->mmio_size))
+		return -EINVAL;
+
+	ret = __pkvm_host_donate_hyp_mmio(smmu->mmio_addr, smmu->mmio_size, &haddr);
+	if (ret)
+		return ret;
+
+	smmu->base = (void __iomem *)haddr;
+
+	return 0;
+}
+
+/* Called while is the host is still trusted. */
+static int smmu_init(void)
+{
+	size_t smmu_arr_size = PAGE_ALIGN(sizeof(*kvm_hyp_arm_smmu_v3_smmus) *
+					  kvm_hyp_arm_smmu_v3_count);
+	struct hyp_arm_smmu_v3_device *smmu;
+	u64 pfn, nr_pages;
+	int ret;
+
+	kvm_hyp_arm_smmu_v3_smmus = kern_hyp_va(kvm_hyp_arm_smmu_v3_smmus);
+	pfn = hyp_virt_to_pfn(kvm_hyp_arm_smmu_v3_smmus);
+	nr_pages = smmu_arr_size >> PAGE_SHIFT;
+
+	ret = __pkvm_host_donate_hyp(pfn, nr_pages);
+	if (ret)
+		return ret;
+
+	for_each_smmu(smmu) {
+		ret = smmu_init_device(smmu);
+		if (ret)
+			goto out_reclaim_smmu;
+	}
+
+	return 0;
+
+out_reclaim_smmu:
+	while (smmu != kvm_hyp_arm_smmu_v3_smmus)
+		smmu_deinit_device(--smmu);
+	WARN_ON(__pkvm_hyp_donate_host(pfn, nr_pages));
+	return ret;
+}
+
+static int smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
+{
+	return 0;
+}
+
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
+	.host_stage2_idmap		= smmu_host_stage2_idmap,
+};
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
new file mode 100644
index 000000000000..0d9e48b201f5
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_ARM_SMMU_V3_H
+#define __KVM_ARM_SMMU_V3_H
+
+#include <asm/kvm_asm.h>
+
+/*
+ * Parameters from the trusted host:
+ * @mmio_addr		base address of the SMMU registers
+ * @mmio_size		size of the registers resource
+ *
+ * Other members are filled and used at runtime by the SMMU driver.
+ * @base		Virtual address of SMMU registers
+ */
+struct hyp_arm_smmu_v3_device {
+	phys_addr_t		mmio_addr;
+	size_t			mmio_size;
+	void __iomem		*base;
+};
+
+extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
+#define kvm_hyp_arm_smmu_v3_count kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count)
+
+extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
+#define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
+
+#endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.54.0.545.g6539524ca2-goog

