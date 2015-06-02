From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Tue, 2 Jun 2015 20:43:55 +0200
Message-ID: <20150602184355.GI20384@8bytes.org>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<20150519152435.GL20611@8bytes.org>
	<20150520170926.GI11498@arm.com>
	<20150529064337.GN20611@8bytes.org> <55684F1C.3050702@arm.com>
	<20150529144043.GA20384@8bytes.org> <20150601094014.GC1641@arm.com>
	<20150602073956.GG20384@8bytes.org>
	<20150602094746.GC22569@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150602094746.GC22569-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Jun 02, 2015 at 10:47:46AM +0100, Will Deacon wrote:
> On Tue, Jun 02, 2015 at 08:39:56AM +0100, Joerg Roedel wrote:
> > I don't think we need to postpone anything. Domains returned by
> > iommu_domain_alloc() need to work for all groups. If there are multiple
> > IOMMUs in the system with different capabilities/page-table formats the
> > IOMMU core needs to build multiple page-tables for that domain.
> 
> I really don't think that's feasible. We support an awful lot of
> combinations that affect the page table format on ARM: there are 5
> different formats, each supporting different translation regimes (sets
> of page size) and each of those needs configuring for input/output
> address sizes to compute the number of levels. You could easily end up
> with over 20 page tables and their corresponding sets of control
> register values.

We only need to build page-tables for IOMMUs that are actually in the
system. And this also only for domains that are not tied to a particular
group. If some hardware vendor is crazy enough to put 20 IOMMUs in the
system with each having its own page-table format, then be it so. But in
reality I think we will have only a handful of different page-tables.

> Given that we only install one page table in the end, I'm struggling to
> see the issue with postponing its allocation until we've figured out
> the IOMMU instance thanks to a device attach.

It is a question of the use-case for the domain. A device driver (like
for USB or graphics) would allocate the domain with the _for_group
function and end up with only one page-table.

But if VFIO comes around and wants to attach devices to a KVM guest it
would use iommu_domain_alloc() and has then all page-tables it possibly
needs (for devices attached at start and even devices that might later
be hotplugged into the guest).


	Joerg
