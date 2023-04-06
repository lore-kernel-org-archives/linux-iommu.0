Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021DAD47;
	Thu,  6 Apr 2023 19:05:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB61F169E;
	Thu,  6 Apr 2023 12:06:02 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3FD3F73F;
	Thu,  6 Apr 2023 12:05:17 -0700 (PDT)
Message-ID: <b5bfb532-3387-8020-7c29-3559d312fa94@arm.com>
Date: Thu, 6 Apr 2023 20:05:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/17] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <51111b86-97af-b3d2-d3e8-5cebc350f37f@arm.com> <ZC7utpUloineTYaV@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZC7utpUloineTYaV@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 5:09 pm, Jason Gunthorpe wrote:
> On Thu, Apr 06, 2023 at 04:44:57PM +0100, Robin Murphy wrote:
>> On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
>>> It should always attach to the current group->domain, so don't take in a
>>> domain parameter. Use the __iommu_device_set_domain() common code to
>>> handle the attach.
>>
>> Hmm, why do we still end up with this in two places, and potentially called
>> twice in the same path?
>>
>> iommu_probe_device()
>>    __iommu_probe_device()
>>      iommu_group_get_for_dev()
>>        iommu_group_add_device()
>>          iommu_group_do_dma_first_attach()
>>    iommu_create_device_direct_mappings()
>>    iommu_group_do_dma_first_attach()
>>
>> Seems off to me... at best it's confusing, but at worst it's plain wrong
>> (it's the one in iommu_group_add_device() that I'm most suspicious of)
> 
> Lu and Kevin pointed to this as well, it started out that way.
> 
> I made a whole other series tidying the probe related flows just based
> on this observation..
> 
> I can pull one patch into here since this seems to catch everyone.
> 
> AFIACT it is harmless at this point since we can safely call
> first_attach twice?

Possibly; the other attach paths usually check and avoid calling into 
the driver to reattach the currently-attached domain, so at worst it 
could conceivably cause refcounting or data corruption issues inside a 
driver which tracks a current domain pointer internally and assumes it 
won't alias the new one. However I guess in practice either our current 
drivers don't mind, or any which do aren't seeing multi-device groups.

 From a quick history dive, it seems that the iommu_group_add_device() 
one was in fact the original default domain attach site, but things 
diverged in 6e1aa2049154 ("iommu: Move default domain allocation to 
iommu_probe_device()"), where IIRC we still had to deal with a mix of 
drivers calling iommu_group_add_device() and/or 
iommu_group_get_for_dev() plus the new probe_device path, so it may have 
still been needed (or at least seemed risky to remove) at that point, 
but then it was overlooked for cleanup after the whole probe_device 
conversion was finished?

Thanks,
Robin.

>> Not to mention the slightly different open-coded variant we still seem to
>> have in iommu_setup_default_domain() via the "else if
>> (!group->default_domain)" path :/
> 
> Yes.. Humm. More parts could be moved into a function but I think it
> would obfuscates what iommu_setup_default_domain() does.
> 
> Oh, I see another mistake:
> 
> 	if (group->domain) {
> 		iommu_create_device_direct_mappings(group->domain, dev);
>                                                    ^^^^^^^^^^^^^^^
> 
> iommu_create_device_direct_mappings should only be called on the
> default domain.
> 
>> (BTW if any comments seem misplaced, it's because I'm really looking at the
>> end result at the cover-letter commit in your branch, rather than trying to
>> review each patch independently)
> 
> That is probably best. The patches are OK but it is hard to see the
> final arrangment
> 
> Thanks,
> Jason
