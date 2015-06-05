From: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 10/22] iommu: Introduce direct mapped region handling
Date: Fri, 5 Jun 2015 16:32:04 +0200
Message-ID: <20150605143204.GJ16345@suse.de>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<1432831305-11126-11-git-send-email-joro@8bytes.org>
	<20150605141749.GA7420@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150605141749.GA7420-5wv7dgnIgG8@public.gmane.org>
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
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Jun 05, 2015 at 03:17:50PM +0100, Will Deacon wrote:
> On Thu, May 28, 2015 at 05:41:33PM +0100, Joerg Roedel wrote:
> > +/**
> > + * struct iommu_dm_region - descriptor for a direct mapped memory region
> > + * @list: Linked list pointers
> > + * @start: System physical start address of the region
> > + * @length: Length of the region in bytes
> > + * @prot: IOMMU Protection flags (READ/WRITE/...)
> > + */
> > +struct iommu_dm_region {
> > +	struct list_head	list;
> > +	phys_addr_t		start;
> > +	size_t			length;
> > +	int			prot;
> > +};
> 
> I'm slightly puzzled about this. It looks to me like we're asking the
> IOMMU driver to construct a description of the system's physical address
> space, but this information tends to be known elsewhere for things like
> initialising lowmem on the CPU using memblock.

Well, this is not about the general memory layout of the machine, it is
more about the requirements of the firmware. The firmware might have
their own mapping requirements, for example a USB controler that is
handled by the BIOS. Other devices (be2net adapters with special
firmware) might have such requirements too. On x86 these requirements
are described in the IOMMU ACPI tables (RMRR entries on Intel, Unity
mappings on AMD).

> Also, it looks like we just use these regions to create the default
> domain using iommu_map calls -- why don't we just have an IOMMU callback
> to initialise the default domain instead? That would allow IOMMUs with a
> per-master bypass mode to avoid allocating page tables altogether.

In theory yes, but this information is not only needed for the creation
of default domains, but also for a generic DMA-API implementation for
IOMMU drivers. A DMA-API implementation has to mark these address ranges
as reserved in its address allocator, so it is better to export this
information than doing the handling in the iommu drivers.


	Joerg
