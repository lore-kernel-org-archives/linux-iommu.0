Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2FC433F2
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D25206D5
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEe2issc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D25206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4464889BF7;
	Wed, 15 Jul 2020 09:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AvHbJHONYGAf; Wed, 15 Jul 2020 09:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 598F78927B;
	Wed, 15 Jul 2020 09:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC22C07FF;
	Wed, 15 Jul 2020 09:04:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57B96C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 09:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4875D884FC
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 09:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yw4eWjeX1WwC for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 09:04:51 +0000 (UTC)
X-Greylist: delayed 05:21:05 by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4EE598998C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 09:04:51 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id q74so1486995iod.1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q4dxg/x+C61ezLjqHNaCCzjzXw07QWDdBXsi9fVkAUU=;
 b=YEe2issca20y2/l73T3sa81rOD0zgi1OUm8I/tbIAEmNaSjKhPdRRwJBKafc2gc3jk
 xDQYds+jIMarrr7rQWr59jGk4zxqH1Wu2H5gqoNbIV8k/iPjTfSnbsRa7W3NEOcMK3up
 2LgACIRQucnwj+gcTH6lQJtscwwtIK86qjmEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q4dxg/x+C61ezLjqHNaCCzjzXw07QWDdBXsi9fVkAUU=;
 b=rwRVXRa3/JkLBvwr77gmp0x9CLqXcwOyzU490UOx+RN2ef3fMm68A5PV2mYF48TBMe
 nUveoFxV32DiffDgag7IVZX5kS+Qu4llU7l8f5vXDcWD+bTkfAlf5n5ZeRqp/NFzPoYg
 g5foktxIkAZRmS5Qnj2LTeYLl+f/rTwBUMOpW6c/EqXgpdKY9AZc/Kmp+FoeYhxhZDMA
 bg28kMsbC5aAT3yMFJxJmWqE3L3QWLxkxrzQW6lhDlw7MuG6uwXB04A8/cR77rKcW5Zz
 l1ehdAwLHv9aG1leTSaKK8QI9OwTikO7P9nH2UMmVhfJiNMTkD388hPnuO0K7IOJy4ko
 Q1fg==
X-Gm-Message-State: AOAM532iBCS7Z+30UCWY9szdCr+hjwoZLZ4bohwcQnlf7PXX9ZaaVgf3
 0Y9OtMQxl2SUIMydULNGV9OziraYr9s=
X-Google-Smtp-Source: ABdhPJzrAdDHgP3bx7L0UdlyZi+t4otVW0ZSCBV+eWzEWtgHj0XsEIXa58MeTBSFAUivRiGemcq0iw==
X-Received: by 2002:a02:8308:: with SMTP id v8mr10468145jag.101.1594803889892; 
 Wed, 15 Jul 2020 02:04:49 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com.
 [209.85.166.172])
 by smtp.gmail.com with ESMTPSA id d6sm813456ilq.27.2020.07.15.02.04.48
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 02:04:48 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id k6so1337070ili.6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 02:04:48 -0700 (PDT)
X-Received: by 2002:a92:de42:: with SMTP id e2mr8593960ilr.189.1594803887732; 
 Wed, 15 Jul 2020 02:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <20200713091211.2183368-2-tientzu@chromium.org>
 <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
 <20200714110141.GD16178@lst.de>
 <CALiNf2-9b5LMjv+KCqFJ9oz2FocT6oQ1zVY_MBaFgNG1DQxZ=Q@mail.gmail.com>
In-Reply-To: <CALiNf2-9b5LMjv+KCqFJ9oz2FocT6oQ1zVY_MBaFgNG1DQxZ=Q@mail.gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Wed, 15 Jul 2020 17:04:36 +0800
X-Gmail-Original-Message-ID: <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
Message-ID: <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
To: Christoph Hellwig <hch@lst.de>
Cc: Nicolas Boichat <drinkcat@chromium.org>, devicetree@vger.kernel.org,
 heikki.krogerus@linux.intel.com, Saravana Kannan <saravanak@google.com>,
 suzuki.poulose@arm.com, Robin Murphy <robin.murphy@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, dan.j.williams@intel.com,
 treding@nvidia.com, frowand.list@gmail.com
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

On Wed, Jul 15, 2020 at 11:46 AM Claire Chang <tientzu@chromium.org> wrote:
>
> On Tue, Jul 14, 2020 at 7:01 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Jul 13, 2020 at 12:55:43PM +0100, Robin Murphy wrote:
> > > On 2020-07-13 10:12, Claire Chang wrote:
> > >> The bounced DMA ops provide an implementation of DMA ops that bounce
> > >> streaming DMA in and out of a specially allocated region. Only the
> > >> operations relevant to streaming DMA are supported.
> > >
> > > I think there are too many implicit assumptions here - apparently that
> > > coherent allocations will always be intercepted by
> > > dma_*_from_dev_coherent(), and that calling into dma-direct won't actually
> > > bounce things a second time beyond where you thought they were going,
> > > manage coherency for a different address, and make it all go subtly wrong.
> > > Consider "swiotlb=force", for instance...
If I understand it correctly, reusing SWIOTLB won't prevent the
coherent allocations
from always being intercepted by dma_*_from_dev_coherent(), right?
Since we can't bounce the coherent memory, we still need to rely on
dma_*_from_dev_coherent() and a reserved-memory region for coherent DMA to
restrict the device DMA access.

As for calling into dma-direct, in this version, I use set_dma_ops to set the
dma_bounced_ops, so I just bypass dma-direct and SWIOTLB. "swiotlb=force"
won't bounce things a second time and the data will still be bounced
to the region
set in dts.
Besides, I did a quick search and found that only two *-iommu.c directly use
dma_direct_map_page.
https://elixir.bootlin.com/linux/latest/C/ident/dma_direct_map_page
Since bounced DMA is to mitigate the lack of DMA access control on systems
without an IOMMU (see patch#4, only call of_dma_set_bounce_buffer for the
devices not behind an IOMMU), can we assume no one will use dma-direct?
(I understand that if we build bounced DMA on top of SWIOTLB, we don't need
to worry about this.)

> > >
> > > Again, plumbing this straight into dma-direct so that SWIOTLB can simply
> > > target a different buffer and always bounce regardless of masks would seem
> > > a far better option.
> >
> > I haven't really had time to read through the details, but I agree that
> > any bouncing scheme should reuse the swiotlb code and not invent a
> > parallel infrastructure.
> Thanks for the feedback. I'll try to reuse SWIOTLB.
My current plan is to first change the buffers management logic in SWIOTLB to
use gen_pool like this patch (i.e., gen_pool_dma_alloc, gen_pool_free, ect), and
then make SWIOTLB use the device's private pool for regular DMA to/from system
memory if possible.
Does this sound right?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
