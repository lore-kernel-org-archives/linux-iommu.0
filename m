From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Date: Wed, 26 Sep 2018 15:35:44 -0700
Message-ID: <20180926153544.54884f88@jacob-builder>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920170046.20154-4-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 20 Sep 2018 18:00:39 +0100
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> +
> +static int io_mm_attach(struct iommu_domain *domain, struct device
> *dev,
> +			struct io_mm *io_mm, void *drvdata)
> +{
> +	int ret;
> +	bool attach_domain = true;
> +	int pasid = io_mm->pasid;
> +	struct iommu_bond *bond, *tmp;
> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
> +
> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
> +		return -ENODEV;
> +
> +	if (pasid > param->max_pasid || pasid < param->min_pasid)
> +		return -ERANGE;
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return -ENOMEM;
> +
> +	bond->domain		= domain;
> +	bond->io_mm		= io_mm;
> +	bond->dev		= dev;
> +	bond->drvdata		= drvdata;
> +
> +	spin_lock(&iommu_sva_lock);
> +	/*
> +	 * Check if this io_mm is already bound to the domain. In
> which case the
> +	 * IOMMU driver doesn't have to install the PASID table
> entry.
> +	 */
> +	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
> +		if (tmp->io_mm == io_mm) {
> +			attach_domain = false;
> +			break;
> +		}
> +	}
> +
> +	ret = domain->ops->mm_attach(domain, dev, io_mm,
> attach_domain);
> +	if (ret) {
> +		kfree(bond);
> +		goto out_unlock;
> +	}
> +
> +	list_add(&bond->mm_head, &io_mm->devices);
> +	list_add(&bond->domain_head, &domain->mm_list);
> +	list_add(&bond->dev_head, &param->mm_list);
> +

I am trying to understand if mm_list is needed for both per device and
per domain. Do you always unbind and detach domain? Seems device could
use the domain->mm_list to track all mm's, true?
