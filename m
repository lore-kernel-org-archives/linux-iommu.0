Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE8BA27
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 11:42:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B5011FB;
	Mon, 22 May 2023 04:43:41 -0700 (PDT)
Received: from [10.57.83.43] (unknown [10.57.83.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5047C3F6C4;
	Mon, 22 May 2023 04:42:56 -0700 (PDT)
Message-ID: <c36e755a-416a-cf50-57fb-78438a2f61db@arm.com>
Date: Mon, 22 May 2023 12:42:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, bugtracker@fischbytes.de,
 iommu@lists.linux.dev
References: <2282218.ElGaqSPkdT@helios-lx>
 <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
 <1877598.tdWV9SEqCh@helios-lx>
 <302501af-05a3-9757-d923-602ad9a6d9c9@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <302501af-05a3-9757-d923-602ad9a6d9c9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-05-16 02:13, Baolu Lu wrote:
> On 5/13/23 9:11 PM, bugtracker@fischbytes.de wrote:
>> On Saturday, May 13, 2023 8:20:40 AM CEST you wrote:
>>
>>  > On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote:
>>
>>  > > Hi there,
>>
>>  > >
>>
>>  > > I came here today to ask if there are any plans regarding the
>>
>>  > > implementation of a "relaxed RMRR" kernel parameter to aid using 
>> IOMMU on
>>
>>  > > broken platforms such as the ProLiant Series by Hewlett Packard
>>
>>  > > Enterprise. To everyone not aware of the issue;
>>
>>  > >
>>
>>  > > Certain vendors that are under the assumption that standards are 
>> for jerks
>>
>>  > > and Intel's specifications are a loose optional guideline have
>>
>>  > > implemented RMRR in such a way that every PCI device is marked as
>>
>>  > > reserved and therefore cannot be passed through to a virtual 
>> machine.
>>
>>  > > This issue has been very well documented by some people that have 
>> a lot
>>
>>  > > more experience than I do at the below linked resource. I was 
>> hoping that
>>
>>  > > the kernel devs could implement the Relaxed RMRR option as an 
>> optional
>>
>>  > > kernel parameter to use on these bugged platforms as that would 
>> re-enable
>>
>>  > > or rather enable a lot of broken servers for the first time ever 
>> to use
>>
>>  > > PCIe Passthrough. I can verify the issue exists on a HPE DL360e 
>> Gen8 with
>>
>>  > > trying to passthrough a GPU to a KVM/QEMU machine.
>>
>>  > >
>>
>>  > > Link to fix: https://github.com/Aterfax/relax-intel-rmrr
>>
>>  > >
>>
>>  > > Furthermore, since I am not a developer and wouldn't claim that I am
>>
>>  > > competent enough to decide whether or not implementing this patch 
>> would
>>
>>  > > present an issue in terms of stability or security, I was hoping 
>> that you
>>
>>  > > could evaluate the situation. I can verify the pre-built packages 
>> for the
>>
>>  > > Proxmox Linux environment fix the issue and behave identical in 
>> function
>>
>>  > > to other systems that ignore RMRR completely, such as VMWare ESXi.
>>
>>  > >
>>
>>  > > Thanks alot in advance, you implementing this patch would really 
>> mean a
>>
>>  > > lot, since the hardware manufacturers just don't seem to care for 
>> fixing
>>
>>  > > up this, erm, mess.
>>
>>  >
>>
>>  > The relaxed RMRRs are used for legacy purpose, but it requires the 
>> full
>>
>>  > range of memory addresses are available after the OS device driver 
>> takes
>>
>>  > over the control of the device.
>>
>>  >
>>
>>  > Not all RMRRs are of this type and typically the VT-d driver only 
>> allows
>>
>>  > those RMRRs for USB and graphic devices as relaxed ones.
>>
>>  >
>>
>>  > Are you proposing to add a kernel parameter to allow any RMRR for an
>>
>>  > arbitrary device to be relaxed, or I didn't get the idea here?
>>
>>  >
>>
>>  > Best regards,
>>
>>  > baolu
>>
>>
>> Correct, the idea here is that, while this observation can only be 
>> made on specific hardware, it more often than not occurs that devices 
>> that definitely shouldn't be (like e.g. GPUs attached to the PCIe 
>> Interface) are marked as reserved by offending firmware. A perfect 
>> solution would of course be to force the hardware vendors to push a 
>> firmware update that resolves the violation of Intel's specifications, 
>> but such a thing doesn't appear to have happened in the past and it's 
>> very unlikely that, let's say Hewlett Packard Enterprise, will ever 
>> release a firmware update for those thousands of broken servers.
>>
>>
>> (Quoted from here; 
>> https://github.com/Aterfax/relax-intel-rmrr/blob/master/deep-dive.md#rmrr---the-monster-in-a-closet ;
>>
>>
>> /Intel anticipated the some will be tempted to misuse the feature as 
>> they warned in the VT-d specification: "RMRR regions are expected to 
>> be used for legacy usages (...). Platform designers should avoid or 
>> limit use of reserved memory regions"./
>>
>>
>> /HP (and probably others) decided to mark every freaking PCI device 
>> memory space as RMRR! Like that, just in case... just that their tools 
>> could potentially maybe monitor these devices while OS agent is not 
>> installed. But wait, there's more! They marked ALL devices as such, 
>> even third party ones physically installed in motherboard's PCI/PCIe 
>> slots!/)
>>
>>
>> Hope this could clarify my inquiry a bit more.
> 
> Thanks for the information.
> 
> This Red Hat white paper explains why RMRR is not supported for device
> pass-through.
> 
> https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
> 
> I am concerned that adding a kernel option to release all RMRRs blindly
> could be harmful to users. Some users may not be aware of how RMRR
> impacts device passthrough and may only use the option because they
> find it will help them in some use cases where it's impossible without
> it.

Agreed, I would be very uncomfortable doing anything at the IOMMU API 
level to override firmware information. Not to mention that doing 
anything at the level of individual drivers is plain impractical when we 
already have at least 4 of these mechanisms (Intel RMRR, AMD IVMD, Arm 
IORT RMR, and now the generic Devicetree binding as well).

The thing to propose, if anything, would be not messing with the 
reserved regions themselves, but adding another "I know what I'm doing 
and I accept responsibility for picking the pieces up if it breaks" 
control at the VFIO level to permit assignment in spite of them - it 
feels like it's probably somewhere in between allow_unsafe_interrupts 
and noiommu mode in terms of potential impact, so doesn't seem entirely 
unreasonable off the bat.

Thanks,
Robin.
