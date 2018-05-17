From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Thu, 17 May 2018 08:59:09 -0700
Message-ID: <20180517085909.7470dfb5@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF2537-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 17 May 2018 11:41:56 +0000
"Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > +int iommu_report_device_fault(struct device *dev, struct
> > +iommu_fault_event *evt) {
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
> > +		evt_pending = kmemdup(evt, sizeof(struct
> > iommu_fault_event),
> > +				GFP_KERNEL);
> > +		if (!evt_pending) {
> > +			ret = -ENOMEM;
> > +			goto done_unlock;
> > +		}
> > +		mutex_lock(&fparam->lock);
> > +		list_add_tail(&evt_pending->list,
> > &fparam->faults);  
> 
> I may missed it. Here only see list add, how about removing? Who
> would remove entry from the fault list?
> 
deletion of the pending event is in page response function (int
iommu_page_response), once iommu driver finds a matching response for
the pending request, it will delete the pending event.

if the response never came, right now we don't delete it, just gives
warning.

> > +		mutex_unlock(&fparam->lock);
> > +	}
> > +	ret = fparam->handler(evt, fparam->data);  
> 
> I remember you mentioned there will be a queue to store the faults.
> Is it in the fparam->faults list? Or there is no such queue?
There are two use cases:
case A: guest SVA, PRQ events are reported outside IOMMU subsystem,
	e.g. vfio
case B: in-kernel

The io page fault queuing is Jean's patchset, mostly for case
B (in-kernel IO page fault handling). I will convert intel-svm to Jean's
io page fault mechanism so that we can also have parallel and out of
order queuing of PRQ. I still need some time to evaluate intel specific
needs such as streaming page request/response.

For case A, there is no queuing in host IOMMU driver. My understanding
of the flow is as the following:
1. host IOMMU receives PRQ
2. host IOMMU driver reports PRQ fault event to registered called, i.e.
vfio
3. VFIO reports fault event to QEMU
4. QEMU injects PRQ to guest
5. Guest IOMMU driver receives PRQ in IRQ
6. Guest IOMMU driver queue PRQ by groups, PASID.
So as long as in-kernel PRQ handling can do queuing, there is no need
for queuing in the host reporting path.

Jacob
