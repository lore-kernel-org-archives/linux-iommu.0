From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Thu, 12 Oct 2017 20:05:38 +0800
Message-ID: <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0fecd29e-eaf7-9503-b087-7bfbc251da88-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, nwatters@c
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

Thanks for replying.
On 2017/10/9 19:36, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 09/10/17 10:49, Yisheng Xie wrote:
>> Hi Jean,
>>
>> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>>> Following discussions at plumbers and elsewhere, it seems like we need to
>>> unify some of the Shared Virtual Memory (SVM) code, in order to define
>>> clear semantics for the SVM API.
>>>
>>> My previous RFC [1] was centered on the SMMUv3, but some of this code will
>>> need to be reused by the SMMUv2 and virtio-iommu drivers. This second
>>> proposal focuses on abstracting a little more into the core IOMMU API, and
>>> also trying to find common ground for all SVM-capable IOMMUs.
>>>
>>> SVM is, in the context of the IOMMU, sharing page tables between a process
>>> and a device. Traditionally it requires IO Page Fault and Process Address
>>> Space ID capabilities in device and IOMMU.
>>>
>>> * A device driver can bind a process to a device, with iommu_process_bind.
>>>   Internally we hold on to the mm and get notified of its activity with an
>>>   mmu_notifier. The bond is removed by exit_mm, by a call to
>>>   iommu_process_unbind or iommu_detach_device.
>>>
>>> * iommu_process_bind returns a 20-bit PASID (PCI terminology) to the
>>>   device driver, which programs it into the device to access the process
>>>   address space.
>>>
>>> * The device and the IOMMU support recoverable page faults. This can be
>>>   either ATS+PRI for PCI, or platform-specific mechanisms such as Stall
>>>   for SMMU.
>>>
>>> Ideally systems wanting to use SVM have to support these three features,
>>> but in practice we'll see implementations supporting just a subset of
>>> them, especially in validation environments. So even if this particular
>>> patchset assumes all three capabilities, it should also be possible to
>>> support PASID without IOPF (by pinning everything, see non-system SVM in
>>> OpenCL)
>> How to pin everything? If user malloc anything we should pin it. It should
>> from user or driver?
> 
> For userspace drivers, I guess it would be via a VFIO ioctl, that does the
> same preparatory work as VFIO_IOMMU_MAP_DMA, but doesn't call iommu_map.
> For things like OpenCL SVM buffers, it's the kernel driver that does the
> pinning, just like VFIO does it, before launching the work on a SVM buffer.
> 
>>> , or IOPF without PASID (sharing the single device address space
>>> with a process, could be useful for DPDK+VFIO).
>>>
>>> Implementing both these cases would enable PT sharing alone. Some people
>>> would also like IOPF alone without SVM (covered by this series) or process
>>> management without shared PT (not covered). Using these features
>>> individually is also important for testing, as SVM is in its infancy and
>>> providing easy ways to test is essential to reduce the number of quirks
>>> down the line.
>>>
>>>   Process management
>>>   ==================
>>>
>>> The first part of this series introduces boilerplate code for managing
>>> PASIDs and processes bound to devices. It's something any IOMMU driver
>>> that wants to support bind/unbind will have to do, and it is difficult to
>>> get right.
>>>
>>> Patches
>>> 1: iommu_process and PASID allocation, attach and release
>>> 2: process_exit callback for device drivers
>>> 3: iommu_process search by PASID
>>> 4: track process changes with an MMU notifiers
>>> 5: bind and unbind operations
>>>
>>> My proposal uses the following model:
>>>
>>> * The PASID space is system-wide. This means that a Linux process will
>>>   have a single PASID. I introduce the iommu_process structure and a
>>>   global IDR to manage this.
>>>
>>> * An iommu_process can be bound to multiple domains, and a domain can have
>>>   multiple iommu_process.
>> when bind a task to device, can we create a single domain for it? I am thinking
>> about process management without shared PT(for some device only support PASID
>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
>> Do you have any idea about this?
> 
> A device always has to be in a domain, as far as I know. Not supporting
> PRI forces you to pin down all user mappings (or just the ones you use for
> DMA) but you should sill be able to share PT. Now if you don't support
> shared PT either, but only PASID, then you'll have to use io-pgtable and a
> new map/unmap API on an iommu_process. I don't understand your concern
> though, how would the link between process and domains prevent this use-case?
> 
So you mean that if an iommu_process bind to multiple devices it should create
multiple io-pgtables? or just share the same io-pgtable?

>>> * IOMMU groups share same PASID table. IOMMU groups are a convenient way
>>>   to cover various hardware weaknesses that prevent a group of device to
>>>   be isolated by the IOMMU (untrusted bridge, for instance). It's foolish
>>>   to assume that all PASID implementations will perfectly isolate devices
>>>   within a bus and functions within a device, so let's assume all devices
>>>   within an IOMMU group have to share PASID traffic as well. In general
>>>   there will be a single device per group.
>>>
>>> * It's up to the driver implementation to decide where to implement the
>>>   PASID tables. For SMMU it's more convenient to have a single PASID table
>>>   per domain. And I think the model fits better with the existing IOMMU
>>>   API: IOVA traffic is shared by all devices in a domain, so should PASID
>>>   traffic.
>> What's the meaning of "share PASID traffic"? PASID space is system-wide,
>> and a domain can have multiple iommu_process , so a domain can have multiple
>> PASIDs , one PASID for a iommu_process, right?
I get what your mean now, thanks for your explain.

> 
> Yes, I meant that if a device can access mappings for a specific PASID,
> then other devices in that same domain are also able to access them.
> 
> A few reasons for this choice in the SMMU:
> * As all devices in an IOMMU group will be in the same domain and share
> the same PASID traffic, it encompasses that case. Groups are the smallest
> isolation granularity, then users are free to choose to put different
> IOMMU groups in different domains.
> * For architectures that can have both non-PASID and PASID traffic
> simultaneously, like the SMMU, it is simpler to reason about PASID tables
> being a domain, rather than sharing PASID0 within the domain and handling
> all others per device.
> * It's the same principle as non-PASID mappings (iommu_map/unmap is on a
> domain).
> * It implement the classic example of IOMMU architectures where multiple
> device descriptors point to the same PASID tables.
> * It may be desirable for drivers to share PASIDs within a domain, if they
> are actually using domains for conveniently sharing address spaces between
> devices. I'm not sure how much this is used as a feature. It does model a
> shared bus where each device can snoop DMA, so it may be useful.
> 

I get another question about this design, thinking about the following case:

If a platform device with PASID ability, e.g. accelerator, which have multiple
accelerator process units(APUs), it may create multiple virtual devices, one
virtual device represent for an APU, with the same sid.

They can be in different groups, however must be in the same domain as this
design, for domain held the PASID table, right? So how could they be used by
different guest OS?

Thanks
Yisheng Xie

> bind/unbind operations are done on devices and not domains, though,
> because it allows users to know which device supports PASID, PRI, etc.
> 
> Thanks,
> Jean
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
