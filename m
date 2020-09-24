Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2FCC47420
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 11:06:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B172A239CF
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 11:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B172A239CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0ECA22E103;
	Thu, 24 Sep 2020 11:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvD6MMNIJoM6; Thu, 24 Sep 2020 11:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC5872E0E9;
	Thu, 24 Sep 2020 11:06:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFE0BC0859;
	Thu, 24 Sep 2020 11:06:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD3CCC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BAF0986A75
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8IYAKbDcM-R for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 11:06:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 80F1F86A32
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:06:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B689B152B;
 Thu, 24 Sep 2020 04:06:28 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539263F8C6;
 Thu, 24 Sep 2020 04:06:26 -0700 (PDT)
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200924082830.GB27174@8bytes.org>
 <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
 <20200924101640.GE2483160@ulmo>
 <bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com>
 <832be601-c016-70b7-2b59-5f4915c53f85@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <46f10f99-5da5-257a-4a02-984ff8ed8c6f@arm.com>
Date: Thu, 24 Sep 2020 12:06:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <832be601-c016-70b7-2b59-5f4915c53f85@samsung.com>
Content-Language: en-GB
Cc: jean-philippe@linaro.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Ajay kumar <ajaynumb@gmail.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 will@kernel.org, hch@lst.de
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

On 2020-09-24 11:47, Marek Szyprowski wrote:
> Hi Robin,
> 
> On 24.09.2020 12:40, Robin Murphy wrote:
>> On 2020-09-24 11:16, Thierry Reding wrote:
>>> On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
>>>> On 24.09.2020 10:28, Joerg Roedel wrote:
>>>>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
>>>>>> It allows to remap given buffer at the specific IOVA address,
>>>>>> although
>>>>>> it doesn't guarantee that those specific addresses won't be later
>>>>>> used
>>>>>> by the IOVA allocator. Probably it would make sense to add an API for
>>>>>> generic IOMMU-DMA framework to mark the given IOVA range as
>>>>>> reserved/unused to protect them.
>>>>> There is an API for that, the IOMMU driver can return IOVA reserved
>>>>> regions per device and the IOMMU core code will take care of mapping
>>>>> these regions and reserving them in the IOVA allocator, so that
>>>>> DMA-IOMMU code will not use it for allocations.
>>>>>
>>>>> Have a look at the iommu_ops->get_resv_regions() and
>>>>> iommu_ops->put_resv_regions().
>>>>
>>>> I know about the reserved regions IOMMU API, but the main problem here,
>>>> in case of Exynos, is that those reserved regions won't be created by
>>>> the IOMMU driver but by the IOMMU client device. It is just a result
>>>> how
>>>> the media drivers manages their IOVA space. They simply have to load
>>>> firmware at the IOVA address lower than the any address of the used
>>>> buffers.
>>>
>>> I've been working on adding a way to automatically add direct mappings
>>> using reserved-memory regions parsed from device tree, see:
>>>
>>> https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gmail.com/
>>>
>>> Perhaps this can be of use? With that you should be able to add a
>>> reserved-memory region somewhere in the lower range that you need for
>>> firmware images and have that automatically added as a direct mapping
>>> so that it won't be reused later on for dynamic allocations.
>>
>> It can't easily be a *direct* mapping though - if the driver has to
>> use the DMA masks to ensure that everything stays within the
>> addressable range, then (as far as I'm aware) there's no physical
>> memory that low down to equal the DMA addresses.
>>
>> TBH I'm not convinced that this is a sufficiently common concern to
>> justify new APIs, or even to try to make overly generic. I think just
>> implementing a new DMA attribute to say "please allocate/map this
>> particular request at the lowest DMA address possible" would be good
>> enough. Such a thing could also serve PCI drivers that actually care
>> about SAC/DAC to give us more of a chance of removing the "try a
>> 32-bit mask first" trick from everyone's hotpath...
> 
> Hmm, I like the idea of such DMA attribute! It should make things really
> simple, especially in the drivers. Thanks for the great idea! I will try
> to implement it then instead of the workarounds I've proposed in
> s5p-mfc/exynos4-is drivers.

Right, I think it's fair to draw a line and say that anyone who wants a 
*specific* address needs to manage their own IOMMU domain.

In the backend I suspect it's going to be cleanest to implement a 
dedicated iova_alloc_low() (or similar) function in the IOVA API that 
sidesteps all of the existing allocation paths and goes straight to the 
rbtree.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
