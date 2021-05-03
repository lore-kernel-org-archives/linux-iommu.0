Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB47C433B4
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:18:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129FC611AE
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129FC611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A431560B49;
	Mon,  3 May 2021 16:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dScFZ_p2MH_n; Mon,  3 May 2021 16:18:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 852CA60B42;
	Mon,  3 May 2021 16:18:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E021C000D;
	Mon,  3 May 2021 16:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C432EC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E0E1404AC
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ZPKDBjKecZC for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:18:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE9B54048B
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=zpY/fJwiTYldq+5hs6TbypeBMb6zUV0s0vLmpskG04k=; b=pkb2zK8Il7Fl1zuBZC/q3SC3Cd
 7YpIyTbYD5ArSwja0Du1alZ6wxXknauDJa5gQefrBFpUDnb5HOkexw7Vnkiv3s80VnUfChHge2veP
 HigvYe2Q7LL+u3rGq88FG8rmG6J+cAWOl1+elxhErP4yGqO9REkBLDd8rgrqpLw80fzMbyPuWAi+5
 1rjFUbXe713a32P7pH41AXYwStrIiwdQE+omBHfLG4g5rwhRF9hnAZ95Y9Q1ZUt19Fx+F8azFgmWH
 1OSUPXAs0XAPIEJz8onfLNZMct4ovyldMBLSDc0LXqamxhR5FvXNUijOApsUaUAwK/twIMxjDW+wU
 0A8CPAgg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldbGj-0003tB-97; Mon, 03 May 2021 10:18:02 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
Date: Mon, 3 May 2021 10:17:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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



On 2021-05-02 1:58 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Attempt to find the mapping type for P2PDMA pages on the first
>> DMA map attempt if it has not been done ahead of time.
>>
>> Previously, the mapping type was expected to be calculated ahead of
>> time, but if pages are to come from userspace then there's no
>> way to ensure the path was checked ahead of time.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 473a08940fbc..2574a062a255 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -825,11 +825,18 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>>   static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
>>   						    struct pci_dev *client)
>>   {
>> +	enum pci_p2pdma_map_type ret;
>> +
>>   	if (!provider->p2pdma)
>>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>>   
>> -	return xa_to_value(xa_load(&provider->p2pdma->map_types,
>> -				   map_types_idx(client)));
>> +	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
>> +				  map_types_idx(client)));
>> +	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
>> +		return ret;
>> +
>> +	return upstream_bridge_distance_warn(provider, client, NULL,
>> +					     GFP_ATOMIC);
> 
> Returning a "bridge distance" from a "get map type" routine is jarring,
> and I think it is because of a pre-existing problem: the above function
> is severely misnamed. Let's try renaming it (and the other one) to
> approximately:
> 
>      upstream_bridge_map_type_warn()
>      upstream_bridge_map_type()
> 
> ...and that should fix that. Well, that, plus tweaking the kernel doc
> comments, which are also confused. I think someone started off thinking
> about distances through PCIe, but in the end, the routine boils down to
> just a few situations that are not distances at all.
> 
> Also, the above will read a little better if it is written like this:
> 
> 	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
> 				  map_types_idx(client)));
> 
> 	if (ret == PCI_P2PDMA_MAP_UNKNOWN)
> 		ret = upstream_bridge_map_type_warn(provider, client, NULL,
> 						    GFP_ATOMIC);
> 	
> 	return ret;
> 
> 
>>   }

I agree that some of this has evolved in a way that some of the names
are a bit odd now. Could definitely use a cleanup, but that's not really
part of this series. When I have some time I can look at doing a cleanup
series to help with some of this.

>>   static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>> @@ -877,7 +884,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   	case PCI_P2PDMA_MAP_BUS_ADDR:
>>   		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>>   	default:
>> -		WARN_ON_ONCE(1);
> 
> Why? Or at least, why, in this patch? It looks like an accidental
> leftover from something, seeing as how it is not directly related to the
> patch, and is not mentioned at all.

Before this patch, it was required that users of P2PDMA call
pci_p2pdma_distance_many() in some form before calling
pci_p2pdma_map_sg(). So, by convention, a usable map type had to already
be in the cache. The warning was there to yell at anyone who wrote code
that violated that convention.

This patch removes that convention and allows users to map P2PDMA pages
sight unseen and if the mapping type isn't in the cache, then it will
determine the mapping type at dma mapping time. Thus, the warning can be
removed and the function can fail normally if the mapping is unsupported.

Logan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
