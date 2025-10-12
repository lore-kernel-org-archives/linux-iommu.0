Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9D236453
	for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760266347; cv=none; b=TtNMU6DLe6sUGfI4JvcilMI+SUmO5UbngcmGsaUluxD7B2zHwXFx0OKcAcTmC33p3ajAd7o0XiwgQl8WtpenXrnfqLVO1e59GTH9+PTVk2qm0Dkkf8qAqIih1Cy8BvV64nlB9fVKVOr//mLaYmMzNWIPpD7DKqoag8Gb7duVHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760266347; c=relaxed/simple;
	bh=MqF5cMOJ84e/bDS4TErqwcOhQLiLI58hkMImp466mJw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=iCWBPYxV8tszYuK+phCoAV/bs65v8CmY74c7Rp6taDHHbfTwjgjCPZ1fJZnj1PEYS3uQ6yKMlgi+MBW25mkKn4dolDLUdnIdoEpQNMX3eYrWpqSZ+X3/Q04WZ8PIjbsB1FsQc4uTN+1TzwzHkWMvfhuY4sAbuRwSfoCguuisuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlqfiSJs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlqfiSJs"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e44f22f15so483790666b.2
        for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760266343; x=1760871143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=KlqfiSJsl1/Y8GcPwbwDSqaHZf2ahqxfBuSvw+IZ83reZ7Ohi3I0gkawj7ZK9tjDGa
         8ZyuqwxUZBo09ng5Odmo8QURu+joCPn5YPYoMGyat7yAVu+aScQkSCpjUGjOtAFcam8f
         rOKNRjn1l3HThTpJOeDiWLbMHrds/tBD1M3Z45XwfCV/rKeCq5kCEIFZeD3ffoyT8bVF
         eYJ7KioTlgiNu1F7r7Su+5Ct8Hy78IWfHw/wqsZqxSmDQHptIbhlzcBOP601B4/ZO95d
         sOTnmfOXVij20QCMeO9KkNLeoVS6/M/XlqpzWfGSNHof0PQPskDqwSybLYFp6XAKGcwX
         wXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760266343; x=1760871143;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=jjKrtazdPgqiyrTwiW2S/HHNv0PYhPB/E0+AQXxymRMQToYoDSoty7p46K8Y1ca+WD
         lyMvY5qWEgINxJkXBLPUl5uszJyNJmB9hqTD6oFZGcqTyFY8tIfSLzRfXtH22zKm1jbo
         zXkrYHK07pZxrmadil/hpJ82GMrnK8hOFed7b5zRnw19FVoi6C0yVcBujH9XmUmdXm0Q
         +ZLDLG3b1lPhr+oMjpPqYEg5++X1Mj9wQaErm26BsiqjRw/rHBBmtF1TEaz7yndSIIj1
         7uOQYCDuMwEtaAxRW7l2Dd4SJzdYXlvj6RSi0YDihiTHG2fKt4nhzGfr6isRGtfajVKw
         N4vQ==
X-Gm-Message-State: AOJu0YwZKYNc8l31yP6YieMMWKCn71PYXfOX8yYUFYO6sMQAU4fGz1NU
	ilRr/IbQXn0tR24Ni/ZtfZRDErQbum58zCfv5qbiie+VglWskwaMOUy9wVXvng==
X-Gm-Gg: ASbGncsWelgy7JpcQWLtRcl5caoLZLl3c8SkkC/OfI37Of/3F1oi3M/JjLlfg+kfM+p
	kwn2FTa6lvxBDGfVCFL8BF6ddo58dJwc2Lg42hTBAq3YonYqavWHExiqXuqpca0p4FTerWnt6jv
	mUHmKpKAqZYAKC+P87E3gjjq2cGpOtwGsySJkbHhvhHcnAaaUzt2iogz7GCp0K3s1uOS8P3YcrN
	ZJK+0Na4LBBk+ycljPJlDrSW5C5chi2o4vfZ/JYtuCEJhrA1WHBIyba09uTpAJWHkxOrL0O/yl+
	hRmdrROe77ws9z38Bcm/EJlYPszotZlr10qhW5ieAFT+zTGy/lXoDEionPPyuyBc7wCfXwDbXVL
	F5QgZqd6vNXQbYJpWnyC6xW0ew7HtzdB+03ofH9YUZkLOElnaR1wQ3PoIq/fbxjt9Ht4Z5oEb/8
	E=
X-Google-Smtp-Source: AGHT+IGpnc73DvzgvhXnM6IXi/RiZA/Mw6XZR7FH07n78kbcJVw1ff18xsQwbSwwRBD8xIEozEoGuQ==
X-Received: by 2002:a17:907:3e22:b0:b3e:b226:5bad with SMTP id a640c23a62f3a-b50a9a6d8a3mr1889184266b.8.1760266343213;
        Sun, 12 Oct 2025 03:52:23 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm688164366b.5.2025.10.12.03.52.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 03:52:22 -0700 (PDT)
Date: Sun, 12 Oct 2025 12:52:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH RFC] Implement DMA Guard Pages
Message-ID: <20251012125218.45c5f972.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I wonder if there is any interest in a feature like this?

DMA Guard Pages are unmapped pages inserted between consecutive DMA
mappings for devices behind IOMMUs. A device accessing its mappings
out of bounds will hopefully fault instead of hitting other memory.

I wrote this hack yesterday to debug such a device, since getting
an IOMMU fault is easier to detect and more convenient than looking
at some weird malfunction and wondering where it came from.

(BTW, can a PCI driver "catch" IOMMU faults by its devices?)

It looks like a useful aid for PCI driver developers and testers,
or maybe somebody would want this in regular use for reliability?

Honestly, I was surprised that no such thing (apparently?) exists.
So I dug into dma-iommu.c and wrote my own. The implementation is
trivial, it hooks into iommu_dma_alloc_iova()/iommu_dma_free_iova()
which appear to be a bottleneck where all iova (de)allocations for
DMA mappings must pass. The allocations are increased a little, but
callers are unaware of that and only map what they wanted to map.

It even seems to work, but beware it's first time I touch this code.

Michal

---
 drivers/iommu/Kconfig     | 18 ++++++++++++++++++
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..f607873bf39a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -157,6 +157,24 @@ config IOMMU_DMA
 	select NEED_SG_DMA_LENGTH
 	select NEED_SG_DMA_FLAGS if SWIOTLB
 
+config IOMMU_DMA_GUARD_PAGES_KB
+	int "DMA Guard Pages size in KB"
+	default 0
+	depends on IOMMU_DMA && EXPERT
+	help
+	  Specify the minimum amount of Guard Pages to be inserted between
+	  consecutive DMA mappings to devices behind IOMMUs. DMA Guard Pages
+	  are not mapped to any memory and hardware attempts to access them
+	  will fault. This helps catch hardware accessing valid mappings out
+	  of bounds which could otherwise unintentionally consume or corrupt
+	  other memory mapped adjacently.
+
+	  Size will be automatically increased to one or more IOMMU pages,
+	  depending on applicable alignment constraints. Small power-of-two
+	  mappings may get as many Guard Pages as the mapping uses itself.
+
+	  If unsure, use the default size of zero to disable DMA Guard Pages.
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	select IOMMU_MM_DATA
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7944a3af4545..51edf148f6c4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -746,6 +746,17 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+static unsigned long size_to_iova_len(struct iova_domain *iovad, size_t size)
+{
+	size_t guard_size = 0;
+
+	/* allocate optional guard pages after the requested mapping */
+	if (CONFIG_IOMMU_DMA_GUARD_PAGES_KB)
+		guard_size = iova_align(iovad, CONFIG_IOMMU_DMA_GUARD_PAGES_KB << 10);
+
+	return (size + guard_size) >> iova_shift(iovad);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
@@ -759,7 +770,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	}
 
 	shift = iova_shift(iovad);
-	iova_len = size >> shift;
+	iova_len = size_to_iova_len(iovad, size);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
@@ -796,17 +807,21 @@ static void iommu_dma_free_iova(struct iommu_domain *domain, dma_addr_t iova,
 				size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &domain->iova_cookie->iovad;
+	unsigned long iova_len;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI)
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI) {
 		domain->msi_cookie->msi_iova -= size;
-	else if (gather && gather->queued)
+		return;
+	}
+
+	iova_len = size_to_iova_len(iovad, size);
+
+	if (gather && gather->queued)
 		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad),
-				&gather->freelist);
+				iova_len, &gather->freelist);
 	else
-		free_iova_fast(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad));
+		free_iova_fast(iovad, iova_pfn(iovad, iova), iova_len);
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
-- 
2.48.1
