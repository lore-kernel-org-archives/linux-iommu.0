From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Tue, 25 Sep 2018 15:17:11 -0700
Message-ID: <20180925151711.7ea1cf75@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 25 Sep 2018 15:58:41 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Jacob,
> 
> Just two minor things below, that I noticed while using fault handlers
> for SVA. From my perspective the series is fine otherwise
> 
> On 11/05/2018 21:54, Jacob Pan wrote:
> > +int iommu_unregister_device_fault_handler(struct device *dev)
> > +{
> > +       struct iommu_param *param = dev->iommu_param;
> > +       int ret = 0;
> > +
> > +       if (!param)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&param->lock);  
> 
> Could we check that param->fault_param isn't NULL here, so that the
> driver can call this function unconditionally in a cleanup path?
> 
sounds good.

	if (!param || param->fault_param)
		return -EINVAL;

> > +       /* we cannot unregister handler if there are pending faults
> > */
> > +       if (!list_empty(&param->fault_param->faults)) {
> > +               ret = -EBUSY;
> > +               goto unlock;
> > +       }
> > +
> > +       kfree(param->fault_param);
> > +       param->fault_param = NULL;
> > +       put_device(dev);
> > +unlock:
> > +       mutex_unlock(&param->lock);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> > +
> > +
> > +/**
> > + * iommu_report_device_fault() - Report fault event to device
> > + * @dev: the device
> > + * @evt: fault event data
> > + *
> > + * Called by IOMMU model specific drivers when fault is detected,
> > typically
> > + * in a threaded IRQ handler.
> > + *
> > + * Return 0 on success, or an error.
> > + */
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt)
> > +{
> > +       int ret = 0;
> > +       struct iommu_fault_event *evt_pending;
> > +       struct iommu_fault_param *fparam;
> > +
> > +       /* iommu_param is allocated when device is added to group */
> > +       if (!dev->iommu_param | !evt)  
> 
> Should probably be ||
> 
your are right, thanks!
