Return-Path: <SRS0=hF+p=NZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD254C433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 16:16:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5D361051
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 16:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A5D361051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rosenzweig.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 170E2426BC;
	Fri,  3 Sep 2021 16:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_yNp5qgoQNn; Fri,  3 Sep 2021 16:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCF25426C1;
	Fri,  3 Sep 2021 16:16:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0C78C0010;
	Fri,  3 Sep 2021 16:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 039A3C000E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 16:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D33054073D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 16:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vCxDmkOotSCg for <iommu@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 16:16:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24497400C7
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 16:16:55 +0000 (UTC)
Date: Fri, 3 Sep 2021 09:11:14 -0400
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/8] iommu/dma: Disable get_sgtable for granule >
 PAGE_SIZE
Message-ID: <YTIe8t8ImNfZtAyO@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev>
 <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
 <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
 <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Sven Peter <iommu@lists.linux-foundation.org>,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>
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

> > On the IOMMU API level you have much more information available about the actual
> > hardware and can prepare the buffers in a way that makes both devices happy.
> > That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
> > can actually guarantee to map the entire list to a single contiguous IOVA block.
> 
> Essentially there are two reasonable options, and doing pretend dma-buf
> export/import between two devices effectively owned by the same driver is
> neither of them. Handily, DRM happens to be exactly where all the precedent
> is, too; unsurprisingly this is not a new concern.
> 
> One is to go full IOMMU API, like rockchip or tegra, attaching the relevant
> devices to your own unmanaged domain(s) and mapping pages exactly where you
> choose. You still make dma_map/dma_unmap calls for the sake of cache
> maintenance and other housekeeping on the underlying memory, but you ignore
> the provided DMA addresses in favour of your own IOVAs when it comes to
> programming the devices.

I guess this is the way to go for DCP.

> The lazier option if you can rely on all relevant devices having equal DMA
> and IOMMU capabilities is to follow exynos, and herd the devices into a
> common default domain. Instead of allocating you own domain, you grab the
> current domain for one device (which will be its default domain) and
> manually attach the other devices to that. Then you forget all about IOMMUs
> but make sure to do all your regular DMA API calls using that first device,
> and the DMA addresses which come back should be magically valid for the
> other devices too. It was a bit of a cheeky hack TBH, but I'd still much
> prefer more of that over any usage of get_sgtable outside of actual
> dma-buf...

It'd probably be *possible* to get away with this for DCP but it'd
probably involve more hacks, since the DARTs are not 100% symmetric and
there are some contraints on the different DARTs involved.

It'd also be less desirable -- there is no reason for the display
coprocessor to know the actual *contents* of the framebuffer, only the
IOVA valid only for the actual display hardware. These are two devices
in hardware with two independent DARTs, by modeling as such we reduce
the amount we need to trust the coprocessor firmware blob.

> Note that where multiple IOMMU instances are involved, the latter approach
> does depend on the IOMMU driver being able to support sharing a single
> domain across them; I think that might sort-of-work for DART already, but
> may need a little more attention.

I think this already works (for USB-C).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
