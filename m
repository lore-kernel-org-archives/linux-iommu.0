Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA949C2BA2B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBF720753
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5jAerjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF720753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BA9F86A35;
	Wed,  8 Apr 2020 12:01:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xbb6oshbNM5k; Wed,  8 Apr 2020 12:01:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01C9086A4A;
	Wed,  8 Apr 2020 12:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0968C1AE8;
	Wed,  8 Apr 2020 12:01:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3096C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9D0092048D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKuX+qXMUy3U for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 12:01:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id C7B5920361
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kSiif4wtedwpdt50zgS9p2DvMcuq0oyuGm5DAffS2Lc=; b=O5jAerjDMyDSpUBMTA/oevrNio
 S+TlXAsFGadlEtQRn1K3WEKNHl4L8/5pvGWwOLyvixbzEcvd+/ni+/XU7d+F+gFhv2eHAswYI0p5y
 3vblTkwNDKub9/GntTSs3x8s7XoXcgKJWPdjELcFB03oSS6bmMLVCycLYwliDuP1T49LyprcML2MU
 I+lYkcJVsuhyarlTX3/yPf/XwGZTqxWVjwXdtAKHkAKx9VvIp4YlafGpxerk1luAU75O4vT1PQ0f6
 jtPBngw3NtlCkVbEBYkQYZEyDSVKr4FEj31ywgR/Pkbn4h44juFzKCV/mmP8+2Spa1LpO8PFmgUYF
 +AaNY5dQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM9Nw-0005cH-PA; Wed, 08 Apr 2020 12:00:49 +0000
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
Subject: [PATCH 22/28] mm: remove both instances of __vmalloc_node_flags
Date: Wed,  8 Apr 2020 13:59:20 +0200
Message-Id: <20200408115926.1467567-23-hch@lst.de>
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

The real version just had a few callers that can open code it and
remove one layer of indirection.  The nommu stub was public but only
had a single caller, so remove it and avoid a CONFIG_MMU ifdef in
vmalloc.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h |  9 ---------
 mm/nommu.c              |  3 ++-
 mm/vmalloc.c            | 20 ++++++--------------
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c1b9d6eca05f..4a46d296e70d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -115,17 +115,8 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
-#ifndef CONFIG_MMU
-extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
-static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
-						gfp_t flags, void *caller)
-{
-	return __vmalloc_node_flags(size, node, flags);
-}
-#else
 extern void *__vmalloc_node_flags_caller(unsigned long size,
 					 int node, gfp_t flags, void *caller);
-#endif
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
diff --git a/mm/nommu.c b/mm/nommu.c
index 2df549adb22b..9553efa59787 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -150,7 +150,8 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
-void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags)
+void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
+		void *caller)
 {
 	return __vmalloc(size, flags);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index de7952959e82..3d59d848ad48 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2566,14 +2566,6 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
-static inline void *__vmalloc_node_flags(unsigned long size,
-					int node, gfp_t flags)
-{
-	return __vmalloc_node(size, 1, flags, node,
-				__builtin_return_address(0));
-}
-
-
 void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
 				  void *caller)
 {
@@ -2594,8 +2586,8 @@ void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
  */
 void *vmalloc(unsigned long size)
 {
-	return __vmalloc_node_flags(size, NUMA_NO_NODE,
-				    GFP_KERNEL);
+	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc);
 
@@ -2614,8 +2606,8 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vzalloc(unsigned long size)
 {
-	return __vmalloc_node_flags(size, NUMA_NO_NODE,
-				GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc);
 
@@ -2670,8 +2662,8 @@ EXPORT_SYMBOL(vmalloc_node);
  */
 void *vzalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node_flags(size, node,
-			 GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
+				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
