Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62EC2BA1A
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6161920753
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JShSJcTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6161920753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C6B920361;
	Wed,  8 Apr 2020 12:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2t4Tp-0C2KQH; Wed,  8 Apr 2020 12:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CFBC7204D1;
	Wed,  8 Apr 2020 12:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA6C5C1AE8;
	Wed,  8 Apr 2020 12:01:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECC68C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DB6B187E9D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfpB18S4Zf10 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 12:01:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B7E687EA7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hO/JGmPVe815bwvJstKZaSg4nB/n8KECGr699QuWMC4=; b=JShSJcTre/OE8rtxOsBentK9Y9
 +To9ubUv9HFmlVVfgu+0tJaOeivBlM4WMR5RofZYDAjfvLiaH+PmoRmSzaXLeT/PuuG0wPFwy7ava
 O+qeB/d2qDLKzwTqjBhMVJsoI/1HO4DpkYc9F9ebFr2qoDMJ83gCGfVzgBuToAcG5+cx7ts6nxG7X
 qipqr5bysSCc8wWRdj0tsh/I5ebNsysXCDUi+PmYHjY1885iyJDrT4OulkZGUcmdSgI8D1bE3XzIW
 s7NNDT3dJUv7d0B4+UvZ6sb6hvTaTyuCs672Kcxy5XKGIQu/lHEMGH3X9T90O/xHOaj6CPP1MtkeD
 c7kyU5IA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM9O5-0005mY-W5; Wed, 08 Apr 2020 12:00:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 25/28] mm: remove vmalloc_user_node_flags
Date: Wed,  8 Apr 2020 13:59:23 +0200
Message-Id: <20200408115926.1467567-26-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Open code it in __bpf_map_area_alloc, which is the only caller.  Also
clean up __bpf_map_area_alloc to have a single vmalloc call with
slightly different flags instead of the current two different calls.

For this to compile for the nommu case add a __vmalloc_node_range stub
to nommu.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h |  1 -
 kernel/bpf/syscall.c    | 23 +++++++++++++----------
 mm/nommu.c              | 14 ++++++++------
 mm/vmalloc.c            | 20 --------------------
 4 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 108f49b47756..f90f2946aac2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -106,7 +106,6 @@ extern void *vzalloc(unsigned long size);
 extern void *vmalloc_user(unsigned long size);
 extern void *vmalloc_node(unsigned long size, int node);
 extern void *vzalloc_node(unsigned long size, int node);
-extern void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *vmalloc_32_user(unsigned long size);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 48d98ea8fad6..249d9bd43321 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -281,26 +281,29 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
 
-	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
+	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO;
+	unsigned int flags = 0;
+	unsigned long align = 1;
 	void *area;
 
 	if (size >= SIZE_MAX)
 		return NULL;
 
 	/* kmalloc()'ed memory can't be mmap()'ed */
-	if (!mmapable && size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
+	if (mmapable) {
+		BUG_ON(!PAGE_ALIGNED(size));
+		align = SHMLBA;
+		flags = VM_USERMAP;
+	} else if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
+		area = kmalloc_node(size, gfp | GFP_USER | __GFP_NORETRY,
 				    numa_node);
 		if (area != NULL)
 			return area;
 	}
-	if (mmapable) {
-		BUG_ON(!PAGE_ALIGNED(size));
-		return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
-					       __GFP_RETRY_MAYFAIL | flags);
-	}
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_RETRY_MAYFAIL | flags,
-			      numa_node, __builtin_return_address(0));
+
+	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
+			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
+			flags, numa_node, __builtin_return_address(0));
 }
 
 void *bpf_map_area_alloc(u64 size, int numa_node)
diff --git a/mm/nommu.c b/mm/nommu.c
index 81a86cd85893..b42cd6003d7d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -150,6 +150,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
+void *__vmalloc_node_range(unsigned long size, unsigned long align,
+		unsigned long start, unsigned long end, gfp_t gfp_mask,
+		pgprot_t prot, unsigned long vm_flags, int node,
+		const void *caller)
+{
+	return __vmalloc(size, flags);
+}
+
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller)
 {
@@ -180,12 +188,6 @@ void *vmalloc_user(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_user);
 
-void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
-{
-	return __vmalloc_user_flags(size, flags | __GFP_ZERO);
-}
-EXPORT_SYMBOL(vmalloc_user_node_flags);
-
 struct page *vmalloc_to_page(const void *addr)
 {
 	return virt_to_page(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 333fbe77255a..f6f2acdaf70c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2658,26 +2658,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-/**
- * vmalloc_user_node_flags - allocate memory for userspace on a specific node
- * @size: allocation size
- * @node: numa node
- * @flags: flags for the page level allocator
- *
- * The resulting memory area is zeroed so it can be mapped to userspace
- * without leaking data.
- *
- * Return: pointer to the allocated memory or %NULL on error
- */
-void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
-{
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
-				    flags | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, node,
-				    __builtin_return_address(0));
-}
-EXPORT_SYMBOL(vmalloc_user_node_flags);
-
 /**
  * vmalloc_exec - allocate virtually contiguous, executable memory
  * @size:	  allocation size
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
