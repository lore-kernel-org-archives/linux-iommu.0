Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A58C433FE
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:47:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA51F611C3
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA51F611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 675034059A;
	Thu,  4 Nov 2021 12:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvA4dMCueswb; Thu,  4 Nov 2021 12:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 498EE4058C;
	Thu,  4 Nov 2021 12:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2D6C0019;
	Thu,  4 Nov 2021 12:47:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0165EC000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D133360886
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMVS4513lzzR for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40C196087C
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:47:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB5F5611CE
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636030056;
 bh=O89SG59ERFkapOwq86PzKcmSXMmROh38ILRsxSPw7zc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FUvx4DVOJMgsgc8Dclim6uiPNanlCw5L3gLp5PVRYWaoNB9rczDaMyOu74b5oF1d4
 AHQF0P2QUe/aKt1at2I3AWfbFZ99fftU7/5wpYdVqsnnHuI/KpFI/ENXZez8TbJFb4
 5TS6iTqKetd4Skk5at9pKxYakuM5yK4ng3Jdk71JGqsTnKlLuGhsWwFWtNfIFAKjFQ
 cyJuzZCeLF6on0nF5PCFzmBT7h8dRN7nAbyXaHB8drhluEVwshEhKQjWhhuHXt15VG
 d3Qzpw5oaHVDaArQs6B3Z7jd2EO/RgHBiPRqHM1jWw/Z0bJql4Pe26pacZ0L+oNTgI
 3MfAezPvDs5Sg==
Received: by mail-ot1-f48.google.com with SMTP id
 v2-20020a05683018c200b0054e3acddd91so8059672ote.8
 for <iommu@lists.linux-foundation.org>; Thu, 04 Nov 2021 05:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM5325CXAJSrm+QEBCOt7VxUOUbE5BiiErr6nbXt5OC8Tv+kLZYZOx
 ILuqjDmqDLh+MMUzoaZbPa57aTvLCO3IwQTvOaQ=
X-Google-Smtp-Source: ABdhPJxhWjJHaSYxFkhh2iWefDx6Z+2GQYHsj7ZwDXxYFvelaU3rJtXffw/e5rsmEHaDNyuzdbd+XCXcawBw+m5Y8K0=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr39447582oth.30.1636030056196; 
 Thu, 04 Nov 2021 05:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
 <20211104085336.GA24260@lst.de>
 <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
 <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
In-Reply-To: <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Nov 2021 13:47:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
Message-ID: <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
To: Walter Wu <walter-zh.wu@mediatek.com>
Cc: wsd_upstream <wsd_upstream@mediatek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
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

On Thu, 4 Nov 2021 at 13:31, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Thu, 2021-11-04 at 09:57 +0100, Ard Biesheuvel wrote:
> > On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > > > diff --git a/include/linux/set_memory.h
> > > > b/include/linux/set_memory.h
> > > > index f36be5166c19..6c7d1683339c 100644
> > > > --- a/include/linux/set_memory.h
> > > > +++ b/include/linux/set_memory.h
> > > > @@ -7,11 +7,16 @@
> > > >
> > > >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> > > >  #include <asm/set_memory.h>
> > > > +
> > > > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > >
> > > This is an arm64-specific symbol, and one that only controls a
> > > default.  I don't think it is suitable to key off stubs in common
> > > code.
> > >
> > > > +static inline int set_memory_valid(unsigned long addr, int
> > > > numpages, int enable) { return 0; }
> > >
> > > Pleae avoid overly long lines.
> > >
> > > > +             if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED))
> > > > {
> > > > +                     kaddr = (unsigned
> > > > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> > >
> > > This can just use page_address.
> > >
> > > > +                     /* page remove kernel mapping for arm64 */
> > > > +                     set_memory_valid(kaddr, size >> PAGE_SHIFT,
> > > > 0);
> > > > +             }
> > >
> > > But more importantly:  set_memory_valid only exists on arm64, this
> > > will break compile everywhere else.  And this API is complete crap.
> > > Passing kernel virtual addresses as unsigned long just sucks, and
> > > passing an integer argument for valid/non-valid also is a horrible
> > > API.
> > >
> >
> > ... and as I pointed out before, you can still pass rodata=off on
> > arm64, and get the old behavior, in which case bad things will happen
> > if you try to use an API that expects to operate on page mappings
> > with
> > a 1 GB block mapping.
> >
>
> Thanks for your suggestion.
>
>
> > And you still haven't explained what the actual problem is: is this
> > about CPU speculation corrupting non-cache coherent inbound DMA?
>
> No corrupiton, only cpu read it, we hope to fix the behavior.
>

Fix which behavior? Please explain

1) the current behavior
2) why the current behavior is problematic for you
3) how this patch changes the current behavior
4) why the new behavior fixes your problem.

There is no penalty for using too many words.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
