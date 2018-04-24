From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Date: Tue, 24 Apr 2018 11:29:43 -0700
Message-ID: <20180424112943.79af1c3f@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180423113013.GB38106@ostrya.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180423113013.GB38106-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
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

On Mon, 23 Apr 2018 12:30:13 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> On Mon, Apr 16, 2018 at 10:49:01PM +0100, Jacob Pan wrote:
> [...]
> > +int iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param)
> > +		return -EINVAL;
> > +
> > +	/* Only allow one fault handler registered for each device
> > */
> > +	if (param->fault_param)
> > +		return -EBUSY;
> > +
> > +	mutex_lock(&param->lock);
> > +	get_device(dev);
> > +	param->fault_param =
> > +		kzalloc(sizeof(struct iommu_fault_param),
> > GFP_ATOMIC);  
> 
> This can be GFP_KERNEL
> 
yes, will change.
> [...]
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt) +{
> > +	int ret = 0;
> > +	struct iommu_fault_event *evt_pending;
> > +	struct iommu_fault_param *fparam;
> > +
> > +	/* iommu_param is allocated when device is added to group
> > */
> > +	if (!dev->iommu_param | !evt)
> > +		return -EINVAL;
> > +	/* we only report device fault if there is a handler
> > registered */
> > +	mutex_lock(&dev->iommu_param->lock);
> > +	if (!dev->iommu_param->fault_param ||
> > +		!dev->iommu_param->fault_param->handler) {
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +	fparam = dev->iommu_param->fault_param;
> > +	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> > +		evt_pending = kzalloc(sizeof(*evt_pending),
> > GFP_ATOMIC);  
> 
> We're expecting caller to be a thread at the moment, so this could be
> GFP_KERNEL too. You could also use kmemdup to remove the memcpy below
> 
good idea. will do.
> [...]
> > +static inline int iommu_register_device_fault_handler(struct
> > device *dev,
> > +
> > iommu_dev_fault_handler_t handler,
> > +						void *data)
> > +{
> > +	return 0;  
> 
> Should return -ENODEV
> 
right. thanks.
> Thanks,
> Jean

[Jacob Pan]
