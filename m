From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Per PCI device pasid table interfaces
Date: Wed, 11 Jul 2018 15:39:32 +0800
Message-ID: <20180711073932.GA15615@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
	<1531113778-28238-7-git-send-email-baolu.lu@linux.intel.com>
	<20180711021826.GA2359@xz-mi> <5B45B11D.1080405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5B45B11D.1080405-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 11, 2018 at 03:26:21PM +0800, Lu Baolu wrote:

[...]

> >> +int intel_pasid_alloc_table(struct device *dev)
> >> +{
> >> +	struct device_domain_info *info;
> >> +	struct pasid_table *pasid_table;
> >> +	struct pasid_table_opaque data;
> >> +	struct page *pages;
> >> +	size_t size, count;
> >> +	int ret, order;
> >> +
> >> +	info = dev->archdata.iommu;
> >> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
> >> +		    !info->pasid_supported || info->pasid_table))
> >> +		return -EINVAL;
> >> +
> >> +	/* DMA alias device already has a pasid table, use it: */
> >> +	data.pasid_table = &pasid_table;
> >> +	ret = pci_for_each_dma_alias(to_pci_dev(dev),
> >> +				     &get_alias_pasid_table, &data);
> >> +	if (ret)
> >> +		goto attach_out;
> >> +
> >> +	pasid_table = kzalloc(sizeof(*pasid_table), GFP_ATOMIC);
> > Do we need to take some lock here (e.g., the pasid lock)?  Otherwise
> > what if two devices (that are sharing the same DMA alias) call the
> > function intel_pasid_alloc_table() concurrently, then could it
> > possible that we create one table for each of the device while AFAIU
> > we should let them share a single pasid table?
> 
> The only place where this function is called is in a single-thread context
> (protected by a spinlock of device_domain_lock with local interrupt disabled).
> 
> So we don't need an extra lock here. But anyway, I should put a comment
> here.

Yeah, that would be nice too!  Or add a comment for both of the
functions:

  /* Must be with device_domain_lock held */

Regards,

-- 
Peter Xu
