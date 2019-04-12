From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Do we always need to reserve an iova before iommu_map?
Date: Thu, 11 Apr 2019 18:42:20 -0700
Message-ID: <20190412014219.GA23701@Asurada-Nvidia.nvidia.com>
References: <20190409224718.GA3281@Asurada-Nvidia.nvidia.com>
	<3916e00d-d3a9-11be-4107-73429f6dd8bf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3916e00d-d3a9-11be-4107-73429f6dd8bf-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thanks for the reply Robin.

On Wed, Apr 10, 2019 at 10:20:38AM +0100, Robin Murphy wrote:
> On 09/04/2019 23:47, Nicolin Chen wrote:
> > According to the routine of iommu_dma_alloc(), it allocates an iova
> > then does iommu_map() to map the iova to a physical address of new
> > allocated pages. However, in remoteproc_core.c, I see its code try
> > to iommu_map() without having an alloc_iova() or alloc_iova_fast().
> >
> > Is it safe to do so? If an iova range is not allocated but mapped,
> > would a later iommu_dma_alloc() happen to hit this iova range when
> > doing its alloc_iova() and then fail to map?
> > 
> > And I am not very familiar with remoteproc code, so if I am missing
> > something, please kindly educate me.
> 
> AFAICS that area of the remoteproc code is using its own IOMMU domain, so
> it's free to manage that domain's address space however it wants - the

I see. So it seems that it would be safe to map to an iova without
dealing with iova_domain, as long as the device is attached to a
separately allocated iommu_domain; for those who use DMA API would
need to go through iova management.

> generic IOVA allocator is a good option for the DMA API where the only
> constraint is that the address we get fits within a mask, but drivers with
> more specific requirements may well be better off using other allocation
> methods. See also various DRM drivers (Tegra/Rockchip/etc.) that do similar,
> using a drm_mm to manage the address space.

Yea, I am aware of DRM drivers that manage both iommu_domain and
iova_domain manually. But it feels a bit heavy for our use case:

We have a downstream driver using DMA API for iommu_dma_alloc().
And it is happy with the API because the same API works for both
IOMMU and non-IOMMU configurations. But it also has one single
allocation that requires (same as remoteproc) to iommu_map to a
hard coded iova. Although it's so far a downstream use case, we
want to seek for a solution that could be closer to the mainline.

The current solution seems to give up the API and add own IOMMU
domain and iova management like DRM drivers. Could there be any
way of reserving an IOVA without giving up the API?

Thank you
Nicolin
