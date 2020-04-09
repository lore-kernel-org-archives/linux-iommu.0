Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A807C2BA19
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 22:43:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEE820730
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 22:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4onPV0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEE820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A3AAB20503;
	Thu,  9 Apr 2020 22:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id og2R7YuLqlqS; Thu,  9 Apr 2020 22:43:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 79A4520396;
	Thu,  9 Apr 2020 22:43:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB77C089F;
	Thu,  9 Apr 2020 22:43:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37662C089F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 22:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 25930876F2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 22:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9oTHGlhrH8F7 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 22:25:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9FC6869D3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 22:25:15 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id i186so491221qke.1
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zZmDvv9VsaMcSR+uAlcqBBO7fDfxOBX/cPeyIGlPXM=;
 b=W4onPV0FDtRSS9y6l1W+W/FVY7uMwYmp/vLxbV+vsTO2W55vIfLst1ikMIBLMv47KZ
 64ToStA7a/6zppDU+wTlTfU6Un6EOx32pfCLeSVtqFEU4ptlSPugU0N+X034gxeIEd+F
 sZ22vzsQqnM3Miz22Gk0POiNvD6ME0G4DRZUu2V8o+JOPEqF23MicCWNGTbmmYIhLe6V
 3W5oV53czY23X0IJIdp9cV+2Oc5V3oKlN3PwYT1QLJTo9I26Y6rC6ay6XFYA6QD+wQeh
 /I0xueubtqoupnFXkcYtIoaN9TVAPRTkCMdnq3avNZap0J3hFNk8iJ7/qgVG1ZOC7J6L
 Bwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zZmDvv9VsaMcSR+uAlcqBBO7fDfxOBX/cPeyIGlPXM=;
 b=CCKWTT3NdxtJ9bvhUspSYc6ZYQnuYiPVbWdVPachpWIbjhwtrJ8bM4JqW5bMoer7kX
 WyoR1reR0CQRBW9z07xsrXWEZ6E2uHZvh51NKCEWaYcN2jIlXTCiXuof76h5wi5fCO2F
 N5iD9uNK4Jp+Qjuh9Gbi1tT8B9i1EOkqQIzJjxB4NaT4P9oTDTiElxPdsv0CkL1djI4R
 e3jqqAOeEaW6UF+8Ekn9f72u2bwo5+pAe4EsCPXUHVlsJ+mK33EgzInwdQVL2mpkE02r
 8uBM+sT/r9FT1FZO4l9OYeFcH4lldWDRLWt6pWpeTp6rbSG+2ai3iJsWhUG9zmRQf/NQ
 O4xw==
X-Gm-Message-State: AGi0PuZmf8kgfLSceUDYL56zwtucGfQUnJ3CW7vqYFn8WVKgMkwk6dC8
 c3tfUeur+9iwmk4orOHyEREs+XB121Q9Lw9WKws=
X-Google-Smtp-Source: APiQypIwNq7wZY1PnpGu/Qv59bzelpOE6CP1WGeABev8jhWjEtJ5m8SKmmGAGV+0ntLTtupM9GwEs2trz+3rj7Qjirg=
X-Received: by 2002:a37:6587:: with SMTP id z129mr1198478qkb.437.1586471114653; 
 Thu, 09 Apr 2020 15:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-26-hch@lst.de>
In-Reply-To: <20200408115926.1467567-26-hch@lst.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Apr 2020 15:25:03 -0700
Message-ID: <CAEf4BzZOC2tLrqt_Km=WQb=9xiya2e31i6K3oJuzgYQt6wp1LQ@mail.gmail.com>
Subject: Re: [PATCH 25/28] mm: remove vmalloc_user_node_flags
To: Christoph Hellwig <hch@lst.de>, Johannes Weiner <hannes@cmpxchg.org>
X-Mailman-Approved-At: Thu, 09 Apr 2020 22:43:48 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

cc Johannes who suggested this API call originally

On Wed, Apr 8, 2020 at 5:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Open code it in __bpf_map_area_alloc, which is the only caller.  Also
> clean up __bpf_map_area_alloc to have a single vmalloc call with
> slightly different flags instead of the current two different calls.
>
> For this to compile for the nommu case add a __vmalloc_node_range stub
> to nommu.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/vmalloc.h |  1 -
>  kernel/bpf/syscall.c    | 23 +++++++++++++----------
>  mm/nommu.c              | 14 ++++++++------
>  mm/vmalloc.c            | 20 --------------------
>  4 files changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 108f49b47756..f90f2946aac2 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -106,7 +106,6 @@ extern void *vzalloc(unsigned long size);
>  extern void *vmalloc_user(unsigned long size);
>  extern void *vmalloc_node(unsigned long size, int node);
>  extern void *vzalloc_node(unsigned long size, int node);
> -extern void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags);
>  extern void *vmalloc_exec(unsigned long size);
>  extern void *vmalloc_32(unsigned long size);
>  extern void *vmalloc_32_user(unsigned long size);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 48d98ea8fad6..249d9bd43321 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -281,26 +281,29 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
>          * __GFP_RETRY_MAYFAIL to avoid such situations.
>          */
>
> -       const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
> +       const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO;
> +       unsigned int flags = 0;
> +       unsigned long align = 1;
>         void *area;
>
>         if (size >= SIZE_MAX)
>                 return NULL;
>
>         /* kmalloc()'ed memory can't be mmap()'ed */
> -       if (!mmapable && size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> -               area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
> +       if (mmapable) {
> +               BUG_ON(!PAGE_ALIGNED(size));
> +               align = SHMLBA;
> +               flags = VM_USERMAP;
> +       } else if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> +               area = kmalloc_node(size, gfp | GFP_USER | __GFP_NORETRY,
>                                     numa_node);
>                 if (area != NULL)
>                         return area;
>         }
> -       if (mmapable) {
> -               BUG_ON(!PAGE_ALIGNED(size));
> -               return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
> -                                              __GFP_RETRY_MAYFAIL | flags);
> -       }
> -       return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_RETRY_MAYFAIL | flags,
> -                             numa_node, __builtin_return_address(0));
> +
> +       return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> +                       gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
> +                       flags, numa_node, __builtin_return_address(0));
>  }
>
>  void *bpf_map_area_alloc(u64 size, int numa_node)
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 81a86cd85893..b42cd6003d7d 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,6 +150,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> +void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +               unsigned long start, unsigned long end, gfp_t gfp_mask,
> +               pgprot_t prot, unsigned long vm_flags, int node,
> +               const void *caller)
> +{
> +       return __vmalloc(size, flags);
> +}
> +
>  void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
>                 int node, const void *caller)
>  {
> @@ -180,12 +188,6 @@ void *vmalloc_user(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc_user);
>
> -void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
> -{
> -       return __vmalloc_user_flags(size, flags | __GFP_ZERO);
> -}
> -EXPORT_SYMBOL(vmalloc_user_node_flags);
> -
>  struct page *vmalloc_to_page(const void *addr)
>  {
>         return virt_to_page(addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 333fbe77255a..f6f2acdaf70c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2658,26 +2658,6 @@ void *vzalloc_node(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node);
>
> -/**
> - * vmalloc_user_node_flags - allocate memory for userspace on a specific node
> - * @size: allocation size
> - * @node: numa node
> - * @flags: flags for the page level allocator
> - *
> - * The resulting memory area is zeroed so it can be mapped to userspace
> - * without leaking data.
> - *
> - * Return: pointer to the allocated memory or %NULL on error
> - */
> -void *vmalloc_user_node_flags(unsigned long size, int node, gfp_t flags)
> -{
> -       return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> -                                   flags | __GFP_ZERO, PAGE_KERNEL,
> -                                   VM_USERMAP, node,
> -                                   __builtin_return_address(0));
> -}
> -EXPORT_SYMBOL(vmalloc_user_node_flags);
> -
>  /**
>   * vmalloc_exec - allocate virtually contiguous, executable memory
>   * @size:        allocation size
> --
> 2.25.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
