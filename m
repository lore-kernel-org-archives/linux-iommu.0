Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457333D0
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 12:59:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y1so17249010wru.2
        for <iommu@lists.linux.dev>; Wed, 01 Feb 2023 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNUt4LXC/vnI+uinFgyT66VRoqWna4CviemrNT21aBc=;
        b=thk5T6OXjBQKQ8JCuo3/JBvaiAeliPJbKUA6Ev5LIvBWS09yiKK0shaiUVxTtsTeBt
         c+XuSCQ1TP1IABgnoI6i3lGgX+giB2jgzc1THVgnusuLSQNNNt6bS+ImpDXuysQeJ11F
         JLcR0da7d/4keUdWrMMV2L7qbinuKb59mEpdP3CKABCoa7skqfyKpnUaZECC+1fYWn+j
         l070kGUPgEqRTrzSe+a7rh2sFc8U5Y5/WwbZmcxsKDn5r9s/zFcm47LcB05dNt10Vb1q
         pEcW8SBeF5Bj3vtIw+Q+nhL7Z+MyrwOPXm6jZ+5aZvuVzUPsAqGjE1ZVojd5nV5B6WZX
         GYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNUt4LXC/vnI+uinFgyT66VRoqWna4CviemrNT21aBc=;
        b=gBZjdg5YF499+lGGq3wOl9/bUPJKRyuJdBn02bInM8LOMC0vwt6kiZHzmhoqxigYXC
         OIix78zTspKm544weFEX11pWxiXZn0BN60FVv5bhyIfQoVcrtKewo2YACyg59q+w4JcB
         C2+ARuTz1Pi+tGUXkU5k73whh978EPlDHl487PMYhY3GyOkYNEkbG/WNYcLBVIXfLzXW
         1WRyDo9uNEOf9WeWcoMyWWIkqx39tuRhckYK1SRbzgYVjTTN1AR4xt8Yj6MogPqDEyK/
         S2wUXpZVvW0hhhIyDoN6EMBSWkNueIl3PFI5bjUO3dlZIzQME5kNFv3zM5DR1H0iMiyK
         XgPQ==
X-Gm-Message-State: AO0yUKV6Lk+X3yn0bMcpxeIgTPgaeJmkpUrKTUIT5eaHX8wRg5th0e5L
	gLomM+QN59zyyWuF9t3vvZ0YGg==
X-Google-Smtp-Source: AK7set9dF9IqnNhJnBWjTtGsSxR/PrtlZWcMlOX8jMonsihAZRhFZWtS6tLGLt7ILypTZ2wjrtzJig==
X-Received: by 2002:a05:6000:1889:b0:2bf:c5e4:1af4 with SMTP id a9-20020a056000188900b002bfc5e41af4mr2995748wri.15.1675256373642;
        Wed, 01 Feb 2023 04:59:33 -0800 (PST)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000024f00b002bfae16ee2fsm17972811wrz.111.2023.02.01.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:59:33 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: maz@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	yuzenghui@huawei.com,
	smostafa@google.com,
	dbrazdil@google.com,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 18/45] KVM: arm64: iommu: Add per-cpu page queue
Date: Wed,  1 Feb 2023 12:53:02 +0000
Message-Id: <20230201125328.2186498-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201125328.2186498-1-jean-philippe@linaro.org>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hyp driver will need to allocate pages when handling some
hypercalls, to populate page, stream and domain tables. Add a per-cpu
page queue that will contain host pages to be donated and reclaimed.
When the driver needs a new page, it sets the needs_page bit and returns
to the host with an error. The host pushes a page and retries the
hypercall.

The queue is per-cpu to ensure that IOMMU map()/unmap() requests from
different CPUs don't step on each others. It is populated on demand
rather than upfront to avoid wasting memory, as these allocations should
be relatively rare.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile        |  2 +
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  4 ++
 include/kvm/iommu.h                     | 15 +++++++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 52 +++++++++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 include/kvm/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 530347cdebe3..f7dfc88c9f5b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,6 +28,8 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 hyp-obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
+hyp-obj-$(CONFIG_KVM_IOMMU) += iommu/iommu.o
+
 ##
 ## Build rules for compiling nVHE hyp code
 ## Output of this folder is `kvm_nvhe.o`, a partially linked object
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 26a95717b613..4959c30977b8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -3,6 +3,10 @@
 #define __ARM64_KVM_NVHE_IOMMU_H__
 
 #if IS_ENABLED(CONFIG_KVM_IOMMU)
+int kvm_iommu_init(void);
+void *kvm_iommu_donate_page(void);
+void kvm_iommu_reclaim_page(void *p);
+
 /* Hypercall handlers */
 int kvm_iommu_alloc_domain(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 			   unsigned long pgd_hva);
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
new file mode 100644
index 000000000000..12b06a5df889
--- /dev/null
+++ b/include/kvm/iommu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_IOMMU_H
+#define __KVM_IOMMU_H
+
+#include <asm/kvm_host.h>
+
+struct kvm_hyp_iommu_memcache {
+	struct kvm_hyp_memcache	pages;
+	bool needs_page;
+} ____cacheline_aligned_in_smp;
+
+extern struct kvm_hyp_iommu_memcache *kvm_nvhe_sym(kvm_hyp_iommu_memcaches);
+#define kvm_hyp_iommu_memcaches kvm_nvhe_sym(kvm_hyp_iommu_memcaches)
+
+#endif /* __KVM_IOMMU_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
new file mode 100644
index 000000000000..1a9184fbbd27
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU operations for pKVM
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#include <asm/kvm_hyp.h>
+#include <kvm/iommu.h>
+#include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/mm.h>
+
+struct kvm_hyp_iommu_memcache __ro_after_init *kvm_hyp_iommu_memcaches;
+
+void *kvm_iommu_donate_page(void)
+{
+	void *p;
+	int cpu = hyp_smp_processor_id();
+	struct kvm_hyp_memcache tmp = kvm_hyp_iommu_memcaches[cpu].pages;
+
+	if (!tmp.nr_pages) {
+		kvm_hyp_iommu_memcaches[cpu].needs_page = true;
+		return NULL;
+	}
+
+	p = pkvm_admit_host_page(&tmp);
+	if (!p)
+		return NULL;
+
+	kvm_hyp_iommu_memcaches[cpu].pages = tmp;
+	memset(p, 0, PAGE_SIZE);
+	return p;
+}
+
+void kvm_iommu_reclaim_page(void *p)
+{
+	int cpu = hyp_smp_processor_id();
+
+	pkvm_teardown_donated_memory(&kvm_hyp_iommu_memcaches[cpu].pages, p,
+				     PAGE_SIZE);
+}
+
+int kvm_iommu_init(void)
+{
+	enum kvm_pgtable_prot prot;
+
+	/* The memcache is shared with the host */
+	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_OWNED);
+	return pkvm_create_mappings(kvm_hyp_iommu_memcaches,
+				    kvm_hyp_iommu_memcaches + NR_CPUS, prot);
+}
-- 
2.39.0

