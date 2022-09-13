Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654D66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:59:09 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id y2so6831999qkl.11
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lc6C5FZ3R6bpGdrTQfUMqHUthTTami+g742/pfBsTic=;
        b=RlsLmEiP3JVWhyXjCMSzF7A4AVjyq1jRjWCW9x5GNVTee31Y+zsIXxNeUFqHaiWHyg
         8J6hP8RFMjTeETwSHV9ENC6pqQalmeYj6JweS9Tsv7OxuqvPlsMarmRSfwGBaWF+XcBE
         la0+kyQTMUqV4xn7LwqYCphDGQkUMF9O3ZqeG7FJEIlcBtt95RRsh5UONSCeySm6f9no
         qWos+YkhM9jVDPaT5oAH5RbFh07TQsfPjWCoTiWZNYZktg0UxgNqKCsIm4np7G5/9pqK
         Gqu0dk9U2X717zjfg5WZXwdvFki/e2iGeK+mAGJNsof/XN1i9elvjnIO7qYgQkqpgSuo
         A90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lc6C5FZ3R6bpGdrTQfUMqHUthTTami+g742/pfBsTic=;
        b=IgDwFHPElcB2kObsmBNeDFVYH0RRhXtGSFQGX+NqGfZIGaghp3/2ZnnQS+bRMwjrU7
         ck12n1kt2ID605NVZSlKbT1JP8gxaIrj7htU0vRibqFOnowl2DCF9bqmycdNW78B24Xj
         VKEQ0cUFRGwTp7/MqZPLLHkAA3I2pedFhlki43SKpLWTyI3z2z7KRGjpSerM5wNrLw8F
         LNkPCJ+HR8EqJbv9iIVmMpGeiyQCxRqvF5gHuiv8L+ZxV9CbB/65jxuRBeGso/lfip5a
         QTynYg1UqQEyoZGAGIUIaaU6Wz7XW8dbfX8AoKKf7rxB9Z9Mxi1KE6KgF3FlwmNKrhto
         QY0w==
X-Gm-Message-State: ACgBeo0fLx8NRN9zlatF0nMfAztFjbL/roowMjiREGQ1Q8fQfUyxffc4
	FKJpPu/R0A2RyMnWvkdaVUE=
X-Google-Smtp-Source: AA6agR4JgnZFDc4dYiN2cHvYsrY/zIDRf84OViiKl4IHPDPBj/qqA4B2wHLv+IBu33IWNCFBvl5WRQ==
X-Received: by 2002:a05:620a:22b0:b0:6cd:f06a:7978 with SMTP id p16-20020a05620a22b000b006cdf06a7978mr13621240qkh.106.1663099148142;
        Tue, 13 Sep 2022 12:59:08 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:07 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 20/21] mm/cma: introduce rmem shared-dmb-pool
Date: Tue, 13 Sep 2022 12:55:07 -0700
Message-Id: <20220913195508.3511038-21-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A 'shared-dmb-pool' reserved-memory device tree node defines a
Designated Movable Block for use by an associated Contiguous
Memory Allocator.

Devices access the CMA region in the same manner as a 'shared-
dma-pool', but the kernel page allocator is free to use the
memory like any other ZONE_MOVABLE memory.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/of/of_reserved_mem.c |  5 +++++
 kernel/dma/contiguous.c      | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0eb9e8898d7b..700c0dc0d3b6 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -123,6 +123,11 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		   && !nomap) {
 		/* Need adjust the alignment to satisfy the CMA requirement */
 		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+	} else if (IS_ENABLED(CONFIG_CMA)
+		   && of_flat_dt_is_compatible(node, "shared-dmb-pool")) {
+		/* Need adjust the alignment to satisfy CMA/DMB requirements */
+		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+		align = max_t(phys_addr_t, align, DMB_MIN_ALIGNMENT_BYTES);
 	}
 
 	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..65dda12752a7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/dmb.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -397,10 +398,11 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 	.device_release = rmem_cma_device_release,
 };
 
-static int __init rmem_cma_setup(struct reserved_mem *rmem)
+static int __init _rmem_cma_setup(struct reserved_mem *rmem, bool in_dmb)
 {
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	phys_addr_t align = CMA_MIN_ALIGNMENT_BYTES;
 	struct cma *cma;
 	int err;
 
@@ -414,16 +416,25 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
+	if (in_dmb) {
+		if (default_cma) {
+			pr_err("Reserved memory: cma-default cannot be DMB\n");
+			return -EINVAL;
+		}
+		align = max_t(phys_addr_t, align, DMB_MIN_ALIGNMENT_BYTES);
+	}
+	if (!IS_ALIGNED(rmem->base | rmem->size, align)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	err = __cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				      &cma, in_dmb);
 	if (err) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
+
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
@@ -433,10 +444,22 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
 
-	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created %s memory pool at %pa, size %ld MiB\n",
+		in_dmb ? "DMB" : "CMA", &rmem->base,
+		(unsigned long)rmem->size / SZ_1M);
 
 	return 0;
 }
+
+static int __init rmem_cma_setup(struct reserved_mem *rmem)
+{
+	return _rmem_cma_setup(rmem, false);
+}
 RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", rmem_cma_setup);
+
+static int __init rmem_cma_in_dmb_setup(struct reserved_mem *rmem)
+{
+	return _rmem_cma_setup(rmem, true);
+}
+RESERVEDMEM_OF_DECLARE(cma_in_dmb, "shared-dmb-pool", rmem_cma_in_dmb_setup);
 #endif
-- 
2.25.1

