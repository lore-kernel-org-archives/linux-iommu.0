Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128F9C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 08:57:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7B3610FD
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 08:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE7B3610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E878607DA;
	Thu,  4 Nov 2021 08:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o12qmAARfv1m; Thu,  4 Nov 2021 08:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2898460614;
	Thu,  4 Nov 2021 08:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA12C0019;
	Thu,  4 Nov 2021 08:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F8EC0012
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 283B680F8C
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUR9k-82RjiX for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 08:57:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0A1780F89
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:57:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8658F60E9C
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636016235;
 bh=9GnYflMSk1zGFDWqohvW6i+zYCvs8Ks+GwVIYMqi16Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TBjb9Yu61yn/io080EO5vexYHENH6T7Lc7zLulpV4rVCAMEzD+5IYIl9FCopcoxGX
 hLn1N6Kl9HU56L3Kt5pg8tWCJyZLVItmlLVmFQVeKtAsPg4qTTpJzGki/i7C/CB/JX
 l4F5cpuY8O4obR0uYFU7oKhS4gB2gTOzbUBRI/KYHRdABd9wWNZKqHl0l+k6zHnv9J
 EqYXt6LB0IVoLQuFoepOMNsuCafp6++z218lKGjaczRzHb8M23EA6+XeGwbtF4L70b
 K4BULyibwTZfQh8ApaDsqsULqUzVX9FwzPNN1jsUPHDlLIj89R9Vw7CbywbjAmW4PJ
 xGG7TO/NgsioQ==
Received: by mail-oo1-f44.google.com with SMTP id
 a17-20020a4a6851000000b002b59bfbf669so1693140oof.9
 for <iommu@lists.linux-foundation.org>; Thu, 04 Nov 2021 01:57:15 -0700 (PDT)
X-Gm-Message-State: AOAM530NmBQ6pGqzjfF3TCfuw0ywdcJBrX8GlhSwckBCF2KeXHH4YxjP
 SL9isEPEuLZekmfIW7jSFfmNVtZEhg5GI/bVZ1I=
X-Google-Smtp-Source: ABdhPJydgSUDDybkK0rHy627UMULvyYtlQWf9i2EfDmp2/C1uqN/3mY4roW+glGzK3Rt8ZzaI1IEXHbY8JpIAFCo8f4=
X-Received: by 2002:a4a:e1a3:: with SMTP id 3mr2689882ooy.32.1636016234879;
 Thu, 04 Nov 2021 01:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
 <20211104085336.GA24260@lst.de>
In-Reply-To: <20211104085336.GA24260@lst.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Nov 2021 09:57:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
Message-ID: <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
To: Christoph Hellwig <hch@lst.de>
Cc: Walter Wu <walter-zh.wu@mediatek.com>,
 wsd_upstream <wsd_upstream@mediatek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> > index f36be5166c19..6c7d1683339c 100644
> > --- a/include/linux/set_memory.h
> > +++ b/include/linux/set_memory.h
> > @@ -7,11 +7,16 @@
> >
> >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> >  #include <asm/set_memory.h>
> > +
> > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
>
> This is an arm64-specific symbol, and one that only controls a
> default.  I don't think it is suitable to key off stubs in common
> code.
>
> > +static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }
>
> Pleae avoid overly long lines.
>
> > +             if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> > +                     kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle));
>
> This can just use page_address.
>
> > +                     /* page remove kernel mapping for arm64 */
> > +                     set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> > +             }
>
> But more importantly:  set_memory_valid only exists on arm64, this
> will break compile everywhere else.  And this API is complete crap.
> Passing kernel virtual addresses as unsigned long just sucks, and
> passing an integer argument for valid/non-valid also is a horrible
> API.
>

... and as I pointed out before, you can still pass rodata=off on
arm64, and get the old behavior, in which case bad things will happen
if you try to use an API that expects to operate on page mappings with
a 1 GB block mapping.

And you still haven't explained what the actual problem is: is this
about CPU speculation corrupting non-cache coherent inbound DMA?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
