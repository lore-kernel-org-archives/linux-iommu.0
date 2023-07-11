Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA41FCF
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689108361; x=1720644361;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bMf3zpaNUsB0eGTK5cLexWrhss7IZThtcdQyprXDLXU=;
  b=lzsWtVCU6BqsyHc476QxXPqVpkUoOJejwE2JYj1c9JOm9OAJy1qUt2q3
   kjOI7G5TRtcSl3yfOePoF2cJd1IHSifyHHNMG2ErqbF35lnqVlOoyu9SX
   oHq5u2W8Ep24C+mA4T9h9S5kM3Br+BLeusKFwm3jknjrpA4YgK+AwN2Ek
   Hh/VoaUgcW5VZmnGCeqsBxLI52Gx0Hu5dAzIMGwEqOBeRXRB0fUxhGM5A
   OLX9mRMhV1MLgM2KahXb8cf5oGl75GVjvt/qT644PXN6wAaWFewyqdBv7
   vSrRDg0RDOuUcQDuUGi8dGs7ffNS/zcfwGoJkvML2V+vquuqq6f7qM7+O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354631866"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="354631866"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 13:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811343747"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="811343747"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 13:46:00 -0700
Date: Tue, 11 Jul 2023 13:50:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/9] iommu: Add common code to handle IO page faults
Message-ID: <20230711135056.4b1fd94a@jacob-builder>
In-Reply-To: <20230711010642.19707-4-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
	<20230711010642.19707-4-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Lu,

On Tue, 11 Jul 2023 09:06:36 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> The individual iommu drivers report iommu faults by calling
> iommu_report_device_fault(), where a pre-registered device fault handler
> is called to route the fault to another fault handler installed on the
> corresponding iommu domain.
> 
> The pre-registered device fault handler is static and won't be dynamic
> as the fault handler is eventually per iommu domain. Replace the device
> fault handler with a static common code to avoid unnecessary code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index da340f11c5f5..41328f03e8b4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1278,6 +1278,28 @@ int iommu_unregister_device_fault_handler(struct
> device *dev) }
>  EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
>  
> +static int iommu_handle_io_pgfault(struct device *dev,
> +				   struct iommu_fault *fault)
> +{
> +	struct iommu_domain *domain;
> +
> +	if (fault->type != IOMMU_FAULT_PAGE_REQ)
> +		return -EINVAL;
> +
> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> +		domain = iommu_get_domain_for_dev_pasid(dev,
> fault->prm.pasid, 0);
> +	else
> +		domain = iommu_get_domain_for_dev(dev);
we don't support IOPF w/o PASID yet, right?

> +
> +	if (!domain || !domain->iopf_handler)
> +		return -ENODEV;
> +
> +	if (domain->iopf_handler == iommu_sva_handle_iopf)
> +		return iommu_queue_iopf(fault, dev);
Just wondering why have a special treatment for SVA domain. Can
iommu_queue_iopf() be used as SVA domain->iopf_handler?

> +
> +	return domain->iopf_handler(fault, dev, domain->fault_data);
> +}
> +
>  /**
>   * iommu_report_device_fault() - Report fault event to device driver
>   * @dev: the device
> @@ -1320,7 +1342,7 @@ int iommu_report_device_fault(struct device *dev,
> struct iommu_fault_event *evt) mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	ret = iommu_handle_io_pgfault(dev, &evt->fault);
>  	if (ret && evt_pending) {
>  		mutex_lock(&fparam->lock);
>  		list_del(&evt_pending->list);


Thanks,

Jacob
