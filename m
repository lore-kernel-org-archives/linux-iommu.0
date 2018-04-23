From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 13/22] iommu: introduce page response function
Date: Mon, 23 Apr 2018 05:16:49 -0700
Message-ID: <20180423051649.63f0febd@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<AM4PR0802MB23698019B80CCE6B083D1448A3890@AM4PR0802MB2369.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AM4PR0802MB23698019B80CCE6B083D1448A3890-Gx+wUQKpQCVHkdfAM7dXeUdOKmgb957onBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 23 Apr 2018 12:47:10 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> On Mon, Apr 16, 2018 at 10:49:02PM +0100, Jacob Pan wrote:
> [...]
> > +	/*
> > +	 * Check if we have a matching page request pending to
> > respond,
> > +	 * otherwise return -EINVAL
> > +	 */
> > +	list_for_each_entry_safe(evt, iter,
> > &param->fault_param->faults, list) {  
> 
> I don't think you need the "_safe" iterator if you're exiting the loop
> right after removing the event.
> 
you are right, good catch!
> > +		if (evt->pasid == msg->pasid &&
> > +		    msg->page_req_group_id ==
> > evt->page_req_group_id) {
> > +			msg->private_data = evt->iommu_private;  
> 
> Ah sorry, I missed this bit in my review of 10/22. I thought
> private_data would be for evt->device_private. In this case I guess we
> can drop device_private, or do you plan to use it?
> 
NP. vt-d still plan to use device_private for gfx device.
> > +			ret = domain->ops->page_response(dev, msg);
> > +			list_del(&evt->list);
> > +			kfree(evt);
> > +			break;
> > +		}
> > +	}
> > +
> > +done_unlock:
> > +	mutex_unlock(&param->fault_param->lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_page_response);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 32435f9..058b552 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -163,6 +163,55 @@ struct iommu_resv_region {
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > + * enum page_response_code - Return status of fault handlers,
> > telling the IOMMU
> > + * driver how to proceed with the fault.
> > + *
> > + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the
> > page tables
> > + *	populated, retry the access. This is "Success" in PCI
> > PRI.
> > + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
> > faults from
> > + *	this device if possible. This is "Response Failure" in
> > PCI PRI.
> > + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
> > retry the
> > + *	access. This is "Invalid Request" in PCI PRI.
> > + */
> > +enum page_response_code {
> > +	IOMMU_PAGE_RESP_SUCCESS = 0,
> > +	IOMMU_PAGE_RESP_INVALID,
> > +	IOMMU_PAGE_RESP_FAILURE,
> > +};  
> 
> Field names aren't consistent with the comment. I'd go with
> IOMMU_PAGE_RESP_* 
> 
will do.
> > +
> > +/**
> > + * enum page_request_handle_t - Return page request/response
> > handler status
> > + *
> > + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
> > not send a
> > + *	reply to the device.
> > + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
> > next handler,
> > + *	or terminate.
> > + */
> > +enum page_request_handle_t {
> > +	IOMMU_PAGE_RESP_HANDLED = 0,
> > +	IOMMU_PAGE_RESP_CONTINUE,  
> 
> Same here regarding the comment. Here I'd prefer
> "iommu_fault_status_t" for the enum and IOMMU_FAULT_STATUS_* for the
> fields, because they can be used for unrecoverable faults as well.
> 
> But since you're not using these values in your patches, I guess you
> can drop this enum? At the moment the return value of fault handler
> is 0 (as specified at iommu_register_device_fault_handler), meaning
> that the handler always takes ownership of the fault.
> 
> It will be easy to extend once we introduce multiple fault handlers
> that can either take the fault or pass it to the next one. Existing
> implementations will still return 0 - HANDLED, and new ones will
> return either HANDLED or CONTINUE.
> 
I shall drop these, only put in here to match your patch. i am looking
into converting vt-d svm prq to your queued fault patch. I think it will
give both functional and performance benefit.
> > +/**
> > + * Generic page response information based on PCI ATS and PASID
> > spec.
> > + * @addr: servicing page address
> > + * @pasid: contains process address space ID
> > + * @resp_code: response code
> > + * @page_req_group_id: page request group index
> > + * @type: group or stream/single page response  
> 
> @type isn't in the structure
> 
missed that, i move it to iommu private data since it is vtd only
> > + * @private_data: uniquely identify device-specific private data
> > for an
> > + *                individual page response  
> 
> IOMMU-specific? If it is set by iommu.c, I think we should comment
> about it, something like "This field is written by the IOMMU core".
> Maybe also rename it to iommu_private to be consistent with
> iommu_fault_event
> 
sounds good.
> > + */
> > +struct page_response_msg {
> > +	u64 addr;
> > +	u32 pasid;
> > +	enum page_response_code resp_code;
> > +	u32 pasid_present:1;
> > +	u32 page_req_group_id;
> > +	u64 private_data;
> > +};
> > +
> > +/**
> >   * struct iommu_ops - iommu ops and capabilities
> >   * @capable: check capability
> >   * @domain_alloc: allocate iommu domain
> > @@ -195,6 +244,7 @@ struct iommu_resv_region {
> >   * @bind_pasid_table: bind pasid table pointer for guest SVM
> >   * @unbind_pasid_table: unbind pasid table pointer and restore
> > defaults
> >   * @sva_invalidate: invalidate translation caches of shared
> > virtual address
> > + * @page_response: handle page request response
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -250,6 +300,7 @@ struct iommu_ops {
> >  				struct device *dev);
> >  	int (*sva_invalidate)(struct iommu_domain *domain,
> >  		struct device *dev, struct tlb_invalidate_info
> > *inv_info);
> > +	int (*page_response)(struct device *dev, struct
> > page_response_msg *msg); 
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -471,6 +522,7 @@ extern int
> > iommu_unregister_device_fault_handler(struct device *dev); 
> >  extern int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt); 
> > +extern int iommu_page_response(struct device *dev, struct
> > page_response_msg *msg);  
> 
> Please also define a -ENODEV function for !CONFIG_IOMMU_API, otherwise
> it doesn't build.
> 
> And I think struct page_response_msg and the enums should be declared
> outside #ifdef CONFIG_IOMMU_API. Same for struct iommu_fault_event and
> the enums in patch 10/22. Otherwise device drivers will have to add
> #ifdefs everywhere their code accesses these structures.
> 
> Thanks,
> Jean
> 
good point.
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); extern struct iommu_domain
> > *iommu_group_default_domain(struct iommu_group *); -- 
> > 2.7.4
> >   

[Jacob Pan]
