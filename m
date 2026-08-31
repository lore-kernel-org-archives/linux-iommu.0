Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F254B1A3;
	Mon, 31 Aug 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183996; cv=none; b=rTpxIPdk05Iz3qSiWHdXrj3ig1uLWivcveCkB8ddQtmVEuJALVfq5PVfHwjMsCUfkwRLcnCftTq0VAMBJC9cEb1NDZNqLqJpWUKnWOpn9izQ2/7wc4XXetemzXkjainC0s0GVBeC8tMTvOvfwsR7yuT7/HjxKDAvIehQkRQNE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183996; c=relaxed/simple;
	bh=W0l5gsiaGlNx1eXeXcuBJF6lf9NaAtRUFj6LLSrbp68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGjBi/KwI+pVotMjdfXsX8C4BEt0xCLiQnigElr9DyeXpon8MNhuY6TYkqR0mLGwJiyFHaplIJxUlUtcw/JFlse7fKiH66hQKS3MYhnidcLzZ+16xOyys1v+/Q3GqK9LawJqTHlrI2s5Q/Xxplfyw4WjJU8PjlzG1Ud5c7BPQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=d4rdScxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gtbxhfq3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="d4rdScxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gtbxhfq3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A344140014E;
	Mon, 31 Aug 2026 09:46:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 09:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788183988;
	 x=1788270388; bh=WtrrhnQSSWCgmz9kHkcuSRnA5Geu3BtwOZsT/4SdJ2A=; b=
	d4rdScxONmnwn6IcVcRHof9/75TP92DzF+/RcJduE1GwyklanzXvJr8g59JOclXd
	DQ3LcWuV4yM8CupXGzurHV/PUX1NXcWg8NsMlt9O3U1SQ27y9TIrtFimj1sre8BL
	zXfw2QWcr6y0WXkNwePDlRETAhjlg7K7jDnhuwKEKukg3HlkML+jMCSWLBR9SM6K
	+BceoC21DlKHlLgbfecK/qoC/Q87UKVwExaX1ae35zWA3lxQoeXpwsG54EJivt08
	t919Wt5aSUubOWqSUzuNHGolADBqLZoTM+mBKoxEAHJWbTGvkm+cEovox8zWNcJx
	/KIdWKZeJuZ+3eNJEn3Mig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788183988; x=
	1788270388; bh=WtrrhnQSSWCgmz9kHkcuSRnA5Geu3BtwOZsT/4SdJ2A=; b=G
	tbxhfq3PGdaS7CExexV3Ovm/fQ60zMJ2zS8Fbf4FTMddze0na6qGRiXtKceTDull
	JqaDBSUSNdQVnNcpeR65Jn6hM9Ta97lwDzH+V6AWZpqFsUAalbLSh19L0xQwrHMD
	DzhP/2IjtsENdUqVIFpB/2Pld+HXIE0waCHIoEhLCNiJtlSl4F43KGHGfXBAZsQA
	EF9EsXJf4qN1c0JmfyJnoZYT6IziPEwwM7hzg/tXwgB//VAhpVH++SRuE35R/E/a
	8PMxHIAdfYiHwzQSuJq+NJ3A6bRrKcp2yXG33oq6K1OicjmVull6pbE6UoMzWJOE
	eumxHS8t2kkKvWpQEpjdg==
X-ME-Sender: <xms:tIWVajDiT17yhxdYNi1JPfV0NpWOuHb-JbTDd-gyrk1KkcnpUX71oQ>
    <xme:tIWVahE-DGjQf2tuuYH0u61tMumnfyFoPTidTb7Em2JDiec2jRbgzKwNCrKxdlJBk
    8KJF27F2ihkQIxaixUkWnmOQlTNgRlgbWQ3drcL1Kbg3qhWiB-50ko>
X-ME-Received: <xmr:tIWVauO9UF3a6DZiwAXM20SrhmcgVa1ygYY8bwxrLSV0YvEwdvMOb_JXpDfmK7d3VwamfSG4MxpezPD27fx89BSD20vPoWKjRfqo6A>
X-ME-Proxy-Cause: dmFkZTEZP4OZ9jXNZOcRDBDxlZNGFCwjOCpnyInwxKH9r2Kdyhq5QmdE82JUknhgvsM37R
    C0IAoqvjf8uGcjR2jCdNfZmbbaLCnS/uC3qqe1M8bD/SraXJJcu5ed5xdUnCe6zJ2Rgwdu
    I7ipoFiIxfAtUtsLZi4fkMWcUFOUmY9ef8+uxfXQtzkR6QdN0nvBdw/8V4exh82cuf1gCY
    QoDXGiT2Hp4fNn45SHDl8f7XwoQ/4hlglswQqlA7EV4FM4DHoyO21Tq2uBpm8AqJkj038V
    kDxpN0Y13MjDNqZjewMamNifmQcj80AnggebFcCQawXKuxmiWJv3fJm6XBKTVx0XoRa6CD
    RekIYNHlVUjsAxKTZISdJJp09TYIyoWOJgn/Ya5pjCwhlO6nY7PvIusHu8bN5t2HqvhReH
    /WkMJ9CzmKqP5LqX3pIwZbt4bitvQ8HYD/Txw1f0b2qpHBajdz5lZYuWslHoVEDPsx5rgn
    0VlWSxTwoa6kGH68hGiEKMbN5t38zwxb3svxTLERTTcd9knI4CrxH1sMHxL9x1j7S+Xfb5
    F2AkriGb2W/osghnq51XAAsBaoJcBF7gVxiX5TujqOgPwRAXKsyhueyzT+PN/mVMVk813H
    xl5JWhh3zJDTvYVO5xObhWZ7iY4f0P9/nuXsaePatdUhhimLsyTMBXjZbQqA
X-ME-Proxy: <xmx:tIWVaigr8uC7l37QK2-SsIQncztUHpuGorbqA0PIclf-xMq318RRvw>
    <xmx:tIWVau3XE-djMFRRbeiyjVoXnlnjwnc9fplGcpMe-BuJPXLgbb9kew>
    <xmx:tIWVavkbdKs3MAUliHzVR-7J_xziml3X79EiJLZmC_JbjJxjUUDTPQ>
    <xmx:tIWVatu6GX_HuZT9-7PcrIWAPvfHDO3U9Fu8wUYnejRhoWEPuzaogA>
    <xmx:tIWVakFwnOjYI9gopM4-FVWmFnEpUnv00e62tzwwDGAfV1XrFy2f2rKJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 09:46:27 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 31 Aug 2026 15:46:09 +0200
Subject: [PATCH v2 2/2] iommu: apple-dart: Support specifying the DMA
 aperture in the DT
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-iommu-apple-dart-aperture-v2-2-d16ce3770299@jannau.net>
References: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
In-Reply-To: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6603; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=W0l5gsiaGlNx1eXeXcuBJF6lf9NaAtRUFj6LLSrbp68=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqyprWt+xfOdeLD/yZY/nJrP8+SblGY6Vml9Zbb9fKl4m
 tpdqWk7OkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExk2VNGhlOL/0a73Vw6r545
 1rdW4NfK1CsaTxbNjPx7w9x136dvdcIM/zQLw6b9Uz63/afdFp7P+5v/aXy+/zPFwLApZY3U6Yf
 3pdkB
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Apple DARTs are often connected directly to devices that expect only a
portion of their address space to be used for DMA (for example, because
other ranges are mapped directly to something else). Devices can specify
the start and end of the aperture via "iommus" args if the DART device
node specifies "#iommu-cells = <5>. Aperture start and length are 64-bit
values as apertures above and larger than 4GB are used.
Limit compile testing to 64-bit architectures to avoid warnings in the
calculation of 64-bit dma_addr_t values.

This range *can* be outside of the DART's IAS. In that case, it is
assumed that the hardware truncates addresses and the page tables will
only map the lower bits of the address. However, the specified range
cannot straddle an IAS boundary (you cannot cover more than IAS worth
of address space nor wrap).

This corresponds to the vm-base and vm-size properties on the Apple
device tree side of things.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple-dart.c | 74 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index b160fb464c5f..ebf4547d32b4 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -21,6 +21,7 @@
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -267,6 +268,7 @@ struct apple_dart_domain {
 	struct io_pgtable_ops *pgtbl_ops;
 
 	bool finalized;
+	u64 mask;
 	struct mutex init_lock;
 	struct apple_dart_atomic_stream_map stream_maps[MAX_DARTS_PER_DEVICE];
 
@@ -285,6 +287,13 @@ struct apple_dart_master_cfg {
 	/* Intersection of DART capabilitles */
 	u32 supports_bypass : 1;
 
+	/*
+	 * DMA aperture start and end to be overridden by "iommus"' phandle
+	 * args. By default determined by DART's ias but may be outside of it.
+	 */
+	dma_addr_t dma_min;
+	dma_addr_t dma_max;
+
 	struct apple_dart_stream_map stream_maps[MAX_DARTS_PER_DEVICE];
 };
 
@@ -537,7 +546,7 @@ static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
 	if (!ops)
 		return 0;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys(ops, iova & dart_domain->mask);
 }
 
 static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
@@ -551,8 +560,8 @@ static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return -ENODEV;
 
-	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp,
-			      mapped);
+	return ops->map_pages(ops, iova & dart_domain->mask, paddr, pgsize,
+			      pgcount, prot, gfp, mapped);
 }
 
 static size_t apple_dart_unmap_pages(struct iommu_domain *domain,
@@ -563,7 +572,8 @@ static size_t apple_dart_unmap_pages(struct iommu_domain *domain,
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
 
-	return ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
+	return ops->unmap_pages(ops, iova & dart_domain->mask, pgsize, pgcount,
+				gather);
 }
 
 static void
@@ -590,6 +600,7 @@ static int apple_dart_finalize_domain(struct apple_dart_domain *dart_domain,
 {
 	struct apple_dart *dart = cfg->stream_maps[0].dart;
 	struct io_pgtable_cfg pgtbl_cfg;
+	u32 ias = min_t(u32, dart->ias, fls64(cfg->dma_max));
 	int ret = 0;
 	int i, j;
 
@@ -610,7 +621,7 @@ static int apple_dart_finalize_domain(struct apple_dart_domain *dart_domain,
 
 	pgtbl_cfg = (struct io_pgtable_cfg){
 		.pgsize_bitmap = dart->pgsize,
-		.ias = dart->ias,
+		.ias = ias,
 		.oas = dart->oas,
 		.coherent_walk = 1,
 		.iommu_dev = dart->dev,
@@ -623,10 +634,10 @@ static int apple_dart_finalize_domain(struct apple_dart_domain *dart_domain,
 		goto done;
 	}
 
+	dart_domain->mask = DMA_BIT_MASK(pgtbl_cfg.ias);
 	dart_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	dart_domain->domain.geometry.aperture_start = 0;
-	dart_domain->domain.geometry.aperture_end =
-		(dma_addr_t)DMA_BIT_MASK(pgtbl_cfg.ias);
+	dart_domain->domain.geometry.aperture_start = cfg->dma_min;
+	dart_domain->domain.geometry.aperture_end = cfg->dma_max;
 	dart_domain->domain.geometry.force_aperture = true;
 
 	dart_domain->finalized = true;
@@ -803,20 +814,65 @@ static int apple_dart_of_xlate(struct device *dev,
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
 	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
 	struct apple_dart *cfg_dart;
+	dma_addr_t dma_max = DMA_BIT_MASK(dart->ias);
+	dma_addr_t dma_min = 0;
 	int i, sid;
 
 	put_device(&iommu_pdev->dev);
 
-	if (args->args_count != 1)
+	if (args->args_count != 1 && args->args_count != 5)
 		return -EINVAL;
+
 	sid = args->args[0];
 
+	if (args->args_count == 5) {
+		dma_addr_t length = ((dma_addr_t)args->args[3] << 32) | args->args[4];
+
+		if (!length)
+			return -EINVAL;
+
+		dma_min = ((dma_addr_t)args->args[1] << 32) | args->args[2];
+
+		if (!IS_ALIGNED(dma_min, dart->pgsize) ||
+		    !IS_ALIGNED(length, dart->pgsize)) {
+			dev_err(dev, "Unaligned DMA window %pad, %pad (0x%x)\n",
+				&dma_min, &length, dart->pgsize);
+			return -EINVAL;
+		}
+		if (check_add_overflow(dma_min, length - 1, &dma_max)) {
+			dev_err(dev, "DMA window length (%pad) overflows range for start %pad\n",
+				&length, &dma_min);
+			return -EINVAL;
+		}
+
+		/*
+		 * Ensure that the DMA window does not exceed the DART's ias.
+		 */
+		if ((dma_min ^ dma_max) & ~DMA_BIT_MASK(dart->ias)) {
+			dev_err(dev, "Invalid DMA window for ias=%d\n",
+				dart->ias);
+			return -EINVAL;
+		}
+	}
+
 	if (!cfg) {
 		cfg = kzalloc_obj(*cfg);
 		if (!cfg)
 			return -ENOMEM;
 		/* Will be ANDed with DART capabilities */
 		cfg->supports_bypass = true;
+		/* Will be merged with other DARTs to the common range. */
+		cfg->dma_min = dma_min;
+		cfg->dma_max = dma_max;
+	} else {
+		if (dma_min >= cfg->dma_max || cfg->dma_min >= dma_max) {
+			dev_err(dev, "non-overlapping DMA windows: %pad..%pad, %pad..%pad\n",
+				&dma_min, &dma_max,
+				&cfg->dma_min, &cfg->dma_max);
+			return -EINVAL;
+		}
+		cfg->dma_min = max(dma_min, cfg->dma_min);
+		cfg->dma_max = min(dma_max, cfg->dma_max);
 	}
 	dev_iommu_priv_set(dev, cfg);
 

-- 
2.55.0

