From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Tue, 19 Sep 2017 14:30:38 +0200
Message-ID: <20170919123038.GF8398@8bytes.org>
References: <20170914194444.32551-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914194444.32551-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

thanks for the RFC patch. I have some comments about the interface to
the IOMMU-API below.

On Thu, Sep 14, 2017 at 03:44:33PM -0400, Rob Clark wrote:
> +/**
> + * iommu_domain_resume - Resume translations for a domain after a fault.
> + *
> + * This can be called at some point after the fault handler is called,
> + * allowing the user of the IOMMU to (for example) handle the fault
> + * from a task context.  It is illegal to call this if
> + * iommu_domain_set_attr(STALL) failed.
> + *
> + * @domain:    the domain to resume
> + * @terminate: if true, the translation that triggered the fault should
> + *    be terminated, else it should be retried.
> + */
> +void iommu_domain_resume(struct iommu_domain *domain, bool terminate)
> +{
> +	/* invalid to call if iommu_domain_set_attr(STALL) failed: */
> +	if (WARN_ON(!domain->ops->domain_resume))
> +		return;
> +	domain->ops->domain_resume(domain, terminate);
> +}
> +EXPORT_SYMBOL_GPL(iommu_domain_resume);

So this function is being called by the device driver owning the domain,
right?

I don't think that the resume call-back you added needs to be exposed
like this. It is better to do the page-fault handling completly in the
iommu-code, including calling the resume call-back and just let the
device-driver provide a per-domain call-back to let it handle the fault
and map in the required pages.

The interface could look like this:

	* New function iommu_domain_enable_stalls(domain) - When
	  this function returns the domain is in stall-handling mode. A
	  iommu_domain_disable_stalls() might make sense too, not sure
	  about that.

	* When stalls are enabled for a domain, report_iommu_fault()
	  queues the fault to a workqueue (so that its handler can
	  block) and in the workqueue you call ->resume() based on the
	  return value of the handler.

As a side-note, as there has been discussion on this: For now it doesn't
make sense to merge this with the SVM page-fault handling efforts, as
this path is different enough (SVM will call handle_mm_fault() as the
handler, for example).


Regards,

	Joerg
