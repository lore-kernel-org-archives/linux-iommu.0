Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC335A2B2
	for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640360; cv=none; b=Nl1gMOiU4y+u92WANort/6WhXIBBnnCR6oE28xQ0M+ctVV9MaC63HRLf9feqxmTBhSmq3LsjmGNnhhk2vIz1ILofnkScKNYeRv0AykuWcor1hKX548ZDaBYp4rx5nF0F998AiKgfQKkbFjq32EXIJzidEcYpyC7YQokiBaTQxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640360; c=relaxed/simple;
	bh=vXwQDqElLwmdFXH6atI73BgGkGDD39YTucq302WuvLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A2QWz8HNQps24SoFuuIQi+eZBNdOEGkA/OQChvNccCtm4fa9N0+7/X1s73zKKTwder+Kr41kOMHF4Eugw0D4Fo4tMdyriOhsw4rV8lY8m6420G/MjPVPGWBgR8QiV16FzlNhCUoZ1YEeIWslO8v9yGD+it95rpX5t44fiEIb4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeFLGKnK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeFLGKnK"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so32896395e9.1
        for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640355; x=1756245155; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyXp0c9r8a6Z3kqM6MYogJzQkCF/sRbjU6o05FpAFo=;
        b=eeFLGKnK8afd9ALg+ZM9mdCDPuq4TAtyE1zIBsASaxjbrcHe2Y7t4gYszHhOa5lAyv
         MH+zNjvx7h+DcDoFK4YlrIXz8yJujWtYvx5/b8zF+HmHot+Fjg3IhhiA2jqBFf8nFxFH
         TPOB0hIiDfKt6JJjGnlkdPk6GVc7SHnf204hXxk1wQxJSQGyyBAGg588s1ohYijJLwIQ
         /32bTKiRLgl9UkvNc1xgheyS7M78vHZNUZn2soAvCVkWlklG1XWx3c/zawpRsxt6cBM2
         Laa8kDWTxcy4NoDZEfepyy9hgLskOQ6hZ0Pp1V5FWzxC6xEndMaYx+eE6Q4+RH2idGdG
         GnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640355; x=1756245155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyXp0c9r8a6Z3kqM6MYogJzQkCF/sRbjU6o05FpAFo=;
        b=l+D19GCdbyllxJpd4pDAgzec6vV9bXGNvrQXRO2RbVTEHRktsiLHSD37+gaycTBh+C
         CTW/Qgzx5mB79dSMQ9mSz7eeYxLbO34REVj4IDwYu5Y3nxrImd9z+MBZY0e2vO8mSrMD
         LUPAe/QHeK/51mdcKkrVgz5ehqAbW3OIW5VgvDnqN2AkxGbBVzdCI+0/xnErGC5+qwpm
         HD7doLlZMdcKZYGFwaFxXyynOH5Rbcar0nM7TWUogQMeXdfEK5RDLszXfrb6n7ORDiU3
         GPrVnNjxa6liJQWYpSskJCV6ESl4hfvAHDbb2pUcUmV4Q2gaLH67/bCuDFKSUHuMWdxe
         zfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUWi3QPuxMD1NGvdH3fSXMUu0R/C2JwZEIm4vQyqo03dS4647VJLMhUiuyaLDZVdNkI88hqtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU23Z3pvedO+/6wGSgn8ONNgM6BPe6J4cB1/q7Jr760wsRD3uf
	QBovs/6AKso7yikcrLvswEWMajSCYM9HWGOhGGMoq+hHYTVRyNAhxtJpeS7iVz4/mOPr0nrx0tZ
	Puel8ZA8IUaJtuQ==
X-Google-Smtp-Source: AGHT+IF09z/zChrY/XKW2p3rPVo1I7WRsoRzioqDNTUyJHzYESu4rlz8VOrrsAe/v0WNmek1lpwYcIduC6GS/A==
X-Received: from wmth10.prod.google.com ([2002:a05:600c:8b6a:b0:459:e347:8a6e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4284:b0:3a6:d145:e2cc with SMTP id ffacd0b85a97d-3c32e03e447mr337072f8f.15.1755640354609;
 Tue, 19 Aug 2025 14:52:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:39 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-12-smostafa@google.com>
Subject: [PATCH v4 11/28] KVM: arm64: iommu: Add memory pool
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

IOMMU drivers would require to allocate memory for the shadow page
table. Similar to the host stage-2 CPU page table, the IOMMU pool
is allocated early from the carveout and it's memory is added in
a pool which the IOMMU driver can allocate from and reclaim at
run time.

At this point the nr_pages is 0 as there are no driver, in the next
patches when the SMMUv3 driver is added, it will add it's own function
to return the number of pages needed in kvm/iommu.c.
Unfortunately, this part has 2 leak into kvm/iommu as this happens too
early before drivers can have any init calls.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h       |  1 +
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 20 +++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c         | 10 +++++++++-
 arch/arm64/kvm/iommu.c                  | 11 +++++++++++
 arch/arm64/kvm/pkvm.c                   |  1 +
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1a08066eaf7e..fcb4b26072f7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1676,5 +1676,6 @@ void check_feature_map(void);
 
 struct kvm_iommu_ops;
 int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
+size_t kvm_iommu_pages(void);
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 219363045b1c..9f4906c6dcc9 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -10,8 +10,11 @@ struct kvm_iommu_ops {
 	void (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
 };
 
-int kvm_iommu_init(void);
+int kvm_iommu_init(void *pool_base, size_t nr_pages);
 
 void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
 				 enum kvm_pgtable_prot prot);
+void *kvm_iommu_donate_pages(u8 order);
+void kvm_iommu_reclaim_pages(void *ptr);
+
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index f7d1c8feb358..1673165c7330 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -15,6 +15,7 @@ struct kvm_iommu_ops *kvm_iommu_ops;
 
 /* Protected by host_mmu.lock */
 static bool kvm_idmap_initialized;
+static struct hyp_pool iommu_pages_pool;
 
 static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
 {
@@ -72,7 +73,7 @@ static int kvm_iommu_snapshot_host_stage2(void)
 	return ret;
 }
 
-int kvm_iommu_init(void)
+int kvm_iommu_init(void *pool_base, size_t nr_pages)
 {
 	int ret;
 
@@ -80,6 +81,13 @@ int kvm_iommu_init(void)
 	    !kvm_iommu_ops->host_stage2_idmap)
 		return -ENODEV;
 
+	if (nr_pages) {
+		ret = hyp_pool_init(&iommu_pages_pool, hyp_virt_to_pfn(pool_base),
+				    nr_pages, 0);
+		if (ret)
+			return ret;
+	}
+
 	ret = kvm_iommu_ops->init();
 	if (ret)
 		return ret;
@@ -95,3 +103,13 @@ void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
 		return;
 	kvm_iommu_ops->host_stage2_idmap(start, end, pkvm_to_iommu_prot(prot));
 }
+
+void *kvm_iommu_donate_pages(u8 order)
+{
+	return hyp_alloc_pages(&iommu_pages_pool, order);
+}
+
+void kvm_iommu_reclaim_pages(void *ptr)
+{
+	hyp_put_page(&iommu_pages_pool, ptr);
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index bdbc77395e03..09ecee2cd864 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -21,6 +21,7 @@
 #include <nvhe/trap_handler.h>
 
 unsigned long hyp_nr_cpus;
+size_t hyp_kvm_iommu_pages;
 
 #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
 			 (unsigned long)__per_cpu_start)
@@ -33,6 +34,7 @@ static void *selftest_base;
 static void *ffa_proxy_pages;
 static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
 static struct hyp_pool hpool;
+static void *iommu_base;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
@@ -70,6 +72,12 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!ffa_proxy_pages)
 		return -ENOMEM;
 
+	if (hyp_kvm_iommu_pages) {
+		iommu_base = hyp_early_alloc_contig(hyp_kvm_iommu_pages);
+		if (!iommu_base)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -321,7 +329,7 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = kvm_iommu_init();
+	ret = kvm_iommu_init(iommu_base, hyp_kvm_iommu_pages);
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
index 926a1a94698f..5460b1bd44a6 100644
--- a/arch/arm64/kvm/iommu.c
+++ b/arch/arm64/kvm/iommu.c
@@ -7,9 +7,20 @@
 #include <linux/kvm_host.h>
 
 extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+extern size_t kvm_nvhe_sym(hyp_kvm_iommu_pages);
 
 int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
 {
 	kvm_nvhe_sym(kvm_iommu_ops) = hyp_ops;
 	return 0;
 }
+
+size_t kvm_iommu_pages(void)
+{
+	/*
+	 * This is called very early during setup_arch() where no initcalls,
+	 * so this has to call specific functions per each KVM driver.
+	 */
+	kvm_nvhe_sym(hyp_kvm_iommu_pages) = 0;
+	return 0;
+}
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index fcd70bfe44fb..6098beda36fa 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -63,6 +63,7 @@ void __init kvm_hyp_reserve(void)
 	hyp_mem_pages += hyp_vmemmap_pages(STRUCT_HYP_PAGE_SIZE);
 	hyp_mem_pages += pkvm_selftest_pages();
 	hyp_mem_pages += hyp_ffa_proxy_pages();
+	hyp_mem_pages += kvm_iommu_pages();
 
 	/*
 	 * Try to allocate a PMD-aligned region to reduce TLB pressure once
-- 
2.51.0.rc1.167.g924127e9c0-goog

