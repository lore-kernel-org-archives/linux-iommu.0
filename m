From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Mon, 1 Jun 2015 10:40:14 +0100
Message-ID: <20150601094014.GC1641@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<20150519152435.GL20611@8bytes.org>
	<20150520170926.GI11498@arm.com>
	<20150529064337.GN20611@8bytes.org> <55684F1C.3050702@arm.com>
	<20150529144043.GA20384@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150529144043.GA20384-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Fri, May 29, 2015 at 03:40:43PM +0100, Joerg Roedel wrote:
> On Fri, May 29, 2015 at 12:35:56PM +0100, Robin Murphy wrote:
> > The trouble with this is, what about the CPU page size? Say you have
> > some multimedia subsystem with its own integrated SMMU and for that
> > they've only implemented the 16K granule scheme because it works
> > best for the video hardware (and the GPU driver is making direct
> > IOMMU API calls to remap carved-out RAM rather than using
> > DMA-mapping). Now, the SMMU on the compute side of the SoC serving
> > the general peripherals will be rendered useless by bumping the
> > system-wide minimum page size up to 16K, because it then can't map
> > that scatterlist of discontiguous 4K pages that the USB controller
> > needs...
> > 
> > I think this really represents another push to get away from (or at
> > least around) the page-at-a-time paradigm - if the IOMMU API itself
> > wasn't too fussed about page sizes and could let drivers handle the
> > full map/unmap requests however they see fit, I think we could
> > bypass a lot of these issues. We've already got the Intel IOMMU
> > driver doing horrible hacks with the pgsize_bitmap to cheat the
> > system, I'm sure we don't want to add any more of that. How about
> > something like the below diff as a first step?
> 
> Moving functionality out of the iommu core code into the drivers is the
> wrong direction imo. It is better to solve it with something like
> 
> 	struct iommu_domain *iommu_domain_alloc_for_group(struct iommu_group *group);
> 
> Which gets us a domain that can only be assigned to that particular
> group. Since there is a clear one-to-many relationship between a
> hardware iommu and the groups of devices behind it, we could propagate
> the pgsize_bitmap from the iommu to the group and then to the domain.
> 
> Domains allocated via iommu_domain_alloc() would get the merged
> pgsize_bitmap like I described in my previous mail.
> 
> But to make this happen we need a representation of single hardware
> iommu instances in the iommu core first.

I like this proposal. The only remaining part is that the pgsize bitmap
inherited by the domain can only truly be finalised once the page table
is allocated, which in turn can only happen once we've identified the
IOMMU instance.

In the case of iommu_domain_alloc_for_group, that's nice and
straightforward (i.e. as part of the call) but for the default
iommu_domain_alloc() case, we'd have to continue postponing things to
->attach time before we could provide a reliable pgsize_bitmap. This is
to handle the case where an SMMU may be able to support only a subset of
the pgsize_bitmap on a per-domain basis.

In which situation do you think the merged pgsize_bitmap would get used?
The only place I can think of is if we're trying to call iommu_map on a
domain with no devices attached. However, if that domain was created
using iommu_domain_alloc() then the pgsize_bitmap is the least of our
worries -- we don't even know the page table format!

Will
