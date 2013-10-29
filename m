From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
 based	devices
Date: Tue, 29 Oct 2013 13:07:31 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15036EE436@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
 <1380554923-17818-3-git-send-email-a.motakis@virtualopensystems.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718A4AC@039-SN2MPN1-011.039d.mgd.msft.net>
 <526F0F7F.1040509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <526F0F7F.1040509@redhat.com>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>, Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Don Dutile [mailto:ddutile@redhat.com]
> Sent: Monday, October 28, 2013 8:30 PM
> To: Bhushan Bharat-R65777
> Cc: Antonios Motakis; kvmarm@lists.cs.columbia.edu;
> alex.williamson@redhat.com; linux-samsung-soc@vger.kernel.org;
> kvm@vger.kernel.org; agraf@suse.de; Yoder Stuart-B08248;
> iommu@lists.linux-foundation.org; tech@virtualopensystems.com
> Subject: Re: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
> based devices
> 
> On 09/30/2013 11:37 AM, Bhushan Bharat-R65777 wrote:
> >
> >
> >> -----Original Message-----
> >> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> >> bounces@lists.linux-foundation.org] On Behalf Of Antonios Motakis
> >> Sent: Monday, September 30, 2013 8:59 PM
> >> To: kvmarm@lists.cs.columbia.edu; alex.williamson@redhat.com
> >> Cc: linux-samsung-soc@vger.kernel.org; kvm@vger.kernel.org;
> agraf@suse.de; Yoder
> >> Stuart-B08248; iommu@lists.linux-foundation.org; Antonios Motakis;
> >> tech@virtualopensystems.com
> >> Subject: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
> based
> >> devices
> >>
> >> Platform devices in the Linux kernel are usually managed by the DT
> interface.
> >> This patch forms the base to support these kind of devices with VFIO.
> >>
> >> Signed-off-by: Antonios Motakis<a.motakis@virtualopensystems.com>
> >> ---
> >>   drivers/vfio/Kconfig         |  11 +++
> >>   drivers/vfio/Makefile        |   1 +
> >>   drivers/vfio/vfio_platform.c | 187
> +++++++++++++++++++++++++++++++++++++++++++
> >>   include/uapi/linux/vfio.h    |   1 +
> >>   4 files changed, 200 insertions(+)
> >>   create mode 100644 drivers/vfio/vfio_platform.c
> >>
> >> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> 1f84eda..35254b7
> >> 100644
> >> --- a/drivers/vfio/Kconfig
> >> +++ b/drivers/vfio/Kconfig
> >> @@ -13,4 +13,15 @@ menuconfig VFIO
> >>
> >>   	  If you don't know what to do here, say N.
> >>
> >> +config VFIO_PLATFORM
> >> +	tristate "VFIO support for device tree based platform devices"
> >> +	depends on VFIO&&  EVENTFD&&  OF
> >> +	help
> >> +	  Support for platform devices with VFIO. This is required to make
> >> +	  use of platform devices present on device tree nodes using the
> VFIO
> >> +	  framework. Devices that are not described in the device tree
> cannot
> >> +	  be used by this driver.
> >> +
> >> +	  If you don't know what to do here, say N.
> >> +
> >>   source "drivers/vfio/pci/Kconfig"
> >> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile index
> >> 2398d4a..575c8dd 100644
> >> --- a/drivers/vfio/Makefile
> >> +++ b/drivers/vfio/Makefile
> >> @@ -1,3 +1,4 @@
> >>   obj-$(CONFIG_VFIO) += vfio.o
> >>   obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >>   obj-$(CONFIG_VFIO_PCI) += pci/
> >> +obj-$(CONFIG_VFIO_PLATFORM) += vfio_platform.o
> >> diff --git a/drivers/vfio/vfio_platform.c
> b/drivers/vfio/vfio_platform.c new
> >
> > We can make this parallel to PCI, something like
> drivers/vfio/platform/platform.c
> >
> pls, no.  'platform' is too generic, and it really means 'arm-dt' ... so
> can
> move it to the arch/arm space, and have it's kconfig conditional on
> ARM&&VFIO.
> if kept under drivers/vfio, then use a better directory name that ties it
> to arm-dt.
> thanks.

This has nothing to do with ARM specifically.  We need this for Power architecture
as well.

And the name should be 'platform' as that _is_ the name of the bus
that these devices sit on.

This has nothing to do with device tree's per se.  It so happens that
the device tree is parsed and devices discovered there are added
to the platform bus.

The intent is to allow devices on the platform bus to be passed through
to user space using vfio.

Stuart
