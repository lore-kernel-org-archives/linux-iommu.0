From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
Date: Tue, 19 Feb 2019 10:37:12 -0800
Message-ID: <20190219103712.73a1c2a1@jacob-builder>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
	<20181112064501.2290-2-baolu.lu@linux.intel.com>
	<20190130110507.54e8bfad@jacob-builder>
	<65452190-afac-bc71-de29-ce24b508955a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <65452190-afac-bc71-de29-ce24b508955a-5wv7dgnIgG8@public.gmane.org>
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
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 15 Feb 2019 17:33:34 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Jacob, Lu,
> 
> On 30/01/2019 19:05, Jacob Pan wrote:
> > On Mon, 12 Nov 2018 14:44:57 +0800
> > Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> >   
> >> This adds APIs for IOMMU drivers and device drivers to manage
> >> the PASIDs used for DMA transfer and translation. It bases on
> >> I/O ASID allocator for PASID namespace management and relies
> >> on vendor specific IOMMU drivers for paravirtual PASIDs.
> >>  
> > Trying to integrate this with VT-d SVM code had some thoughts.
> > First of all, it seems to me the problem we are trying to solve
> > here is to allow custom PASID/IOASID allocator.
> > IOASID, as in driver base, is a common infrastructure of its own
> > right. So it is OK to let device drivers such as VT-d driver
> > directly communicate with IOASID w/o going through common IOMMU
> > layer. Therefore I see little value of adding this wrapper to
> > ioasid code, instead I feel it might be less work to enhance ioasid
> > with the following:
> > 
> > 1. allow ioasid code to register a system wide custom asid
> > allocator, which takes precedence over the idr allocator
> > e.g.
> > typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max,
> > void *data); void ioasid_set_allocator(ioasid_alloc_fn_t fn)
> > {}
> > We can still use idr for tracking ioasid and private data lookup,
> > since the ioasid idr is exclusively owned by ioasid_alloc, we can
> > rest and be sure there is no conflict with other callers. See code
> > comments below.  
> 
> Yes, I think we need the alloc function to be registered at boot time.
> Because even when using a PV allocation instead of idr allocation, we
> do need a way to quickly retrieve PASID->mm when handling an I/O page
> fault. In the ioasid_alloc() function, we could do, roughly:
> 
> static ioasid_t (*ioasid_alloc_fn)(...);
> 
> ioasid_t ioasid_alloc(... min, max...)
> {
> 	if (ioasid_alloc_fn) {
> 	   ioasid = ioasid_alloc_fn(min, max);
> 
> 	   /* With PV allocation, only use the IDR for storage */
> 	   min = ioasid;
> 	   max = ioasid + 1;
> 	}
> 
> 	idr_lock
> 	ioasid = idr_alloc(... min, max... );
> 	idr_unlock
> }
> 
Completely agreed, i have made similar modifications locally and works
well with VT-d. Similarly for the free function, so I combined them like
this.
typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void
*data);
typedef int (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);

struct ioasid_allocator {
	ioasid_alloc_fn_t alloc;
	ioasid_free_fn_t free;
	void *pdata; /* used for allocator, e.g. iommu model specific
		      * data
		      */
};

The limitation is that, we only support one allocator. I assume there
is only one pvIOMMU in the guest kernel?


> > 2. support setting asid private data _after_ asid is allocated. The
> > use case is that PASID allocation and mm bind can be split into
> > separate stages. Private data (mm related) are not available at the
> > time of allocation, only bind time.
> > Since IDR needs the data pointer at allocation time, we can still
> > create an empty ioasid_data for ioasid tracking at alloc time. i.e.
> > struct ioasid_data {
> > 	void *ptr; /* private data */
> > };  
> 
> I think I agree as well (though finding the right ordering and locking
> in SVA allocation is giving me the biggest headache these days). If
> the PASID becomes reachable early we need to make sure that concurrent
> threads working on the PASID space can deal with incomplete data, but
> I think that might be one of the easiest alternatives.
> 
> > 3. allow NULL ioasid_set
> > I also had a hard time understanding the use of ioasid_set, since
> > there is already a private data associated with each ioasid, is it
> > not enough to group ioasid based on private data?  
> 
> The idea behind ioasid_set is that different modules compete for the
> single IOASID space, and associate different data types to their
> IOASIDs.
> 
> (a) iommu-sva associates an mm_struct
> (b) IOMMU driver allocates a PASIDs for each auxiliary domain, and
> probably associates an iommu_domain to it.
> (c) device drivers (e.g. AMD KFD) want some PASIDs for their own use
> in the same space, and will have their own private data in there.
> 
> For (a) we also want the io_pgfault code to find the mm associated
> with a PASID:
>   iopf_handle_mm_fault()
>     iommu_sva_find(pasid)
>       ioasid_find(&shared_pasid_set, pasid) -> mm struct
> 
> And in this case we really need the search to be only on the
> shared_pasid_set, or else the IOPF code gets something that's not an
> mm struct.
> 
> The easy alternative is to let the IOMMU driver handle both (a) and
> (b), and store the same data type for both. I've been considering
> this a few times this week, but it doesn't solve case (c).
> 
Thanks for explaining. If the consumer and producer/allocator of an
IOASID is the same module, then they should know what private data type
they are searching for. So no need for the set in this case?
In case of vSVA, I do find set is useful. In this case, VFIO allocates
IOASID, IOMMU driver does bind and set private data. ioasid_set would
be useful for VFIO layer to enforce security check such that only
ioasid allocated by the same qemu process can perform bind operation
on it.

Thanks,

Jacob
> Thanks,
> Jean
> 
> > So the usage scenarios can be.
> > 1. during boot, vt-d driver register a custom ioasid allocator
> > (vcmd) if it detects its running as a guest.
> > 
> > 2. Running as a guest, all pasid allocation via ioasid_alloc() will
> > go to this custom allocators and tracked
> > 
> > 3. for native case, there is no custom allocator, ioasid just use
> > IDR alloc
> > 
> > 4. for native bind mm, pasid allocation already has private data
> > filled in when calling ioasid_alloc
> > 
> > 5. for guest bind, pasid is allocated with empty private data
> > (called by VFIO layer), but private data is filled in later by bind
> > guest pasid inside the vt-d driver.
> > 
> > So my thinking is that we can avoid having another layer of APIs as
> > below and keep everything within ioasid. Also allows private data
> > to be managed at lower level as compared to VFIO.
> > 
> > 
> > Thanks,
> > 
> > Jacob
> >   
>  [...]  
>  [...]  
>  [...]  
> > 
> > [Jacob Pan]
> >   
> 

[Jacob Pan]
