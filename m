From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Wed, 6 Dec 2017 11:25:21 -0800
Message-ID: <20171206112521.1edf8e9b@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a6cfc27a-6121-1e67-6e0d-f94a383bcd6f-5wv7dgnIgG8@public.gmane.org>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 5 Dec 2017 17:21:15 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Jacob,
> 
> On 04/12/17 21:37, Jacob Pan wrote:
> > On Fri, 24 Nov 2017 12:03:50 +0000
> > Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> >   
> >> On 17/11/17 18:55, Jacob Pan wrote:  
> >>> When nested translation is turned on and guest owns the
> >>> first level page tables, device page request can be forwared
> >>> to the guest for handling faults. As the page response returns
> >>> by the guest, IOMMU driver on the host need to process the
> >>> response which informs the device and completes the page request
> >>> transaction.
> >>>
> >>> This patch introduces generic API function for page response
> >>> passing from the guest or other in-kernel users. The definitions
> >>> of the generic data is based on PCI ATS specification not limited
> >>> to any vendor.>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>  
> [...]
> > I think the simpler interface works for in-kernel driver use case
> > very well. But in case of VFIO, the callback function does not turn
> > around send back page response. The page response comes from guest
> > and qemu, where they don;t keep track of the the prq event data.  
> 
> Is it safe to trust whatever response the guest or userspace gives
> us? The answer seems fairly vendor- and device-specific so I wonder
> if VFIO or IOMMU shouldn't do a bit of sanity checking somewhere, and
> keep track of all injected page requests.
> 
> From SMMUv3 POV, it seems safe (haven't looked at SMMUv2 but I'm not
> so confident).
> 
> * The guest can only send page responses to devices assigned to it,
> that's a given.
> 
Agree, IOMMU driver cannot enforce it. I think VFIO layer can make sure
page response come from the assigned device and its guest/container.
> * If, after we injected a page request, the guest doesn't reply at
> all, then the device leaks page request credits and at some point it
> will stop sending requests.
>   -> So the PRI capability needs to be reset whenever we change the  
>      device's domain, to clear the credit counter and pending states.
> 
>   For SMMUv3, the stall buffer may be shared between devices on some
>   implementations, in which case the guest could prevent other
> devices to stall by letting the buffer fill up.
>   -> We might have to keep track of stalls in the host driver and set
> a credit or timeout to each stall, if it comes to that.
>   -> In addition, send a terminate-all-stalls command when changing
> the device's domain.
> 
We have the same situation in VT-d with shared queue which in turn may
affect other guests. Letting host driver maintain record of pending page
request seems the best way to go. VT-d has a way to drain PRQ per PASID
and RID combination. I guess this is the same as your
"terminate-all-stalls" but with finer control? Or
"terminate-all-stalls" only applies to a given device.
Seems we can implement a generic timeout/credit mechanism in IOMMU
driver with model specific action to drain/terminate. The timeout value
can also be model specific.

> * If the guest sends spurious or duplicate page responses (where the
> PRGI or PASID doesn't exist in any outstanding page request of the
> device)
> 
If we keep track of pending PRQ in host IOMMU driver, then it can
detect duplicated case.
>   For PRI if we send an invalid PRG Response, the endpoint sets UPRGI
> in the PRI cap, and issues an Unexpected Completion. Then I suppose
> the worst that happens is we get an AER report that we can't handle?
> I'm not too familiar with that part of PCIe.
> 
I don;t see this mentioned in the PCI ATS spec., but in general this
sounds like a case HW has to handle, perhaps ignoring them is
reasonable as you said below.
>   Stall is designed to tolerate this and will just ignore the
> response.
> 
> * If PRI/stall isn't even enabled, the IOMMU driver can check that in
> the device configuration and not send the reply.
> 
> 
> 
> 
> Regardless, I have a few comments on the page_response_msg:
> 
Thanks, all points are taken unless commented.
> > +/**
> > + * Generic page response information based on PCI ATS and PASID
> > spec.
> > + * @paddr: servicing page address  
> 
> Maybe call it @addr, so we don't read this field as "phys addr"
> 
> > + * @pasid: contains process address space ID, used in shared
> > virtual memory(SVM)  
> 
> The "used in shared virtual memory(SVM)" part isn't necessary and
> we're changing the API name.
> 
> > + * @rid: requestor ID
> > + * @did: destination device ID  
> 
> I guess you can remove @rid and @did
> 
> > + * @last_req: last request in a page request group  
> 
> Is @last_req needed at all, since only the last request requires a
> response?
> 
right, i was thinking we had single page response in vt-d, but there is
not need either.
> > + * @resp_code: response code  
> 
> The comment is missing a description for @pasid_present here
> 
> > + * @page_req_group_id: page request group index
> > + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> > IOMMU_FAULT_WRITE  
> 
> Is @prot really needed in the response?
> 
no, you are right.
> > + * @type: group or stream response  
> 
> The page request doesn't provide this information
> 
this is vt-d specific. it is in the vt-d page request descriptor and
response descriptors are different depending on the type.
Since we intend the generic data to be super set of models, I add this
field.
> > + * @private_data: uniquely identify device-specific private data
> > for an
> > + *                individual page response
> > +
> > + */
> > +struct page_response_msg {
> > +	u64 paddr;
> > +	u32 pasid;
> > +	u32 rid:16;
> > +	u32 did:16;
> > +	u32 resp_code:4;
> > +	u32 last_req:1;
> > +	u32 pasid_present:1;
> > +#define IOMMU_PAGE_RESP_SUCCESS	0
> > +#define IOMMU_PAGE_RESP_INVALID	1
> > +#define IOMMU_PAGE_RESP_FAILURE	0xF  
> 
> Maybe move these defines closer to resp_code.
> For someone not familiar with PRI, we should add some comments about
> those values:
> 
> * SUCCESS: the request was paged-in successfully
> * INVALID: could not page-in one or more pages in the group
> * FAILURE: permanent PRI error, may disable faults in the device
> 
> > +	u32 page_req_group_id : 9;
> > +	u32 prot;
> > +	enum page_response_type type;
> > +	u32 private_data;
> > +};
> > +  
> 
> Thanks,
> Jean

[Jacob Pan]
