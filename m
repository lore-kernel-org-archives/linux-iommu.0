From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Date: Thu, 7 Jun 2018 14:21:13 +0100
Message-ID: <d10d7011-08c0-2945-8587-3b4c35c84f2c@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180417131047.0a9c310f@w520.home>
 <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
 <20180420164251.5245f822@jacob-builder> <20180529140915.1f174689@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
 <20180529211746.74f1dd23@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06@SHSMSX101.ccr.corp.intel.com>
 <a07a0a0a-ebdd-c81a-7ed6-cff19e6078d7@arm.com>
 <20180530125240.34e0e80c@jacob-builder>
 <1c1094e8-ecbb-7731-910c-59e4de1e5c70@arm.com>
 <20180605103253.634ef8fd@jacob-builder>
 <2831caf1-d40b-58c3-313c-afb7262e1861@arm.com>
 <20180606142204.529adec5@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606142204.529adec5@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>, Auger Eric <eric.auger@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On 06/06/18 22:22, Jacob Pan wrote:
> On Wed, 6 Jun 2018 12:20:51 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 05/06/18 18:32, Jacob Pan wrote:
>>>> "bytes" could be passed by VFIO as argument to bind_pasid_table,
>>>> since it can deduce it from argsz
>>>>  
>>> Are you suggesting we wrap this struct in a vfio struct with argsz?
>>> or we directly use this struct?
>>>
>>> I need to clarify how vfio will use this.  
>>
>> Right, I think we've diverged a bit since the last discussion :)
>>
>>> - User program:
>>> struct pasid_table_config ptc = { .bytes = sizeof(ptc) };
>>> ptc.version = 1;
>>> ioctl(device, VFIO_DEVICE_BIND_PASID_TABLE, &ptc);  
>>
>> Any reason to do the ioctl on device instead of container? As we're
>> binding address spaces we probably want a consistent view for the
>> whole container, like the MAP/UNMAP ioctls do.
>>
> I was thinking the pasid table storage is per device, it would be
> more secure if the pasid table is contained within the device. We
> should have one device per container in most cases.
> in case of two or more devices in the same container shares the same
> pasid table, isolation may not be good in that the second device can
> dma with pasids it does not own but in the shared pasid table.

The situation seems similar to map/unmap interface: if two devices are
in the same container, they are not isolated from each others, they
access the same address space. One device can access mappings that were
created for the other, and it's a feature rather than a security issue.
In a non-SVA configuration, if user wants to isolate two devices (the
usual case), they will use different containers. With SVA I think they
should keep doing that. But that's probably a matter of taste more than
a technical problem.

My issue with doing the ioctl on device, though, is that we tell users
that we can isolate PASIDs at device granularity, which isn't
necessarily the case. If two PCI devices are in the same group because
they aren't isolated by ACS (they can do p2p), then a BIND_PASID_TABLE
call on one device might allow the other device to see the same address
spaces, even if that other device doesn't have a pasid table.

In my host-sva patches I don't allow bind if there's more than one
device in the group, but that's only to keep the series simple, and I
don't think we should prevent SVA support for multi-device groups from
being added later (some people might actually want p2p + PASID). So if
not on containers, the ioctl should at least be on groups. Otherwise
we'll make false promises to users and might run into trouble later.

>> As I remember it the userspace interface would use a VFIO header and
>> the BIND ioctl. I can't find the email in my archive though, so I
>> might be imagining it. This is what I remember, on the user side:
>>
>> struct {
>> 	struct vfio_iommu_type1_bind	hdr;
>> 	struct pasid_table_config	cfg;
>> } bind = {
>> 	.hdr.argsz	= sizeof(bind),
>> 	.hdr.flags	= VFIO_IOMMU_BIND_PASID_TABLE,
>> 	/* cfg data here */
>> };
>>
>> ioctl(container, VFIO_DEVICE_BIND, &bind);
>>
> or maybe just use your VFIO_IOMMU_BIND command and vfio_iommu_type1_bind
> with a new flag and PTC as the data. there can be future extensions,
> bind pasid table can be too narrow. And i agree below using argsz and
> flags are more flexible.
> 
> i.e.
> /* takes pasid_table_config as data for flag VFIO_IOMMU_BIND_PASIDTBL */
> struct vfio_iommu_type1_bind {
> 	__u32	argsz;
> 	__u32	flags;
> #define VFIO_IOMMU_BIND_PROCESS		(1 << 0)
> #define VFIO_IOMMU_BIND_PASIDTBL	(1 << 1)
> 	__u8	data[];
> };
> 
> pseudo code in kernel:
> 	switch (bind.flags) {
> 	case VFIO_IOMMU_BIND_PROCESS:
> 		return vfio_iommu_type1_bind_process(iommu, (void *)arg,
> 						     &bind);
> 	case VFIO_IOMMU_BIND_PASIDTBL:
> 		return vfio_iommu_type1_bind_pasid_tbl(iommu, &bind);
> }
> 
> vfio_iommu_type1_bind_pasid_tbl(iommu, bind)
> {
> 	/* loop through domain list, group, device */
> 	struct pasid_table_cfg *ptc = bind->data;
> 	iommu_bind_pasid_table(domain, device, ptc);
> }

Seems sensible

Thanks,
Jean
