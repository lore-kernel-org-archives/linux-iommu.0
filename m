Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C3266A7
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857E0106F;
	Thu, 23 Nov 2023 08:50:10 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40BD3F7A6;
	Thu, 23 Nov 2023 08:49:22 -0800 (PST)
Message-ID: <ff23d70e-8af6-47b5-a85c-de68ebaab4e8@arm.com>
Date: Thu, 23 Nov 2023 16:49:21 +0000
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
References: <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com> <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com> <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com> <20231120154536.GE10140@ziepe.ca>
 <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
 <20231122175055.GI10140@ziepe.ca> <20231123095141.19dc26d6@collabora.com>
 <20231123134800.GA432016@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231123134800.GA432016@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2023 1:48 pm, Jason Gunthorpe wrote:
> On Thu, Nov 23, 2023 at 09:51:41AM +0100, Boris Brezillon wrote:
>> Beside, I think your objection that custom allocators are in the way of
>> this caching generalization is a bit of an over statement, especially if
>> custom allocators provide the same guarantees you get from existing
>> allocations (page-backed, no fields used in the page, etc). Worst case
>> scenario, you disable the generic cache for all users that pass a custom
>> allocator, and add a pr_warn() (or WARN_ON() if you want to be pushy)
>> to make sure driver owners take that into consideration quickly.
> 
> I want to have common algorithms to manage the radix system, like mm
> does, and then have some fairly hairy stuff done in the new common
> code to address all the needs we now understand people have. This is
> not just "caching".
> 
> One of the important things on this list is RCU freeing of the table
> memory.
> 
> RCU freeing requires precious space in the struct page.
> 
> External ops mean we must have the io page table instance available
> inside the RCU callback so it knows what op to call to free.
> 
> This means the struct page needs to store both a rcu_head and another
> pointer.
> 
> Currently the similar page table algorithms in the mm side consume all
> the free struct page space. I don't expect the future io page table
> version of the same stuff to be much different.
> 
> So it is not just that the allocator side can't use the struct page
> memory. It is that an external allocator inherently demands *more*
> space in the struct page, space we may not have to give.
> 
> Worse, the entire idea of RCU free seems to be incompatible with what
> you are trying to achieve since pages could be unavailable for use
> while they are waiting in RCU.
> 
> I'm looking at this and thinking we loose the option to do RCU in the
> generic code to accommodate external ops. "make RCU optional" is
> basically saying to duplicate alot of stuff because RCU becomes pretty
> fundamental to features and algorithm design.
> 
> Do you understand my alarm to this direction better now?  I'm sorry if
> I haven't explained this clearly enough. (I'm coming at this from the
> MM perspective where the sorts of algorithms and problems here are
> already well known)
> 
>> unresponsive and reluctant to change how they use the APIs. So, if I
>> follow your way of thinking, you'll just be stuck in the same place,
>> waiting for DRM drivers to accept the transversal changes you intend to
>> push.
> 
> I wasn't imagining a forced API change. I think the current API can
> work fine along with an optional pre-allocation scheme.
> 
>> What I strongly oppose to though, is having someone say 'I have the
>> perfect solution for you', and then tell me, 'but you have to wait
>> another six months, maybe more, to see what it looks like'.
> 
> I never said you should be blocked. I agreed with duplicating if
> necessary to be unblocked.
> 
> I also outlined and encouraged you to solve the general problem, but I
> fully understand you don't want to take it on. That's fine too.
> 
> You are both mis-characterizing my position as trying to block the DRM
> driver :(
> 
> I'm trying to accomodate the work I see we need to do soon on the
> enterprise iommu side that touches this same code.
> 
> Look, if we go down this road then we may end up duplicating the page
> table code so the iommu drivers can use the improved versions until
> the DRM driver can be changed. Maybe doing duplication later is better
> than sooner.

Oh, so essentially your plan is to replace io-pgtable-arm with something 
else entirely. That's fair enough; happy to review that when I see it, 
but as I pointed out, realistically this change hardly makes that any 
worse than what's *already* present in io-pgtable-arm that you're going 
to have to deal with anyway.

I would instinctively assume that an "enterprise" optimised version 
would want to be a clean-slate fork itself since I can't imagine it 
wants to be burdened with having to handle non-coherent pagetables, 
Armv7 LPAE format, or any of the quirks for embedded and mobile IOMMUs. 
I have no issue with moving SMMUv3 to a shiny new pagetable 
implementation in future, but that is quite clearly not at all 
incompatible with leaving the existing implementation in place for all 
the *other* decidedly non-enterprise io-pgtable-arm users, both IOMMU 
and GPU, not to mention GPU-via-IOMMU in the case of Adreno.

Thanks,
Robin.
