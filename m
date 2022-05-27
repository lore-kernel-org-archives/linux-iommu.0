Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2171DC433F5
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 01:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8222C4275D;
	Fri, 27 May 2022 01:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ke5i9c2Ehy6F; Fri, 27 May 2022 01:25:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A27CD4275A;
	Fri, 27 May 2022 01:25:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 767E6C0032;
	Fri, 27 May 2022 01:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89741C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 01:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71C478489A
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 01:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kw6OKjDQbXGQ for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 01:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E7F784898
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 01:25:46 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-300628e76f3so32839667b3.12
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xOB8pdz5YMawh+tE4HzeA8+mu9Tju2B2ZXIXRpGMpRw=;
 b=HDF2wYgtuU9Zw5wHJkW/PUAU89NXp/Cxl6BPYcfMd9izTtaGCSXBDvOlCoV0vgy8S+
 G/mYwHmzudfV/hPQFS3w4rjQ40EGbQajpQG/PsZTt9J2urxzEPM7ZGsHqv4b9R81F8Eg
 BV5GFD9nU7xKKO08afjDufFWRvZwPWiKYSVpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xOB8pdz5YMawh+tE4HzeA8+mu9Tju2B2ZXIXRpGMpRw=;
 b=FHU2L+2kWgV6TNkzW5qHf9/2OUYM/pdfrJMj0KsDqldwY9F9gt7we0eSTPl3gJ/VkI
 X0WCjDEnpjIpxuBnSoFkxyYHFoe+COAoxeyPqQwTUgwN5A/jRxtNsNGa/lWTaR5eCNty
 gSZfGMeY7kz9mrU+p+XtfVcwAjdFEeFqbBjfMKm5zsl6aL/aKchBUGsb4l7UzJRZeTk3
 TvVLf/3y7bcyLb1VZZseJ3opFKZdTPQ9itszdqSkPsSR12t0sqrxl8BMtTAQdCIkomDs
 mIRYUu+cJpS5blpwvNKL3m/Xv7kgm4BviqMEfMgW/nP7djyav8SNVgy+Gb6RiLMnE0nK
 nHhA==
X-Gm-Message-State: AOAM5324ThSCXdk/Zb0BomGESHnVnyPasNmHPVWkhm5SAmbvKMQ8EMbK
 n2gshH7F4YDglUdOvU5T7K2Jq0H7zcP+HVPDICZg/w==
X-Google-Smtp-Source: ABdhPJyhsnVAPLaMcmgCWDAhzi1PgucWk5A9KwG/Q2umXETsbwwzIiu1bfGanEPnbdip2vtnovjMl2T+wtjSv79nkes=
X-Received: by 2002:a81:802:0:b0:2f7:cd12:9d53 with SMTP id
 2-20020a810802000000b002f7cd129d53mr39479699ywi.197.1653614744913; Thu, 26
 May 2022 18:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210806103423.3341285-1-stevensd@google.com>
 <48f72bbddb099b474d7917ff0e7c14a271d31350.camel@linux.ibm.com>
In-Reply-To: <48f72bbddb099b474d7917ff0e7c14a271d31350.camel@linux.ibm.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 27 May 2022 10:25:34 +0900
Message-ID: <CAD=HUj62m_P53nr-Zz4bO4Bsn_tgauWX3a28MgRgsB2xShB4Hg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add dynamic iommu backed bounce buffers
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 24, 2022 at 9:27 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Fri, 2021-08-06 at 19:34 +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > This patch series adds support for per-domain dynamic pools of iommu
> > bounce buffers to the dma-iommu API. This allows iommu mappings to be
> > reused while still maintaining strict iommu protection.
> >
> > This bounce buffer support is used to add a new config option that, when
> > enabled, causes all non-direct streaming mappings below a configurable
> > size to go through the bounce buffers. This serves as an optimization on
> > systems where manipulating iommu mappings is very expensive. For
> > example, virtio-iommu operations in a guest on a linux host require a
> > vmexit, involvement the VMM, and a VFIO syscall. For relatively small
> > DMA operations, memcpy can be significantly faster.
> >
> > As a performance comparison, on a device with an i5-10210U, I ran fio
> > with a VFIO passthrough NVMe drive and virtio-iommu with '--direct=1
> > --rw=read --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k,
> > and 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> > spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> > 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> > by >99%, as bounce buffers don't require syncing here in the read case.
> > Running with multiple jobs doesn't serve as a useful performance
> > comparison because virtio-iommu and vfio_iommu_type1 both have big
> > locks that significantly limit mulithreaded DMA performance.
> >
> > These pooled bounce buffers are also used for subgranule mappings with
> > untrusted devices, replacing the single use bounce buffers used
> > currently. The biggest difference here is that the new implementation
> > maps a whole sglist using a single bounce buffer. The new implementation
> > does not support using bounce buffers for only some segments of the
> > sglist, so it may require more copying. However, the current
> > implementation requires per-segment iommu map/unmap operations for all
> > untrusted sglist mappings (fully aligned sglists included). On a
> > i5-10210U laptop with the internal NVMe drive made to appear untrusted,
> > fio --direct=1 --rw=read --ioengine=libaio --iodepth=64 --bs=64k showed
> > a statistically significant decrease in CPU load from 2.28% -> 2.17%
> > with the new iommu bounce buffer optimization enabled.
> >
> > Each domain's buffer pool is split into multiple power-of-2 size
> > classes. Each class allocates a fixed number of buffer slot metadata. A
> > large iova range is allocated, and each slot is assigned an iova from
> > the range. This allows the iova to be easily mapped back to the slot,
> > and allows the critical section of most pool operations to be constant
> > time. The one exception is finding a cached buffer to reuse. These are
> > only separated according to R/W permissions - the use of other
> > permissions such as IOMMU_PRIV may require a linear search through the
> > cache. However, these other permissions are rare and likely exhibit high
> > locality, so the should not be a bottleneck in practice.
> >
> > Since untrusted devices may require bounce buffers, each domain has a
> > fallback rbtree to manage single use buffers. This may be necessary if a
> > very large number of DMA operations are simultaneously in-flight, or for
> > very large individual DMA operations.
> >
> > This patch set does not use swiotlb. There are two primary ways in which
> > swiotlb isn't compatible with per-domain buffer pools. First, swiotlb
> > allocates buffers to be compatible with a single device, whereas
> > per-domain buffer pools don't handle that during buffer allocation as a
> > single buffer may end up being used by multiple devices. Second, swiotlb
> > allocation establishes the original to bounce buffer mapping, which
> > again doesn't work if buffers can be reused. Effectively the only code
> > that can be shared between the two use cases is allocating slots from
> > the swiotlb's memory. However, given that we're going to be allocating
> > memory for use with an iommu, allocating memory from a block of memory
> > explicitly set aside to deal with a lack of iommu seems kind of
> > contradictory. At best there might be a small performance improvement if
> > wiotlb allocation is faster than regular page allocation, but buffer
> > allocation isn't on the hot path anyway.
> >
> > Not using the swiotlb has the benefit that memory doesn't have to be
> > preallocated. Instead, bounce buffers consume memory only for in-flight
> > dma transactions (ignoring temporarily cached buffers), which is the
> > smallest amount possible. This makes it easier to use bounce buffers as
> > an optimization on systems with large numbers of devices or in
> > situations where devices are unknown, since it is not necessary to try
> > to tune how much memory needs to be set aside to achieve good
> > performance without costing too much memory.
> >
> > Finally, this series adds a new DMA_ATTR_PERSISTENT_STREAMING flag. This
> > is meant to address devices which create long lived streaming mappings
> > but manage CPU cache coherency without using the dma_sync_* APIs.
> > Currently, these devices don't function properly with swiotlb=force. The
> > new flag is used to bypass bounce buffers so such devices will function
> > when the new bounce buffer optimization is enabled. The flag is added to
> > the i915 driver, which creates such mappings. It can also be added to
> > various dma-buf implementations as an optimization, although that is not
> > done here.
> >
> > v1 -> v2:
> >  - Replace existing untrusted bounce buffers with new bounce
> >    buffer pools. This includes significant rework to account for
> >    untrusted bounce buffers being required instead of an
> >    optimization.
> >  - Add flag for persistent streaming mappings.
> >
>
> Hi David,
>
> I'm currently looking into converting s390 from our custom IOMMU based
> DMA API implementation to using dma-iommu.c. We're always using an
> IOMMU for PCI devices even when doing pass-through to guests (under
> both the KVM and z/VM hypervisors). In this case I/O TLB flushes, which
> we use to do the shadowing of the guest I/O translations, are
> relatively expensive I'm thus very interested in your work. I've tried
> rebasing it on v5.18 and got it to compile but didn't get DMA to work
> though it seems to partially work as I don't get probe failures unlike
> with a completely broken DMA API. Since I might have very well screwed
> up the rebase and my DMA API conversion is experimental too I was
> wondering if you're still working on this and might have a current
> version I could experiment with?

Unfortunately I don't have anything more recent to share. I've come
across some performance issues caused by pathological usage patterns
in internal usage, but I haven't seen any correctness issues. I'm
hoping that I'll be able to address the performance issues and send a
rebased series within the next month or so.

It's definitely possible that this series has some bugs. I've tested
it on a range of chromebooks and their various hardware and drivers,
but that's still all relatively normal x86_64/arm64. If your hardware
is more particular about its DMA, this series might be missing
something.

-David
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
