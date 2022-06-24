Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D248291C
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 15:13:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C16B143D;
	Fri, 24 Jun 2022 08:13:03 -0700 (PDT)
Received: from [10.57.84.111] (unknown [10.57.84.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEAB3F534;
	Fri, 24 Jun 2022 08:13:01 -0700 (PDT)
Message-ID: <42679e49-4a04-4700-f420-f6ffe0f4b7d1@arm.com>
Date: Fri, 24 Jun 2022 16:12:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Content-Language: en-GB
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: cohuck@redhat.com, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <20220622161721.469fc9eb.alex.williamson@redhat.com>
 <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
 <20220623170044.1757267d.alex.williamson@redhat.com>
 <20220624015030.GJ4147@nvidia.com>
 <20220624081159.508baed3.alex.williamson@redhat.com>
 <20220624141836.GS4147@nvidia.com>
 <20220624082831.22de3d51.alex.williamson@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220624082831.22de3d51.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220624151255.2aEf6dBn4MQGxFTZqxSkF-pkeNcDa-octL0ieyvwwzU@z>

On 2022-06-24 15:28, Alex Williamson wrote:
> On Fri, 24 Jun 2022 11:18:36 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Fri, Jun 24, 2022 at 08:11:59AM -0600, Alex Williamson wrote:
>>> On Thu, 23 Jun 2022 22:50:30 -0300
>>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>    
>>>> On Thu, Jun 23, 2022 at 05:00:44PM -0600, Alex Williamson wrote:
>>>>    
>>>>>>>> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
>>>>>>>> +{
>>>>>>>> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
>>>>>>>> +	struct vfio_device *device;
>>>>>>>
>>>>>>> Check group for NULL.
>>>>>>
>>>>>> OK - FWIW in context this should only ever make sense to call with an
>>>>>> iommu_group which has already been derived from a vfio_group, and I did
>>>>>> initially consider a check with a WARN_ON(), but then decided that the
>>>>>> unguarded dereference would be a sufficiently strong message. No problem
>>>>>> with bringing that back to make it more defensive if that's what you prefer.
>>>>>
>>>>> A while down the road, that's a bit too much implicit knowledge of the
>>>>> intent and single purpose of this function just to simply avoid a test.
>>>>
>>>> I think we should just pass the 'struct vfio_group *' into the
>>>> attach_group op and have this API take that type in and forget the
>>>> vfio_group_get_from_iommu().
>>>
>>> That's essentially what I'm suggesting, the vfio_group is passed as an
>>> opaque pointer which type1 can use for a
>>> vfio_group_for_each_vfio_device() type call.  Thanks,
>>
>> I don't want to add a whole vfio_group_for_each_vfio_device()
>> machinery that isn't actually needed by anything.. This is all
>> internal, we don't need to design more than exactly what is needed.
>>
>> At this point if we change the signature of the attach then we may as
>> well just pass in the representative vfio_device, that is probably
>> less LOC overall.
> 
> That means that vfio core still needs to pick an arbitrary
> representative device, which I find in fundamental conflict to the
> nature of groups.  Type1 is the interface to the IOMMU API, if through
> the IOMMU API we can make an assumption that all devices within the
> group are equivalent for a given operation, that should be done in type1
> code, not in vfio core.  A for-each interface is commonplace and not
> significantly more code or design than already proposed.  Thanks,

It also occurred to me this morning that there's another middle-ground 
option staring out from the call-wrapping notion I mentioned yesterday - 
while I'm not keen to provide it from the IOMMU API, there's absolutely 
no reason that VFIO couldn't just use the building blocks by itself, and 
in fact it works out almost absurdly simple:

static bool vfio_device_capable(struct device *dev, void *data)
{
	return device_iommu_capable(dev, (enum iommu_cap)data);
}

bool vfio_group_capable(struct iommu_group *group, enum iommu_cap cap)
{
	return iommu_group_for_each_dev(group, (void *)cap, vfio_device_capable);
}

and much the same for iommu_domain_alloc() once I get that far. The 
locking concern neatly disappears because we're no longer holding any 
bus or device pointer that can go stale. How does that seem as a 
compromise for now, looking forward to Jason's longer-term view of 
rearranging the attach_group process such that a vfio_device falls 
naturally to hand?

Cheers,
Robin.
