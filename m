Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8045FC433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:21:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAEF611AC
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAEF611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 849CC60620;
	Mon,  3 May 2021 18:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aBFpI0yRgr_Z; Mon,  3 May 2021 18:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CE276069B;
	Mon,  3 May 2021 18:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B97DC0019;
	Mon,  3 May 2021 18:21:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2B73C000D
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C732C404B9
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5T78IqDTsk8N for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 18:20:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37E51402C7
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=btAG4Vr3f5GLEzhmHmHkox49Ultu4PcxMLcQ9c/IbGg=; b=Kok6u9aTNQ/DTtp1uHx6mPrNjx
 K8OjtI9P0WjkLvmrMoggQoeKvdKKIN8gAf//ZoorpRZxjiWc12WO+bWHaVjJOoXdbmJdZIAIUUL1x
 Q6vPsiblyYvlCii5btWVUafaskZ5yfaz9cDn/nnSxzVz+4JYypdaPqNwwnVcKoWo4Sne+INjhTfrV
 ZW3hhWBsn8zY0B97HLikca3VnzSWWlgwewCA8CA6MeLf174EE1h8BrpH8TB/RtRDj7O61YRad/Djs
 j0PGayIK3T4fD/uzv3Z6XaDwcSoaqpjnxy6wGL2mD+pDdVcJztSQdxhWIFsh1Ipo3mp/N2GlM7zPU
 EFmnDZ6w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lddBX-0000Z1-P0; Mon, 03 May 2021 12:20:49 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
 <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8402ca0b-f147-fb99-bab4-71f047d2ba46@deltatee.com>
Date: Mon, 3 May 2021 12:20:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com,
 ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com,
 dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com,
 andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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



On 2021-05-03 12:17 p.m., John Hubbard wrote:
> On 5/3/21 8:57 AM, Logan Gunthorpe wrote:
>>
>>
>> On 2021-05-01 9:58 p.m., John Hubbard wrote:
>>> Another odd thing: this used to check for memory failure and just give
>>> up, and now it doesn't. Yes, I realize that it all still works at the
>>> moment, but this is quirky and we shouldn't stop here.
>>>
>>> Instead, a cleaner approach would be to push the memory allocation
>>> slightly higher up the call stack, out to the
>>> pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
>>> the kmalloc() call, and fail out if it can't get a page for the seq_buf
>>> buffer. Then you don't have to do all this odd stuff.
>>
>> I don't really agree with this assessment. If kmalloc fails to
>> initialize the seq_buf() (which should be very rare), the only thing
>> that is lost is the one warning print that tells the user the command
>> line parameter needed disable the ACS. Everything else works fine,
>> nothing else can fail. I don't see the need to add extra complexity just
>> so the code errors out in no-mem instead of just skipping the one,
>> slightly more informative, warning line.
> 
> That's the thing: memory failure should be exceedingly rare for this.
> Therefore, just fail out entirely (which I don't expect we'll likely
> ever see), instead of doing all this weird stuff to try to continue
> on if you cannot allocate a single page. If you are in that case, the
> system is not in a state that is going to run your dma p2p setup well
> anyway.
> 
> I think it's *less* complexity to allocate up front, fail early if
> allocation fails, and then not have to deal with these really odd
> quirks at the lower levels.
>

I don't see how it's all that weird. We're skipping a warning if we
can't allocate memory to calculate part of the message. It's really not
necessary. If the memory really can't be allocated then something else
will fail, but we really don't need to fail here because we couldn't
print a verbose warning message.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
