From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 09/18] vfio/platform: support MMAP of MMIO regions
Date: Wed, 22 Oct 2014 10:56:15 -0600
Message-ID: <1413996975.4202.226.camel@ul30vt.home>
References: <1413205825-6370-1-git-send-email-a.motakis@virtualopensystems.com>
	<1413205825-6370-10-git-send-email-a.motakis@virtualopensystems.com>
	<1413910307.4202.148.camel@ul30vt.home>
	<CAG8rG2yUmpzzfEYVqA0H+5LcBcLjFY=j43t420Sa7FLnfmG8Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAG8rG2yUmpzzfEYVqA0H+5LcBcLjFY=j43t420Sa7FLnfmG8Ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-10-22 at 15:55 +0200, Antonios Motakis wrote:
> On Tue, Oct 21, 2014 at 6:51 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Mon, 2014-10-13 at 15:10 +0200, Antonios Motakis wrote:
> >> Allow to memory map the MMIO regions of the device so userspace can
> >> directly access them. PIO regions are not being handled at this point.
> >>
> >> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> >> ---
> >>  drivers/vfio/platform/vfio_platform_common.c | 57 ++++++++++++++++++++++++++++
> >>  1 file changed, 57 insertions(+)
> >>
> >> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> >> index ac74710..4db7187 100644
> >> --- a/drivers/vfio/platform/vfio_platform_common.c
> >> +++ b/drivers/vfio/platform/vfio_platform_common.c
> >> @@ -57,6 +57,16 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
> >>                       if (!(res->flags & IORESOURCE_READONLY))
> >>                               vdev->regions[i].flags |=
> >>                                       VFIO_REGION_INFO_FLAG_WRITE;
> >> +
> >> +                     /*
> >> +                      * Only regions addressed with PAGE granularity may be
> >> +                      * MMAPed securely.
> >> +                      */
> >> +                     if (!(vdev->regions[i].addr & ~PAGE_MASK) &&
> >> +                                     !(vdev->regions[i].size & ~PAGE_MASK))
> >> +                             vdev->regions[i].flags |=
> >> +                                     VFIO_REGION_INFO_FLAG_MMAP;
> >> +
> >
> > Should this be included in the above !readonly test?  I don't see that
> > we're doing anything below that would prevent writes to the mmap for a
> > readonly resource.  I suspect that just like PCI, it's not all that
> > useful to provide mmap support for read-only regions.  They're not
> > typically performance paths.
> 
> Indeed. Alternatively we could just MMAP the region as read only as
> well. Even if typically they are not performance critical areas, maybe
> it doesn't hurt to allow MMAP when possible.

Sure, we could allow a read-only mmap.  On PCI the only read-only region
is the PCI option ROM.  The PCI spec indicates that devices may use the
same address decoders for the ROM as for BARs, so the ROM and BAR may
not be simultaneously accessible.  QEMU also caches the ROM once the
guest does read it, so it's never been an issue to allow mmap of that
resource.  I would probably only bother to provide read-only mmap if you
know vfio-platform devices are going to make more significant use of
read-only regions.  Thanks,

Alex
