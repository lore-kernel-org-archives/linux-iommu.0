Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1554A7F9
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082795; cv=none; b=B3EXIIUgg/LVeg4Aoc/Uh19rIXjuWI6XJ+MEAZiINPDOT/Z8JEGxq/Oa4D3g46d+bu/zN17Qa1bmhZDVaoEcMfQ637cslk1ji+wQbJ5VDbWNAqzZm+mNeLUWHipQinwEQUqLfMzS0/6BPV9hYa+ryd6pGOOC/VHlSlEK4tG+tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082795; c=relaxed/simple;
	bh=dUxE5mNIeukUldblked8004/Yygfcq19gYw2I3T7rmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQlpveFHxpRaxAhMQFfHxsJ7zo0i2tI9OyFlDKv/JXITGvphb+eVEswWwGmGm5kwmgDGGf+4CDbZBfX8zp4dOXwb4Bh6Gcp1RtPvK2F3CPersXji5vbWoioM1SWH0gFy1ugwKiXhDUa5q9RRBOnqoN3s3nEkMnwVIFiXKX1bc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS6GwffK; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS6GwffK"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso4565279a12.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082790; x=1790687590; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEPQieGs38qja288Nq+x3XKvBGSW7T//30W/ZzzD6PA=;
        b=uS6GwffKamBPg6dJWd6KlPlb1ikhlAtUT4SDKQJ7ymzQ9HfqZ8/ZXIZws1HKHKucXe
         Z9YqP5fg6dgntZZ8SCVnKV1UZJXxnF4TNcW3x59//Gm91we83hGjAbn7+8vJnwfzVDX8
         +W2cprmV0OEjzWrhh/jwinuZrGiy1GI7HJo62U+f4dKPwEHgwyIZoMhJjgp308lJphTd
         YbCRKg61XCuj5JLs0vl48LY6VuKhAIjViaNqIs7Ms0oTZcucn8XWcU3ki+dpoFCIwJbA
         IFn+Zt9+lk1UlzZW4SqrQvgUSGGcB/rMr0JbGqXj2xE40hlj4PbX+ORcXh9MESLPoBGK
         aRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082790; x=1790687590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEPQieGs38qja288Nq+x3XKvBGSW7T//30W/ZzzD6PA=;
        b=LPZmF24MqG4gPjKj9IfY56G26+dhqI29TipEXKJ5mniW3tUOauzolcmkxqwTkqn/rX
         h59UwXVeg0h9IFLFFhYWP1Z9Yb/T72ITcQ+rdcw0XCfjcrAqsDS0TUs0+FLJgB5PPTKm
         PhJ/hek+vyitgRLm0EOHd2hRg6TI8pBogtDWwP9uGeTfzYcHlhxainkgDfstGUaaPyui
         WPcwc9WVUVPwrihpiHL+kFZMCsXVmRWTBWdAmwZy+c/o2HIssPLLUJdSN3vCUceMkGmt
         +d+eexG8rWQm/zMO6W9txp7ggKPUuL05/Ri1TaVly4TXuEr+kzQ67jI/rj2/mj80UZXE
         E41Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlhuPHXfPFo23mutr1LLkVsFUh/CycH/LEY/NKBXnyX4TjjTiBgHmrjLy0TJMwyB9zTX3I6w==@lists.linux.dev
X-Gm-Message-State: AFuF++kYSHvph4TqHrLarF6J7RjuadS6IU0oyeF0yvD80JC4ksO7pIzb
	oDrsx1mEpMo/IUrhNXXk+YtVIMjPvrOKdSkPsq89d4CYBppuPxoB/5t6NkgSIB2TJ394JpqWCyi
	PaS8/IJLTwPQ5fA==
X-Received: from edxs13.prod.google.com ([2002:a05:6402:164d:b0:6a9:cb33:8782])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:23d0:b0:6a8:59aa:214c with SMTP id 4fb4d7f45d1cf-6aa55eee346mr10169438a12.11.1790082789756;
 Tue, 22 Sep 2026 06:13:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:12:39 +0000
In-Reply-To: <20260922131259.2975334-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260922131259.2975334-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922131259.2975334-7-smostafa@google.com>
Subject: [PATCH v8 06/25] KVM: arm64: iommu: Introduce IOMMU driver infrastructure
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"

To establish DMA isolation, KVM needs an IOMMU driver which provides
ops implemented at EL2.

Only one driver can be used and is registered with
pkvm_iommu_register_driver() by passing pointer to the ops.

This must be called before module_init() which is the point KVM
initializes.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h       |  5 +++++
 arch/arm64/kvm/Makefile                 |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
 arch/arm64/kvm/hyp/nvhe/iommu.c         | 19 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c         | 10 ++++++++++
 arch/arm64/kvm/iommu.c                  | 25 +++++++++++++++++++++++++
 7 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu.c
 create mode 100644 arch/arm64/kvm/iommu.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 27fe0cd5b2d7..7ba7d384889e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1717,4 +1717,9 @@ static __always_inline enum fgt_group_id __fgt_reg_to_group_id(enum vcpu_sysreg
 
 long kvm_get_cap_for_kvm_ioctl(unsigned int ioctl, long *ext);
 
+#ifndef __KVM_NVHE_HYPERVISOR__
+struct pkvm_iommu_ops;
+int pkvm_iommu_register_driver(struct pkvm_iommu_ops *hyp_ops);
+#endif
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 59612d2f277c..0ddef54f7434 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -24,7 +24,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-mmio.o vgic/vgic-mmio-v2.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
-	 vgic/vgic-v5.o
+	 vgic/vgic-v5.o iommu.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
new file mode 100644
index 000000000000..83abe1a443c6
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_NVHE_IOMMU_H__
+#define __ARM64_KVM_NVHE_IOMMU_H__
+
+struct pkvm_iommu_ops {
+	int (*init)(void);
+};
+
+int pkvm_iommu_init(void);
+
+#endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f57450ebcb49..7cb79db9bc47 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -24,7 +24,8 @@ CFLAGS_switch.nvhe.o += -Wno-override-init
 
 hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o \
+	 iommu.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../hyp-entry.o ../exception.o ../pgtable.o ../vgic-v5-sr.o
 hyp-obj-y += ../../../kernel/smccc-call.o
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu.c
new file mode 100644
index 000000000000..ef456eff42d2
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU operations for pKVM
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <nvhe/iommu.h>
+
+/* Only one set of ops supported */
+struct pkvm_iommu_ops *pkvm_iommu_ops;
+
+int pkvm_iommu_init(void)
+{
+	/* Keep DMA isolation optional. */
+	if (!pkvm_iommu_ops || !pkvm_iommu_ops->init)
+		return 0;
+
+	return pkvm_iommu_ops->init();
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 75b00c323310..9607d1b18a88 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -13,6 +13,7 @@
 #include <nvhe/early_alloc.h>
 #include <nvhe/ffa.h>
 #include <nvhe/gfp.h>
+#include <nvhe/iommu.h>
 #include <nvhe/memory.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -328,6 +329,15 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	/*
+	 * IOMMU init is done at the end, as it sets up and initializes many
+	 * resources that would be leaked if the hypervisor fails after as there
+	 * is no remove_iommu_driver() at the moment.
+	 */
+	ret = pkvm_iommu_init();
+	if (ret)
+		goto out;
+
 	pkvm_hyp_vm_table_init(vm_table_base);
 
 	pkvm_ownership_selftest(selftest_base);
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
new file mode 100644
index 000000000000..30a3862e93d7
--- /dev/null
+++ b/arch/arm64/kvm/iommu.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Mostafa Saleh <smostafa@google.com>
+ */
+
+#include <linux/kvm_host.h>
+
+extern struct pkvm_iommu_ops *kvm_nvhe_sym(pkvm_iommu_ops);
+
+static DEFINE_MUTEX(pkvm_iommu_reg_lock);
+
+int pkvm_iommu_register_driver(struct pkvm_iommu_ops *hyp_ops)
+{
+	guard(mutex)(&pkvm_iommu_reg_lock);
+
+	if (!is_protected_kvm_enabled() || is_kvm_arm_initialised())
+		return -EPERM;
+
+	if (kvm_nvhe_sym(pkvm_iommu_ops))
+		return -EBUSY;
+
+	kvm_nvhe_sym(pkvm_iommu_ops) = hyp_ops;
+	return 0;
+}
-- 
2.55.0.1082.g2b9226bbc0-goog

