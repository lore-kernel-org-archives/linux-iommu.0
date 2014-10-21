From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/5] vfio/iommu_type1: implement the
	VFIO_DMA_MAP_FLAG_NOEXEC flag
Date: Tue, 21 Oct 2014 08:37:54 -0600
Message-ID: <1413902274.4202.113.camel@ul30vt.home>
References: <1413205748-6300-1-git-send-email-a.motakis@virtualopensystems.com>
	<1413205748-6300-6-git-send-email-a.motakis@virtualopensystems.com>
	<1413839603.4202.108.camel@ul30vt.home>
	<CAG8rG2wca4w8LaDSVbgNwfd=e077UaVdpaFhFkMphmyH62Dm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAG8rG2wca4w8LaDSVbgNwfd=e077UaVdpaFhFkMphmyH62Dm3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tue, 2014-10-21 at 14:40 +0200, Antonios Motakis wrote:
> On Mon, Oct 20, 2014 at 11:13 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Mon, 2014-10-13 at 15:09 +0200, Antonios Motakis wrote:
> >> Some IOMMU drivers, such as the ARM SMMU driver, make available the
> >> IOMMU_NOEXEC flag, to set the page tables for a device as XN (execute never).
> >> This affects devices such as the ARM PL330 DMA Controller, which respects
> >> this flag and will refuse to fetch DMA instructions from memory where the
> >> XN flag has been set.
> >>
> >> The flag can be used only if all IOMMU domains behind the container support
> >> the IOMMU_NOEXEC flag. Also, if any mappings are created with the flag, any
> >> new domains with devices will have to support it as well.
> >>
> >> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> >> ---
> >>  drivers/vfio/vfio_iommu_type1.c | 25 ++++++++++++++++++++++++-
> >>  1 file changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 8b4202a..e225e8f 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -569,6 +569,12 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
> >>       if (map->flags & VFIO_DMA_MAP_FLAG_READ)
> >>               prot |= IOMMU_READ;
> >>
> >> +     if (map->flags & VFIO_DMA_MAP_FLAG_NOEXEC) {
> >> +             if (!vfio_domains_have_iommu_cap(iommu, IOMMU_CAP_NOEXEC))
> >> +                     return -EINVAL;
> >> +             prot |= IOMMU_NOEXEC;
> >> +     }
> >> +
> >>       if (!prot || !size || (size | iova | vaddr) & mask)
> >>               return -EINVAL;
> >
> > I think this test needs to move above adding the NOEXEC flag, otherwise
> > we now allow mappings without read or write, which is an ABI change.
> >
> 
> Ack.
> 
> >>
> >> @@ -662,6 +668,14 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
> >>               dma = rb_entry(n, struct vfio_dma, node);
> >>               iova = dma->iova;
> >>
> >> +             /*
> >> +              * if any of the mappings to be replayed has the NOEXEC flag
> >> +              * set, then the new iommu domain must support it
> >> +              */
> >> +             if ((dma->prot | IOMMU_NOEXEC) &&
> >
> > I think you mean
> >
> > & IOMMU_NOEXEC
> 
> Ack.
> 
> >
> >> +                             !(domain->caps & IOMMU_CAP_NOEXEC))
> >> +                     return -EINVAL;
> >> +
> >
> > In patch 2/5 you stated:
> >
> >         The IOMMU_NOEXEC flag needs to be available for all the IOMMUs
> >         of the container used.
> >
> > But here you'll create heterogeneous containers so long as there are no
> > NOEXEC mappings.  Is that intentional or a side effect of the above
> > masking bug?
> >
> 
> Yeah, my intention was to not stop the user of having heterogeneous
> containers, as long as he doesn't care about using the NOEXEC flag. As
> soon as the user tries to apply this flag however, then it should be
> supported by all the IOMMUs behind the container - otherwise it is not
> enforceable.
> 
> Do you think we should change this behavior? I think most users will
> not care about using this flag, and we should not stop them from
> mixing containers.

I think that's a reasonable way to go, but let's add a comment in uapi
vfio.h describing that expectation.  Thanks,

Alex

> >>               while (iova < dma->iova + dma->size) {
> >>                       phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
> >>                       size_t size;
> >> @@ -749,6 +763,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>       if (iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> >>               domain->caps |= IOMMU_CAP_CACHE_COHERENCY;
> >>
> >> +     if (iommu_capable(bus, IOMMU_CAP_NOEXEC))
> >> +             domain->caps |= IOMMU_CAP_NOEXEC;
> >> +
> >>       /*
> >>        * Try to match an existing compatible domain.  We don't want to
> >>        * preclude an IOMMU driver supporting multiple bus_types and being
> >> @@ -900,6 +917,11 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >>                               return 0;
> >>                       return vfio_domains_have_iommu_cap(iommu,
> >>                                                 IOMMU_CAP_CACHE_COHERENCY);
> >> +             case VFIO_DMA_NOEXEC_IOMMU:
> >> +                     if (!iommu)
> >> +                             return 0;
> >> +                     return vfio_domains_have_iommu_cap(iommu,
> >> +                                                        IOMMU_CAP_NOEXEC);
> >>               default:
> >>                       return 0;
> >>               }
> >> @@ -923,7 +945,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >>       } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> >>               struct vfio_iommu_type1_dma_map map;
> >>               uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> >> -                             VFIO_DMA_MAP_FLAG_WRITE;
> >> +                             VFIO_DMA_MAP_FLAG_WRITE |
> >> +                             VFIO_DMA_MAP_FLAG_NOEXEC;
> >>
> >>               minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> >>
> >
> >
> >
> 
> 
> 
