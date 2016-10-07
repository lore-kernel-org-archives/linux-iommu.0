From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 12/15] vfio: Allow reserved msi iova registration
Date: Fri, 7 Oct 2016 14:45:17 -0600
Message-ID: <20161007144517.74d876bb@t450s.home>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-13-git-send-email-eric.auger@redhat.com>
	<20161006141932.0a193f9b@t450s.home>
	<27e4db66-7df2-16b4-c3d9-982d6ea845b0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <27e4db66-7df2-16b4-c3d9-982d6ea845b0-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 7 Oct 2016 19:11:43 +0200
Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Alex,
> 
> On 06/10/2016 22:19, Alex Williamson wrote:
> > On Thu,  6 Oct 2016 08:45:28 +0000
> > Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >   
> >> The user is allowed to register a reserved MSI IOVA range by using the
> >> DMA MAP API and setting the new flag: VFIO_DMA_MAP_FLAG_MSI_RESERVED_IOVA.
> >> This region is stored in the vfio_dma rb tree. At that point the iova
> >> range is not mapped to any target address yet. The host kernel will use
> >> those iova when needed, typically when MSIs are allocated.
> >>
> >> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> Signed-off-by: Bharat Bhushan <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >>
> >> ---
> >> v12 -> v13:
> >> - use iommu_get_dma_msi_region_cookie
> >>
> >> v9 -> v10
> >> - use VFIO_IOVA_RESERVED_MSI enum value
> >>
> >> v7 -> v8:
> >> - use iommu_msi_set_aperture function. There is no notion of
> >>   unregistration anymore since the reserved msi slot remains
> >>   until the container gets closed.
> >>
> >> v6 -> v7:
> >> - use iommu_free_reserved_iova_domain
> >> - convey prot attributes downto dma-reserved-iommu iova domain creation
> >> - reserved bindings teardown now performed on iommu domain destruction
> >> - rename VFIO_DMA_MAP_FLAG_MSI_RESERVED_IOVA into
> >>          VFIO_DMA_MAP_FLAG_RESERVED_MSI_IOVA
> >> - change title
> >> - pass the protection attribute to dma-reserved-iommu API
> >>
> >> v3 -> v4:
> >> - use iommu_alloc/free_reserved_iova_domain exported by dma-reserved-iommu
> >> - protect vfio_register_reserved_iova_range implementation with
> >>   CONFIG_IOMMU_DMA_RESERVED
> >> - handle unregistration by user-space and on vfio_iommu_type1 release
> >>
> >> v1 -> v2:
> >> - set returned value according to alloc_reserved_iova_domain result
> >> - free the iova domains in case any error occurs
> >>
> >> RFC v1 -> v1:
> >> - takes into account Alex comments, based on
> >>   [RFC PATCH 1/6] vfio: Add interface for add/del reserved iova region:
> >> - use the existing dma map/unmap ioctl interface with a flag to register
> >>   a reserved IOVA range. A single reserved iova region is allowed.
> >> ---
> >>  drivers/vfio/vfio_iommu_type1.c | 77 ++++++++++++++++++++++++++++++++++++++++-
> >>  include/uapi/linux/vfio.h       | 10 +++++-
> >>  2 files changed, 85 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 5bc5fc9..c2f8bd9 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -442,6 +442,20 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
> >>  	vfio_lock_acct(-unlocked);
> >>  }
> >>  
> >> +static int vfio_set_msi_aperture(struct vfio_iommu *iommu,
> >> +				dma_addr_t iova, size_t size)
> >> +{
> >> +	struct vfio_domain *d;
> >> +	int ret = 0;
> >> +
> >> +	list_for_each_entry(d, &iommu->domain_list, next) {
> >> +		ret = iommu_get_dma_msi_region_cookie(d->domain, iova, size);
> >> +		if (ret)
> >> +			break;
> >> +	}
> >> +	return ret;  
> > 
> > Doesn't this need an unwind on failure loop?  
> At the moment the de-allocation is done by the smmu driver, on
> domain_free ops, which calls iommu_put_dma_cookie. In case,
> iommu_get_dma_msi_region_cookie fails on a given VFIO domain currently
> there is no other way but destroying all VFIO domains and redo everything.
> 
> So yes I plan to unfold everything, ie call iommu_put_dma_cookie for
> each domain.

That's a pretty harsh user experience isn't it?  They potentially have
some domains where the cookie is setup and others without and they have
no means to recover except to tear it all down and start over?  Thanks,

Alex
