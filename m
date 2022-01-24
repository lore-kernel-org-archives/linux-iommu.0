Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBB7C433F5
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 16:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0278084B90;
	Mon, 24 Jan 2022 16:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_09AQ7T4x_U; Mon, 24 Jan 2022 16:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5CFE84B80;
	Mon, 24 Jan 2022 16:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765A4C007B;
	Mon, 24 Jan 2022 16:40:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD1D3C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A989560B5C
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BB48GiLFFJa2 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:40:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE2AF60B21
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2C5101E;
 Mon, 24 Jan 2022 08:40:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6981B3F793;
 Mon, 24 Jan 2022 08:40:23 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	konrad@kernel.org
Subject: [PATCH 1/3] swiotlb: Simplify debugfs setup
Date: Mon, 24 Jan 2022 16:40:17 +0000
Message-Id: <278f7915ed3ad8768c6cad671ce8f1a3d4ec085c.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: tientzu@chromium.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, guozhengkui@vivo.com
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

Debugfs functions are already stubbed out for !CONFIG_DEBUG_FS, so we
can remove most of the #ifdefs, just keeping one to manually optimise
away the initcall when it would do nothing. We can also simplify the
code itself by factoring out the directory creation and realising that
the global io_tlb_default_mem now makes debugfs_dir redundant.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..bdce89e053bd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,9 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
-#endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/io.h>
 #include <linux/of.h>
@@ -758,47 +756,29 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *debugfs_dir;
-
-static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
+static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
+					 const char *dirname)
 {
+	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
+	if (!mem->nslabs)
+		return;
+
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
 }
 
-static int __init swiotlb_create_default_debugfs(void)
+static int __init __maybe_unused swiotlb_create_default_debugfs(void)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-
-	debugfs_dir = debugfs_create_dir("swiotlb", NULL);
-	if (mem->nslabs) {
-		mem->debugfs = debugfs_dir;
-		swiotlb_create_debugfs_files(mem);
-	}
+	swiotlb_create_debugfs_files(&io_tlb_default_mem, "swiotlb");
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
 late_initcall(swiotlb_create_default_debugfs);
-
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-#ifdef CONFIG_DEBUG_FS
-static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
-{
-	struct io_tlb_mem *mem = rmem->priv;
-
-	mem->debugfs = debugfs_create_dir(rmem->name, debugfs_dir);
-	swiotlb_create_debugfs_files(mem);
-}
-#else
-static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
-{
-}
-#endif
-
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -860,7 +840,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		rmem->priv = mem;
 
-		rmem_swiotlb_debugfs_init(rmem);
+		swiotlb_create_debugfs_files(mem, rmem->name);
 	}
 
 	dev->dma_io_tlb_mem = mem;
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
