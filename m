From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Tue, 23 Oct 2018 22:13:42 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE1E3C4@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
	<9c6cd6c1-3569-4251-8344-fc9df0e743bc@linux.intel.com>
	<20181022102254.GA25399@araj-mobl1.jf.intel.com>
	<02006e4f-2acf-6ff8-b695-c54c99509b46@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <02006e4f-2acf-6ff8-b695-c54c99509b46-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Raj, Ashok" <ashok.raj-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, October 23, 2018 2:57 PM
> 
> Hi,
> 
> On 10/22/18 6:22 PM, Raj, Ashok wrote:
> > On Mon, Oct 22, 2018 at 12:49:47PM +0800, Lu Baolu wrote:
> >> Hi,
> >>
> >> On 10/20/18 2:11 AM, Jean-Philippe Brucker wrote:
> >>> Some devices might support multiple DMA address spaces, in particular
> >>> those that have the PCI PASID feature. PASID (Process Address Space ID)
> >>> allows to share process address spaces with devices (SVA), partition a
> >>> device into VM-assignable entities (VFIO mdev) or simply provide
> >>> multiple DMA address space to kernel drivers. Add a global PASID
> >>> allocator usable by different drivers at the same time. Name it I/O ASID
> >>> to avoid confusion with ASIDs allocated by arch code, which are usually
> >>> a separate ID space.
> >>>
> >>> The IOASID space is global. Each device can have its own PASID space,
> >>> but by convention the IOMMU ended up having a global PASID space,
> so
> >>> that with SVA, each mm_struct is associated to a single PASID.
> >>>
> >>> The allocator doesn't really belong in drivers/iommu because some
> >>> drivers would like to allocate PASIDs for devices that aren't managed by
> >>> an IOMMU, using the same ID space as IOMMU. It doesn't really
> belong in
> >>> drivers/pci either since platform device also support PASID. Add the
> >>> allocator in drivers/base.
> >>
> >> One concern of moving pasid allocator here is about paravirtual
> >> allocation of pasid.
> >>
> >> Since there is only a single set of pasid tables which is controlled by
> >
> > Minor correction: Single system wide PASID namespace, but PASID tables
> > would be created ideally per-bdf for isolation purposes.
> >
> > I'm sure you meant name space, but didn't want that to be mis-
> interpreted.
> 
> Yes, confirmed.
> 

Above essentially means that multiple IOASID allocators may exist.
There needs a way for IOMMU driver to choose which one to use, e.g.
for current two usages the core allocator will be used on host and
also in VM (non-VTd cases), and pv allocator will be used in VM w/
virtual VTd.

Thanks
Kevin
