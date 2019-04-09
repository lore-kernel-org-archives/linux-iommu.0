Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECDC282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:15:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1E52084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1E52084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2443DDDE;
	Tue,  9 Apr 2019 17:15:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D623ADD2
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:15:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7651676D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:15:24 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D056B68B02; Tue,  9 Apr 2019 19:15:11 +0200 (CEST)
Date: Tue, 9 Apr 2019 19:15:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Message-ID: <20190409171511.GC14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-8-hch@lst.de>
	<67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190409171511.r60tx1ZXwaofAADWH0sfMAj1j88evNrl3z_c2gETSo4@z>

On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>> +static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>> +		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
>> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
>
> That wants to be iommu_get_dma_domain() there to minimise the overhead. In 
> fact, I guess this could now be streamlined a bit in the style of 
> iommu_dma_map_page() above - i.e. avoid doing a second domain lookup in the 
> sync case - but that can happen later (if indeed you haven't already).

Yes, this should be iommu_get_dma_domain - this got lost during
a rebase to the kernel version that changed to the iommu_get_dma_domain
calls.

I don't think I've optimized to remove the additional call, but
I can easily throw in another patch to do that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
