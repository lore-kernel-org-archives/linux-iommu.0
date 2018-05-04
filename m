From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Date: Fri, 4 May 2018 11:07:06 -0700
Message-ID: <20180504110706.3392a98e@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
	<20180503214616.51553247@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180503214616.51553247@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Liu-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org" <Liu-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 3 May 2018 21:46:16 -0700
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Wed, 2 May 2018 10:31:50 +0100
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> > On 01/05/18 23:58, Jacob Pan wrote:  
> > >>>> Maybe this should be called "NG_PAGE_PASID",      
> > >>> Sure. I was thinking page range already implies non-global
> > >>> pages.      
> > >>>> and "DOMAIN_PAGE" should
> > >>>> instead be "PAGE_PASID". If I understood their meaning
> > >>>> correctly, it would be more consistent with the rest.
> > >>>>      
> > >>> I am trying not to mix granu between request w/ PASID and w/o.
> > >>> DOMAIN_PAGE meant to be for request w/o PASID.      
> > >>
> > >> Is the distinction necessary? I understand the IOMMU side might
> > >> offer many possibilities for invalidation, but the user probably
> > >> doesn't need all of them. It might be easier to document,
> > >> upstream and maintain if we only specify what's currently needed
> > >> by users (what does QEMU VT-d use?) Others can always extend it
> > >> by increasing the version.
> > >>
> > >> Do you think that this invalidation message will be used outside
> > >> of BIND_PASID_TABLE context? I can't see an other use but who
> > >> knows. At the moment requests w/o PASID are managed with
> > >> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And
> > >> in a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are
> > >> just a special case using PASID 0 (for Arm and AMD) so I suppose
> > >> they'll use the same invalidation commands as requests w/ PASID.
> > >>    
> > > My understanding is that for GIOVA use case, VT-d vIOMMU creates
> > > GIOVA-GPA mapping and the host shadows the 2nd level page tables
> > > to create GIOVA-HPA mapping. So when assigned device in the guest
> > > can do both DMA map/unmap and VFIO map/unmap, VFIO unmap is one
> > > time deal (I guess invalidation can be captured in other code
> > > path), but guest kernel use of DMA unmap could will trigger
> > > invalidation. QEMU needs to trap those invalidation and passdown
> > > to physical IOMMU. So we do need invalidation w/o PASID.    
> > 
> > Hm, isn't this all done by host userspace? Whether guest does DMA
> > map/unmap or VFIO map/unmap, it creates/removes IOVA-GPA mappings in
> > the vIOMMU. QEMU captures invalidation requests for these mappings
> > from the guest, finds GPA-HVA in the shadow map and sends a VFIO
> > map/unmap request for IOVA-HVA.
> >   
> Sorry for the delay but you are right, I have also confirmed with Yi
> that we don't need second level invalidation. I will remove IOTLB
> invalidation w/o PASID case from the API.
> 
Now the passdown invalidation granularities look like:
(sorted by coarseness), will send out in v5 patchset soon if no issues.

/**
 * enum iommu_inv_granularity - Generic invalidation granularity
 *
 * @IOMMU_INV_GRANU_DOMAIN:		Device context cache associated with a
 *					domain ID.
 * @IOMMU_INV_GRANU_DEVICE:		Device context cache associated with a
 *					device ID
 * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID caches of all
 *					PASIDs associated with a domain ID
 * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID cache associated
 *					with a PASID and a domain
 * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of selected page range
 *					within a PASID
 *
 * When an invalidation request is passed down to IOMMU to flush translation
 * caches, it may carry different granularity levels, which can be specific
 * to certain types of translation caches. For an example, PASID selective
 * granularity is only applicable PASID cache and IOTLB invalidation but for
 * device context caches.
 * This enum is a collection of granularities for all types of translation
 * caches. The idea is to make it easy for IOMMU model specific driver to
 * convert from generic to model specific value. Not all combinations between
 * translation caches and granularity levels are valid. Each IOMMU driver
 * can enforce check based on its own conversion table. The conversion is
 * based on 2D look-up with inputs as follows:
 * - translation cache types
 * - granularity
 * No global granularity is allowed in that passdown invalidation for an
 * assigned device should only impact the device or domain itself.
 *
 *             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
 *  granule         |           |           |           |
 * -----------------+-----------+-----------+-----------+-----------
 *  DOMAIN          |           |           |           |     Y
 *  DEVICE          |           |           |           |     Y
 *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
 *  PASID_SEL       |   Y       |   Y       |   Y       |
 *  PAGE_PASID      |           |   Y       |           |
 *
 */
enum iommu_inv_granularity {
	IOMMU_INV_GRANU_DOMAIN,
	IOMMU_INV_GRANU_DEVICE,
	IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
	IOMMU_INV_GRANU_PASID_SEL,
	IOMMU_INV_GRANU_PAGE_PASID,
	IOMMU_INV_NR_GRANU,
};


> Thanks,
> 
> > Thanks,
> > Jean
> >   
> 
> [Jacob Pan]

[Jacob Pan]
