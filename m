From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH] vfio/type1: Do not support IOMMUs that allow bypass
Date: Thu, 29 Oct 2015 18:50:14 +0000
Message-ID: <20151029185014.GN3440@arm.com>
References: <20151015205046.28129.50479.stgit@gimli.home>
	<5621039F.50609@linaro.org> <1445010682.4059.508.camel@redhat.com>
	<20151027154043.GF1689@arm.com>
	<1445961611.8018.269.camel@redhat.com>
	<20151029182819.GJ3440@arm.com> <56326882.10109@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56326882.10109-5wv7dgnIgG8@public.gmane.org>
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
Cc: "eric.auger" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 29, 2015 at 06:42:10PM +0000, Robin Murphy wrote:
> On 29/10/15 18:28, Will Deacon wrote:
> >On Tue, Oct 27, 2015 at 10:00:11AM -0600, Alex Williamson wrote:
> >>On Tue, 2015-10-27 at 15:40 +0000, Will Deacon wrote:
> >>>On Fri, Oct 16, 2015 at 09:51:22AM -0600, Alex Williamson wrote:
> >>>>Would it be possible to add iommu_domain_geometry support to arm-smmu.c?
> >>>>In addition to this test to verify that DMA cannot bypass the IOMMU, I'd
> >>>>eventually like to pass the aperture information out through the VFIO
> >>>>API.  Thanks,
> >>>
> >>>The slight snag here is that we don't know which SMMU in the system the
> >>>domain is attached to at the point when the geometry is queried, so I
> >>>can't give you an upper bound on the aperture. For example, if there is
> >>>an SMMU with a 32-bit input address and another with a 48-bit input
> >>>address.
> >>>
> >>>We could play the same horrible games that we do with the pgsize bitmap,
> >>>and truncate some global aperture everytime we probe an SMMU device, but
> >>>I'd really like to have fewer hacks like that if possible. The root of
> >>>the problem is still that domains are allocated for a bus, rather than
> >>>an IOMMU instance.
> >>
> >>Yes, Intel VT-d has this issue as well.  In theory we can have
> >>heterogeneous IOMMU hardware units (DRHDs) in a system and the upper
> >>bound of the geometry could be diminished if we add a less capable DRHD
> >>into the domain.  I suspect this is more a theoretical problem than a
> >>practical one though as we're typically mixing similar DRHDs and I think
> >>we're still capable of 39-bit addressing in the least capable version
> >>per the spec.
> >>
> >>In any case, I really want to start testing geometry.force_aperture,
> >>even if we're not yet comfortable to expose the IOMMU limits to the
> >>user.  The vfio type1 shouldn't be enabled at all for underlying
> >>hardware that allows DMA bypass.  Thanks,
> >
> >Ok, I'll put it on my list of things to look at under the assumption that
> >the actual aperture limits don't need to be accurate as long as DMA to
> >an arbitrary unmapped address always faults.
> 
> I'm pretty sure we'd only ever set the aperture to the full input address
> range anyway (since we're not a GART-type thing), in which case we should
> only need to worry about unmatched streams that don't hit in a domain at
> all. Doesn't the disable_bypass option already cover that? (FWIW I hacked it
> up for v2 a while back, too[0]).

Well, the "full input address range" is tricky when you have multiple SMMU
instances with different input address sizes. I can do something similar
to the pgsize_bitmap.

I also don't think the disable_bypass option is what we're after -- this
is about devices attached to a VFIO domain that can still mysteriously
bypass the SMMU for some ranges AFAIU (and shouldn't be an issue for ARM).

Will
