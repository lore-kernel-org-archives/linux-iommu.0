From: Auger Eric <eric.auger@redhat.com>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Tue, 8 Nov 2016 15:27:23 +0100
Message-ID: <dae12190-1eb6-20a9-5740-9e5be8bb65fc@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home> <20161108024559.GA20591@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108024559.GA20591@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, joro@8bytes.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, tglx@linutronix.de, robin.murphy@arm.com, dwmw@amazon.co.uk, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 08/11/2016 03:45, Will Deacon wrote:
> Hi all,
> 
> I figured this was a reasonable post to piggy-back on for the LPC minutes
> relating to guest MSIs on arm64.
> 
> On Thu, Nov 03, 2016 at 10:02:05PM -0600, Alex Williamson wrote:
>> We can always have QEMU reject hot-adding the device if the reserved
>> region overlaps existing guest RAM, but I don't even really see how we
>> advise users to give them a reasonable chance of avoiding that
>> possibility.  Apparently there are also ARM platforms where MSI pages
>> cannot be remapped to support the previous programmable user/VM
>> address, is it even worthwhile to support those platforms?  Does that
>> decision influence whether user programmable MSI reserved regions are
>> really a second class citizen to fixed reserved regions?  I expect
>> we'll be talking about this tomorrow morning, but I certainly haven't
>> come up with any viable solutions to this.  Thanks,
> 
> At LPC last week, we discussed guest MSIs on arm64 as part of the PCI
> microconference. I presented some slides to illustrate some of the issues
> we're trying to solve:
> 
>   http://www.willdeacon.ukfsn.org/bitbucket/lpc-16/msi-in-guest-arm64.pdf
> 
> Punit took some notes (thanks!) on the etherpad here:
> 
>   https://etherpad.openstack.org/p/LPC2016_PCI

Thanks to both of you for the minutes and slides. Unfortunately I could
not travel but my ears were burning ;-)
> 
> although the discussion was pretty lively and jumped about, so I've had
> to go from memory where the notes didn't capture everything that was
> said.
> 
> To summarise, arm64 platforms differ in their handling of MSIs when compared
> to x86:
> 
>   1. The physical memory map is not standardised (Jon pointed out that
>      this is something that was realised late on)
>   2. MSIs are usually treated the same as DMA writes, in that they must be
>      mapped by the SMMU page tables so that they target a physical MSI
>      doorbell
>   3. On some platforms, MSIs bypass the SMMU entirely (e.g. due to an MSI
>      doorbell built into the PCI RC)
>   4. Platforms typically have some set of addresses that abort before
>      reaching the SMMU (e.g. because the PCI identifies them as P2P).
> 
> All of this means that userspace (QEMU) needs to identify the memory
> regions corresponding to points (3) and (4) and ensure that they are
> not allocated in the guest physical (IPA) space. For platforms that can
> remap the MSI doorbell as in (2), then some space also needs to be
> allocated for that.
> 
> Rather than treat these as separate problems, a better interface is to
> tell userspace about a set of reserved regions, and have this include
> the MSI doorbell, irrespective of whether or not it can be remapped.
> Don suggested that we statically pick an address for the doorbell in a
> similar way to x86, and have the kernel map it there. We could even pick
> 0xfee00000. If it conflicts with a reserved region on the platform (due
> to (4)), then we'd obviously have to (deterministically?) allocate it
> somewhere else, but probably within the bottom 4G.

This is tentatively achieved now with
[1] [RFC v2 0/8] KVM PCIe/MSI passthrough on ARM/ARM64 - Alt II
(http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264506.html)
> 
> The next question is how to tell userspace about all of the reserved
> regions. Initially, the idea was to extend VFIO, however Alex pointed
> out a horrible scenario:
> 
>   1. QEMU spawns a VM on system 0
>   2. VM is migrated to system 1
>   3. QEMU attempts to passthrough a device using PCI hotplug
> 
> In this scenario, the guest memory map is chosen at step (1), yet there
> is no VFIO fd available to determine the reserved regions. Furthermore,
> the reserved regions may vary between system 0 and system 1. This pretty
> much rules out using VFIO to determine the reserved regions.Alex suggested
> that the SMMU driver can advertise the regions via /sys/class/iommu/. This
> would solve part of the problem, but migration between systems with
> different memory maps can still cause problems if the reserved regions
> of the new system conflict with the guest memory map chosen by QEMU.


OK so I understand we do not want anymore the VFIO chain capability API
(patch 5 of above series) but we prefer a sysfs approach instead.

I understand the sysfs approach which allows the userspace to get the
info earlier and independently on VFIO. Keeping in mind current QEMU
virt - which is not the only userspace - will not do much from this info
until we bring upheavals in virt address space management. So if I am
not wrong, at the moment the main action to be undertaken is the
rejection of the PCI hotplug in case we detect a collision.

I can respin [1]
- studying and taking into account Robin's comments about dm_regions
similarities
- removing the VFIO capability chain and replacing this by a sysfs API

Would that be OK?

What about Alex comments who wanted to report the usable memory ranges
instead of unusable memory ranges?

Also did you have a chance to discuss the following items:
1) the VFIO irq safety assessment
2) the MSI reserved size computation (is an arbitrary size OK?)

Thanks

Eric

> Jon pointed out that most people are pretty conservative about hardware
> choices when migrating between them -- that is, they may only migrate
> between different revisions of the same SoC, or they know ahead of time
> all of the memory maps they want to support and this could be communicated
> by way of configuration to libvirt. It would be up to QEMU to fail the
> hotplug if it detected a conflict. Alex asked if there was a security
> issue with DMA bypassing the SMMU, but there aren't currently any systems
> where that is known to happen. Such a system would surely not be safe for
> passthrough.
> 
> Ben mused that a way to handle conflicts dynamically might be to hotplug
> on the entire host bridge in the guest, passing firmware tables describing
> the new reserved regions as a property of the host bridge. Whilst this
> may well solve the issue, it was largely considered future work due to
> its invasive nature and dependency on firmware tables (and guest support)
> that do not currently exist.
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
