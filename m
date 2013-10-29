From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
 based	devices
Date: Tue, 29 Oct 2013 21:58:13 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15036EEB83@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
  <1380554923-17818-3-git-send-email-a.motakis@virtualopensystems.com>
  <6A3DF150A5B70D4F9B66A25E3F7C888D0718A4AC@039-SN2MPN1-011.039d.mgd.msft.net>
  <526F0F7F.1040509@redhat.com> <1383047233.4097.124.camel@ul30vt.home>
 <526FECB7.9050904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <526FECB7.9050904@redhat.com>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Bhushan Bharat-R65777 <R65777@freescale.com>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Don Dutile [mailto:ddutile@redhat.com]
> Sent: Tuesday, October 29, 2013 12:13 PM
> To: Alex Williamson
> Cc: Bhushan Bharat-R65777; Antonios Motakis;
> kvmarm@lists.cs.columbia.edu; linux-samsung-soc@vger.kernel.org;
> kvm@vger.kernel.org; agraf@suse.de; Yoder Stuart-B08248;
> iommu@lists.linux-foundation.org; tech@virtualopensystems.com
> Subject: Re: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
> based devices
> 
> On 10/29/2013 07:47 AM, Alex Williamson wrote:
> > On Mon, 2013-10-28 at 21:29 -0400, Don Dutile wrote:
> >> On 09/30/2013 11:37 AM, Bhushan Bharat-R65777 wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> >>>> bounces@lists.linux-foundation.org] On Behalf Of Antonios Motakis
> >>>> Sent: Monday, September 30, 2013 8:59 PM
> >>>> To: kvmarm@lists.cs.columbia.edu; alex.williamson@redhat.com
> >>>> Cc: linux-samsung-soc@vger.kernel.org; kvm@vger.kernel.org;
> agraf@suse.de; Yoder
> >>>> Stuart-B08248; iommu@lists.linux-foundation.org; Antonios Motakis;
> >>>> tech@virtualopensystems.com
> >>>> Subject: [PATCH 2/7] Initial skeleton of VFIO support for Device
> Tree based
> >>>> devices
> >>>>
> >>>> Platform devices in the Linux kernel are usually managed by the DT
> interface.
> >>>> This patch forms the base to support these kind of devices with
> VFIO.
> >>>>
> >>>> Signed-off-by: Antonios Motakis<a.motakis@virtualopensystems.com>
> >>>> ---
> >>>>    drivers/vfio/Kconfig         |  11 +++
> >>>>    drivers/vfio/Makefile        |   1 +
> >>>>    drivers/vfio/vfio_platform.c | 187
> +++++++++++++++++++++++++++++++++++++++++++
> >>>>    include/uapi/linux/vfio.h    |   1 +
> >>>>    4 files changed, 200 insertions(+)
> >>>>    create mode 100644 drivers/vfio/vfio_platform.c
> >>>>
> >>>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> 1f84eda..35254b7
> >>>> 100644
> >>>> --- a/drivers/vfio/Kconfig
> >>>> +++ b/drivers/vfio/Kconfig
> >>>> @@ -13,4 +13,15 @@ menuconfig VFIO
> >>>>
> >>>>    	  If you don't know what to do here, say N.
> >>>>
> >>>> +config VFIO_PLATFORM
> >>>> +	tristate "VFIO support for device tree based platform
> devices"
> >>>> +	depends on VFIO&&   EVENTFD&&   OF
> >>>> +	help
> >>>> +	  Support for platform devices with VFIO. This is required to
> make
> >>>> +	  use of platform devices present on device tree nodes using
> the VFIO
> >>>> +	  framework. Devices that are not described in the device
> tree cannot
> >>>> +	  be used by this driver.
> >>>> +
> >>>> +	  If you don't know what to do here, say N.
> >>>> +
> >>>>    source "drivers/vfio/pci/Kconfig"
> >>>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile index
> >>>> 2398d4a..575c8dd 100644
> >>>> --- a/drivers/vfio/Makefile
> >>>> +++ b/drivers/vfio/Makefile
> >>>> @@ -1,3 +1,4 @@
> >>>>    obj-$(CONFIG_VFIO) += vfio.o
> >>>>    obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >>>>    obj-$(CONFIG_VFIO_PCI) += pci/
> >>>> +obj-$(CONFIG_VFIO_PLATFORM) += vfio_platform.o
> >>>> diff --git a/drivers/vfio/vfio_platform.c
> b/drivers/vfio/vfio_platform.c new
> >>>
> >>> We can make this parallel to PCI, something like
> drivers/vfio/platform/platform.c
> >>>
> >> pls, no.  'platform' is too generic, and it really means 'arm-dt' ...
> so can
> >> move it to the arch/arm space, and have it's kconfig conditional on
> ARM&&VFIO.
> >> if kept under drivers/vfio, then use a better directory name that ties
> it to arm-dt.
> >> thanks.
> >
> > The intention is that vfio platform device support is not arm-dt
> > specific.  This is to be used by both arm and embedded ppc.  The
> devices
> > we intend to support with them are known as platform drivers in the
> > kernel, thus the name.  I suppose the question remains whether the
> > interface here is really generic for any "platform" device or whether
> > we're making whether we're making an interface specifically for device
> > tree platform devices, or if those are one in the same.  In any case,
> > arm-dt is certainly not the answer.
> >
> > Alex
> >
> I thought that was the intention until I saw this use in platform.c:
> 	static const struct of_device_id vfio_platform_match[] = {
> 
> So, of_device_id hit me as DT-specific, and thus, the file should have
> a name that implies its not as platform-generic as one may want/expect.
> I agree that the 'arm' part can be dropped, but it's not of-agnostic atm.

That part of the patch needs to be re-worked...and the comment
indicates it is not final.  The vfio-platform driver should not register
to handle specific compatible strings.  Kim Phillips has a 
patch posted that adds 'wildcard' support to platform drivers
so that a driver can bind to any device.

Stuart
