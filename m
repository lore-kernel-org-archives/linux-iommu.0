Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A86EC433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 12:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D39C85ADB;
	Mon, 13 Dec 2021 12:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBvHAsVAC7U6; Mon, 13 Dec 2021 12:28:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A6F485ADA;
	Mon, 13 Dec 2021 12:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4B86C001E;
	Mon, 13 Dec 2021 12:28:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A43C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2C3A40250
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxgoZvOwcR6P for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 12:28:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DE0240243
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639398499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=rTXDZrXPlfq+xyqjAIT5qWvY4GCGUra41drHaxTKJRM=;
 b=LATLAdX/X4XKVc5EYaK1GH6/wQtPVo4KrJlnFZNupD9hwQeXyX3LQoxHTk+s8CtnBM9WgD
 iHsUNu0bz226P8T3k87LEiJd/hBEulGOaFPzaxZSfq8Ql2eNXG1xmMpnoLpIbBzvJI2b2j
 W8N2yWxWsvmkbmippFTYjwSVWUMLSAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-9Iu2KUIaNiGiv9ltAQ48bA-1; Mon, 13 Dec 2021 07:28:18 -0500
X-MC-Unique: 9Iu2KUIaNiGiv9ltAQ48bA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 166601853028;
 Mon, 13 Dec 2021 12:28:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-202.pek2.redhat.com
 [10.72.12.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC973694D8;
 Mon, 13 Dec 2021 12:27:51 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] dma/pool: create dma atomic pool only if dma zone has
 managed pages
Date: Mon, 13 Dec 2021 20:27:11 +0800
Message-Id: <20211213122712.23805-5-bhe@redhat.com>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: John.p.donnelly@oracle.com, kexec@lists.infradead.org,
 stable@vger.kernel.org, hch@lst.de, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, akpm@linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, cl@linux.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Currently three dma atomic pools are initialized as long as the relevant
kernel codes are built in. While in kdump kernel of x86_64, this is not
right when trying to create atomic_pool_dma, because there's no managed
pages in DMA zone. In the case, DMA zone only has low 1M memory presented
and locked down by memblock allocator. So no pages are added into buddy
of DMA zone. Please check commit f1d4d47c5851 ("x86/setup: Always reserve
the first 1M of RAM").

Then in kdump kernel of x86_64, it always prints below failure message:

 DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
 swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-0.rc5.20210611git929d931f2b40.42.fc35.x86_64 #1
 Hardware name: Dell Inc. PowerEdge R910/0P658H, BIOS 2.12.0 06/04/2018
 Call Trace:
  dump_stack+0x7f/0xa1
  warn_alloc.cold+0x72/0xd6
  ? _raw_spin_unlock_irq+0x24/0x40
  ? __alloc_pages_direct_compact+0x90/0x1b0
  __alloc_pages_slowpath.constprop.0+0xf29/0xf50
  ? __cond_resched+0x16/0x50
  ? prepare_alloc_pages.constprop.0+0x19d/0x1b0
  __alloc_pages+0x24d/0x2c0
  ? __dma_atomic_pool_init+0x93/0x93
  alloc_page_interleave+0x13/0xb0
  atomic_pool_expand+0x118/0x210
  ? __dma_atomic_pool_init+0x93/0x93
  __dma_atomic_pool_init+0x45/0x93
  dma_atomic_pool_init+0xdb/0x176
  do_one_initcall+0x67/0x320
  ? rcu_read_lock_sched_held+0x3f/0x80
  kernel_init_freeable+0x290/0x2dc
  ? rest_init+0x24f/0x24f
  kernel_init+0xa/0x111
  ret_from_fork+0x22/0x30
 Mem-Info:
 ......
 DMA: failed to allocate 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation
 DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations

Here, let's check if DMA zone has managed pages, then create atomic_pool_dma
if yes. Otherwise just skip it.

Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
Cc: stable@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
---
 kernel/dma/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5a85804b5beb..00df3edd6c5d 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -206,7 +206,7 @@ static int __init dma_atomic_pool_init(void)
 						    GFP_KERNEL);
 	if (!atomic_pool_kernel)
 		ret = -ENOMEM;
-	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
+	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA);
 		if (!atomic_pool_dma)
@@ -229,7 +229,7 @@ static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
 	if (prev == NULL) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 			return atomic_pool_dma32;
-		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
+		if (atomic_pool_dma && (gfp & GFP_DMA))
 			return atomic_pool_dma;
 		return atomic_pool_kernel;
 	}
-- 
2.17.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
