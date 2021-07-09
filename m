Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C843C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 07:25:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E646121E
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 07:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E646121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C00D84022B;
	Fri,  9 Jul 2021 07:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96eU0a_gEWmJ; Fri,  9 Jul 2021 07:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67BE3401F1;
	Fri,  9 Jul 2021 07:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38ECDC001A;
	Fri,  9 Jul 2021 07:25:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D03FC000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 07:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA32042250
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 07:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1VIJXVsI7VLt for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 07:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB70B4158C
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 07:25:32 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id s4so8410063qkm.13
 for <iommu@lists.linux-foundation.org>; Fri, 09 Jul 2021 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=whFUneYINRIgyp8Pel0QMZvhhIk7uCGvvk56hecjsos=;
 b=TDjKIe5QOAn1zKQay0mscOVMXJczKUdKIBUyrz2/d9BHU6hpfp6DKYlgfH1hIr5XU5
 CQvUjkem9fIaRR9atRbvtKtokHArjX7H6SA0d+acKx1fSSW2qOOqYhXW9aHDRSSjoYlI
 yNcc3dA9bh17k3UDaQEgruEFezCrz4ScdOT48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=whFUneYINRIgyp8Pel0QMZvhhIk7uCGvvk56hecjsos=;
 b=PRVtqc1ycIfaTQFO+ikMqYrKLu67Gq0JunzCowUuVw6i6+lqDXYya+95OtXNJHme07
 jJIqbImuigOvz4ugYh1NXmvlcDrD9sdr/5MPLHPYXYYHAhI++Gdh+yhWsnBsgVvHC70G
 uhrdheG8Yb+dxVnaxMxAkx+W48Yu4z39MMXiNU9oobftwzan3t/lHlmBG3+E89IA0uNw
 yr2Z2fQN0ss5AjCjJDfIKrBV+i6kHq36XRSi/xf+pNAhhuupqqBsxFLASoLC1V7GV3eV
 Wvylvul4PNsnXLi0LbKA5IVxtLrzz5XSbnsxfrnwdpCOXVmVyhKh38Q80OCwR26qePwO
 j3ww==
X-Gm-Message-State: AOAM533P27q1VhTdE9xc1VrwrPcVauN19o301xPNfX+D8OTs9ah2v0vr
 4K0CCeSY/0Ie0Neq2Fk9O60vzOCz65cyObasMoZ2Xg==
X-Google-Smtp-Source: ABdhPJxHq6W2C4bfcTfl1i4+C3i3IPLXY3z46Q0bCrW2+TLpl/S3gsCeYqNvWaOAioBXZs+O3EZ0lYfp3sZRtNs3f4o=
X-Received: by 2002:a37:644f:: with SMTP id y76mr12978776qkb.194.1625815531525; 
 Fri, 09 Jul 2021 00:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210707075505.2896824-1-stevensd@google.com>
 <YObFbqEk1nGVuHLF@8bytes.org>
 <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
In-Reply-To: <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 9 Jul 2021 16:25:20 +0900
Message-ID: <CAD=HUj43XgXR5MsNzuqdsxPML7wzMGm3XsgXsYSdNATcgDm8bA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To: Robin Murphy <robin.murphy@arm.com>
Cc: David Stevens <stevensd@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

On Fri, Jul 9, 2021 at 2:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-08 10:29, Joerg Roedel wrote:
> > Adding Robin too.
> >
> > On Wed, Jul 07, 2021 at 04:55:01PM +0900, David Stevens wrote:
> >> Add support for per-domain dynamic pools of iommu bounce buffers to the
> >> dma-iommu API. This allows iommu mappings to be reused while still
> >> maintaining strict iommu protection. Allocating buffers dynamically
> >> instead of using swiotlb carveouts makes per-domain pools more amenable
> >> on systems with large numbers of devices or where devices are unknown.
>
> But isn't that just as true for the currently-supported case? All you
> need is a large enough Thunderbolt enclosure and you could suddenly plug
> in a dozen untrusted GPUs all wanting to map hundreds of megabytes of
> memory. If there's a real concern worth addressing, surely it's worth
> addressing properly for everyone.

Bounce buffers consume memory, so there is always going to be some
limitation on how many devices are supported. This patch series limits
the memory consumption at a given point in time to approximately the
amount of active DMA transactions. There's really no way to improve
significantly on that. The 'approximately' qualification could be
removed by adding a shrinker, but that doesn't change things
materially.

This is compared to reusing swiotlb, where the amount of memory
consumed would be the largest amount of active DMA transactions you
want bounce buffers to handle. I see two concrete shortcomings here.
First, most of the time you're not doing heavy IO, especially for
consumer workloads. Second, it raises the problem of per-device
tuning, since you don't want to waste performance by having too few
bounce buffers but you also don't want to waste memory by
preallocating too many bounce buffers. This tuning becomes more
problematic once you start dealing with external devices.

Also, although this doesn't directly address the raised concern, the
bounce buffers are only used for relatively small DMA transactions. So
large allocations like framebuffers won't actually consume extra
memory via bounce buffers.

> >> When enabled, all non-direct streaming mappings below a configurable
> >> size will go through bounce buffers. Note that this means drivers which
> >> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> >> feature is enabled. However, all drivers which work with swiotlb=force
> >> should work.
> >>
> >> Bounce buffers serve as an optimization in situations where interactions
> >> with the iommu are very costly. For example, virtio-iommu operations in
> >> a guest on a linux host require a vmexit, involvement the VMM, and a
> >> VFIO syscall. For relatively small DMA operations, memcpy can be
> >> significantly faster.
>
> Yup, back when the bounce-buffering stuff first came up I know
> networking folks were interested in terms of latency for small packets -
> virtualised IOMMUs are indeed another interesting case I hadn't thought
> of. It's definitely been on the radar as another use-case we'd like to
> accommodate with the bounce-buffering scheme. However, that's the thing:
> bouncing is bouncing and however you look at it it still overlaps so
> much with the untrusted case - there's no reason that couldn't use
> pre-mapped bounce buffers too, for instance - that the only necessary
> difference is really the policy decision of when to bounce. iommu-dma
> has already grown complicated enough, and having *three* different ways
> of doing things internally just seems bonkers and untenable. Pre-map the
> bounce buffers? Absolutely. Dynamically grow them on demand? Yes please!
> Do it all as a special thing in its own NIH module and leave the
> existing mess to rot? Sorry, but no.

I do agree that iommu-dma is getting fairly complicated. Since a
virtualized IOMMU uses bounce buffers much more heavily than
sub-granule untrusted DMA, and for the reasons stated earlier in this
email, I don't think pre-allocated bounce buffers are viable for the
virtualized IOMMU case. I can look at migrating the sub-granule
untrusted DMA case to dynamic bounce buffers, if that's an acceptable
approach.

-David

> Thanks,
> Robin.
>
> >> As a performance comparison, on a device with an i5-10210U, I ran fio
> >> with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
> >> --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
> >> 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> >> spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> >> 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> >> by >99%, as bounce buffers don't require syncing here in the read case.
> >> Running with multiple jobs doesn't serve as a useful performance
> >> comparison because virtio-iommu and vfio_iommu_type1 both have big
> >> locks that significantly limit mulithreaded DMA performance.
> >>
> >> This patch set is based on v5.13-rc7 plus the patches at [1].
> >>
> >> David Stevens (4):
> >>    dma-iommu: add kalloc gfp flag to alloc helper
> >>    dma-iommu: replace device arguments
> >>    dma-iommu: expose a few helper functions to module
> >>    dma-iommu: Add iommu bounce buffers to dma-iommu api
> >>
> >>   drivers/iommu/Kconfig          |  10 +
> >>   drivers/iommu/Makefile         |   1 +
> >>   drivers/iommu/dma-iommu.c      | 119 ++++--
> >>   drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
> >>   drivers/iommu/io-buffer-pool.h |  91 +++++
> >>   include/linux/dma-iommu.h      |  12 +
> >>   6 files changed, 861 insertions(+), 28 deletions(-)
> >>   create mode 100644 drivers/iommu/io-buffer-pool.c
> >>   create mode 100644 drivers/iommu/io-buffer-pool.h
> >>
> >> --
> >> 2.32.0.93.g670b81a890-goog
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
