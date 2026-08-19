Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC027477987;
	Wed, 19 Aug 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151178; cv=none; b=mfWyxEkNhovNz7oEhSLwHDJ6otrM0hZenvnfr16iKQ2bsOCTr8YWV835dF+hTfpMRreldqQaHyoP1cxKCfhJ2L8aDbVa9cJ9uKddf1qLpcsr0bHWjbr/ApQCKpFPd5y1GDL1PlMV0HhjF+ZrV75VRwYglOOaKHJCm2N9WlH7Dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151178; c=relaxed/simple;
	bh=FbyOzRgdywKDBHRx8l02hzwwB8bqNEhHNRkH6Xxlqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdJ540TEMKRaDn5LrKnmlh9SCmWvT1DwbNYu+CmG1XqJ86UF5vH7F1dAX2OV20HN9g/j3pXs/nIst/hE45y2YQrZ+K5HidGaYag69x3DxXbNT/FYSbRoAcYB2efOPoep4ftZxnmi0pXoxXGO8DvyxUQ/XgzOrtvBFpqIswakWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Gi2upZBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtLLicWf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Gi2upZBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtLLicWf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04FE1140014F;
	Wed, 19 Aug 2026 10:52:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 10:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787151175;
	 x=1787237575; bh=cWJ7YipM5dUZEBUb+Zs3mE2xmmW2oTemPngyFleNW74=; b=
	Gi2upZBGJtT9Hqkyr9rnkScRzgxAPY+ZBp5p+ZmVTv6NBvJ6T2nWqkqWZRXp0F6F
	GCOWqPu/rljgtMFMyj1t9RGvlXNA5e4RBGfWYnH0SkHMcu4Tvq7+1o7i9p2vbWxG
	teEQhPXkGqx6jCzEQLyaXqRTvEAJtxFIut3gMx7TfnGlLF8GvWsC2LoGyzfF9zL3
	oJ1WloCTmxv7Grh8bUlafegQpU4uJOFEBGMdiV8jxMjRoMcHm3V9UbZGrrnuhOKj
	Jd1nP3t/23BxC9n6usDc6243EUH6IEzY2JWj0BtGFKQiLMrhfYsbVse/jfeX6YO8
	hHghUU0jZtzC9zkETeP8JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787151175; x=
	1787237575; bh=cWJ7YipM5dUZEBUb+Zs3mE2xmmW2oTemPngyFleNW74=; b=U
	tLLicWf0ULZdYAjrmBqvR41givFVHxVv64Qxghz1uKC8F4WC5x6KuVtQwMMyPpmr
	hMkLO7ylo82Xo8tVbRBWSXhSTj3dKDBtbQ0dw0xCxcSoPYdmB7XtqL1MeqeDYQCY
	FHglyouGlRt1e2+d4/NniUjd5vc7KUG6nhB6eoe5A1SPKAzVemAXKlIPKxwcQcJc
	iiN1Ru5GpduxipjvunvCmxsrwSuo2RQgpzua+WpfkcjokExbDLGT8ZHISW3e2SI7
	hbu//Fdlbt3aiB080boh3q+P2NnnjSz9G/ujEZrZY+LU9Z0xito1Ks4MW+MxvBW1
	NJQmq1tPlLz2g8rkslWDA==
X-ME-Sender: <xms:RsOFaumQ8JNDGGp3lBK017QsHq16DbVHlBJlg_5ZLRjz77AmgJyfMA>
    <xme:RsOFatbY_BqtG7VhMnmeucQf4-x4WVVLmnCD4uKKLLhr0f9BkCvqasQZRADEvRUmn
    ouOeISNs-ZLwYyFDzCpqp4bEc5n6YBGq8cBrUE_xUkVfDgXvgw78A>
X-ME-Received: <xmr:RsOFasShazzwTnAJk__nc04NJzMxe7tWSnqRmmbhKNtYSwy7oAheev_T4_SmxsF02Efamdt1BjrM9NHdpbPw8quxwCd92Dn79BZJtw>
X-ME-Proxy-Cause: dmFkZTE9TViwfq+braXum8jXlJNh6tjfJssH5OCKEStoqwW04qQEaTL3gCCfAPdgPpcaW1
    pEharjtJlrCMhTSjNcYokOC3LxLmv5k6jCaTOqTYBEU3vhWxeKKuzyTu6NxdaEPiGvLvqn
    tk+JWyJuiTaTBDoyzuuSiWQ7uiu+fI8K67zHGsiXtgIbdVCAvjBtq1r6V25uQf2tFWplnV
    db1tw8RMwX7E0nhaCeQIWbNUfVRayGesgwU2vp2wbhjaK2rJX2kWsR+GBsDKsedTKLNhf1
    NmN+JtT9Vn2ozOLHqwmD79wtlkHlz3Hm/WivkLeA3EW0JrcrCwuRDevSQEd2pd3xeUdwty
    r1TAP7yGqK1aW1uHFLgUU13cBiUX+kM5PANz/kQ26hFsLIlreu1TXiVVRlEcM2HmyZ9KAs
    5vTd4w+1Pi4oIcVqTcXJTz9Kf5nzlUtzWsV+cJ0bizznq+PA3qcuXx/zUoNVHUhWXZ6zSC
    qiz+27y86DDY+iAUjMb+dwJFkC27USE9ieU37Oe9HxE1XNgk3EYp1G6LO3Rmb0n0RDeuX3
    4udE0P4HTkKhgC1Wq0Gxogh3HUsG2+li02XT8vaA9nv/RxouwH2o8hTBuWoqk56B07HGpx
    1k7bFqmli+M1y5QLWUzVSwoibXgsgP/yrKHlJUMgg4KRf3O+d5+NsoGmiZ3w
X-ME-Proxy: <xmx:RsOFavVXjTlkZ1fUPpCUyz0wSArznf481MGQQYPW09qp7TPo3K53Qg>
    <xmx:RsOFajYZYh4hM9PlKefCvkRjBDs1krcbxOPy2z0Hw1yZzhpX6dnWuw>
    <xmx:RsOFag5-uQNU-N6cnlQP7ieDFFEXgltADyjW09gWYHIfJaWBHJV5oA>
    <xmx:RsOFasxbHwz1_v9aLnFXXnfRlxu0GwxSMh3P-AE6alkkjnX3YmRYqQ>
    <xmx:R8OFalsAOJi7rfhqYmNdbagqkk563ptIz62MLA3L_DhzYH_UNvwgizeE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 10:52:54 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 19 Aug 2026 16:52:28 +0200
Subject: [PATCH 2/2] iommu: apple-dart: Support specifying the DMA aperture
 in the DT
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-iommu-apple-dart-aperture-v1-2-252703f381aa@jannau.net>
References: <20260819-iommu-apple-dart-aperture-v1-0-252703f381aa@jannau.net>
In-Reply-To: <20260819-iommu-apple-dart-aperture-v1-0-252703f381aa@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6658; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=FbyOzRgdywKDBHRx8l02hzwwB8bqNEhHNRkH6Xxlqxw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzWw/aP1q+aI81Sy9HyOaRu7pLnCx8tS3LIr2z3C9x04
 4fD3GvnOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEzksiHDP4WMrH1Gd6udeSpu
 PArPniefVd1/zuzJB00GQdXeXt+GLoZ/2ufjXu48u17y8vm71VyfZ4tvWNHuuvzapifcn5vUd70
 8xAYA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Apple DARTs are often connected directly to devices that expect only a
portion of their address space to be used for DMA (for example, because
other ranges are mapped directly to something else). Devices can specify
the start and end of the aperture via "iommus" args if the DART device
node specifies "#iommu-cells = <5>. Aperture start and lengt are 64-bit
values since most of the devices use such values. Limit compile testing
to 64-bit architectures to avoid warnings when construction 64-bit
dma_addr_t values.

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
 drivers/iommu/Kconfig      |  2 +-
 drivers/iommu/apple-dart.c | 62 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 10 deletions(-)

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
index b160fb464c5f..16ba65a6b8ff 100644
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
@@ -803,20 +814,53 @@ static int apple_dart_of_xlate(struct device *dev,
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
+		dma_max = dma_min + length - 1;
+
+		/*
+		 * Ensure that the DMA window does not exceed the dart's ias.
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

