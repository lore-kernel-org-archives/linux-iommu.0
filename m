Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C0C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 17:46:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D34064E90
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 17:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D34064E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36D0442FD7;
	Fri, 12 Mar 2021 17:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kzaI1Za-ne-E; Fri, 12 Mar 2021 17:46:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C12042FD6;
	Fri, 12 Mar 2021 17:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD4BC000B;
	Fri, 12 Mar 2021 17:46:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE01C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AB9360661
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JzeaB48j2_5F for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 17:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2D8E605DF
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:46:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4DC1FB;
 Fri, 12 Mar 2021 09:46:43 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74DF03F7D7;
 Fri, 12 Mar 2021 09:46:38 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
 <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <90a2825c-da2f-c031-a70f-08c5efb3db56@arm.com>
Date: Fri, 12 Mar 2021 17:46:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
Content-Language: en-GB
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-03-12 16:18, Logan Gunthorpe wrote:
> 
> 
> On 2021-03-12 8:51 a.m., Robin Murphy wrote:
>> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>>> Hi,
>>>
>>> This is a rework of the first half of my RFC for doing P2PDMA in
>>> userspace
>>> with O_DIRECT[1].
>>>
>>> The largest issue with that series was the gross way of flagging P2PDMA
>>> SGL segments. This RFC proposes a different approach, (suggested by
>>> Dan Williams[2]) which uses the third bit in the page_link field of the
>>> SGL.
>>>
>>> This approach is a lot less hacky but comes at the cost of adding a
>>> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
>>> scarce bit in the page_link. For our purposes, a 64BIT restriction is
>>> acceptable but it's not clear if this is ok for all usecases hoping
>>> to make use of P2PDMA.
>>>
>>> Matthew Wilcox has already suggested (off-list) that this is the wrong
>>> approach, preferring a new dma mapping operation and an SGL
>>> replacement. I
>>> don't disagree that something along those lines would be a better long
>>> term solution, but it involves overcoming a lot of challenges to get
>>> there. Creating a new mapping operation still means adding support to
>>> more
>>> than 25 dma_map_ops implementations (many of which are on obscure
>>> architectures) or creating a redundant path to fallback with dma_map_sg()
>>> for every driver that uses the new operation. This RFC is an approach
>>> that doesn't require overcoming these blocks.
>>
>> I don't really follow that argument - you're only adding support to two
>> implementations with the awkward flag, so why would using a dedicated
>> operation instead be any different? Whatever callers need to do if
>> dma_pci_p2pdma_supported() says no, they could equally do if
>> dma_map_p2p_sg() (or whatever) returns -ENXIO, no?
> 
> The thing is if the dma_map_sg doesn't support P2PDMA then P2PDMA
> transactions cannot be done, but regular transactions can still go
> through as they always did.
> 
> But replacing dma_map_sg() with dma_map_new() affects all operations,
> P2PDMA or otherwise. If dma_map_new() isn't supported it can't simply
> not support P2PDMA; it has to maintain a fallback path to dma_map_sg().

But AFAICS the equivalent fallback path still has to exist either way. 
My impression so far is that callers would end up looking something like 
this:

	if (dma_pci_p2pdma_supported()) {
		if (dma_map_sg(...) < 0)
			//do non-p2p fallback due to p2p failure
	} else {
		//do non-p2p fallback due to lack of support
	}

at which point, simply:

	if (dma_map_sg_p2p(...) < 0)
		//do non-p2p fallback either way

seems entirely reasonable. What am I missing?

Let's not pretend that overloading an existing API means we can start 
feeding P2P pages into any old subsystem/driver without further changes 
- there already *are* at least some that retry ad infinitum if DMA 
mapping fails (the USB layer springs to mind...) and thus wouldn't 
handle the PCI_P2PDMA_MAP_NOT_SUPPORTED case acceptably.

> Given that the inputs and outputs for dma_map_new() will be completely
> different data structures this will be quite a lot of similar paths
> required in the driver. (ie mapping a bvec to the input struct and the
> output struct to hardware requirements) If a bug crops up in the old
> dma_map_sg(), developers might not notice it for some time seeing it
> won't be used on the most popular architectures.

Huh? I'm specifically suggesting a new interface that takes the *same* 
data structure (at least to begin with), but just gives us more 
flexibility in terms of introducing p2p-aware behaviour somewhat more 
safely. Yes, we already know that we ultimately want something better 
than scatterlists for representing things like this and dma-buf imports, 
but that hardly has to happen overnight.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
