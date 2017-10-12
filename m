From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to
 and from devices
Date: Thu, 12 Oct 2017 14:47:38 +0200
Message-ID: <20171012124738.r5lihlxaedwkw4oq@8bytes.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <20171011113348.GE30803@8bytes.org>
 <ee7f80e3-ca30-0ee7-53f3-3e57b2b58df6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ee7f80e3-ca30-0ee7-53f3-3e57b2b58df6-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas@goog>
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On Thu, Oct 12, 2017 at 12:13:20PM +0100, Jean-Philippe Brucker wrote:
> On 11/10/17 12:33, Joerg Roedel wrote:
> > Here is how I think the base API should look like:
> > 
> > 	* iommu_iovm_device_init(struct device *dev);
> > 	  iommu_iovm_device_shutdown(struct device *dev);
> > 
> > 	  These two functions do the device specific setup/shutdown. For
> > 	  PCI this would include enabling the PRI, PASID, and ATS
> > 	  capabilities and setting up a PASID table for the device.
> 
> Ok. On SMMU the PASID table also hosts the non-PASID page table pointer,
> so the table and capability cannot be setup later than attach_device (and
> we'll probably have to enable PASID in add_device). But I suppose it's an
> implementation detail.

Right, when the capabilities are enabled is an implementation detail of
the iommu-drivers. 

> Some device drivers will want to use ATS alone, for accelerating IOVA
> traffic. Should we enable it automatically, or provide device drivers with
> a way to enable it manually? According to the PCI spec, PASID has to be
> enabled before ATS, so device_init would have to first disable ATS in that
> case.

Yes, driver can enable ATS for normal use of a device, and
disable/re-enable it when the driver requests PASID/PRI functionality.
That is also an implementation detail. You should probably also document
that the init/shutdown functions may interrupt device operation, so that
driver writers are aware of that.

> 
> > 	* iommu_iovm_bind_mm(struct device *dev, struct mm_struct *mm,
> > 			     iovm_shutdown_cb *cb);
> > 	  iommu_iovm_unbind_mm(struct device *dev, struct mm_struct *mm);
> > 
> > 	  These functions add and delete the entries in the PASID table
> > 	  for the device and setup mmu_notifiers for the mm_struct to
> > 	  keep IOMMU TLBs in sync with the CPU TLBs.
> > 
> > 	  The shutdown_cb is invoked by the IOMMU core code when the
> > 	  mm_struct goes away, for example because the process
> > 	  segfaults.
> > 
> > 	The PASID handling is best done these functions as well, unless
> > 	there is a strong reason to allow device drivers to do the
> > 	handling themselves.
> > 
> > The context data can be stored directly in mm_struct, including the
> > PASID for that mm.
> 
> Changing mm_struct probably isn't required at the moment, since the mm
> subsystem won't use the context data or the PASID. Outside of
> drivers/iommu/, only the caller of bind_mm needs the PASID in order to
> program it into the device. The only advantage I see would be slightly
> faster bind(), when finding out if a mm is already bound to devices. But
> we don't really need fast bind(), so I don't think we'd have enough
> material to argue for a change in mm_struct.

The idea behind storing the PASID in mm_struct is that we have a
system-wide PASID-allocator and only one PASID per address space, even
when accessed from multiple devices.

There will be hardware implemenations where this is required, afaik. It
doesn't mean that it _needs_ to be part of mm_struct, but it is
certainly easier than tracking this 1-1 relation separatly.

> We do need to allocate a separate "iommu_mm_struct" wrapper to store the
> mmu_notifier. Maybe bind() could return this structure (that contains the
> PASID), and unbind() would take this iommu_mm_struct as argument?

I'd like to track this iommu_mm_struct only in iommu-code, otherwise
drivers need to track the pointer somewhere. And we need to track the
mm_struct->iommu_mm_struct relation anyway in core-code to handle events
like segfaults, when the whole mm_struct goes away under us. So when we
track this in core code, there is no need to track this again in the
device drivers.


Regards,

	Joerg

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
