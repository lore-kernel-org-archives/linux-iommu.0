From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Wed, 1 Apr 2015 17:38:54 +0200
Message-ID: <20150401153854.GG4441@8bytes.org>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
	<20150331144956.GA24094@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150331144956.GA24094-5wv7dgnIgG8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tue, Mar 31, 2015 at 03:49:56PM +0100, Will Deacon wrote:
> But isn't this restriction already the case in practice? For example, if
> I have a domain with some mapping already configured, then that mapping
> will be using some fixed set of page sizes. Attaching a device behind
> another IOMMU that doesn't support that page size would effectively require
> the domain page tables to be freed and re-allocated from scratch.

The problem is that this restriction depends on the IOMMU driver in use.
>From the beginning of the IOMMU-API the backend drivers have supported
sharing a domain by multiple devices. In fact, the domain is just an
abstraction for an address space that can be attached to devices just
like cpu page-tables are assigned to threads of a process.

We can discuss whether this fundamental concept of the IOMMU-API needs
to be changed (moving into the direction this patch-set proposes). I
could imaging removing the domain concept entirely and just have
map/unmap functions like this:

	iommu_map(struct device *dev, dma_addr_t iova,
		  phys_addr_t phys, size_t size)
	iommu_unmap(struct device *dev, dma_addr_t iova,
		    phys_addr_t phys, size_t size)

This would require some changes for the users of the IOMMU-API, but it
shouldn't be too hard.

Or we keep the desired semantics as they are now and do everything
needed for that in the IOMMU drivers. For the arm-smmu this would mean
exposing a common set of supported pgsizes between IOMMUs, or to build
multiple page-tables to match the different IOMMU capabilities.

I am open for disussions for either way, but I like the current
semantics a bit more, as it allows us to share page-tables between
devices and we can move all of the nasty code in VFIO that already
creates multiple domains to get different page-tables into the
IOMMU core or the drivers (were it belongs).

What I definitly don't want is a mixture of both concepts depending on
the IOMMU driver in use. We should settle on one way and force the
drivers to behave accordingly. We don't need a common API when every
driver behaves differently.


	Joerg
