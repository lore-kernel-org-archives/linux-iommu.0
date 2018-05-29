From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 14/23] iommu: introduce page response function
Date: Tue, 29 May 2018 09:13:19 -0700
Message-ID: <20180529091319.544d2e57@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF92F37.3050404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5AF92F37.3050404-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 14 May 2018 14:39:51 +0800
Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > IO page faults can be handled outside IOMMU subsystem. For an
> > example, when nested translation is turned on and guest owns the
> > first level page tables, device page request can be forwared
> > to the guest for handling faults. As the page response returns
> > by the guest, IOMMU driver on the host need to process the
> > response which informs the device and completes the page request
> > transaction.
> >
> > This patch introduces generic API function for page response
> > passing from the guest or other in-kernel users. The definitions of
> > the generic data is based on PCI ATS specification not limited to
> > any vendor.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Link: https://lkml.org/lkml/2017/12/7/1725
> > ---
> >  drivers/iommu/iommu.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h
> > | 43 +++++++++++++++++++++++++++++++++++++++++++ 2 files changed,
> > 88 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index b3f9daf..02fed3e 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1533,6 +1533,51 @@ int iommu_sva_invalidate(struct iommu_domain
> > *domain, }
> >  EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
> >  
> > +int iommu_page_response(struct device *dev,
> > +			struct page_response_msg *msg)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +	int ret = -EINVAL;
> > +	struct iommu_fault_event *evt;
> > +	struct iommu_domain *domain =
> > iommu_get_domain_for_dev(dev); +
> > +	if (!domain || !domain->ops->page_response)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param || !param->fault_param)
> > +		return -EINVAL;
> > +
> > +	/* Only send response if there is a fault report pending */
> > +	mutex_lock(&param->fault_param->lock);
> > +	if (list_empty(&param->fault_param->faults)) {
> > +		pr_warn("no pending PRQ, drop response\n");
> > +		goto done_unlock;
> > +	}
> > +	/*
> > +	 * Check if we have a matching page request pending to
> > respond,
> > +	 * otherwise return -EINVAL
> > +	 */
> > +	list_for_each_entry(evt, &param->fault_param->faults,
> > list) {
> > +		if (evt->pasid == msg->pasid &&
> > +		    msg->page_req_group_id ==
> > evt->page_req_group_id) {
> > +			msg->private_data = evt->iommu_private;
> > +			ret = domain->ops->page_response(dev, msg);
> > +			list_del(&evt->list);
> > +			kfree(evt);
> > +			break;
> > +		}
> > +	}  
> 
> Are above two checks duplicated? We won't find a matching
> request if the list is empty. And we need to  printk a message
> if we can't find the matching request.
> 
sorry about the delay. I am not sure which two checks, we only search
for pending page request if the list is not empty.
Yes, it is a good idea to print out warning if the page response has no
match request.
> Best regards,
> Lu Baolu
> 
>  [...]  
> 

[Jacob Pan]
