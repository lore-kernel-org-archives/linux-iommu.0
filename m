Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CBFC10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1320B1F
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 888F8D7A;
	Mon, 22 Apr 2019 18:11:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1FE31D38
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:11:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F9CD829
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:11:16 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 1434668AFE; Mon, 22 Apr 2019 20:11:01 +0200 (CEST)
Date: Mon, 22 Apr 2019 20:11:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: laurentiu.tudor@nxp.com
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Message-ID: <20190422181100.GB32490@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	hch@lst.de, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422181100.elx0ZzxZQn-AUc7aX8mRnHvIWV-oAnOKWiSYCJ80H44@z>

On Mon, Apr 22, 2019 at 07:51:25PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> If possible / available call into the DMA API to get a proper iommu
> mapping and a dma address for the newly allocated coherent dma memory.

I don't think this is so simple.  The original use case of
dma_declare_coherent_memory was memory that is local to a device, where
we copy in data through a MMIO mapping and the device can then access
it.  This use case still seems to be alive in the ohci-sm501 and
ohci-tmio drivers.  Going through the iommu in those cases would be
counter productive.

The other use cases, including the OF ones seem to be (and Marek who
added that support should correct me if I'm wrong) normal host DRAM
that is just set aside for the device.

So if we want to support these prealloc pools with an iommu we need to
split the use cases.  I have to say I really hate the way we do the DMA
"coherent" allocations, so I'm all in favor of that, it just hasn't
bubbled up towards the front of my todo list yet.

My highlevel plan here would be:

 a) move the two OHCI drivers away from our current DMA declare
    coherent code, and just use a trivial genalloc allocator for
    their MMIO space, given that the USB layer already wraps the
    dma_alloc/free APIs anyway
 b) move the rest of the DMA coherent stuff into the actual dma
    map ops, similar to how we handle CMA allocations.  In fact
    we should probably do this by a new page allocation helper
    that tries CMA, "coherent" or the page allocator as fallback
 b) also merge the OF-side handling of CMA vs "coherent" into a
    single implementation.  Preferably dropping the misleading
    "coherent" name while we are at it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
