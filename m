Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E9C433E4
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 05:02:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0622D20758
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 05:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0622D20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B762687D2D;
	Thu, 20 Aug 2020 05:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMbFMyQQ6tuI; Thu, 20 Aug 2020 05:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 96C8A87D22;
	Thu, 20 Aug 2020 05:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4814DC0889;
	Thu, 20 Aug 2020 05:02:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44EDAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 05:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 327AE867A5
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 05:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HO7arMuU_aTQ for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 05:02:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9AC85865E0
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 05:02:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7DCC068BEB; Thu, 20 Aug 2020 07:02:14 +0200 (CEST)
Date: Thu, 20 Aug 2020 07:02:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
Message-ID: <20200820050214.GA4815@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com>
 <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <2b32f1d8-16f7-3352-40a5-420993d52fb5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b32f1d8-16f7-3352-40a5-420993d52fb5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>
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

On Wed, Aug 19, 2020 at 03:07:04PM +0100, Robin Murphy wrote:
>> FWIW, I asked back in time what the plan is for non-coherent
>> allocations and it seemed like DMA_ATTR_NON_CONSISTENT and
>> dma_sync_*() was supposed to be the right thing to go with. [2] The
>> same thread also explains why dma_alloc_pages() isn't suitable for the
>> users of dma_alloc_attrs() and DMA_ATTR_NON_CONSISTENT.
>
> AFAICS even back then Christoph was implying getting rid of NON_CONSISTENT 
> and *replacing* it with something streaming-API-based - i.e. this series - 
> not encouraging mixing the existing APIs. It doesn't seem impossible to 
> implement a remapping version of this new dma_alloc_pages() for 
> IOMMU-backed ops if it's really warranted (although at that point it seems 
> like "non-coherent" vb2-dc starts to have significant conceptual overlap 
> with vb2-sg).

You can alway vmap the returned pages from dma_alloc_pages, but it will
make cache invalidation hell - you'll need to use
invalidate_kernel_vmap_range and flush_kernel_vmap_range to properly
handle virtually indexed caches.

Or with remapping you mean using the iommu do de-scatter/gather?

You can implement that trivially implement it yourself for the iommu
case:

{
	merge_boundary = dma_get_merge_boundary(dev);
	if (!merge_boundary || merge_boundary > chunk_size - 1) {
		/* can't coalesce */
		return -EINVAL;
	}

	
	nents = DIV_ROUND_UP(total_size, chunk_size);
	sg = sgl_alloc();
	for_each_sgl() {
		sg->page = __alloc_pages(get_order(chunk_size))
		sg->len = chunk_size;
	}
	dma_map_sg(sg, DMA_ATTR_SKIP_CPU_SYNC);
	// you are guaranteed to get a single dma_addr out
}

Of course this still uses the scatterlist structure with its annoying
mix of input and output parametes, so I'd rather not expose it as
an official API at the DMA layer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
