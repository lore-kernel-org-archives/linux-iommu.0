Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B8C4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206C960F37
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 206C960F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A728606FD;
	Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHvfNX2ta4F1; Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E52E60C09;
	Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F61EC001F;
	Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF05C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E59D260720
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfzbsiXVcW5a for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF19860715
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076436; x=1658612436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z1V0kd2qCOL9tX4hStPvB2PLIDsfutT0f6QLFPZOYuY=;
 b=XCdLCnPc8dCQOtVKqk1k0EkM7ZmrsIHudn8IDmgzLQFZ0Jq6bb8kQCgp
 036/tzf8XDoGX2sJ+zYLC3rGVlziCoxjeshDXWNh0pNRgSIrxuQUbexkM
 xKwGTGpX/NUQORUQVGkCxMcLzb+pX0/Uf43wxypWN9FgAXHOviW85rdcA
 0wKUXwbgNJU4vNFWD+p1rRJO8UtGxfSPkh4YkcTYkqC4SQ68TuZ4PQwXw
 U6/rTrO35dmNhtvBhGaSATLxrkPagzA6gHubKyTovZ6ORM47iPG+b27gh
 clom5b/Agq4XXgZbp922Nc5vAWwuhuoiNLuG5WKd82004vk9JyUFxXa/q w==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198452"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:35 +0800
IronPort-SDR: CI70stGoCoYJgiZ4eS3DkNWJcxXIHlpIB1G/cnr1Q8GM3aJ/sY+rWL5t2a0P2RT6IF65Ckae5n
 FpP1pxvJ86yfjWQ0XbqUuYWyvJA9ES/KYiJDIJnH6V/arWbGFm5ICTHdAftHJH7T31WE+Uyjty
 7Wmi3sGdG8zhjs9PAUw0k8dwtp1SLDSdWmdmeQnTPsM2i7jXWzoQTo5CexAa0j4zSQQb/nai9w
 svGia7Y4Z2TFW5kYlERnJ4pB50+6IvFVShBb0Gr3jGXMH87XiUGGZLcEMimA26iuMaeEsQMm/x
 MwrRM7kBMhNrY6sisa3mNFYw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:24 -0700
IronPort-SDR: 7ealWTp55CZ7bL3tJ/aaVbGP16h6pCxLZLGJvdMqFInFeK8lXI6qJJN+T294Fk+cYCKbuRL5a4
 DhDqryWpLNkLiLpQOnSDhKLtI/n83up5yrg0WRdErqNgFt6WnEsy6VIRw8FiXw0beTku/Xy+2j
 Cn5C3UcecDXN800Im5bjdY1oxeqxFb3MnA6CPcHcUHHba368h5HZWtH2v9d/0hlW7IwbBfjpDC
 xgEeNzkU5VFflnDZT1HNlyhkeQBEszXMbNruQNMxO/1AVPQTvXu4H3WBXPGZCJ/IUvMI+MhHm5
 AlM=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:36 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
Date: Fri, 23 Jul 2021 14:40:27 -0700
Message-Id: <20210723214031.3251801-2-atish.patra@wdc.com>
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

To facilitate streaming DMA APIs, this patch introduces a set of generic
cache operations related dma sync. Any platform can use the generic ops
to provide platform specific cache management operations. Once the
standard RISC-V CMO extension is available, it can be built on top of it.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
 arch/riscv/mm/Makefile                   |  1 +
 arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..5bdb03c9c427
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef __ASM_RISCV_DMA_NON_COHERENT_H
+#define __ASM_RISCV_DMA_NON_COHERENT_H
+
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+struct riscv_dma_cache_sync {
+	void (*cache_invalidate)(phys_addr_t paddr, size_t size);
+	void (*cache_clean)(phys_addr_t paddr, size_t size);
+	void (*cache_flush)(phys_addr_t paddr, size_t size);
+};
+
+void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
+#endif
+
+#endif
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..959bef49098b 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -27,3 +27,4 @@ KASAN_SANITIZE_init.o := n
 endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
+obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
new file mode 100644
index 000000000000..2f6e9627c4aa
--- /dev/null
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V specific functions to support DMA for non-coherent devices
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <asm/dma-noncoherent.h>
+
+static struct riscv_dma_cache_sync *dma_cache_sync;
+unsigned long riscv_dma_uc_offset;
+
+static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
+		dma_cache_sync->cache_invalidate(paddr, size);
+	else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
+		dma_cache_sync->cache_clean(paddr, size);
+	else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
+		dma_cache_sync->cache_flush(paddr, size);
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if (!dma_cache_sync)
+		return;
+
+	__dma_sync(paddr, size, dir);
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if (!dma_cache_sync)
+		return;
+
+	__dma_sync(paddr, size, dir);
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent)
+{
+	/* If a specific device is dma-coherent, set it here */
+	dev->dma_coherent = coherent;
+}
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	void *flush_addr = page_address(page);
+
+	memset(flush_addr, 0, size);
+	if (dma_cache_sync && dma_cache_sync->cache_flush)
+		dma_cache_sync->cache_flush(__pa(flush_addr), size);
+}
+
+void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops)
+{
+	dma_cache_sync = ops;
+}
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
