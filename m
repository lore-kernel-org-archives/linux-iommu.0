Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A8C2BA2B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 14:19:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF6B2083E
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 14:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC90dwXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF6B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC78486AEB;
	Thu,  9 Apr 2020 14:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwkQe3cv4A4A; Thu,  9 Apr 2020 14:19:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB21486AE3;
	Thu,  9 Apr 2020 14:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2DFFC089F;
	Thu,  9 Apr 2020 14:19:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F739C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 64E5F2051A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IuPFlcnxIEXD for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 14:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id EE427203C2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:19:42 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id h9so12122053wrc.8
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUmhXgHoG6HvjILgsbXz8GHCgll+LOxrRpBdz13V/lg=;
 b=BC90dwXA5AK4WR90ooTtvULwZnu4ZsRVQnQLV9NzDFZ7lKqicRXsEGPNedNOxy+3QI
 a1kmoOXSFteeDxdRL+7e8P62DjjD9bQZg3s3fofRhJoe7L1J9a46LbUxrQ6AtBTORXKV
 NDIKSoT9CEStlFz6MiX3tbzgvTr7KX9SEjLdYBH0eiP7EZNSClTpfzc0SSPSYynPiChj
 rYQTfJjtkntOCwrv+a6GMvAsCqYj/CQkd4PMEIkllHf9XhpKzORn/6xDs0+pafSbvmxv
 oU2GBI4+6mAQrXmQRuIHv6FAH1pdnq+zGKXLFmqILm/RS3QETgMEHnp/o0W7dlcGkPIh
 SqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUmhXgHoG6HvjILgsbXz8GHCgll+LOxrRpBdz13V/lg=;
 b=DttKBt3BQwCZAQHeBO+X3ep6dnZgiVDIW100dVsamClcJtxF3mfUPiDJwQBreWnpeI
 957BgR0Rz4w/iPSDKbQ7R2sP//kK2EI7IwkzNvdyh1ws+7caz9IkTzGf8RjFVsD9ApSO
 Sxfoh6livGnYGRyDwBkiaYOSDhCxs7Jm6LleRYFvkc/uUj28QCbbzDRWKSSX+qG6POgI
 XxgCottpWlRRp02JdKNyot5po9RSG7syAG3Jf6fMx7mY6I+gJB8Sh13mLGFIBQ6xAFDW
 hoM5iqR6dSlyPNpbP9eeSxPO+gS7D4LaTTACsILOym38Ouz1RsfQi7G3pWXgtAz2WDee
 7sqQ==
X-Gm-Message-State: AGi0PuZmayJP337QVv4hEH8OhD02ypUDaW6KEWQ/FhdFAFr2ZdC7Wojy
 3fs/Qp3ZBZRIi1BIcie6iQJ1v6Zas8ERwFhVvTY=
X-Google-Smtp-Source: APiQypLOoBbfys5GjBpuB2sw0gQny4RebKmCrdoglSc09SupmnqmNJDVTgB3bGVTn0oBHL2+TIHKXrenRgwfEr3zhLg=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr9091691wrq.362.1586441981450; 
 Thu, 09 Apr 2020 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
 <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
In-Reply-To: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Apr 2020 10:19:30 -0400
Message-ID: <CADnq5_MjTSm6j=_8huVQ854H6jXY5Rg36wc31QDfOpfjfscWxA@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, X86 ML <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
 Nitin Gupta <ngupta@vflare.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 bpf <bpf@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Apr 9, 2020 at 5:41 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Apr 9, 2020 at 10:54 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> > > On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > > > If this code was broken for non-coherent caches a crude powerpc hack
> > > > isn't going to help anyone else.  Remove the hack as it is the last
> > > > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> > >
> > > Well Ben added this to make stuff work on ppc, ofc the home grown dma
> > > layer in drm from back then isn't going to work in other places. I guess
> > > should have at least an ack from him, in case anyone still cares about
> > > this on ppc. Adding Ben to cc.
> >
> > This was due to some drivers (radeon ?) trying to use vmalloc pages for
> > coherent DMA, which means on those 4xx powerpc's need to be non-cached.
> >
> > There were machines using that (440 based iirc), though I honestly
> > can't tell if anybody still uses any of it.
>
> agp subsystem still seems to happily do that (vmalloc memory for
> device access), never having been ported to dma apis (or well
> converted to iommu drivers, which they kinda are really). So I think
> this all still works exactly as back then, even with the kms radeon
> drivers. Question really is whether we have users left, and I have no
> clue about that either.
>
> Now if these boxes didn't ever have agp then I think we can get away
> with deleting this, since we've already deleted the legacy radeon
> driver. And that one used vmalloc for everything. The new kms one does
> use the dma-api if the gpu isn't connected through agp.

All radeons have a built in remapping table to handle non-AGP systems.
On the earlier radeons it wasn't quite as performant as AGP, but it
was always more reliable because AGP is AGP.  Maybe it's time to let
AGP go?

Alex

> -Daniel
>
> > Cheers,
> > Ben.
> >
> > > -Daniel
> > >
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> > > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > > > index ca520028b2cb..f4e6184d1877 100644
> > > > --- a/drivers/gpu/drm/drm_scatter.c
> > > > +++ b/drivers/gpu/drm/drm_scatter.c
> > > > @@ -43,15 +43,6 @@
> > > >
> > > >  #define DEBUG_SCATTER 0
> > > >
> > > > -static inline void *drm_vmalloc_dma(unsigned long size)
> > > > -{
> > > > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > > > -   return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > > > -#else
> > > > -   return vmalloc_32(size);
> > > > -#endif
> > > > -}
> > > > -
> > > >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> > > >  {
> > > >     struct page *page;
> > > > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> > > >             return -ENOMEM;
> > > >     }
> > > >
> > > > -   entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > > > +   entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> > > >     if (!entry->virtual) {
> > > >             kfree(entry->busaddr);
> > > >             kfree(entry->pagelist);
> > > > --
> > > > 2.25.1
> > > >
> > >
> > >
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
