Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16159C2BB1D
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 19:18:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF24F2078A
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WFGud2tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24F2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9578F855B5;
	Tue, 14 Apr 2020 19:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RGQVP1rHg0k; Tue, 14 Apr 2020 19:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2175484D81;
	Tue, 14 Apr 2020 19:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06C68C1D7D;
	Tue, 14 Apr 2020 19:18:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4542FC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2ECE68558F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRQ26Fj2F6SS for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 19:18:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2487684D81
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:18:40 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id x26so328573pgc.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=P9uGK/l9+upt2147+kcKvfUBL5T6QGch+S3tGbTmzhg=;
 b=WFGud2tBPWFna3TtJBPDwDAuc3HGHK64EaaZKf9mtGIDlcqcqYj+zc5/SdWWRMWshu
 raTwvHD7blUEj+visUbTeVR/CmwIC4XYp9lmYsXLyaJPZ3ZVp14dQCZwCgF6//ssCtXR
 0kMk3I6NrQ4quQmpa5nYNEojOp7zczNpCEM3vPAfNRSWnufba2qs902hbkoro4+2x/iz
 FPjdJMuI04crXUgqCwJxr1hpuJZEo3UncZ80cbCsoRkZx4R1HlU/ZxJ+rB759ZBSsmWA
 9BJEu8ErySIBz8RRagX/0hFlQTX/hsOlz4XJF+DTn0lVQLrx/oGqN0SNRXj4fZuBebnL
 eKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=P9uGK/l9+upt2147+kcKvfUBL5T6QGch+S3tGbTmzhg=;
 b=UQ+/q/L1U4rOqObFp9zFkdUMzaiGW778j1TKFTHzK5Yuv/rXt2L3mljcaXKvdljKV4
 F8rXMpMgWhKmoMwaJnTQ0RXcdirFC/Cud2SVW9g6DgxsDtalcpw7vHVlxPqPnYuLSzaV
 0gLtz0UBo12fFzExTxB9o9gL/yNLb1zFLD+MnP7WO3dl7KQDVuwMuux9E8515P0Slw96
 SANzj765+KWr8agNrovUzwvG/cHKp9r8nLBdeGYvvY4AdjMI0JuacZnqptqx22kzONxW
 Je9AnwV6MKujYjh2ML+jGLOzTExeWdO1965RZuNbc/YTEMBRhyg+M9lcFoM4dsgQnt1x
 rA5A==
X-Gm-Message-State: AGi0PuaUGIQQBOmKYGhEsWE/pbWG+5jGoBAb9Wm+fB43Nd8Xk5ldi72h
 jXyv8B8dQkfZzMoWebxy3RCYgA==
X-Google-Smtp-Source: APiQypK8wVeo3OinH7VyXKPdkf8oibdS0+kfLLeCbEyQbUEH3ydOeW4wh59RRBV09oWKbrzrBA9/PA==
X-Received: by 2002:aa7:9d89:: with SMTP id f9mr3546328pfq.194.1586891919386; 
 Tue, 14 Apr 2020 12:18:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id r28sm5417712pfg.186.2020.04.14.12.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 12:18:38 -0700 (PDT)
Date: Tue, 14 Apr 2020 12:18:37 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [rfc v2 4/6] dma-direct: atomic allocations must come from atomic
 coherent pools
In-Reply-To: <26df6b35-af63-bf17-0c21-51684afa6f67@amd.com>
Message-ID: <alpine.DEB.2.22.394.2004141216090.2583@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
 <26df6b35-af63-bf17-0c21-51684afa6f67@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 9 Apr 2020, Tom Lendacky wrote:

> > When a device required unencrypted memory and the context does not allow
> 
> required => requires
> 

Fixed, thanks.

> > blocking, memory must be returned from the atomic coherent pools.
> > 
> > This avoids the remap when CONFIG_DMA_DIRECT_REMAP is not enabled and the
> > config only requires CONFIG_DMA_COHERENT_POOL.  This will be used for
> > CONFIG_AMD_MEM_ENCRYPT in a subsequent patch.
> > 
> > Keep all memory in these pools unencrypted.
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >   kernel/dma/direct.c | 16 ++++++++++++++++
> >   kernel/dma/pool.c   | 15 +++++++++++++--
> >   2 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 70800ca64f13..44165263c185 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -124,6 +124,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t
> > size,
> >   	struct page *page;
> >   	void *ret;
> >   +	/*
> > +	 * Unencrypted memory must come directly from DMA atomic pools if
> > +	 * blocking is not allowed.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> > +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
> > +		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
> > +		if (!ret)
> > +			return NULL;
> > +		goto done;
> > +	}
> > +
> >   	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> >   	    dma_alloc_need_uncached(dev, attrs) &&
> >   	    !gfpflags_allow_blocking(gfp)) {
> > @@ -203,6 +215,10 @@ void dma_direct_free_pages(struct device *dev, size_t
> > size, void *cpu_addr,
> >   {
> >   	unsigned int page_order = get_order(size);
> >   +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> > +	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> > +		return;
> > +
> >   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> >   	    !force_dma_unencrypted(dev)) {
> >   		/* cpu_addr is a struct page cookie, not a kernel address */
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index e14c5a2da734..6685ab89cfa7 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/dma-contiguous.h>
> >   #include <linux/init.h>
> >   #include <linux/genalloc.h>
> > +#include <linux/set_memory.h>
> >   #include <linux/slab.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/workqueue.h>
> > @@ -55,12 +56,20 @@ static int atomic_pool_expand(struct gen_pool *pool,
> > size_t pool_size,
> >     	arch_dma_prep_coherent(page, pool_size);
> >   +#ifdef CONFIG_DMA_DIRECT_REMAP
> >   	addr = dma_common_contiguous_remap(page, pool_size,
> >   					   pgprot_dmacoherent(PAGE_KERNEL),
> >   					   __builtin_return_address(0));
> >   	if (!addr)
> >   		goto free_page;
> > -
> > +#else
> > +	addr = page_to_virt(page);
> > +#endif
> > +	/*
> > +	 * Memory in the atomic DMA pools must be unencrypted, the pools do
> > not
> > +	 * shrink so no re-encryption occurs in dma_direct_free_pages().
> > +	 */
> > +	set_memory_decrypted((unsigned long)page_to_virt(page), 1 << order);
> >   	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> >   				pool_size, NUMA_NO_NODE);
> >   	if (ret)
> > @@ -69,8 +78,10 @@ static int atomic_pool_expand(struct gen_pool *pool,
> > size_t pool_size,
> >   	return 0;
> >     remove_mapping:
> > +#ifdef CONFIG_DMA_DIRECT_REMAP
> >   	dma_common_free_remap(addr, pool_size);
> 
> You're about to free the memory, but you've called set_memory_decrypted()
> against it, so you need to do a set_memory_encrypted() to bring it back to a
> state ready for allocation again.
> 

Ah, good catch, thanks.  I notice that I should also be checking the 
return value of set_memory_decrypted() because pages added to the coherent 
pools *must* be unencrypted.  If it fails, we fail the expansion.

And do the same thing for set_memory_encrypted(), which would be a bizarre 
situation (decrypt succeeded, encrypt failed), by simply leaking the page.

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -7,6 +7,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -53,22 +54,42 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 	arch_dma_prep_coherent(page, pool_size);
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
 		goto free_page;
-
+#else
+	addr = page_to_virt(page);
+#endif
+	/*
+	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
+	 * shrink so no re-encryption occurs in dma_direct_free_pages().
+	 */
+	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+				   1 << order);
+	if (ret)
+		goto remove_mapping;
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
-		goto remove_mapping;
+		goto encrypt_mapping;
 
 	return 0;
 
+encrypt_mapping:
+	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
+				   1 << order);
+	if (WARN_ON_ONCE(ret)) {
+		/* Decrypt succeeded but encrypt failed, purposely leak */
+		goto out;
+	}
 remove_mapping:
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-free_page:
+#endif
+free_page: __maybe_unused
 	if (!dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
