Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66EE626;
	Thu, 13 Apr 2023 16:47:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548EBD75;
	Thu, 13 Apr 2023 09:48:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652733F6C4;
	Thu, 13 Apr 2023 09:47:20 -0700 (PDT)
Message-ID: <eb151466-1357-846a-a365-1517508fea1c@arm.com>
Date: Thu, 13 Apr 2023 17:47:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/17] iommu: Make __iommu_group_set_domain() handle
 error unwind
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <26039535-5f78-74f1-7864-978ad6c2810d@arm.com> <ZC8Y7g99aAQURbtj@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZC8Y7g99aAQURbtj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 8:09 pm, Jason Gunthorpe wrote:
> On Thu, Apr 06, 2023 at 07:08:59PM +0100, Robin Murphy wrote:
> 
>>> +		if (ret) {
>>> +			result = ret;
>>> +			/*
>>> +			 * Keep trying the other devices in the group. If a
>>> +			 * driver fails attach to an otherwise good domain, and
>>> +			 * does not support blocking domains, it should at least
>>> +			 * drop its reference on the current domain so we don't
>>> +			 * UAF.
>>> +			 */
>>> +			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
>>> +				continue;
>>
>> I know it's called out above, but my brain truly can't cope with a flag
>> named "MUST_SUCCEED" which actually means "can fail, but you can't reason
>> about the state after failure". As before, I think the actual flag itself
>> can go away, but the behaviour itself will still be no nicer for being
>> implicit :/
> 
> What I saw is that a bunch of drivers tend to implement attach_dev
> with first some kind of detach, which often cannot fail, and then can
> fail the new attach.
> 
> So, this is intended to go along with that design pattern. We call
> every device's attach and hope that the outcome is either to release
> the current iommu_domain or to attach to the new one.

It's that design pattern which is most of the problem, though. It's a 
left-over from the old pre-default-domain era (quite literally, in most 
cases, where drivers were just minimally bodged to simulate the previous 
core call of ops->detach_dev). In the modern 
always-attached-to-something paradigm, drivers should absolutely be able 
to figure out if an attach will fail *before* they throw away any 
existing device state.

If we reach the point of adding core code that only serves to help 
drivers emulate the new API using the old API because we'd rather 
undermine the new API design than fix the drivers, then frankly that 
seems like an argument for just reverting back to the old API.

Partial failure at the group level - i.e. one device's attach call 
failing after previous ones have succeeded and leaving the group as a 
whole in an inconsistent state - is a separate issue dating all the way 
back to day 1 of groups. I don't disagree with questioning the current 
implicit assumption that that just shouldn't ever happen, but it touches 
on different aspects of driver design than the above.

> If a driver doesn't follow this pattern then we'll UAF.
> 
> The primary purpose of the MUST_SUCCEED flag is to prevent the code
> from trying to go back to the old domain. This really should only
> depend on the caller's context and ability to handle errors, so I
> don't see what would make it implicit?

It could be implicit *because* it's contextual; the domain types already 
carry as much information as the flag would. Attaching to a non-core 
(unmanaged or SVA) domain type is the one case where core code has clear 
reason to unwind if an attach fails mid-group. The initial attach to a 
core domain from nothing in probe_device could be allowed to fail, but 
there there's clearly nothing to unwind, and leaving the device in limbo 
seems OK. Attaching from non-core to core should represent a repeat of 
something which previously succeeded for the given device+domain 
combination, so whether we permit that to fail-to-limbo or mandate that 
drivers must be able to repeat a previous success mostly depends on what 
we think is a reasonable expectation of how to design a driver (I think 
it comes down to whether anyone really needs any domain-specific 
allocations that have to belong to devices rather than the domain 
itself, and cannot otherwise be preserved over a detach/reattach cycle). 
Finally, core to core transitions via sysfs can probably be their own 
special case depending on what falls out of the others.

> We definitely do not want to attach back the old domain if we are
> about to unconditionally free it.
> 
>> TBH I still think the responsibility should be on the drivers to handle
>> rollback of their internal per-device state if returning failure from an
>> .attach_dev call.
> 
> It helps the driver stay consistent, but I don't think it helps the
> core code too much.
> 
> With the two patches to add the rodata IDENTITY domain to drivers I
> think we should go in that direction.
> 
> Lets have an "ops->emergency_domain" that is something the driver can
> always attach. Ideally it will be the BLOCKING domain, but IDENTITY
> could work too.
> 
> When this function gets into trouble it will put the entire group on
> 'emergency_domain' and things will be safe, no UAF.
> 
> This seems pretty simple for drivers since the attach_dev can just
> leave behind whatever state is convenient, so long as their
> emergency_domain cannot fail.
> 
>> But what would be really really really good, now that .detach_dev has
>> truly gone, is to pass *both* "to" and "from" domains to .attach_dev (and a
>> "from" domain to .release_device), so that drivers don't have to squirrel
>> away all these internal references to their own notions of "current" domains
>> which are the root of this whole class of horrid UAF and consistency
>> bugs.
> 
> Usually the IOMMU HW will be touching the IOPTEs via DMA enclosed by
> the iommu_domain, so even if we could remove the iommu_domain pointers
> from the drivers it still retains the HW programming to the
> memory. Freeing the domain will still UAF.
> 
> Refcounts would be another way to address the UAF, then we can leak
> the iommu_domain if things go bad. I think this is more complex on drivers.

Ah, we're thinking of different notions of UAF - I just mean drivers 
dereferencing stale pointers in software. If software leaves the 
hardware pointing at the the wrong thing, then it's already not going to 
work as expected from then on, regardless of whether that 
descriptor/pagetable/whatever is subsequently freed or not, so as far as 
I'm concerned there isn't much meaningful functional difference between 
"broken" and "much more badly broken". Obviously it does matter more 
from an overall kernel safety/stability viewpoint, but that's only a 
concern for when we can't get the API-level functional correctness right 
in the first place.

Thanks,
Robin.
