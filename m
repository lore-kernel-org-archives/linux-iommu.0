From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Date: Thu, 3 May 2018 21:46:16 -0700
Message-ID: <20180503214616.51553247@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b12bcd35-9472-83ed-a26f-e5be3794e2d2-5wv7dgnIgG8@public.gmane.org>
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

On Wed, 2 May 2018 10:31:50 +0100
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> On 01/05/18 23:58, Jacob Pan wrote:
> >>>> Maybe this should be called "NG_PAGE_PASID",    
> >>> Sure. I was thinking page range already implies non-global
> >>> pages.    
> >>>> and "DOMAIN_PAGE" should
> >>>> instead be "PAGE_PASID". If I understood their meaning correctly,
> >>>> it would be more consistent with the rest.
> >>>>    
> >>> I am trying not to mix granu between request w/ PASID and w/o.
> >>> DOMAIN_PAGE meant to be for request w/o PASID.    
> >>
> >> Is the distinction necessary? I understand the IOMMU side might
> >> offer many possibilities for invalidation, but the user probably
> >> doesn't need all of them. It might be easier to document, upstream
> >> and maintain if we only specify what's currently needed by users
> >> (what does QEMU VT-d use?) Others can always extend it by
> >> increasing the version.
> >>
> >> Do you think that this invalidation message will be used outside of
> >> BIND_PASID_TABLE context? I can't see an other use but who knows.
> >> At the moment requests w/o PASID are managed with
> >> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And
> >> in a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are just a
> >> special case using PASID 0 (for Arm and AMD) so I suppose they'll
> >> use the same invalidation commands as requests w/ PASID.
> >>  
> > My understanding is that for GIOVA use case, VT-d vIOMMU creates
> > GIOVA-GPA mapping and the host shadows the 2nd level page tables to
> > create GIOVA-HPA mapping. So when assigned device in the guest can
> > do both DMA map/unmap and VFIO map/unmap, VFIO unmap is one time
> > deal (I guess invalidation can be captured in other code path), but
> > guest kernel use of DMA unmap could will trigger invalidation. QEMU
> > needs to trap those invalidation and passdown to physical IOMMU. So
> > we do need invalidation w/o PASID.  
> 
> Hm, isn't this all done by host userspace? Whether guest does DMA
> map/unmap or VFIO map/unmap, it creates/removes IOVA-GPA mappings in
> the vIOMMU. QEMU captures invalidation requests for these mappings
> from the guest, finds GPA-HVA in the shadow map and sends a VFIO
> map/unmap request for IOVA-HVA.
> 
Sorry for the delay but you are right, I have also confirmed with Yi
that we don't need second level invalidation. I will remove IOTLB
invalidation w/o PASID case from the API.

Thanks,

> Thanks,
> Jean
> 

[Jacob Pan]
