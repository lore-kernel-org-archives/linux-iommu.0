Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0978C433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:25:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5500161053
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5500161053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D60780CF7;
	Tue,  9 Nov 2021 14:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VboTGU0KemRq; Tue,  9 Nov 2021 14:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E4ED80F13;
	Tue,  9 Nov 2021 14:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCC0EC0012;
	Tue,  9 Nov 2021 14:25:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25519C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D8D40332
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5__stszB080 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 14:25:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FD3F400AA
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:25:35 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 73FF167373; Tue,  9 Nov 2021 15:25:32 +0100 (CET)
Date: Tue, 9 Nov 2021 15:25:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/10] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Message-ID: <20211109142532.GD23489@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-6-hch@lst.de>
 <b0c11b91-36d6-e794-9efa-46cdf7a741b1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0c11b91-36d6-e794-9efa-46cdf7a741b1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 David Rientjes <rientjes@google.com>
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

On Thu, Nov 04, 2021 at 12:36:16PM +0000, Robin Murphy wrote:
>> -		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>> -		/* return the page pointer as the opaque cookie */
>> -		return page;
>> -	}
>> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>
> Hmm, does force_dma_unencrypted() actually matter if the caller doesn't 
> want to access the buffer itself? Presumably any subsequent mmap() to 
> userspace would still do the right thing?

Well, force_dma_unencrypted is a bit misnamed I think.  It is mostly
used to force bounce buffering for protected guest schemes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
