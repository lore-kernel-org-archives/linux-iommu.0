From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 09/13] vfio: x86 IOMMU implementation
Date: Thu, 24 May 2012 16:46:55 -0600
Message-ID: <1337899615.4714.79.camel@ul30vt>
References: <20120522043607.5871.11340.stgit@bling.home>
	<20120522050536.5871.65171.stgit@bling.home>
	<4FBEAA5C.4060105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FBEAA5C.4060105-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-05-24 at 17:38 -0400, Don Dutile wrote:
> On 05/22/2012 01:05 AM, Alex Williamson wrote:
> > x86 is probably the wrong name for this VFIO IOMMU driver, but x86
> > is the primary target for it.  This driver support a very simple
> > usage model using the existing IOMMU API.  The IOMMU is expected to
> > support the full host address space with no special IOVA windows,
> > number of mappings restrictions, or unique processor target options.
> >
> > Signed-off-by: Alex Williamson<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >
> >   Documentation/ioctl/ioctl-number.txt |    2
> >   drivers/vfio/Kconfig                 |    6
> >   drivers/vfio/Makefile                |    2
> >   drivers/vfio/vfio.c                  |    7
> >   drivers/vfio/vfio_iommu_x86.c        |  743 ++++++++++++++++++++++++++++++++++
> >   include/linux/vfio.h                 |   52 ++
> >   6 files changed, 811 insertions(+), 1 deletions(-)
> >   create mode 100644 drivers/vfio/vfio_iommu_x86.c
> >
> > diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> > index 111e30a..9d1694e 100644
> > --- a/Documentation/ioctl/ioctl-number.txt
> > +++ b/Documentation/ioctl/ioctl-number.txt
> > @@ -88,7 +88,7 @@ Code  Seq#(hex)	Include File		Comments
> >   		and kernel/power/user.c
> >   '8'	all				SNP8023 advanced NIC card
> >   					<mailto:mcr-b3vwm0MSY3FBDgjK7y7TUQ@public.gmane.org>
> > -';'	64-6F	linux/vfio.h
> > +';'	64-72	linux/vfio.h
> >   '@'	00-0F	linux/radeonfb.h	conflict!
> >   '@'	00-0F	drivers/video/aty/aty128fb.c	conflict!
> >   'A'	00-1F	linux/apm_bios.h	conflict!
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 9acb1e7..bd88a30 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -1,6 +1,12 @@
> > +config VFIO_IOMMU_X86
> > +	tristate
> > +	depends on VFIO&&  X86
> > +	default n
> > +
> >   menuconfig VFIO
> >   	tristate "VFIO Non-Privileged userspace driver framework"
> >   	depends on IOMMU_API
> > +	select VFIO_IOMMU_X86 if X86
> >   	help
> >   	  VFIO provides a framework for secure userspace device drivers.
> >   	  See Documentation/vfio.txt for more details.
> 
> So a future refactoring that uses some chunk of this support
> on a non-x86 machine could be a lot of useless renaming.
> 
> Why not rename vfio_iommu_x86 to something like vfio_iommu_no_iova
> and just make it conditionally compiled on X86 (as you've done above in Kconfig's)?
> Then if another arch can use it, or refactors the file to use
> some of it, and split x86 vs <other-arch> into separate per-arch files,
> or per-iova schemes, it's more descriptive and less disruptive?

Yep, the problem is how to concisely describe what we expect to support
here.  This file supports IOMMU API based usage of an IOMMU with
effectively no DMA window or mapping constraints, optimized for static
mapping of an address space.  What's a good name for that?  Maybe I
should follow the example of others and just call it a Type 1 IOMMU
implementation so the marketing material looks better!  ;-P  That may
honestly be better than calling it x86.  Thoughts?  Thanks,

Alex
