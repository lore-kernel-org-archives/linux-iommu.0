From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Tue, 2 Jun 2015 09:39:56 +0200
Message-ID: <20150602073956.GG20384@8bytes.org>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<20150519152435.GL20611@8bytes.org>
	<20150520170926.GI11498@arm.com>
	<20150529064337.GN20611@8bytes.org> <55684F1C.3050702@arm.com>
	<20150529144043.GA20384@8bytes.org> <20150601094014.GC1641@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150601094014.GC1641-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Jun 01, 2015 at 10:40:14AM +0100, Will Deacon wrote:
> I like this proposal. The only remaining part is that the pgsize bitmap
> inherited by the domain can only truly be finalised once the page table
> is allocated, which in turn can only happen once we've identified the
> IOMMU instance.

We know the IOMMU instance for domains allocted with
iommu_domain_alloc_for_group because every group is behind a single
IOMMU instance. So the page-table can be allocated at domain creation
time and mappings can be created before the group itself is attached.

> In the case of iommu_domain_alloc_for_group, that's nice and
> straightforward (i.e. as part of the call) but for the default
> iommu_domain_alloc() case, we'd have to continue postponing things to
> ->attach time before we could provide a reliable pgsize_bitmap. This is
> to handle the case where an SMMU may be able to support only a subset of
> the pgsize_bitmap on a per-domain basis.

I don't think we need to postpone anything. Domains returned by
iommu_domain_alloc() need to work for all groups. If there are multiple
IOMMUs in the system with different capabilities/page-table formats the
IOMMU core needs to build multiple page-tables for that domain.

VFIO already does that as a workaround of how things are done currently,
but I really think this should be done in the IOMMU core code.

> In which situation do you think the merged pgsize_bitmap would get used?
> The only place I can think of is if we're trying to call iommu_map on a
> domain with no devices attached. However, if that domain was created
> using iommu_domain_alloc() then the pgsize_bitmap is the least of our
> worries -- we don't even know the page table format!

The first usecase for the merged pgsize_bitmap that comes to mind is to
determine the minimum page-size that can be used for a domain. In the
SMMUv3 case when there are IOMMUs with different minium page-sizes in one
system, this would be the biggest minimum page-size of all IOMMUs.

Probably there are other uses for that bitmap that show up at
implementation time.


	Joerg
