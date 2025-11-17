Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E0335093
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405318; cv=none; b=jyDLNNEMvLXw7WBccPFkN6L9SiU+qWujdpw6TPIZlkQwpo/oUxDjEw+W6JXYMxLcviQ8DNtc/dYbjIldxN/H+Tn4Wb6dfeGZWQhTITYYV5KjAG1gHG4RwXTPXaCO0oNtVo9EJDNnobU62d3KPgAr7SNQbI7Jj4uaVQTAQVQcMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405318; c=relaxed/simple;
	bh=9zeMjcd2L1k8BuaEQ9HDOIEDJgUOeJvw5uMmbl2pBbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnoL82vXJhFR92hRysL38rDObT5GynKNXIYxQS0mFqIePxvIJ4rfXS+OdCPrXNEvwkMiZamI9w1JwWCW95ikO8SLtXjAaqnqdgbUpH6M3LtnI916ZqIODaqCupfCni8kPxA9Yj14yCI65VcR5jlWmISE3mWCVb4RDbVE+jdNJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3vlxZKp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3vlxZKp"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47775585257so37314025e9.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763405314; x=1764010114; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=55AGVVkYakMhSKq7jdoT4Ydc3YlHaQUlYhRGsZGie9E=;
        b=K3vlxZKpdmz+Gr0b5kOq9AVDt3szfH+g7S9ewtPPgFmyyKg8NZgw9oknwZFtKeSdYp
         16pLjoi19wA89xRkeltU9Mn3sgx318RKsCcSfSQlrOd+5iTNxiNEVyB8BW/Gbe04O1fM
         3XjodvI4ZySH++iMvE0K0FcCGCznVWwxaKI32G33uHQrCPmiT5i2bBtrPfM7WgIlaqYV
         6EC8c5aDIDMn7klxW6nWrNwBOZCGS9rTDNRzUfhCH8I7RwQ4Pvdtb+iP7D3dwKDjL5k0
         vz0A/nRpM0Qbqoh9HexdCoT262sAuuJwPx271SJInI03qqyMJus/j9gzAJCb7sOCBhKy
         OFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405314; x=1764010114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55AGVVkYakMhSKq7jdoT4Ydc3YlHaQUlYhRGsZGie9E=;
        b=SemQJxUq+vrPrbFMmwAC3Y8klU6xhYl4/fiM+7hPawTVwuLujqXpmEu8mnHetwvnz6
         kfDLSDweVRcr34qzqSovZRYv0CHGyBUsInVT4p7hSdkE5q+FS77pzHF6kQCmDa58xP9c
         sU9TXLzlk/RmVa/Qore84Z3XjLhMyMSFB0VVi+rKaYSnj4y56zrGyau/Bjrag0ud3R7I
         PNSKna50ItmOL2rPDj1qQifFJtebLo1i3I6VXw0+6YECZiTK1Z0KUQXXmdzNbB+8S6je
         Jz99asP3XjJgYev05RlO2JMjiSrjVMWEOyt39knAyj0OXfZjqPR447pET1d4dk6dRrEA
         BTCw==
X-Forwarded-Encrypted: i=1; AJvYcCUtd+MoWytYy5esYH1oG6uosllKb/lDRoLHdBURONkud6W1HkeNUr95AbLExk2qjg1LtTGUjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVOrrC2w4mzRiOOHlNb2NYCgVDRGP6MeEf7LYK64DPpgW77em+
	7fG4DcJ+PblRaD1gaAoX/+1tI+jzoggesejXgxfqw+t94D1XG11NdRzVxTYs4ZfRGizo30B3Peq
	OFkBfdzlwe+lnZQ==
X-Google-Smtp-Source: AGHT+IETdIxY/B60kJGZ2vxQfTV572Z6M9F03+Q3FJ5EaaTwe2O+lpK+vSDpNGyLrCO0Jqd9FsK+JMhkS2KL/g==
X-Received: from wmkz11.prod.google.com ([2002:a7b:c7cb:0:b0:477:98b9:1e26])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:630d:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4778fea2bf7mr111910515e9.20.1763405314472;
 Mon, 17 Nov 2025 10:48:34 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:55 +0000
In-Reply-To: <20251117184815.1027271-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117184815.1027271-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117184815.1027271-9-smostafa@google.com>
Subject: [PATCH v5 08/27] KVM: arm64: iommu: Introduce IOMMU driver infrastructure
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

To establish DMA isolation, KVM needs an IOMMU driver which provide
ops implemented at EL2.

Only one driver can be used and is registered with
kvm_iommu_register_driver() by passing pointer to the ops.

This must be called before module_init() which is the point KVM
initializes.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h       |  5 +++++
 arch/arm64/kvm/Makefile                 |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 13 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 18 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c         |  5 +++++
 arch/arm64/kvm/iommu.c                  | 15 +++++++++++++++
 7 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
 create mode 100644 arch/arm64/kvm/iommu.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 64302c438355..fb2551ba8798 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1652,4 +1652,9 @@ static __always_inline enum fgt_group_id __fgt_reg_to_group_id(enum vcpu_sysreg
 		p;							\
 	})
 
+#ifndef __KVM_NVHE_HYPERVISOR__
+struct kvm_iommu_ops;
+int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
+#endif
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 3ebc0570345c..66959c048492 100644
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
index 000000000000..1ac70cc28a9e
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_NVHE_IOMMU_H__
+#define __ARM64_KVM_NVHE_IOMMU_H__
+
+#include <asm/kvm_host.h>
+
+struct kvm_iommu_ops {
+	int (*init)(void);
+};
+
+int kvm_iommu_init(void);
+
+#endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a244ec25f8c5..8210788d6f88 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -24,7 +24,8 @@ CFLAGS_switch.nvhe.o += -Wno-override-init
 
 hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o \
+	 iommu/iommu.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-y += ../../../kernel/smccc-call.o
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
new file mode 100644
index 000000000000..a01c036c55be
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU operations for pKVM
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <nvhe/iommu.h>
+
+/* Only one set of ops supported */
+struct kvm_iommu_ops *kvm_iommu_ops;
+
+int kvm_iommu_init(void)
+{
+	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
+		return -ENODEV;
+
+	return kvm_iommu_ops->init();
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index eff76be89329..de79803e7439 100644
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
@@ -328,6 +329,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = kvm_iommu_init();
+	if (ret)
+		goto out;
+
 	ret = hyp_ffa_init(ffa_proxy_pages);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
new file mode 100644
index 000000000000..c9041dcb6c57
--- /dev/null
+++ b/arch/arm64/kvm/iommu.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Mostafa Saleh <smostafa@google.com>
+ */
+
+#include <linux/kvm_host.h>
+
+extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+
+int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
+{
+	kvm_nvhe_sym(kvm_iommu_ops) = hyp_ops;
+	return 0;
+}
-- 
2.52.0.rc1.455.g30608eb744-goog

