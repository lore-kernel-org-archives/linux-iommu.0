From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: [RFC 0/3] WIP VFIO for device tree devices on Arndale
Date: Mon, 5 Aug 2013 14:46:41 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503663FA7@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>
List-Id: iommu@lists.linux-foundation.org

Thanks for starting work on this.

> -----Original Message-----
> From: Antonios Motakis [mailto:a.motakis@virtualopensystems.com]
> Sent: Monday, August 05, 2013 8:17 AM
> To: linux-arm-kernel@lists.infradead.org; alex.williamson@redhat.com
> Cc: kvmarm@lists.cs.columbia.edu; iommu@lists.linux-foundation.org;
> linux-samsung-soc@vger.kernel.org; kvm@vger.kernel.org; agraf@suse.de;
> Yoder Stuart-B08248; Antonios Motakis
> Subject: [RFC 0/3] WIP VFIO for device tree devices on Arndale

I think we should call this infrastructure vfio for "platform
devices".  These devices are on a platform bus, as can be seen 
in /sys/bus/platform.  It is conceivable that there are platform
devices not in a device tree.

Also, the term "device tree devices" just seems awkward.

> This is a very early base work, towards VFIO support on ARM platforms
> with an IOMMU. It forms a base on to which to implement the functionality
> necessary to enable using device tree devices on ARM (and other platforms
> based on device trees) with VFIO.
> 
> This very early work of progress is only published for the sake of
> openness,
> and is very far from usable yet. However the driver can bind to devices,
> and return to userspace the info about the memory regions and IRQs.
> 
> This patch series has been tested on the Arndale board (with the Exynos
> 5250
> System MMU).
> 
> It depends on Cho KyongHo's patch series "iommu/exynos: Fixes and
> Enhancements
> of System MMU driver with DT", applied on a Linux 3.10.1 kernel, and also
> my
> own "iommu/exynos: add devices attached to the System MMU to an IOMMU
> group".
> Those patches are required at least in order to test the proposed module
> on
> Arndale.
> 
> This should not be treated as anything more than a work in progress.
> Numerous
> functions still need to be implemented properly, e.g.
>  - Proper binding of the VFIO_DT driver to devices; currently to test the
>    driver, one has to edit the device tree and add the "vfio-dt" to the
>    compatible property. However Linux does not support OF drivers that
>    can be dynamically bound to any device.

Yes, we really need to solve this.  I need to get more familiar with
the platform device infrastructure in Linux, but it seems at a high level
that it shouldn't be that hard to support dynamic binding.  We have
device drivers that register to handle certain "compatible"
strings.  And we have device tree parsing code that does platform_device_add()
calls to associate/bind a device to a driver.

What we need is something like the "new_id" mechanism in PCI where we
can have a platform driver dynamically register to support a new
device type.

Also, note that any Linux driver needs to properly support 'unbinding'
as well.   We can't have the normal driver and vfio competing to
bind to the same device.

>  - Most IOCTLs are not implemented yet. Memory region mapping, DMA
> mapping,
>    IRQFD still need to be added.
>  - The VFIO_IOMMU_TYPE1 is patched to work instead of PCI IOMMU, with
> platform
>    IOMMUs such as the one that is found on Arndale. This is a proof of
> concept
>    hack, and a more permanent fix will be proposed as the code matures.
> 
> The API used is identical to the existing VFIO API that is also used with
> PCI devices. Only devices that include a basic set of IRQs and memory
> regions
> are targeted; devices with complicated relationships with other devices
> on the
> device tree are not taken into account at this stage.
> 
> The API is not extended with device tree specific information; this would
> complicate the driver unnecessarily as it is not needed for the base use
> cases.

I would suggest adding a patch to this series that updates Documentation/vfio.txt
with any platform device specifics.

For example, it should be stated explicitly that if a device has multiple
regions and multiple IRQs that the "index" exposed by VFIO is the same
as the index within the associated "reg" and "interrupt" properties
in the device tree representation.

.i.e. if a device is represented like this in the device tree:

        reg = <0x101e2000 0x1000 0x101e4000 0x1000>;
        interrupts = <24 25 26 27>;

region #0 is 0x101e2000, region #1 is 0x101e4000
interrupt #0 is 24, and so on.

Perhaps that seems obvious, but think it is good to state it
explicitly in Documentation/vfio.txt.

> Antonios Motakis (3):
>   VFIO_IOMMU_TYPE1 workaround to build for platform devices
>   Initial skeleton of VFIO support for Device Tree based devices
>   Return info for device and its memory regions and interrupts
> 
>  drivers/vfio/Kconfig            |  12 ++-
>  drivers/vfio/Makefile           |   1 +
>  drivers/vfio/vfio_dt.c          | 233

would prefer:
drivers/vfio/vfio_platform.c

Thanks,
Stuart

