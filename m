Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B55C81
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 15:46:25 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id iw17so21851073plb.0
        for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=G2HnexRcqtcbOBLQqu2d6rHkLU0457VcAac9EnkFuRg=;
        b=M6rOlqdPkmjiZfbtH4Gd3UfdvQxEoOOzexAHRinwE0agzpX/+31EOl53gQpONkQJFH
         x7jlkmB8Ju/ZKykxHn2AlgBAWt4vDwEY4tQyFwyf7QDYxA0fYkOhIj635hfiu98COud6
         63OM19tktlympYJuOgw4x+1h/bOhFlBLrsuGaF8D0rY6n1FlvYjhEpf2qTPaT7ibG12R
         3toPY4CHO9xsw8F00OrviyYEZ5lFF7DtJ16vV/lgFSKRZvdEQ0rf4BNxKZXea5vtL9lg
         SHt+MvscnWEcbguxdVrXdwCtaNSECnSs/+aeqmZzoZIPS/LJeqnNUuQCtYUi0dG7xhVq
         j1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G2HnexRcqtcbOBLQqu2d6rHkLU0457VcAac9EnkFuRg=;
        b=yZ49vQZEbUyaPycrOcxxPIo6yMkLSSqZiqLf6v6hVMy29LhBYVYNgtCmIkzEWZtKkk
         esfgWd7dnW6oUQEMj0dAsH+if6lPHm3r24H3h8MB9JBWsFO5bwO27f7U/tZGOJhFjIfn
         A9jnIyu5TgPFQ3/3fdKVzYkirjLR+UA9+h68ZV3EQ1qAm7NAFiuz50LchtEac8jvVkIC
         vUqbuO8Camr/krY06ZoWyuLFe3xqjFiH7vU0zDDXTw/TdriU7IAVJ/TYDOpzBIrn0e1N
         2t5RXrplUfWk7r6G1gnC0+hMxS8iB/vHgpQ2CFPUmcdET/xdOElYQMTnvU87tCZOUEyv
         rkjQ==
X-Gm-Message-State: ACrzQf3Uv/Yhae/eyhpoezWzRTIO8/80pkOGPI8bLNGAaNUKmC0N0ugI
	eq7QMBHb1GT764eB/C3OKV8=
X-Google-Smtp-Source: AMsMyM74WBhD3XUDAHvFj//42Gz2/RsZagmBAM3VJg/YiTr8YOUTcYGdSFEE0oFwZtVxS1iY4yrBIw==
X-Received: by 2002:a17:903:120e:b0:178:8650:274 with SMTP id l14-20020a170903120e00b0017886500274mr446319plh.55.1663343185296;
        Fri, 16 Sep 2022 08:46:25 -0700 (PDT)
Received: from localhost.localdomain ([137.220.236.138])
        by smtp.gmail.com with ESMTPSA id p17-20020aa79e91000000b0053639773ad8sm14724489pfq.119.2022.09.16.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:46:24 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/iova: using separate rcache for SAC and DAC
Date: Fri, 16 Sep 2022 23:46:13 +0800
Message-Id: <20220916154613.104965-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

While iommu_dma_forcedac disable, for PCI device kernel
try SAC first, if failed then try DAC. Since now rcache
does not distinguish SAC and DAC, if all PFNs contained
in cpu loaded cache is larger than SAC max PFN, but the
SAC address space is sufficient, as cpu loaded cached is
not empty, kernel will iova_alloc () to alloc IOVA. For
PCI device, kernel alloc SAC most, loaded cache may
invalid for SAC alloc for a long time, kernel will enter
alloc_iova() slow path frequencely, as result performance
is degrade. To circumvent this problem, SAC and DAC maybe
better to use separate caches.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/iommu/iova.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 47d1983dfa2a..d5775719a143 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -16,6 +16,7 @@
 #define IOVA_ANCHOR	~0UL
 
 #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
+#define IOVA_RANGE_CACHE_ARRAY_SIZE (2 * IOVA_RANGE_CACHE_MAX_SIZE)
 
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
@@ -723,13 +724,13 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, ret;
 
-	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
+	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_ARRAY_SIZE,
 				 sizeof(struct iova_rcache),
 				 GFP_KERNEL);
 	if (!iovad->rcaches)
 		return -ENOMEM;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		struct iova_cpu_rcache *cpu_rcache;
 		struct iova_rcache *rcache;
 
@@ -825,11 +826,15 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
 			       unsigned long size)
 {
 	unsigned int log_size = order_base_2(size);
+	unsigned int index;
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
 		return false;
 
-	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
+	if (pfn > DMA_BIT_MASK(32))
+		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
+
+	return __iova_rcache_insert(iovad, &iovad->rcaches[index], pfn);
 }
 
 /*
@@ -881,11 +886,20 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long limit_pfn)
 {
 	unsigned int log_size = order_base_2(size);
+	unsigned long iova_pfn;
+	unsigned int index;
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
 		return 0;
 
-	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
+	iova_pfn = __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
+
+	if (!iova_pfn && limit_pfn > DMA_BIT_MASK(32)) {
+		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
+		iova_pfn = __iova_rcache_get(&iovad->rcaches[index], limit_pfn - size);
+	}
+
+	return iova_pfn
 }
 
 /*
@@ -898,7 +912,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		if (!rcache->cpu_rcaches)
 			break;
@@ -926,7 +940,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 		spin_lock_irqsave(&cpu_rcache->lock, flags);
@@ -945,7 +959,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 	unsigned long flags;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_irqsave(&rcache->lock, flags);
 		for (j = 0; j < rcache->depot_size; ++j) {
-- 
2.31.1

