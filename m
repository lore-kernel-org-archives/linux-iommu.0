From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Date: Wed, 9 May 2018 05:55:30 -0700
Message-ID: <20180509055530.166ab2a6@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
	<20180503214616.51553247@jacob-builder>
	<20180504110706.3392a98e@jacob-builder>
	<ef462e73-01e3-d581-cf91-3e012a337c61@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ef462e73-01e3-d581-cf91-3e012a337c61-5wv7dgnIgG8@public.gmane.org>
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

On Tue, 8 May 2018 11:35:00 +0100
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Jacob,
> 
> Looks mostly good to me, I just have a couple more comments
> 
> On 04/05/18 19:07, Jacob Pan wrote:
> > Now the passdown invalidation granularities look like:
> > (sorted by coarseness), will send out in v5 patchset soon if no
> > issues.
> > 
> > /**
> >  * enum iommu_inv_granularity - Generic invalidation granularity
> >  *
> >  * @IOMMU_INV_GRANU_DOMAIN:		Device context cache
> > associated with a
> >  *					domain ID.
> >  * @IOMMU_INV_GRANU_DEVICE:		Device context cache
> > associated with a
> >  *					device ID
> >  * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID
> > caches of all
> >  *					PASIDs associated with a
> > domain ID
> >  * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID
> > cache associated
> >  *					with a PASID and a domain
> >  * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of
> > selected page range
> >  *					within a PASID
> >  *
> >  * When an invalidation request is passed down to IOMMU to flush
> > translation
> >  * caches, it may carry different granularity levels, which can be
> > specific
> >  * to certain types of translation caches. For an example, PASID
> > selective
> >  * granularity is only applicable PASID cache and IOTLB
> > invalidation but for
> >  * device context caches.  
> 
> Should it be "PASID selective granularity is only applicable to PASID
> cache and IOTLB but not device context caches"?
> 
right, thanks!
> >  * This enum is a collection of granularities for all types of
> > translation
> >  * caches. The idea is to make it easy for IOMMU model specific
> > driver to
> >  * convert from generic to model specific value. Not all
> > combinations between
> >  * translation caches and granularity levels are valid. Each IOMMU
> > driver
> >  * can enforce check based on its own conversion table. The
> > conversion is
> >  * based on 2D look-up with inputs as follows:
> >  * - translation cache types
> >  * - granularity
> >  * No global granularity is allowed in that passdown invalidation
> > for an
> >  * assigned device should only impact the device or domain itself.  
> 
> That last sentence is a bit confusing, because "global granularity"
> might also refer to the "global" TLB flag which is allowed. In my
> opinion you can leave this rationale out, I doubt userspace will ever
> demand a mechanism for global invalidation.
> 
yes, i can leave the last sentence out.
> >  *
> >  *             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
> >  *  granule         |           |           |           |
> >  * -----------------+-----------+-----------+-----------+-----------
> >  *  DOMAIN          |           |           |           |     Y
> >  *  DEVICE          |           |           |           |     Y  
> 
> I can't really see a use-case for DOMAIN and DEVICE. It might make
> more sense to keep only DN_ALL_PASID, which would then also
> invalidate the device context cache. But since they will be very rare
> events, factoring them doesn't seem important.
> 
ok. we have no use for now either, was there for completeness. i will
remove for now.
> >  *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
> >  *  PASID_SEL       |   Y       |   Y       |   Y       |
> >  *  PAGE_PASID      |           |   Y       |           |  
> 
> Why not allow PAGE_PASID+DTLB? We need a way to invalidate individual
> DTLB entries
> 
I was thinking PAGE_PASID+TLB includes PAGE_PASID+DTLB, but you are
right, DTLB should be a 'Y' here.
> Thanks,
> Jean

[Jacob Pan]
