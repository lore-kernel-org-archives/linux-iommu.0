Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E116C4320A
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395FB60EB6
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 395FB60EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0601240676;
	Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqCud4XJWLWs; Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 728744068A;
	Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 158D2C0020;
	Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D65C0010
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C90A460A3E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zm0d4m18xDt8 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45AD0608E7
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076437; x=1658612437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h6g3J4tjDKnyTria/2MziFd3JxC/MOWlZq41Ya428Sw=;
 b=FaoN1xzh2WIdwmWW2Gu0RAGxzGlJaPrrAwKlYNtwWhCuuprcncCWpBum
 7QW+pNPcrs2JTwyDYwhIRv9QywrC85OrQ0f4istmd/VRKLujvUjlHIyHt
 lTz+ZYVV8sxmloLE0wP1VkcwbPxixMYExfJdp6EYCfVLmjWFCjf4KKbYy
 n1Pfb5NTiorUzkBZAylJRvia4gd2W5ppXjRgYlvZWEwPDxeXmGvQpJQ2Z
 Inh8JpkRNIh/MLSToQS/XCKiaxBtTrHI+NX0PZUjOuxhzsqaJT9t6mbZo
 IRSrqbh29i7/5xHk/zAQUFaY61WMy3XkWtOR8jyb8C+Qz8RLFBmEJxcAG A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198460"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:36 +0800
IronPort-SDR: +5+ki43nHfotRi7Nk3o7v8E9RxTe91qpfxps5bSvhotIb8hbzp8nhRj37KjGyLC4AqAscyoJsk
 74NP/1X/ZpwDquZSKrrJos7ueQTHqR66WQVFONuA+Md47fHkwFVZ54I+n8TRqQxC1Rmm0kSdld
 rEO05AVlyhsW2zwlEuoo6i33iB0ljVgB1BwpTCDsGoYToRoF+mt7ALl4QAtPvm7h8c2hoPP7JV
 A7NuvUrMEvGtaP/AzvYpmBhxBnRBOR62YV9dVw49UkEpgo/oWnEgyJa/EHiGy0GrvkHKhf43AD
 XcWsHciaL6hm7EGhxAlhjZcF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:26 -0700
IronPort-SDR: RopbJ1mZd7BhWsWcKFEmQ7WtbbN2Hmd5BOsJ+cqYC6WWZaLYWC+YxSjr74sWYzac7mWE8ByX20
 CjRTn0VmrM7uFgp31+YYSGzhOkMwzw0yorw6oML5t49P3RXU1r2Ggeemijjor6l/XapslEa0m2
 efJZGKLNB4+Wh1h6o8OMOfaZYU44hIeGI7gVEgGMpQJprdd/+e6YslEk3fnyYFOqj73qVJG5et
 AvJhFih8nRANtXfnJPf3u9tps3aivhLC4QFlxZWyQwvdpA3R/L/rUVEQ84bdHZ67CJxbGW5mA9
 YWY=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:37 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 3/5] dma-mapping: Enable global non-coherent pool support for
 RISC-V
Date: Fri, 23 Jul 2021 14:40:29 -0700
Message-Id: <20210723214031.3251801-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Guo Ren <guoren@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Currently, linux,dma-default is used to reserve a global non-coherent pool
to allocate memory for dma operations. This can be useful for RISC-V as
well as the ISA specification doesn't specify a method to modify PMA
attributes or page table entries to define non-cacheable area yet.
A non-cacheable memory window is an alternate options for vendors to
support non-coherent devices. "dma-ranges" must be used in conjunction with
"linux,dma-default" property to define one or more mappings between device
and cpu accesible memory regions.

This allows RISC-V to use global pool for non-coherent platforms that
relies on a uncached memory region that is outside of the system ram.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 kernel/dma/coherent.c | 49 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 97677df5408b..d0b33b1a76f0 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -9,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
+#include <linux/of_address.h>
+#include <linux/libfdt.h>
 
 struct dma_coherent_mem {
 	void		*virt_base;
@@ -302,19 +304,27 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 					vaddr, size, ret);
 }
 
-int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
+static int __dma_init_global_coherent(phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
 {
 	struct dma_coherent_mem *mem;
 
-	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
+	if (phys_addr == device_addr)
+		mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
+	else
+		mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 	dma_coherent_default_memory = mem;
 	pr_info("DMA: default coherent area is set\n");
 	return 0;
 }
-#endif /* CONFIG_DMA_GLOBAL_POOL */
 
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
+{
+	return __dma_init_global_coherent(phys_addr, phys_addr, size);
+}
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 /*
  * Support for reserved memory regions defined in device tree
  */
@@ -329,8 +339,8 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	if (!rmem->priv) {
 		struct dma_coherent_mem *mem;
 
-		mem = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, true);
+		mem = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size, true);
+
 		if (IS_ERR(mem))
 			return PTR_ERR(mem);
 		rmem->priv = mem;
@@ -358,7 +368,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	if (of_get_flat_dt_prop(node, "reusable", NULL))
 		return -EINVAL;
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_RISCV)
 	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
@@ -382,10 +392,33 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 #ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
+	struct device_node *np;
+	const struct bus_dma_region *map = NULL;
+	int ret;
+	int64_t uc_offset = 0;
+
 	if (!dma_reserved_default_memory)
 		return -ENOMEM;
-	return dma_init_global_coherent(dma_reserved_default_memory->base,
-					dma_reserved_default_memory->size);
+
+	/* dma-ranges is only valid for global pool i.e. dma-default is set */
+	np = of_find_node_with_property(NULL, "linux,dma-default");
+	if (!np)
+		goto global_init;
+	of_node_put(np);
+
+	ret = of_dma_get_range(np, &map);
+	if (ret < 0)
+		goto global_init;
+
+	/* Sanity check for the non-coherent global pool from uncached region */
+	if (map->dma_start == dma_reserved_default_memory->base &&
+	    map->size == dma_reserved_default_memory->size)
+		uc_offset = map->offset;
+
+global_init:
+	return __dma_init_global_coherent(dma_reserved_default_memory->base + uc_offset,
+					  dma_reserved_default_memory->base,
+					  dma_reserved_default_memory->size);
 }
 core_initcall(dma_init_reserved_memory);
 #endif /* CONFIG_DMA_GLOBAL_POOL */
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
