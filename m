Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D757487
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 19:15:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C36D75;
	Mon,  3 Apr 2023 12:15:53 -0700 (PDT)
Received: from [10.57.56.209] (unknown [10.57.56.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F3A3F73F;
	Mon,  3 Apr 2023 12:15:07 -0700 (PDT)
Message-ID: <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
Date: Mon, 3 Apr 2023 20:15:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, shameerali.kolothum.thodi@huawei.com,
 jean-philippe@linaro.org, iommu@lists.linux.dev
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia> <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-03 15:51, Nicolin Chen wrote:
> On Mon, Apr 03, 2023 at 11:08:23AM -0300, Jason Gunthorpe wrote:
>> On Sun, Apr 02, 2023 at 05:33:35PM -0700, Nicolin Chen wrote:
>>> The first version is simply to individually forward the entire
>>> command. This can save a few CPU cycles from packing/unpacking
>>> invalidation fields of the commands via a data structure, v.s.
>>> the structure in v1[2].
>>
>> The kernel must validate the SID for the ATS invalidations, we can't
>> just blindly pass it through.
> 
> Yes. I didn't go further with the first version, yet leaving a
> line of comments in the handler: we'd need set/unset_rid_user,
> to validate the SID field of INV_ATC commands, as we discussed.
> 
>> And this simple path needs an explanation how errors are properly
>> handled, eg by making execution synchronous, or someone guaranteeing
>> that errors are impossible.
> 
> Yes. Both versions here execute in a synchronous fashion. The
> error code will be returned in the cache_invalidate_user data
> structure.
> 
>>> Then I added a new mmap interface to share kernel page(s) from the
>>> Driver, to allow QEMU to write all TLBI commands as a single batch.
>>> Then it can initiate the batch invalidation via another synchronous
>>> hypercall.
>>
>> I don't think a mmap is really needed for simple batching, just
>> passing a larger buffer to ioctl is probably good enough
> 
> It wouldn't be a must, yet can omit a copy_from_user() at each
> hypercall? And it also eases VCMDQ a bit.
> 
>> If a SW side is built it should mirror the HW vCMDQ path, not be
>> different.
> 
> The host kernel has the host queue, while the hypervisor fills
> in a guest TLBI queue. Switching between two queues at one SMMU
> CMDQ (HW) requires a very complicated locking mechanism, v.s.
> inserting the batch to the existing host queue. And it probably
> doesn't have a big perf improvement by doing that?
> 
> If SMMU has ECMDQ, it'd allocate a free CMDQ upon availability,
> calling arm_smmu_init_one_queue() and mmapping q->base, then it
> can execute the guest TLBI queue directly, passing that q ptr.

FWIW I don't think that should be visible in a userspace interface. When 
the VMM is just requesting some invalidations in order to emulate some 
commands, it's up to the SMMU driver, or at best between the driver and 
and IOMMUFD, to decide exactly how those requests get executed as 
physical commands - that should not make any difference to the requester 
other than how quickly the requests are processed.

AFAICS this interface can't look like the proper hardware vCMDQ path, 
because the whole point of that will be to configure it in advance, map 
the queue controls directly into the guest, and avoid trapping 
invalidations to the VMM at all. This invalidation request interface is 
a large part of precisely what that path is intended to bypass. I don't 
see much benefit in supporting an additional slightly-accelerated slow 
path where the host avoids a tiny bit of housekeeping by maintaining a 
real vCMDQ *on behalf of* the guest and forwarding trapped commands into 
it instead of just processing them normally as host commands. Or, 
conversely, emulating a vCMDQ *in* the host kernel, in a way which still 
requires traps to bounce through the VMM and back - that just seems 
objectively worse than keeping all the emulation together in one place 
(however, I would concur that a "vhost-style" emulation, using all the 
same interfaces for configuration and error/irq/etc. reporting as the 
real hardware would, might be viable if performance really demands it).

Thanks,
Robin.
