Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D75B5A1
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E1F9FEC;
	Wed, 22 Nov 2023 09:24:25 -0800 (PST)
Received: from [10.57.82.227] (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0733F73F;
	Wed, 22 Nov 2023 09:23:37 -0800 (PST)
Message-ID: <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
Date: Wed, 22 Nov 2023 17:23:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Rob Clark <robdclark@gmail.com>, Gaurav Kohli <quic_gkohli@quicinc.com>,
 Steven Price <steven.price@arm.com>
References: <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com> <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com> <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com> <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com> <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com> <20231120154536.GE10140@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231120154536.GE10140@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-20 3:45 pm, Jason Gunthorpe wrote:
> On Mon, Nov 20, 2023 at 04:14:18PM +0100, Boris Brezillon wrote:
>> On Mon, 20 Nov 2023 10:46:04 -0400
>> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>>> On Mon, Nov 20, 2023 at 03:38:38PM +0100, Boris Brezillon wrote:
>>>
>>>>> At LPC there was quite a lot if interest in improving the io page
>>>>> table stuff to work better. Based on that I'm even more against adding
>>>>> an external allocator at this time. :\
>>>>
>>>> I'm sure this has been discussed with the IOMMU maintainers, but I'd
>>>> really like to hear it from them if you don't mind. Especially since,
>>>> as I mentioned, the custom allocator idea comes from Robin, not me...
>>>
>>> It is a community effort - this is my opinion. We now understand this
>>> io page table area needs a lot of work to meet all the new needs. I'm
>>> against hacking it up like this and making that work harder.
>>
>> Consider it a hack if you like, but the thing is pretty self-contained,
>> and I doubt it will get to a point where things become unmaintainable
>> before you get the generic caching system working. Not to mention
>> Gaurav's use case, which can't really be solved with your caching
>> solution.
> 
> Gaurav doesn't need a custom allocator, he needs a way to manage
> sharing page table memory with the hypervisor. A different set of ops
> that don't replace the entire allocator would be fine for them.
> 
> The issue with taking away the alloc_page is that it complicates the
> ability for the common code to use the struct page fields and more. We
> already know we are going to need those to do some of the things that
> are being asked for, eg RCU freeing and refcounting.

Oh come on, for all the things you claim are simple, you don't think 
it's trivial to make the fancy stuff conditional? (Hint: we already have 
control flow all over which is conditional on the cfg and/or calling 
context, and that future stuff may well end up wanting to be conditional 
in its own right anyway since not all io-pgtable-arm users will need or 
want it).

Having already 90% prototyped deferred freeing (oh, to be able to get 
back to fun things like that...), I see no significant impediment to 
fitting that in around this. Certainly no worse than fitting it around 
the !coherent_walk DMA API bits - in fact if anything, punting all that 
lot into custom allocator hooks starts to look like an attractive idea 
once we have the means (it really wants to be using dma_alloc_pages() 
these days).

>>> I would not expect a resolution in a few weeks.
>>
>> OOC, what's the time frame?
> 
> The larger need has been discussed is considerable work, I would be
> surprised if something could be merged in less than 6 months,
> especially with the upcoming holiday season
> 
>> I've maintained a subsystem for a few years, so I know what it means
>> to contribute upstream and ask or being asked to extend the core to do
>> something the right way. I'm generally patient and try to follow
>> maintainers' recommendations, but there's some point where waiting is
>> no more an option, and you have to be more pragmatic, because there's
>> always a better way of doing things, and perfection is often the enemy
>> of good...
> 
> Here I am not talking about perfection, I am concerned about messing
> up work that I now see as important for other iommu drivers related
> things by making a hack for a DRM driver (which as I've said has,
> unravelling these hacks has been traumatic for many of us
> historically)

In your own words, this is a community effort. You do not own this code, 
and you do not get to prevent the community from solving multiple 
problems they have now, in a way which is reasonable now, just because 
*you* don't like it, and *you* believe it might possibly make it harder 
to do something at some indeterminate point in future. Your objection is 
noted, but as above, I for one do not see a convincing basis for it anyway.

You know what *the community* sees as important? Not having to maintain 
multiple copies of near-identical pagetable code, because maintenance is 
an established and very real concern. This is why we have the io-pgtable 
library in the first place, and why we adapted io-pgtable-arm to support 
panfrost when that came along. If supporting panfrost and panthor as 
io-pgtable users really does ever become a practical problem at some 
point in the future, we will work to address that problem at that point. 
In the meantime, we can get on with the common goal of making Linux do 
the things people want it to do, in the best way that the maintainers 
are happy to maintain. This is not "a hack for a DRM driver", it's a 
simple and convenient generalisation of part of io-pgtable, in keeping 
with the design of io-pgtable (user-provided callbacks are nothing new), 
and straightforwardly serving at least two completely different 
use-cases already.

Thanks,
Robin.
