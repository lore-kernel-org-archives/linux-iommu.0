Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D499FC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 18:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C0EA415DD;
	Wed, 29 Jun 2022 18:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C0EA415DD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=KqlIdYHp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHd1qFyee9xz; Wed, 29 Jun 2022 18:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2FB1408B0;
	Wed, 29 Jun 2022 18:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2FB1408B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8604FC002D;
	Wed, 29 Jun 2022 18:24:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB0C5C0011
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86A59409A2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86A59409A2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XJwHHT_e8IpB for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 18:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D519B408B0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D519B408B0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=6f/hfdoWC+PgJWoBH5fqwFGRbVxwuN3ohOs8yiOPg/w=; b=KqlIdYHpF5kcUd1uj3HgVczqN5
 +LiC/fe4thV0n4GWyYvjongR/yShAMienfuQ1vSKr2dlutBWKxI1nszo45XAnij64gY60aWl25yKn
 9yS7YZF5VmQ5saw9wKgfKuTqMswh1/nBQISRAQ25FYKkr6Le3Ih3GarYYS3dES6F4h5ipa5KBXImW
 +5AYt7ZvYxGywfXkmA46cmlkEvd9ckJZYnEqkIBKI2tycRJV07BzAnX9mR41JUrGOel82aqdx3sqr
 111sVLF6oie65Xr6Z42l/GsfBOMAbGWd8Y9f26Frw8Cb4XUZDZkK9lUUkK39WvPZjSo78/eCvKrz8
 ZKirfsHg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o6cMk-002URm-20; Wed, 29 Jun 2022 12:24:43 -0600
Message-ID: <9725fc38-cbe6-f660-8d5f-6ceb983e6976@deltatee.com>
Date: Wed, 29 Jun 2022 12:24:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
 <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
 <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com,
 jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
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



On 2022-06-29 12:02, Robin Murphy wrote:
> On 2022-06-29 16:39, Logan Gunthorpe wrote:
>> On 2022-06-29 03:05, Robin Murphy wrote:
>>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>> Does this serve any useful purpose? If a page is determined to be device
>>> memory, it's not going to suddenly stop being device memory, and if the
>>> underlying sg is recycled to point elsewhere then sg_assign_page() will
>>> still (correctly) clear this flag anyway. Trying to reason about this
>>> beyond superficial API symmetry - i.e. why exactly would a caller need
>>> to call it, and what would the implications be of failing to do so -
>>> seems to lead straight to confusion.
>>>
>>> In fact I'd be inclined to have sg_assign_page() be responsible for
>>> setting the flag automatically as well, and thus not need
>>> sg_dma_mark_bus_address() either, however I can see the argument for
>>> doing it this way round to not entangle the APIs too much, so I don't
>>> have any great objection to that.
>>
>> Yes, I think you misunderstand what this is for. The SG_DMA_BUS_ADDDRESS
>> flag doesn't mark the segment for the page, but for the dma address. It
>> cannot be set in sg_assign_page() seeing it's not a property of the page
>> but a property of the dma_address in the sgl.
>>
>> It's not meant for use by regular SG users, it's only meant for use
>> inside DMA mapping implementations. The purpose is to know whether a
>> given dma_address in the SGL is a bus address or regular memory because
>> the two different types must be unmapped differently. We can't rely on
>> the page because, as you know, many dma_map_sg() the dma_address entry
>> in the sgl does not map to the same memory as the page. Or to put it
>> another way: is_pci_p2pdma_page(sg->page) does not imply that
>> sg->dma_address points to a bus address.
>>
>> Does that make sense?
> 
> Ah, you're quite right, in trying to take in the whole series at once
> first thing in the morning I did fail to properly grasp that detail, so
> indeed the sg_assign_page() thing couldn't possibly work, but as I said
> that's fine anyway. I still think the lifecycle management is a bit off
> though - equivalently, a bus address doesn't stop being a bus address,
> so it would seem appropriate to update this flag appropriately whenever
> sg_dma_address() is assigned to, and not when it isn't.

Yes, that's pretty much the way the code is now. The only two places
sg_dma_mark_bus_address() is called are in the two pci_p2pdma helpers
that set the dma address to the bus address. The lines before both calls
set the dma_address and dma_len.

Logan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
