Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69778C04E87
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 17:27:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DA7217D9
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 17:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DA7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E1F8C6D;
	Tue, 21 May 2019 17:27:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0551FC6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 17:27:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 97B0B881
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 17:27:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CE0374;
	Tue, 21 May 2019 10:27:54 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5113F718;
	Tue, 21 May 2019 10:27:51 -0700 (PDT)
Subject: Re: Device obligation to write into a DMA_FROM_DEVICE streaming DMA
	mapping
To: Horia Geanta <horia.geanta@nxp.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <VI1PR0402MB348537CB86926B3E6D1DBE0A98070@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <584b54f6-bd12-d036-35e6-23eb2dabe811@arm.com>
Date: Tue, 21 May 2019 18:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB348537CB86926B3E6D1DBE0A98070@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 21/05/2019 18:14, Horia Geanta wrote:
> Hi,
> 
> Is it mandatory for a device to write data in an area DMA mapped DMA_FROM_DEVICE?
> Can't the device just "ignore" that mapping - i.e. not write anything - and
> driver should expect original data to be found in that location (since it was
> not touched / written to by the device)?
> [Let's leave cache coherency aside, and consider "original data" to be in RAM.]
> 
> I am asking this since I am seeing what seems to be an inconsistent behavior /
> semantics between cases when swiotlb bouncing is used and when it's not.
> 
> Specifically, the context is:
> 1. driver prepares a scatterlist with several entries and performs a
> dma_map_sg() with direction FROM_DEVICE
> 2. device decides there's no need to write into the buffer pointed by first
> scatterlist entry and skips it (writing into subsequent buffers)
> 3. driver is notified the device finished processing and dma unmaps the scatterlist
> 
> When swiotlb bounce is used, the buffer pointed to by first scatterlist entry is
> corrupted. That's because swiotlb implementation expects the device to write
> something into that buffer, however the device logic is "whatever was previously
> in that buffer should be used" (2. above).
> 
> For FROM_DEVICE direction:
> -swiotlb_tbl_map_single() does not copy data from original location to swiotlb
> 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
> -swiotlb_tbl_unmap_single() copies data from swiotlb to original location
> 	if (orig_addr != INVALID_PHYS_ADDR &&
> 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
> 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
> and when device did not write anything (as in current situation), it overwrites
> original data with zeros
> 
> In case swiotlb bounce is not used and device does not write into the
> FROM_DEVICE streaming DMA maping, the original data is available.
> 
> Could you please clarify whether:
> -I am missing something obvious OR
> -the DMA API documentation should be updated - to mandate for device writes into
> FROM_DEVICE mappings) OR
> -the swiotlb implementation should be updated - to copy data from original
> location irrespective of DMA mapping direction?

Hmm, that certainly feels like a bug in SWIOTLB - it seems reasonable in 
principle for a device to only partially update a mapped buffer before a 
sync/unmap, so I'd say it probably should be filling the bounce buffer 
with the original data at the start, regardless of direction.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
