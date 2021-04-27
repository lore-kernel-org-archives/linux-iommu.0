Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B3C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:50:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9203760FF1
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9203760FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4956F83BCE;
	Tue, 27 Apr 2021 22:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HteydWduR_GI; Tue, 27 Apr 2021 22:50:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E893983BD2;
	Tue, 27 Apr 2021 22:50:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23BAC001C;
	Tue, 27 Apr 2021 22:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89D46C0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 850C0403FB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9-VVp9y5AaL for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 22:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 949934002B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=PBZp6uxAp8nlNU5Rm16hkR47Rwe8xrGWtpeD+dKWkk4=; b=c2SnI7NAl3/gr4SFEOqWfEjO9J
 1JGnC7Zf5KDX7iHl6Y4Xf/2xqN/Sf5EK4N3LedlbB9Fd00L3W9uy4hRpaf9AzRR6bhJRwlUH+3jQV
 JGHEoIAnzvnTbXFFloa9dmt/bebMlHu8p0eMd7ujtwQMFSXPtCaCZfLSEapIfvrwoLvjkcmHaak0S
 os4Ry++J+BA4Zjy4rlpJGfScH23wq+QuJ1EnvUrl/i2hoEb1GA+PElTtZrctT7avrcp051HeAQJHt
 MommdMIRXxQ8f7+NTw6YINNchc1V2k8mSpMibhQPjTbiWcdM3d674C2MzQOyDshqLUX3ERNg5eNxi
 Yzo0Jtug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWWo-0002hR-Kh; Tue, 27 Apr 2021 16:50:04 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427192232.GO2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <74473159-b4d7-89c8-9dae-7e983b22ef2b@deltatee.com>
Date: Tue, 27 Apr 2021 16:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427192232.GO2047089@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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



On 2021-04-27 1:22 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() either returns a positive number indicating the number
>> of entries mapped or zero indicating that resources were not available
>> to create the mapping. When zero is returned, it is always safe to retry
>> the mapping later once resources have been freed.
>>
>> Once P2PDMA pages are mixed into the SGL there may be pages that may
>> never be successfully mapped with a given device because that device may
>> not actually be able to access those pages. Thus, multiple error
>> conditions will need to be distinguished to determine weather a retry
>> is safe.
>>
>> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
>> convention from dma_map_sg(). The function will return a positive
>> integer on success or a negative errno on failure.
>>
>> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
>> indicate that a P2PDMA page is not mappable.
>>
>> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
>> level implementations that P2PDMA pages are allowed and to warn if a
>> caller introduces them into the regular dma_map_sg() interface.
> 
> So this new API is all about being able to return an error code
> because auditing the old API is basically terrifying?
> 
> OK, but why name everything new P2PDMA? It seems nicer to give this
> some generic name and have some general program to gradually deprecate
> normal non-error-capable dma_map_sg() ?
> 
> I think that will raise less questions when subsystem people see the
> changes, as I was wondering why RW was being moved to use what looked
> like a p2pdma only API.
> 
> dma_map_sg_or_err() would have been clearer
> 
> The flag is also clearer as to the purpose if it is named
> __DMA_ATTR_ERROR_ALLOWED

I'm not opposed to these names. I can use them for v2 if there are no
other opinions.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
