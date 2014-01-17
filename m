From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC][PATCH] Remove bus dependency for iommu_domain_alloc.
Date: Fri, 17 Jan 2014 20:21:16 +0000
Message-ID: <546cedebe8cb4a6d818d9a6c3ef941bf@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1389987042-27352-1-git-send-email-Varun.Sethi@freescale.com>
	<1389989354.8705.89.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389989354.8705.89.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Saturday, January 18, 2014 1:39 AM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC][PATCH] Remove bus dependency for iommu_domain_alloc.
> 
> On Sat, 2014-01-18 at 01:00 +0530, Varun Sethi wrote:
> > This patch attempts to remove iommu_domain_alloc function's dependency
> on the bus type.
> > This dependency is quiet restrictive in case of vfio, where it's
> > possible to bind multiple iommu groups (from different bus types) to
> the same iommu domain.
> >
> > This patch is based on the assumption, that there is a single iommu
> > for all bus types on the system.
> >
> > We maintain a list of bus types (for which iommu ops are registered).
> > In the iommu_domain_alloc function we ensure that all bus types
> correspond to the same set of iommu operations.
> 
> Seems like this just kicks the problem down the road a little ways as I
> expect the assumption isn't going to last long.  I think there's another
> way to do this and we can do it entirely from within vfio_iommu_type1.
> We have a problem on x86 that the IOMMU driver can be backed by multiple
> IOMMU hardware devices.  These separate devices are architecturally
> allowed to have different properties.  The property causing us trouble is
> cache coherency.  Some hardware devices allow us to use IOMMU_CACHE as a
> mapping attribute, others do not.  Therefore we cannot use a single IOMMU
> domain to optimally handle all devices in a heterogeneous environment.
> 
> I think the solution to this is to have vfio_iommu_type1 transparently
> support multiple IOMMU domains.  In the implementation of that, it seems
> to make sense to move the iommu_domain_alloc() to the point where we
> attach a group to the domain.  That means we can scan the devices in the
[Sethi Varun-B16395] Multiple iommu groups can also share the same domain (as a part
Of the same VFIO container). I am not sure how can we handle the case of iommu groups from
Different bus types in vfio.

-Varun

> domain to determine the bus.  I suppose there is still an assumption that
> all the devices in a group are on the same bus, but since the group is
> determined by the IOMMU and we already assume only a single IOMMU per
> bus, I think we're ok.  I spent some time working on a patch to do this,
> but it isn't quite finished.  I'll try to bandage the rough edges and
> send it out as an RFC so you can see what I'm talking about.  Thanks,
> 
> Alex
> 
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  arch/arm/mm/dma-mapping.c             |    2 +-
> >  drivers/gpu/drm/msm/msm_gpu.c         |    2 +-
> >  drivers/iommu/amd_iommu_v2.c          |    2 +-
> >  drivers/iommu/iommu.c                 |   32
> +++++++++++++++++++++++++++++---
> >  drivers/media/platform/omap3isp/isp.c |    2 +-
> >  drivers/remoteproc/remoteproc_core.c  |    2 +-
> >  drivers/vfio/vfio_iommu_type1.c       |    2 +-
> >  include/linux/device.h                |    2 ++
> >  include/linux/iommu.h                 |    4 ++--
> >  virt/kvm/iommu.c                      |    2 +-
> >  10 files changed, 40 insertions(+), 12 deletions(-)
