Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA41E503
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689109208; x=1720645208;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YxuqcQuH86nuBd5JjcxOArrf18TQNwkEwpfUnLkTdDY=;
  b=NZD/WRqcPbsF6FmD3WwhR44j27R/quFizg+u9xvaanK0pwYoBuBYoC3C
   1DkFnyOW/20+JTERrCQY2Z5uNDZyo4l3b4cKuLF41K6VkVDiMyXlFRTQD
   yTc9TfnLXCFr4sib16bvJpmsNpfWaRY9BdyKGtlZYGaLv2jpVYxNkXLFR
   C+XOAhj/W+EWJBM4jaSLSUdIiMUI8kkvUfu2aHm4VR5e/viqIkTK0lS7v
   AkFxN2lb+e04f0MhDLEexLuy+un3vvyYoZFYjHpVmAio2521X83MDBsYi
   5gPWrQxNfAOGsNPgXUeBnGF4jT/mQU9qH/YGUWczcgi5CtS1BepQrcoN2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430860829"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="430860829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715325548"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715325548"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:00:06 -0700
Date: Tue, 11 Jul 2023 14:05:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/9] iommu: Change the return value of dev_iommu_get()
Message-ID: <20230711140503.65e70501@jacob-builder>
In-Reply-To: <20230711010642.19707-5-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
	<20230711010642.19707-5-baolu.lu@linux.intel.com>
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

Hi BaoLu,

On Tue, 11 Jul 2023 09:06:37 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Make dev_iommu_get() return 0 for success and error numbers for failure.
> This will make the code neat and readable. No functionality changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 41328f03e8b4..65895b987e22 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -287,20 +287,20 @@ void iommu_device_unregister(struct iommu_device
> *iommu) }
>  EXPORT_SYMBOL_GPL(iommu_device_unregister);
>  
> -static struct dev_iommu *dev_iommu_get(struct device *dev)
> +static int dev_iommu_get(struct device *dev)
>  {
>  	struct dev_iommu *param = dev->iommu;
>  
>  	if (param)
> -		return param;
> +		return 0;
>  
>  	param = kzalloc(sizeof(*param), GFP_KERNEL);
>  	if (!param)
> -		return NULL;
> +		return -ENOMEM;
>  
>  	mutex_init(&param->lock);
>  	dev->iommu = param;
> -	return param;
> +	return 0;
>  }
>  
>  static void dev_iommu_free(struct device *dev)
> @@ -351,10 +351,9 @@ static int __iommu_probe_device(struct device *dev,
> struct list_head *group_list
>  	 * but for now enforcing a simple global ordering is fine.
>  	 */
>  	mutex_lock(&iommu_probe_device_lock);
> -	if (!dev_iommu_get(dev)) {
> -		ret = -ENOMEM;
> +	ret = dev_iommu_get(dev);
> +	if (ret)
>  		goto err_unlock;
> -	}
>  
>  	if (!try_module_get(ops->owner)) {
>  		ret = -EINVAL;
> @@ -2751,12 +2750,14 @@ int iommu_fwspec_init(struct device *dev, struct
> fwnode_handle *iommu_fwnode, const struct iommu_ops *ops)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	int ret;
>  
>  	if (fwspec)
>  		return ops == fwspec->ops ? 0 : -EINVAL;
>  
> -	if (!dev_iommu_get(dev))
> -		return -ENOMEM;
> +	ret = dev_iommu_get(dev);
> +	if (ret)
> +		return ret;
>  
>  	/* Preallocate for the overwhelmingly common case of 1 ID */
>  	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks,

Jacob
