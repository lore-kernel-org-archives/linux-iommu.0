Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301DC07E9B
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 06:05:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6724461154
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 06:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6724461154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F6EC83BDD;
	Fri,  9 Jul 2021 06:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-zMmD3ttJbj; Fri,  9 Jul 2021 06:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F04283BE1;
	Fri,  9 Jul 2021 06:05:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF2E3C001A;
	Fri,  9 Jul 2021 06:05:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C350DC000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 06:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B516C401F1
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 06:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hL7A1MGeGIV5 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 06:04:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78FD5401E1
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 06:04:59 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id t19so8267564qkg.7
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qbF8puKkycWClRXOTMf8YBIUmvBH80QaLUrpTjvl4Wo=;
 b=Q9CN4y8kuYDyjjOinrLIbhrvsuG7oG8xznHByjxf7T6tNxNXedt3vo8/b+nOld6Z6E
 6X78DZQnUTwmloAZY3YTXydI4GW1oxTuzwDyPQqvnB9Q6Uxht1SC2jowH7Cmku/d5oMf
 eDhKDKwD4fZVhcVC75j2s0T1QKrQ4BHezUNas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qbF8puKkycWClRXOTMf8YBIUmvBH80QaLUrpTjvl4Wo=;
 b=GZBk6Yr+NF1LIz1RgHqYpmacpXTWIQmBaEEedY8dzRcTSLIDVVR1x+4AVaW+LeDmzD
 fUzjfW7EYGo4vnWMIywN6aJ3QoK3C/CBlvFn7kFtP+PYNNYNp1dGhVhjZsTVGzO3pYA6
 VLEiHjpVeTxeHxLCnRNNOWF51jZOyBzR8aML9LTwvyl5a9ooZ78PrXrGgcpT1NiIAGTS
 TOP8YU6oysAE5BY3u672unFm493RCcYFnSjYs5sMQ2xWepPTYhWwSEyOYFA1K2kz4Hve
 gpvQ3dauAscLdR//RKb/fog/TKTHLDH1tKSQaBy8fo/33T6Zm/PK2MM5qsQXT2vS7uDm
 lr6A==
X-Gm-Message-State: AOAM531tDwToRBK8fVox9+Mb9aOJpKxAS5ieFyvnXyHjs62O0prnoHge
 V3Kg7k3jU5bw5t0HA/WhIyi0Qt+Nq8XI6ekJnHH4Pg==
X-Google-Smtp-Source: ABdhPJzYRtOtlgcYODkz4IVS1aZUXFd9F9pL1mZ0QQltwB0/i6BSAvKZrGbRNpALxP8Btapj/TMghujFB2eKQ2QcKHI=
X-Received: by 2002:a05:620a:208e:: with SMTP id
 e14mr13571848qka.328.1625810698435; 
 Thu, 08 Jul 2021 23:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210707075505.2896824-1-stevensd@google.com>
 <f6541f4e-648e-d9a0-eda7-b2a117978ebb@linux.intel.com>
In-Reply-To: <f6541f4e-648e-d9a0-eda7-b2a117978ebb@linux.intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 9 Jul 2021 15:04:47 +0900
Message-ID: <CAD=HUj4_mtTPbXBqQke=Q+zK0EuJZEeWOiVkhphAUfvK-DMHVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To: Lu Baolu <baolu.lu@linux.intel.com>
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

On Thu, Jul 8, 2021 at 10:38 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi David,
>
> I like this idea. Thanks for proposing this.
>
> On 2021/7/7 15:55, David Stevens wrote:
> > Add support for per-domain dynamic pools of iommu bounce buffers to the
> > dma-iommu API. This allows iommu mappings to be reused while still
> > maintaining strict iommu protection. Allocating buffers dynamically
> > instead of using swiotlb carveouts makes per-domain pools more amenable
> > on systems with large numbers of devices or where devices are unknown.
>
> Have you ever considered leveraging the per-device swiotlb memory pool
> added by below series?
>
> https://lore.kernel.org/linux-iommu/20210625123004.GA3170@willie-the-truck/

I'm not sure if that's a good fit. The swiotlb pools are allocated
during device initialization, so they require setting aside the
worst-case amount of memory. That's okay if you only use it with a
small number of devices where you know in advance approximately how
much memory they use. However, it doesn't work as well if you want to
use it with a large number of devices, or with unknown (i.e.
hotplugged) devices.

> >
> > When enabled, all non-direct streaming mappings below a configurable
> > size will go through bounce buffers. Note that this means drivers which
> > don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> > feature is enabled. However, all drivers which work with swiotlb=force
> > should work.
>
> If so, why not making it more scalable by adding a callback into vendor
> iommu drivers? The vendor iommu drivers have enough information to tell
> whether the bounce buffer is feasible for a specific domain.

I'm not very familiar with the specifics of VT-d or restrictions with
the graphics hardware, but at least on the surface it looks like a
limitation of the i915 driver's implementation. The driver uses the
DMA_ATTR_SKIP_CPU_SYNC flag, but never calls the dma_sync functions,
since things are coherent on x86 hardware. However, bounce buffers
violate the driver's assumption that there's no need to sync the CPU
and device domain. I doubt there's an inherent limitation of the
hardware here, it's just how the driver is implemented. Given that, I
don't know if it's something the iommu driver needs to handle.

One potential way this could be addressed would be to add explicit
support to the DMA API for long-lived streaming mappings. Drivers can
get that behavior today via DMA_ATTR_SKIP_CPU_SYNC and dma_sync.
However, the DMA API doesn't really have enough information to treat
ephemeral and long-lived mappings differently. With a new DMA_ATTR
flag for long-lived streaming mappings, the DMA API could skip bounce
buffers. That flag could also be used as a performance optimization in
the various dma-buf implementations, since they seem to mostly fall
into the long-lived streaming category (the handful I checked do call
dma_sync, so there isn't a correctness issue).

-David

> >
> > Bounce buffers serve as an optimization in situations where interactions
> > with the iommu are very costly. For example, virtio-iommu operations in
>
> The simulated IOMMU does the same thing.
>
> It's also an optimization for bare metal in cases where the strict mode
> of cache invalidation is used. CPU moving data is faster than IOMMU
> cache invalidation if the buffer is small.
>
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
