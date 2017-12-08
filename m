From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 8 Dec 2017 16:01:52 -0700
Message-ID: <20171208160152.738b2ebd@t450s.home>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
	<20171206112521.1edf8e9b@jacob-builder>
	<20171207145121.23b3f26f@t450s.home>
	<b0976bc9-68c8-f5c9-881b-5913a4ca1970@arm.com>
	<20171208124017.519120c1@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171208124017.519120c1@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 8 Dec 2017 12:40:17 -0800
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Fri, 8 Dec 2017 13:52:00 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> > On 07/12/17 21:51, Alex Williamson wrote:  
> > >> Agree, IOMMU driver cannot enforce it. I think VFIO layer can make
> > >> sure page response come from the assigned device and its
> > >> guest/container.    
> > > 
> > > Can we enforce it via the IOMMU/VFIO interface?  If the response is
> > > for a struct device, and not an rid/did embedded in a structure,
> > > then vfio can pass it through w/o worrying about it, ie. response
> > > comes in via ioctl with association to vfio device fd -> struct
> > > vfio_device -> struct device, iommu driver fills in rid/did.
> > > Thanks,    
> > 
> > Yes that's probably the best way, reporting faults and receiving
> > responses on the device fd.
> >   
> Just to put these ideas in to code. The IOMMU API used by VFIO has
> struct device* (derived from fd), no did/rid (to be derived from
> struct device by IOMMU driver.)
> 
> int intel_iommu_page_response(struct iommu_domain *domain, struct device *dev,
> 			struct page_response_msg *msg)
> 
> IOMMU driver can further sanitize by checking whether this is a pending
> page request for the device, and refcount outstanding PRQs.
> 
> Does it sound right?

Yep.  Thanks,

Alex
 
> /**
>  * Generic page response information based on PCI ATS and PASID spec.
>  * @addr: servicing page address
>  * @pasid: contains process address space ID, used in shared virtual
> memory(SVM)
>  * @resp_code: response code
>  * @page_req_group_id: page request group index
>  * @type: group or stream/single page response
>  * @private_data: uniquely identify device-specific private data for an
>  *                individual page response
> 
>  */
> struct page_response_msg {
> 	u64 addr;
> 	u32 pasid;
> 	u32 resp_code:4;
> #define IOMMU_PAGE_RESP_SUCCESS	0
> #define IOMMU_PAGE_RESP_INVALID	1
> #define IOMMU_PAGE_RESP_FAILURE	0xF
> 
> 	u32 pasid_present:1;
> 	u32 page_req_group_id : 9;
> 	enum page_response_type type;
> 	u32 private_data;
> };
