Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CB3905EA;
	Wed,  2 Sep 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376751; cv=none; b=BfESxNsOwzT+lpTnQ1tBIvCOEixy/aQaTCvGyt44X7s7uKyKFpyWu5eehattAKhNNf1v4DIv6KAMsjsAM03G8T7x9ulTwZ6QznG0NcWORneVD9CUlpMrdKHnxVRaYfjP2uV3lydbkowF69TvafTNAcCj/fLlFiIree6BZNPESRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376751; c=relaxed/simple;
	bh=AzFRd3uMZ0IcJqKW0o690cDqHnbklcnOKswFQ0IdXwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nW1sttzIzJMdlO19lp1ruSX6Cx8zYRJeiWpZJ5D3kK4rKucBpAEkStr9fdPqEKornMP92gxI6m8T6DBPHbtf3sKVzaZ/XK5V7UewLeISaxdcALYLYoRQnoQqvLy6FcDxPbXn8e+ibi3Pjsf0amOe2uyxfrt3pfhgmPG2yN60/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MAieeHfX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYxlkVQq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="MAieeHfX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYxlkVQq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 39F55EC026E;
	Wed,  2 Sep 2026 15:19:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788376749;
	 x=1788463149; bh=NQdO7P96jiTQ2vGB+LQMTce6TI6ijWre0g6HXNRAZnQ=; b=
	MAieeHfXCgyqIZiuglMyJGbkL7xZntf7dp8HR9VnfCNxT8JT5Cmnp8Vaayw/vhF+
	TEuVh6aS7oSruuY5sHle7TbGy5760v4Y/Y88TLfQNCCQN9xWrEOwnf69qDMtt42e
	YpigM878IwvsTdudrZ+h4cSKQONhi95HeurDR7IaHGKz+c5C5d+Iu5J4sCygw2uP
	9U8upk4/HXG4MuA9CfxvL6ZYuVpNwkWqWGjQuNWI3xzRb02Yk5YiUZ8+Kval63Nr
	UOVPKFaY6TpCmDgt8TQ1btEDWisE2XcSx6KysKtogbbnW/zwszkFDDGybO3PR60b
	K4kUmVIGPXFh7Tn9jPWz8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788376749; x=
	1788463149; bh=NQdO7P96jiTQ2vGB+LQMTce6TI6ijWre0g6HXNRAZnQ=; b=X
	YxlkVQqvnaALTgr/+kH0/YNW8+27O4U/+XR0RBReV+jHvjxVgOr0NiKf/PzMi2Hc
	rRJBVmYv0HRNUE4HThlbPdP4gaiL8EFUpZk1fDvVMyUYBmpJw+tngdIul7pi4Xy0
	/Xhw+0Mx4dDf6uaQgaiGE9lYfhzYetbIkTo0yJuCiUUKYhvK4cP2QwN+YJuv9g6J
	mtYOi+t9e5ExK63O4cnIa+/FYer/e71kvj11WGxL9rgdYD8r8gDGAZioi6lTV20z
	+WSuiqzqy6kdNYofI2cseBNUWFfElGnZdCTynh5WKyJvd1n5F8UKhgN+9yxaufh2
	5b634RQlUIRfgCj5zJlsg==
X-ME-Sender: <xms:rXaYahY2A3ILvpMZtmdTJ3jdeUJu7FslXhwqNMF5zlsb6X-Z8YC9NQ>
    <xme:rXaYav-az7TrKtBJQoHD2EA0Z1409Gt8vLX3zRV8NHw55q_mWbS0jR5mrEY_8G_FQ
    rIMBryxmUWQfXIRi7q8RYT0bJ_IMiJBS8PpWMZQHrRBr6FDiyj1sTyH>
X-ME-Received: <xmr:rXaYajkjZaFAUB9hSZJsmZEXFAm8cFOFDcIzijqhTcW1D1pAkWW2NAlWUIwAfAM7FC8paevKZntoXrQ_P4DigKFGlToqql4UZn5LuQ>
X-ME-Proxy-Cause: dmFkZTE89tjtn2Bc6WrCwdLeNoBdvJR6LgkOyMNQKpFp1TjkiaqcmsCiC8kvrS7T8Jp5oi
    cIW0UnwXmqV3oC7eAHpTzIGJga2xoAPx8GEnFdDNBab77iSzjXmCh1vKt+5d7wJkXOr2VC
    rE5841g2jNxb6p1kbNpFRDNDdq1GYBQSQBcl+GE4IEVVOkkhbgZApi3Ptb2xxuKlhSMG0E
    EOS48D6SGNDHa/XRZdR6SN1/sKBEBUdJJkTJl+8d2Yfwe7ahYEwxJfjYD63OgrtT4gIYR1
    hwNIjQzSLtryyDlnl+S3fmeeQKlp2yc1//CP8qulUPt9Gc7zUmxU+NSlYVI0CNef0PA6qg
    u+KpiwXV4qWtaS5Q1OphHYXkO9rRemOOmitHGKrw/mrnroj3f4u9NtpxlVZYQYahircdo4
    nQ9xcOY4qc5rESeJyIt4mOQ6kYwTF3M2310JmwLboZPtJo7lyv6cL/iYk0iYOVM1E5n67m
    fWEJd9dHH+uiic+TlGlACkZXdN9F1tAYRhEPaOlccZjTDBP0IeMTBzWph3Vz7TNa95Ueeg
    ZF7bVTbeITwiYx+vcNIPWQTLRZPZxdkOofgl7QwCDRNENqghGNJegZSrNCiy2cwOvU2VFQ
    grwoXmBRXUL/BmQVO6GhhKkLEGku0r/vClHwuFdeuojioHfLlkKgwXbr6xJA
X-ME-Proxy: <xmx:rXaYasaU9C-NRIvCl7pkgnZdVIEpqtRM-7ub9DVelfHZn73TPwQI3g>
    <xmx:rXaYajPEphcAugqq6-Wr5Ry05xMoXuj9tsdCv7QhGpbsDCOYC5mjOw>
    <xmx:rXaYaseZ0d7nK4H7jV7K-WLEtZxoyDewXWwbVnz4O1qNVaROq8Jeqg>
    <xmx:rXaYapFf1_oo4TeFP7qif4mSk8agQAcTn2J6CLSj4vWeLoMmSgc9iQ>
    <xmx:rXaYavj3OWzEO3yn0_zc3QDNmzn6dE41Btnv8GK92XG1-jg9qjkSEc6B>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:19:08 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 02 Sep 2026 21:18:55 +0200
Subject: [PATCH v3 2/2] iommu: apple-dart: Support specifying the DMA
 aperture in the DT
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-iommu-apple-dart-aperture-v3-2-252ce55b7001@jannau.net>
References: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
In-Reply-To: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7155; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=AzFRd3uMZ0IcJqKW0o690cDqHnbklcnOKswFQ0IdXwg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwZZcs9GnwvauaULRa4l8JUXS5vHrxXOcjk1suPFeWPn
 7bEqHV2lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIiOJcP/sNYj7Ctuv9j265Zf
 ZAG/VY67zDvbJbfPuHzaIPolwn7jbYY/XJIrjNdwNNg0vFghdN9Xm2FJ0N/Yd6v2d6++s7n+442
 dzAA=
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
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/Kconfig      |  2 +-
 drivers/iommu/apple-dart.c | 74 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6e07bd69467a..27954f462582 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -303,7 +303,7 @@ config SPAPR_TCE_IOMMU
 
 config APPLE_DART
 	tristate "Apple DART IOMMU Support"
-	depends on ARCH_APPLE || COMPILE_TEST
+	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
 	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_DART
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_DART
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

