Return-Path: <SRS0=85Jd=UY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D121C48BD6
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 08:08:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26932168B
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26932168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B1F17B8F;
	Tue, 25 Jun 2019 08:08:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 237DFAE7
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 08:08:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
	[209.85.167.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 77F8A831
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 08:08:03 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id g7so11838012oia.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 01:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Jxnw+U68hXn7Fa0q2TDaDCNwS8hp8RvnOdBQ8+g7VtQ=;
	b=gsNhyB+oc9tMtLREjUGJ++0I0AtwKzyIszihfYNIAEppDixqQEgJYT2a0wWoyjVwXp
	IWsdTw6DaJTH6HcU9tAlQWYUGBi1yxpI/Eh05D+S4IYUpjOmj/msKc3m6VuDIoTIguo3
	yX75sfgDoqqRYQa66kYCLXEwVstb0ZjRVlNS31gx0JuiUMa+famI3VZL5scJx17MjP45
	DlPkCQGtBLNI6zFRWGfvLN8lS8f56EjbcluKJpIHzhqaqoBPZGScRoPfxZ9+h9wPBD/u
	Db3h2jvZbA75AGxTwfkAsLzUngRlMzDNSg/mz0ql4SJW4tkawyyQ+pZ7dS+QXNTePtw4
	PJMA==
X-Gm-Message-State: APjAAAUNATp/hL+Q7jpeijRdzW22Atct9VmqjAFfzd8+QEFOjmb0a3C3
	pYeNBLr4fS54knhy5bTfO63vlpK8wMF2Yk6PUMk=
X-Google-Smtp-Source: APXvYqzrUbQHgU0X1DTs1TPpiF36yqBmvbJBf3nQaoGw1DPSgo/XDZxCB1bntOWxwntQtZIyDTs1Fl08JTO4tIu1AmQ=
X-Received: by 2002:aca:338a:: with SMTP id z132mr13925717oiz.54.1561450082666;
	Tue, 25 Jun 2019 01:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
	<CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
	<20190625063228.GA29561@lst.de>
	<CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
	<20190625073524.GA30815@lst.de>
In-Reply-To: <20190625073524.GA30815@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Jun 2019 10:07:51 +0200
Message-ID: <CAMuHMdU1j9TiSB-67_3P1RMU95Jtb2=1=g2dhpD6zXuk9e69gA@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On Tue, Jun 25, 2019 at 9:35 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 25, 2019 at 09:26:48AM +0200, Geert Uytterhoeven wrote:
> > > > bloat-o-meter says:
> > > >
> > > > add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)
> > >
> > > What do these values stand for?  The code should grow a little as
> > > we now need to include the the pool allocator for the above API
> > > fix.
> >
> > Last 3 values are "bytes added/removed (net increase)".
> > So this increases the static kernel size by ca. 4 KiB.
>
> That seems a lot for the little bit of pool code.  Did m68k not

Exactly, hence my original question...

> build lib/genalloc.c by default before?

Indeed, CONFIG_GENERIC_ALLOCATOR wasn't enabled before.

--- .config.orig 2019-06-25 09:53:35.098691378 +0200
+++ .config 2019-06-25 09:59:23.914874446 +0200
@@ -2401,6 +2401,7 @@
 CONFIG_DECOMPRESS_XZ=y
 CONFIG_DECOMPRESS_LZO=y
 CONFIG_DECOMPRESS_LZ4=y
+CONFIG_GENERIC_ALLOCATOR=y
 CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
@@ -2409,6 +2410,10 @@
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_DMA=y
 CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
+CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
+CONFIG_ARCH_HAS_DMA_MMAP_PGPROT=y
+CONFIG_DMA_REMAP=y
+CONFIG_DMA_DIRECT_REMAP=y
 # CONFIG_DMA_API_DEBUG is not set
 CONFIG_SGL_ALLOC=y
 CONFIG_DQL=y

> Also I'd be curious what the first 4 values are.

Reading scripts/bloat-o-meter in the kernel source tree tells me number of
added/removed symbols (functions or variables), and number of
grown/shrunk symbols.

I run it regularly, to catch silly mistakes (cfr. my favorite one, fixed
by commit 23c323af0375a7f6 ("SUNRPC: No, I did not intend to create a
256KiB hashtable")).

Full output before/after for an atari_defconfig kernel
(numbers are different, baseline has changed, too):

$ bloat-o-meter vmlinux.orig vmlinux
add/remove: 75/0 grow/shrink: 1/2 up/down: 4098/-28 (4070)
Function                                     old     new   delta
gen_pool_alloc_algo_owner                      -     392    +392
dma_atomic_pool_init                           -     360    +360
gen_pool_best_fit                              -     248    +248
dma_common_contiguous_remap                    -     238    +238
gen_pool_destroy                               -     190    +190
gen_pool_free_owner                            -     184    +184
devm_gen_pool_create                           -     174    +174
dma_alloc_from_pool                            -     152    +152
bitmap_clear_ll                                -     138    +138
arch_dma_free                                 12     136    +124
dma_common_free_remap                          -     110    +110
gen_pool_add_owner                             -     108    +108
gen_pool_fixed_alloc                           -     100    +100
dma_common_pages_remap                         -      92     +92
gen_pool_dma_alloc                             -      78     +78
arch_dma_prep_coherent                         -      76     +76
clear_bits_ll                                  -      66     +66
dma_free_from_pool                             -      62     +62
set_bits_ll                                    -      60     +60
devm_gen_pool_match                            -      56     +56
addr_in_gen_pool                               -      56     +56
gen_pool_create                                -      54     +54
gen_pool_virt_to_phys                          -      52     +52
gen_pool_first_fit_align                       -      52     +52
gen_pool_for_each_chunk                        -      42     +42
gen_pool_get                                   -      40     +40
gen_pool_first_fit_order_align                 -      36     +36
gen_pool_set_algo                              -      34     +34
early_coherent_pool                            -      32     +32
__kstrtab_gen_pool_first_fit_order_align       -      31     +31
gen_pool_size                                  -      30     +30
arch_dma_mmap_pgprot                           -      28     +28
dma_in_atomic_pool                             -      26     +26
__kstrtab_gen_pool_alloc_algo_owner            -      26     +26
__kstrtab_gen_pool_first_fit_align             -      25     +25
gen_pool_avail                                 -      24     +24
__kstrtab_gen_pool_for_each_chunk              -      24     +24
__kstrtab_gen_pool_virt_to_phys                -      22     +22
__kstrtab_gen_pool_fixed_alloc                 -      21     +21
__kstrtab_devm_gen_pool_create                 -      21     +21
arch_dma_coherent_to_pfn                       -      20     +20
__kstrtab_gen_pool_free_owner                  -      20     +20
__kstrtab_gen_pool_first_fit                   -      19     +19
__kstrtab_gen_pool_dma_alloc                   -      19     +19
__kstrtab_gen_pool_add_owner                   -      19     +19
__kstrtab_gen_pool_set_algo                    -      18     +18
__kstrtab_gen_pool_best_fit                    -      18     +18
__kstrtab_gen_pool_destroy                     -      17     +17
__kstrtab_gen_pool_create                      -      16     +16
__kstrtab_gen_pool_avail                       -      15     +15
gen_pool_first_fit                             -      14     +14
devm_gen_pool_release                          -      14     +14
__setup_str_early_coherent_pool                -      14     +14
__kstrtab_gen_pool_size                        -      14     +14
__kstrtab_gen_pool_get                         -      13     +13
__setup_early_coherent_pool                    -      12     +12
__ksymtab_gen_pool_virt_to_phys                -       8      +8
__ksymtab_gen_pool_size                        -       8      +8
__ksymtab_gen_pool_set_algo                    -       8      +8
__ksymtab_gen_pool_get                         -       8      +8
__ksymtab_gen_pool_free_owner                  -       8      +8
__ksymtab_gen_pool_for_each_chunk              -       8      +8
__ksymtab_gen_pool_fixed_alloc                 -       8      +8
__ksymtab_gen_pool_first_fit_order_align       -       8      +8
__ksymtab_gen_pool_first_fit_align             -       8      +8
__ksymtab_gen_pool_first_fit                   -       8      +8
__ksymtab_gen_pool_dma_alloc                   -       8      +8
__ksymtab_gen_pool_destroy                     -       8      +8
__ksymtab_gen_pool_create                      -       8      +8
__ksymtab_gen_pool_best_fit                    -       8      +8
__ksymtab_gen_pool_avail                       -       8      +8
__ksymtab_gen_pool_alloc_algo_owner            -       8      +8
__ksymtab_gen_pool_add_owner                   -       8      +8
__ksymtab_devm_gen_pool_create                 -       8      +8
atomic_pool_size                               -       4      +4
atomic_pool                                    -       4      +4
arch_dma_alloc                               312     310      -2
dma_common_mmap                              250     224     -26
Total: Before=3724055, After=3728125, chg +0.11%


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
