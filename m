Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D6ADC
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 21:29:35 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id w14so5393474qtv.13
        for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681507774; x=1684099774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKVxcyUlMFW5qdzkCgP4h7TpGF92heFD4RUEkUjHDYc=;
        b=j4n/kmRKuDKT+obuHiLipX05S2HzKakpxDZQgkWd3EFv9xdlPYwpbIhiNt58T3Mlba
         HOjrJ5hq4gKwyrHy121KhkhWUMAOn6AwDdidA1uIul5dASMPShhqZJ7Li4dxd7pUEBsd
         0pJh30AMNyYodHbfev74oIiFbhIK+6iJjDtcGvxCexyouvFxKvroXDjZ8/iX3r2azz/2
         o5zmbPxJsxDAciTq1krABmSAiGGMm5aReiaDgnNYWp0rqAw5GJV4rri72x9+gwJPYTYL
         Hk1u6pcLqNpDA1M9MPOGIzG5I34wgwZ+MxHAhhf0RA/2g6GZfCHrub7VDs5uNazN050G
         b0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681507774; x=1684099774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKVxcyUlMFW5qdzkCgP4h7TpGF92heFD4RUEkUjHDYc=;
        b=Mxt96cxf3q/zZl8mDdnsOaGc9WfZxod0fM7fso641Aai7rSKHkRPW3mvexqmc0+Z7k
         UEWCuFASXfZ9uz0NlvxkCYKC60GhlEHW1S11tPDVYdOkOBeqpkrvWHAzeB8hlhZwClQH
         cI1cPM6sQNk3j//WpeZ8WCyQpcmkRI1veuCzCMKeWyNfMmnQu6KmuSSDeTEBwC9QBLHR
         79VQ1Lpp1GF62krGX9GemccRy3BRufMbThrYH8pERHGzbIRx2VXMTOBTwTapVBZXdRj2
         gzJha1Ublpv0yHqePV/VPLNffA3spf2p+DVA6XrRVzv6BIVSPxsjHZwz9MIb+bVQRGDy
         moNw==
X-Gm-Message-State: AAQBX9f8MYCYsvJzn9b1LohTGP2b2NTbAzoXfqBiFWcZeN1H9SPNfbrD
	FFRKv8p6ifaoUqxRHPjUztY=
X-Google-Smtp-Source: AKy350aoKyhZqFDur3tbtlzp/oTUUSYYsZQMEWgY1N3s/2EjXGTnTtrXzohSthSKNWkRzYAJvOl0yA==
X-Received: by 2002:a05:622a:19a7:b0:3ec:46e9:bc4b with SMTP id u39-20020a05622a19a700b003ec46e9bc4bmr3633173qtc.29.1681507774449;
        Fri, 14 Apr 2023 14:29:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bm38-20020a05620a19a600b007422eee8058sm1487244qkb.125.2023.04.14.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:29:33 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Claire Chang <tientzu@chromium.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Subject: [PATCH] swiotlb: Relocate PageHighMem test away from rmem_swiotlb_setup
Date: Fri, 14 Apr 2023 14:29:25 -0700
Message-Id: <20230414212926.2336072-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opendmb@gmail.com>

The reservedmem_of_init_fn's are invoked very early at boot before the
memory zones have even been defined. This makes it inappropriate to test
whether the page corresponding to a PFN is in ZONE_HIGHMEM from within
one.

Removing the check allows an ARM 32-bit kernel with SPARSEMEM enabled to
boot properly since otherwise we would be de-referencing an
uninitialized sparsemem map to perform pfn_to_page() check.

The arm64 architecture happens to work (and also has no high memory) but
other 32-bit architectures could also be having similar issues.

While it would be nice to provide early feedback about a reserved DMA
pool residing in highmem, it is not possible to do that until the first
time we try to use it, which is where the check is moved to.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/swiotlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dac42a2ad588..2bb9e3b02380 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -998,6 +998,11 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	/* Set Per-device io tlb area to one */
 	unsigned int nareas = 1;
 
+	if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
+		dev_err(dev, "Restricted DMA pool must be accessible within the linear mapping.");
+		return -EINVAL;
+	}
+
 	/*
 	 * Since multiple devices can share the same pool, the private data,
 	 * io_tlb_mem struct, will be initialized by the first device attached
@@ -1059,11 +1064,6 @@ static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
-		pr_err("Restricted DMA pool must be accessible within the linear mapping.");
-		return -EINVAL;
-	}
-
 	rmem->ops = &rmem_swiotlb_ops;
 	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.34.1

