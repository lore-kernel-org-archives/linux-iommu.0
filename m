Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D19C433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 08:44:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C35613CD
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 08:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C35613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 797B660602;
	Mon, 10 May 2021 08:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RyQmqmTiAtSn; Mon, 10 May 2021 08:44:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77150605F5;
	Mon, 10 May 2021 08:44:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48E4AC000D;
	Mon, 10 May 2021 08:44:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44515C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C5DA83DCB
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AeDo_Es32adl for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 08:44:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 978B783DBF
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:44:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 446F667373; Mon, 10 May 2021 10:44:06 +0200 (CEST)
Date: Mon, 10 May 2021 10:44:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] swiotlb: manipulate orig_addr when tlb_addr has offset
Message-ID: <20210510084406.GA1093@lst.de>
References: <CGME20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55@epcas2p2.samsung.com>
 <20210510083057.46476-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210510083057.46476-1-chanho61.park@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Bumyong Lee <bumyong.lee@samsung.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, May 10, 2021 at 05:30:57PM +0900, Chanho Park wrote:
> +static unsigned int swiotlb_align_offset(struct device *dev, u64 addr);

Please just move swiotlb_align_offset up to avoid the forward declaration.

>  /*
>   * Bounce: copy the swiotlb buffer from or back to the original dma location
>   */
> @@ -346,10 +347,17 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  	size_t alloc_size = mem->slots[index].alloc_size;
>  	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> +	unsigned int tlb_offset;
>  
>  	if (orig_addr == INVALID_PHYS_ADDR)
>  		return;
>  
> +	tlb_offset = (unsigned int)tlb_addr & (IO_TLB_SIZE - 1);
> +	tlb_offset -= swiotlb_align_offset(dev, orig_addr);

Nit: I'd write this as:

	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
			swiotlb_align_offset(dev, orig_addr);

as there is no need for the cast, and just having a single assignment
is easier to follow.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
