Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A750FC433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 01:46:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5B36162D
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 01:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B36162D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B36184439;
	Tue, 11 May 2021 01:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tuzr3BcbNxiI; Tue, 11 May 2021 01:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF09984436;
	Tue, 11 May 2021 01:46:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6591C000E;
	Tue, 11 May 2021 01:46:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABB4C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 01:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED71540593
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 01:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8FsHoYf8PtI for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 01:46:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 403E040585
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 01:46:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 416A161629;
 Tue, 11 May 2021 01:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620697595;
 bh=zRFH7hcgqBzuVJGwApqdrtTvpvj+GmXyjHWNsw6DGg8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=SrbUmQ3XfUDBVScU7RGYGh+COsif34UcsKqoTgGV9vf8XRs8R1lfXDv2Rg8m5+EF9
 CJPluc1/MQWvbLjpb0BVOfrQVGN/CpceyyrZMmsRnCPL3kqtV6OlO3OEzsslK/qv7R
 zfl2Tf8Vw+0CIzNstymmxgXrqQa0cXQFMxMCpH3x+EScqVCBhtS+W0OWy9oXkU1Diw
 G6RzBgQ9DfY0kzP1vEIMFq5Dn15X6EwBB3uZAB8JhvRKGL4JvgSEGm4RjP4loHchpQ
 dnVwpyniLe2sjqdRGm4CgKX7WruGCQeIvlzp1r0kmQMvORLOQOTUtZolCtGmlfMEQH
 t7e1j5rQsPpEw==
Date: Mon, 10 May 2021 18:46:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
In-Reply-To: <20210510084057.GA933@lst.de>
Message-ID: <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: f.fainelli@gmail.com, Julien Grall <julien@xen.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 osstest service owner <osstest-admin@xenproject.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

On Mon, 10 May 2021, Christoph Hellwig wrote:
> On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
> > The pointer dereferenced seems to suggest that the swiotlb hasn't been 
> > allocated. From what I can tell, this may be because swiotlb_force is set 
> > to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on top 
> > of Xen.
> >
> > I am not entirely sure what would be the correct fix. Any opinions?
> 
> Can you try something like the patch below (not even compile tested, but
> the intent should be obvious?
> 
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 16a2b2b1c54d..7671bc153fb1 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -44,6 +44,8 @@
>  #include <asm/tlb.h>
>  #include <asm/alternative.h>
>  
> +#include <xen/arm/swiotlb-xen.h>
> +
>  /*
>   * We need to be able to catch inadvertent references to memstart_addr
>   * that occur (potentially in generic code) before arm64_memblock_init()
> @@ -482,7 +484,7 @@ void __init mem_init(void)
>  	if (swiotlb_force == SWIOTLB_FORCE ||
>  	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>  		swiotlb_init(1);
> -	else
> +	else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  
>  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);

The "IS_ENABLED(CONFIG_XEN)" is not needed as the check is already part
of xen_swiotlb_detect().


But let me ask another question first. Do you think it makes sense to have:

	if (swiotlb_force == SWIOTLB_NO_FORCE)
		return 0;

at the beginning of swiotlb_late_init_with_tbl? I am asking because
swiotlb_late_init_with_tbl is meant for special late initializations,
right? It shouldn't really matter the presence or absence of
SWIOTLB_NO_FORCE in regards to swiotlb_late_init_with_tbl. Also the
commit message for "swiotlb: Make SWIOTLB_NO_FORCE perform no
allocation" says that "If a platform was somehow setting
swiotlb_no_force and a later call to swiotlb_init() was to be made we
would still be proceeding with allocating the default SWIOTLB size
(64MB)." Our case here is very similar, right? So the allocation should
proceed?


Which brings me to a separate unrelated issue, still affecting the path
xen_swiotlb_init -> swiotlb_late_init_with_tbl. If swiotlb_init(1) is
called by mem_init then swiotlb_late_init_with_tbl will fail due to the
check:

    /* protect against double initialization */
    if (WARN_ON_ONCE(io_tlb_default_mem))
        return -ENOMEM;

xen_swiotlb_init is meant to ask Xen to make a bunch of pages physically
contiguous. Then, it initializes the swiotlb buffer based on those
pages. So it is a problem that swiotlb_late_init_with_tbl refuses to
continue. However, in practice it is not a problem today because on ARM
we don't actually make any special requests to Xen to make the pages
physically contiguous (yet). See the empty implementation of
arch/arm/xen/mm.c:xen_create_contiguous_region. I don't know about x86.

So maybe we should instead do something like the appended?


diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f8f07469d259..f5a3638d1dee 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -152,6 +152,7 @@ static int __init xen_mm_init(void)
 	struct gnttab_cache_flush cflush;
 	if (!xen_swiotlb_detect())
 		return 0;
+	swiotlb_exit();
 	xen_swiotlb_init();
 
 	cflush.op = 0;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..f17be37298a7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -285,9 +285,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
-	if (swiotlb_force == SWIOTLB_NO_FORCE)
-		return 0;
-
 	/* protect against double initialization */
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
