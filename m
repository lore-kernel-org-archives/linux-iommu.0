Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E071642C
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 18:17:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF8E311FB;
	Mon, 22 May 2023 11:18:42 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295A73F67D;
	Mon, 22 May 2023 11:17:57 -0700 (PDT)
Message-ID: <cdf49ed5-6d3d-c087-22e4-b42713e3ace7@arm.com>
Date: Mon, 22 May 2023 19:17:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Content-Language: en-GB
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, bugtracker@fischbytes.de,
 iommu@lists.linux.dev
References: <2282218.ElGaqSPkdT@helios-lx>
 <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
 <1877598.tdWV9SEqCh@helios-lx>
 <302501af-05a3-9757-d923-602ad9a6d9c9@linux.intel.com>
 <c36e755a-416a-cf50-57fb-78438a2f61db@arm.com>
 <20230522104422.1ae39d78.alex.williamson@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230522104422.1ae39d78.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/05/2023 5:44 pm, Alex Williamson wrote:
> On Mon, 22 May 2023 12:42:51 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2023-05-16 02:13, Baolu Lu wrote:
>>> On 5/13/23 9:11 PM, bugtracker@fischbytes.de wrote:
>>>> On Saturday, May 13, 2023 8:20:40 AM CEST you wrote:
>>>>   
>>>>   > On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote:
>>>>   
>>>>   > > Hi there,
>>>>   
>>>>   > >
>>>>   
>>>>   > > I came here today to ask if there are any plans regarding the
>>>>   
>>>>   > > implementation of a "relaxed RMRR" kernel parameter to aid using
>>>> IOMMU on
>>>>   
>>>>   > > broken platforms such as the ProLiant Series by Hewlett Packard
>>>>   
>>>>   > > Enterprise. To everyone not aware of the issue;
>>>>   
>>>>   > >
>>>>   
>>>>   > > Certain vendors that are under the assumption that standards are
>>>> for jerks
>>>>   
>>>>   > > and Intel's specifications are a loose optional guideline have
>>>>   
>>>>   > > implemented RMRR in such a way that every PCI device is marked as
>>>>   
>>>>   > > reserved and therefore cannot be passed through to a virtual
>>>> machine.
>>>>   
>>>>   > > This issue has been very well documented by some people that have
>>>> a lot
>>>>   
>>>>   > > more experience than I do at the below linked resource. I was
>>>> hoping that
>>>>   
>>>>   > > the kernel devs could implement the Relaxed RMRR option as an
>>>> optional
>>>>   
>>>>   > > kernel parameter to use on these bugged platforms as that would
>>>> re-enable
>>>>   
>>>>   > > or rather enable a lot of broken servers for the first time ever
>>>> to use
>>>>   
>>>>   > > PCIe Passthrough. I can verify the issue exists on a HPE DL360e
>>>> Gen8 with
>>>>   
>>>>   > > trying to passthrough a GPU to a KVM/QEMU machine.
>>>>   
>>>>   > >
>>>>   
>>>>   > > Link to fix: https://github.com/Aterfax/relax-intel-rmrr
>>>>   
>>>>   > >
>>>>   
>>>>   > > Furthermore, since I am not a developer and wouldn't claim that I am
>>>>   
>>>>   > > competent enough to decide whether or not implementing this patch
>>>> would
>>>>   
>>>>   > > present an issue in terms of stability or security, I was hoping
>>>> that you
>>>>   
>>>>   > > could evaluate the situation. I can verify the pre-built packages
>>>> for the
>>>>   
>>>>   > > Proxmox Linux environment fix the issue and behave identical in
>>>> function
>>>>   
>>>>   > > to other systems that ignore RMRR completely, such as VMWare ESXi.
>>>>   
>>>>   > >
>>>>   
>>>>   > > Thanks alot in advance, you implementing this patch would really
>>>> mean a
>>>>   
>>>>   > > lot, since the hardware manufacturers just don't seem to care for
>>>> fixing
>>>>   
>>>>   > > up this, erm, mess.
>>>>   
>>>>   >
>>>>   
>>>>   > The relaxed RMRRs are used for legacy purpose, but it requires the
>>>> full
>>>>   
>>>>   > range of memory addresses are available after the OS device driver
>>>> takes
>>>>   
>>>>   > over the control of the device.
>>>>   
>>>>   >
>>>>   
>>>>   > Not all RMRRs are of this type and typically the VT-d driver only
>>>> allows
>>>>   
>>>>   > those RMRRs for USB and graphic devices as relaxed ones.
>>>>   
>>>>   >
>>>>   
>>>>   > Are you proposing to add a kernel parameter to allow any RMRR for an
>>>>   
>>>>   > arbitrary device to be relaxed, or I didn't get the idea here?
>>>>   
>>>>   >
>>>>   
>>>>   > Best regards,
>>>>   
>>>>   > baolu
>>>>
>>>>
>>>> Correct, the idea here is that, while this observation can only be
>>>> made on specific hardware, it more often than not occurs that devices
>>>> that definitely shouldn't be (like e.g. GPUs attached to the PCIe
>>>> Interface) are marked as reserved by offending firmware. A perfect
>>>> solution would of course be to force the hardware vendors to push a
>>>> firmware update that resolves the violation of Intel's specifications,
>>>> but such a thing doesn't appear to have happened in the past and it's
>>>> very unlikely that, let's say Hewlett Packard Enterprise, will ever
>>>> release a firmware update for those thousands of broken servers.
>>>>
>>>>
>>>> (Quoted from here;
>>>> https://github.com/Aterfax/relax-intel-rmrr/blob/master/deep-dive.md#rmrr---the-monster-in-a-closet ;
>>>>
>>>>
>>>> /Intel anticipated the some will be tempted to misuse the feature as
>>>> they warned in the VT-d specification: "RMRR regions are expected to
>>>> be used for legacy usages (...). Platform designers should avoid or
>>>> limit use of reserved memory regions"./
>>>>
>>>>
>>>> /HP (and probably others) decided to mark every freaking PCI device
>>>> memory space as RMRR! Like that, just in case... just that their tools
>>>> could potentially maybe monitor these devices while OS agent is not
>>>> installed. But wait, there's more! They marked ALL devices as such,
>>>> even third party ones physically installed in motherboard's PCI/PCIe
>>>> slots!/)
>>>>
>>>>
>>>> Hope this could clarify my inquiry a bit more.
>>>
>>> Thanks for the information.
>>>
>>> This Red Hat white paper explains why RMRR is not supported for device
>>> pass-through.
>>>
>>> https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
>>>
>>> I am concerned that adding a kernel option to release all RMRRs blindly
>>> could be harmful to users. Some users may not be aware of how RMRR
>>> impacts device passthrough and may only use the option because they
>>> find it will help them in some use cases where it's impossible without
>>> it.
>>
>> Agreed, I would be very uncomfortable doing anything at the IOMMU API
>> level to override firmware information. Not to mention that doing
>> anything at the level of individual drivers is plain impractical when we
>> already have at least 4 of these mechanisms (Intel RMRR, AMD IVMD, Arm
>> IORT RMR, and now the generic Devicetree binding as well).
>>
>> The thing to propose, if anything, would be not messing with the
>> reserved regions themselves, but adding another "I know what I'm doing
>> and I accept responsibility for picking the pieces up if it breaks"
>> control at the VFIO level to permit assignment in spite of them - it
>> feels like it's probably somewhere in between allow_unsafe_interrupts
>> and noiommu mode in terms of potential impact, so doesn't seem entirely
>> unreasonable off the bat.
> 
> I'd more likely put this in the same category as the ACS override
> patch, which we've rejected from mainline.
> 
> In the case of the unsafe interrupts option, the risk is a malicious
> guest exploiting arbitrary interrupt vectors on the host.  I certainly
> wouldn't suggest this opt-in for a virtual hosting service, but there
> are a good number of use cases where it can be a relatively safe
> assumption that the guest OS has not been subverted.  Unlike RMRR or
> ACS, an exploit of this vector more likely resulted in a denial of
> service rather than a potential for silent data corruption, and had
> there not been an opt-in, it would have broken the majority of x86
> device assignment cases at the time.  It's also telling that this
> option, which is all but irrelevant on any remotely modern x86 system
> now, still appears with some regularity in vfio related guides, forums,
> and bug logs.

FWIW I'd view the risk here as about the same - in the worst case, if 
you take a device with an active RMRR and assign it to a VFIO domain 
which doesn't have that RMRR mapped properly, what's going to happen is 
that the device causes a bunch of IOMMU faults and/or corrupts 
userspace's memory, and probably stops working. Userspace is already 
free to cause IOMMU faults and/or break its assigned devices by 
misprogramming them, so realistically there's not actually much 
practical impact from the host PoV.

> OTOH, noiommu is an entirely different beast.  The argument for noiommu
> is that certain environments are making use of direct DMA programming
> of devices that are not protected by an IOMMU anyway, access to
> /dev/mem and pci-sysfs enables this given sufficient privileges.  The
> gap that vfio noiommu filled was MSI interrupts.  We'd generally like
> these use cases to move to proper IOMMU protected vfio environments
> anyway, so the goal here was to make that transition easier by waving a
> carrot for making use of the vfio device interface with MSI interrupts
> rather than extending uio-pci-generic beyond what it intended to
> support.  Importantly, vfio noiommu taints the kernel (introducing
> logging of these use cases), requires access using a different device
> file (requiring userspace, as well as kernel opt-in), and provides no
> DMA translation (ruling out more common use cases like VM assignment).

I drew the parallel here being in terms of an option for making the VFIO 
interface usable in a situation where it otherwise wouldn't (or 
shouldn't) be. The current situation is that we have at least 3 IOMMU 
drivers (AMD and the Arm SMMUs) where VFIO *can* go ahead and assign a 
device with reserved regions as long as they don't overlap with any VFIO 
mappings, and let the user unknowingly face the consequences, while one 
driver takes it upon itself to say "hey, assigning this device looks 
like a bad idea since it may not work as you expect - for your own good 
I'm not going to do it." We've already discussed elsewhere about 
rationalising that, which would be the first step towards having a 
coherent argument at all, but after that, at least giving a 
sufficiently-committed user the opportunity to acknowledge and accept 
the risk seems fair in general (I'm thinking a kernel taint and maybe 
requiring a list of specific device BDFs would be a reasonable level of 
involvement).

> Much like what appears to be the history of this patch, the ACS
> override patch has lived a life beyond its initial mainline proposal and
> rejection, it's even been included in a few downstream kernel builds,
> but none of the mainstream distros AFAIK.  My observations of its use
> cases in various communities suggest to me that it was the right choice
> to reject it from mainline.  Like the unsafe interrupt option above,
> making the option sound scary or logging warning in dmesg does not
> ultimately have much affect in an average user's choice to enable these
> sorts of options.  On the contrary, we might speculate that had such
> workarounds been so readily available, would we have as many ACS quirks
> as we do now, would vendors have moved away from RMRRs?
> 
> It's unfortunate that there are generations of server lines that have
> such a barrier to these sorts of use cases, but ultimately we still
> cannot vouch that it's safe to ignore RMRR requirements imposed by the
> firmware in these systems.  Including such options in mainline provides
> a certain degree of validity in these workarounds that we cannot
> support.  Therefore, I'd not be in favor of a user option to ignore a
> firmware directive like this in the mainline kernel, especially to
> enable a system that's potentially already a decade old.  Thanks,

I would agree on that point, though. This particular case does sound 
like such a completely bonkers misuse of RMRRs that frankly I don't 
think I'd want to give any potential appearance of legitimising it to 
any degree either. If a more reasonable case comes to light, though, at 
least the discussion is here on the record now :)

Cheers,
Robin.
