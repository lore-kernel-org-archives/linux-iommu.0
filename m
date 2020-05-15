Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE47C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:10:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D4E20657
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D4E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C63DF1FEAB;
	Fri, 15 May 2020 12:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7AIsAE2ecMF; Fri, 15 May 2020 12:10:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 193142E672;
	Fri, 15 May 2020 12:10:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F40F9C0178;
	Fri, 15 May 2020 12:10:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72619C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6148089A37
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vh2HWS3QFTmp for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 12:10:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 24BCD89702
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:10:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83423D6E;
 Fri, 15 May 2020 05:10:29 -0700 (PDT)
Received: from [10.57.27.64] (unknown [10.57.27.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD3ED3F305;
 Fri, 15 May 2020 05:10:26 -0700 (PDT)
Subject: Re: Constantly map and unmap of streaming DMA buffers with IOMMU
 backend might cause serious performance problem
To: Song Bao Hua <song.bao.hua@hisilicon.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "dagum@barrel.engr.sgi.com" <dagum@barrel.engr.sgi.com>,
 "ralf@oss.sgi.com" <ralf@oss.sgi.com>,
 "grundler@cup.hp.com" <grundler@cup.hp.com>,
 "Jay.Estabrook@compaq.com" <Jay.Estabrook@compaq.com>,
 "sailer@ife.ee.ethz.ch" <sailer@ife.ee.ethz.ch>,
 "andrea@suse.de" <andrea@suse.de>,
 "jens.axboe@oracle.com" <jens.axboe@oracle.com>,
 "davidm@hpl.hp.com" <davidm@hpl.hp.com>
References: <B926444035E5E2439431908E3842AFD249F263@DGGEMI525-MBS.china.huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <36d67d68-4381-c7a7-dcf1-6383bd9ae0ad@arm.com>
Date: Fri, 15 May 2020 13:10:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD249F263@DGGEMI525-MBS.china.huawei.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-05-15 09:19, Song Bao Hua wrote:
[ snip... nice analysis, but ultimately it's still "doing stuff has more 
overhead than not doing stuff" ]

> I am thinking several possible ways on decreasing or removing the latency of DMA map/unmap for every single DMA transfer. Meanwhile, "non-strict" as an existing option with possible safety issues, I won't discuss it in this mail.

But passthrough and non-strict mode *specifically exist* for the cases 
where performance is the most important concern - streaming DMA with an 
IOMMU in the middle has an unavoidable tradeoff between performance and 
isolation, so dismissing that out of hand is not a good way to start 
making this argument.

> 1. provide bounce coherent buffers for streaming buffers.
> As the coherent buffers keep the status of mapping, we can remove the overhead of map and unmap for each single DMA operations. However, this solution requires memory copy between stream buffers and bounce buffers. Thus it will work only if copy is faster than map/unmap. Meanwhile, it will consume much more memory bandwidth.

I'm struggling to understand how that would work, can you explain it in 
more detail?

> 2.make upper-layer kernel components aware of the pain of iommu map/unmap
> upper-layer fs, mm, networks can somehow let the lower-layer drivers know the end of the life cycle of sg buffers. In zswap case, I have seen zswap always use the same 2 pages as the destination buffers to save compressed page, but the compressor driver still has to constantly map and unmap those same two pages for every single compression since zswap and zip drivers are working in two completely different software layers.
> 
> I am thinking some way as below, upper-layer kernel code can call:
> sg_init_table(&sg...);
> sg_mark_reusable(&sg....);
> .... /* use the buffer many times */
> ....
> sg_mark_stop_reuse(&sg);
> 
> After that, if low level drivers see "reusable" flag, it will realize the buffer can be used multiple times and will not do map/unmap every time. it means upper-layer components will further use the buffers and the same buffers will probably be given to lower-layer drivers for new DMA transfer later. When upper-layer code sets " stop_reuse", lower-layer driver will unmap the sg buffers, possibly by providing a unmap-callback to upper-layer components. For zswap case, I have seen the same buffers are always re-used and zip driver maps and unmaps it again and again. Shortly after the buffer is unmapped, it will be mapped in the next transmission, almost without any time gap between unmap and map. In case zswap can set the "reusable" flag, zip driver will save a lot of time.
> Meanwhile, for the safety of buffers, lower-layer drivers need to make certain the buffers have already been unmapped in iommu before those buffers go back to buddy for other users.

That sounds like it would only have benefit in a very small set of 
specific circumstances, and would be very difficult to generalise to 
buffers that are mapped via dma_map_page() or dma_map_single(). 
Furthermore, a high-level API that affects a low-level driver's 
interpretation of mid-layer API calls without the mid-layer's knowledge 
sounds like a hideous abomination of anti-design. If a mid-layer API 
lends itself to inefficiency at the lower level, it would seem a lot 
cleaner and more robust to extend *that* API for stateful buffer reuse. 
Failing that, it might possibly be appropriate to approach this at the 
driver level - many of the cleverer network drivers already implement 
buffer pools to recycle mapped SKBs internally, couldn't the "zip 
driver" simply try doing something like that for itself?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
