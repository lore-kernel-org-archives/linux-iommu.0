Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DD3C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 10:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8A144019A;
	Tue, 22 Feb 2022 10:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-7sq8pPzIYo; Tue, 22 Feb 2022 10:59:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5B1640137;
	Tue, 22 Feb 2022 10:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A2ADC001A;
	Tue, 22 Feb 2022 10:59:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3A0C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 241BF812BB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vyUmWH2z62uo for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 10:59:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EF97812B8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:59:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39757139F;
 Tue, 22 Feb 2022 02:59:02 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D613F70D;
 Tue, 22 Feb 2022 02:58:57 -0800 (PST)
Message-ID: <1acb8748-8d44-688d-2380-f39ec820776f@arm.com>
Date: Tue, 22 Feb 2022 10:58:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-3-baolu.lu@linux.intel.com>
 <YhCdEmC2lYStmUSL@infradead.org>
 <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
 <20220221234837.GA10061@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221234837.GA10061@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2022-02-21 23:48, Jason Gunthorpe wrote:
> On Mon, Feb 21, 2022 at 08:43:33PM +0000, Robin Murphy wrote:
>> On 2022-02-19 07:32, Christoph Hellwig wrote:
>>> So we are back to the callback madness instead of the nice and simple
>>> flag?  Sigh.
>>
>> TBH, I *think* this part could be a fair bit simpler. It looks like this
>> whole callback mess is effectively just to decrement
>> group->owner_cnt, but
> 
> Right, the new callback is because of Greg's push to put all the work
> into the existing bus callback. Having symetrical callbacks is
> cleaner.

I'll continue to disagree that having tons more code purely for the sake 
of it is cleaner. The high-level requirements are fundamentally 
asymmetrical - ownership has to be actively claimed by the bus code at a 
point during probe where it can block probing if necessary, but it can 
be released anywhere at all during remove since that cannot fail. I 
don't personally see the value in a bunch of code bloat for no reason 
other than trying to pretend that an asymmetrical thing isn't.

We already have other concepts in the IOMMU API, like the domain ops 
lifecycle, which are almost self-contained but for needing an external 
prod to get started, so I'm naturally viewing this one the same way.

>> since we should only care about ownership at probe, hotplug, and other
>> places well outside critical fast-paths, I'm not sure we really need to keep
>> track of that anyway - it can always be recalculated by walking the
>> group->devices list,
> 
> It has to be locked against concurrent probe, and there isn't
> currently any locking scheme that can support this. The owner_cnt is
> effectively a new lock for this purpose. It is the same issue we
> talked about with that VFIO patch you showed me.

Huh? How hard is it to hold group->mutex when reading or writing 
group->owner? Walking the list would only have to be done for 
*releasing* ownership and I'm pretty sure all the races there are benign 
- only probe/remove of the driver (or DMA API token) matching a current 
non-NULL owner matter; if two removes race, the first might end up 
releasing ownership "early", but the second is waiting to do that anyway 
so it's OK; if a remove races with a probe, the remove may end up 
leaving the owner set, but the probe is waiting to do that anyway so 
it's OK.

> So, using the group->device_list would require adding something else
> somewhere - which I think should happen when someone has
> justification for another use of whatever that something else is.
> 
> Also, Greg's did have an objection to the the first version, with code
> living in dd.c, that was basically probe time performance. I'm not
> sure making this slower would really be welcomed..

Again, this does not affect probe at all, only remove, and TBH I'd 
expect the performance impact to be negligible. On any sensible system, 
IOMMU groups are not large. Heck, in the typical case I'd guess it's no 
worse than the time we currently spend on group notifiers. I was just 
making the point that there should not be a significant performance 
argument for needing to cache a count value.

>> and some of the relevant places have to do that anyway.
> 
> ???

I was looking at iommu_group_remove_device() at the time, but of course 
we should always have seen an unbind before we get there - that one's on 
me, sorry for the confusion.

>> It has to be s It should be pretty straightforward for
>> iommu_bus_notifier to clear group->owner automatically upon an
>> unbind of the matching driver when it's no longer bound to any other
>> devices in the group either.
> 
> That not_bound/unbind notifier isn't currently triggred during
> necessary failure paths of really_probe().

Eh? Just look at the context of patch #2, let alone the rest of the 
function, and tell me how, if we can't rely on 
BUS_NOTIFY_DRIVER_NOT_BOUND, calling .dma_cleanup *from the exact same 
place* is somehow more reliable?

AFAICS, a notifier handling both BUS_NOTIFY_UNBOUND_DRIVER and 
BUS_NOTIFY_DRIVER_NOT_BOUND would be directly equivalent to the callers 
of .dma_cleanup here.

> Even if this was patched up, it looks like spaghetti to me..
> 
>> use-case) then it should be up to VFIO to decide when it's finally
>> finished with the whole group, rather than pretending we can keep
>> track of nested ownership claims from inside the API.
> 
> What nesting?

The current implementation of iommu_group_claim_dma_owner() allows 
owner_cnt to increase beyond 1, and correspondingly requires 
iommu_group_release_dma_owner() to be called the same number of times. 
It doesn't appear that VFIO needs that, and I'm not sure I'd trust any 
other potential users to get it right either.

>> Furthermore, If Greg was willing to compromise just far enough to let us put
>> driver_managed_dma in the 3-byte hole in the generic struct
>> device_driver,
> 
> Space was not an issue, the earlier version of this switched an
> existing bool to a bitfield.
> 
>> we wouldn't have to have quite so much boilerplate repeated across the
>> various bus implementations (I'm not suggesting to move any actual calls
>> back into the driver core, just the storage of flag itself).
> 
> Not sure that makes sense.. But I don't understand why we need to copy
> and paste this code into every bus's dma_configure *shrug*

That's what I'm saying - right now every bus *has* to have a specific 
.dma_configure implementation if only to retrieve a 
semantically-identical flag from each bus-specific structure; there is 
zero possible code-sharing. With a generically-defined flag, there is 
some possibility for code-sharing now (e.g. patch #3 wouldn't be 
needed), and the potential for more in future.

>> FWIW I have some ideas for re-converging .dma_configure in future
>> which I think should probably be able to subsume this into a
>> completely generic common path, given a common flag.
> 
> This would be great!

Indeed, so if we're enthusiastic about future cleanup that necessitates 
a generic flag, why not make the flag generic to start with?

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
