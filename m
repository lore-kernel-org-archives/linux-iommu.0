Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D91EA74
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 21:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689112697; x=1720648697;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyZA7C6AH9ltjppdaMI0k4Tg4b3CqpfA1YAi4+vR8rQ=;
  b=ZVWzHuXxzwSg+YP8d/XKugBEQR7wepFy9SGPXiW9cV3PquOo8Gouo566
   GCVPG0hPDOkvxJdbGVr799NpkdMANy3IVy9Ve8vBwCwk20t+4QjRrvbQ6
   wPOv9fFB29AUFaZariQFB2xSxLphi64cYttjasO72e7JZN9tbdYTWjEEd
   NraI0it3wCYE5+UeYmXBBylb0YsegnPp5Uu1RsYxduBK2dwubELGp83TH
   yzCsDDP47bgEr7io+CARsN7KcEHs8x0IDcFnnqUkRS3VpsOmzyio/EP6D
   FIDk7DIOGI+hdu0IaZeQ7Q3nRFjIkSXgKOzH4UqpKvzq5TsNt531QuNU6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428485260"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="428485260"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724635780"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="724635780"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:57:53 -0700
Date: Tue, 11 Jul 2023 15:02:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 9/9] iommu: Use fault cookie to store iopf_param
Message-ID: <20230711150249.62917dad@jacob-builder>
In-Reply-To: <20230711010642.19707-10-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
	<20230711010642.19707-10-baolu.lu@linux.intel.com>
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

On Tue, 11 Jul 2023 09:06:42 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Remove the static iopf_param pointer from struct iommu_fault_param to
> save memory.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      |  2 --
>  drivers/iommu/io-pgfault.c | 47 +++++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ffd6fe1317f4..5fe37a7c5a55 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -551,7 +551,6 @@ struct iommu_fault_param {
>   * struct dev_iommu - Collection of per-device IOMMU data
>   *
>   * @fault_param: IOMMU detected device fault reporting data
> - * @iopf_param:	 I/O Page Fault queue and data
>   * @fwspec:	 IOMMU fwspec data
>   * @iommu_dev:	 IOMMU device this device is linked to
>   * @priv:	 IOMMU Driver private data
> @@ -564,7 +563,6 @@ struct iommu_fault_param {
>  struct dev_iommu {
>  	struct mutex lock;
>  	struct iommu_fault_param	*fault_param;
> -	struct iopf_device_param	*iopf_param;
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1749e0869f2e..6a3a4e08e67e 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -158,7 +158,7 @@ int iommu_queue_iopf(struct iommu_fault *fault,
> struct device *dev)
>  	 * As long as we're holding param->lock, the queue can't be
> unlinked
>  	 * from the device and therefore cannot disappear.
>  	 */
> -	iopf_param = param->iopf_param;
> +	iopf_param = iommu_get_device_fault_cookie(dev, 0);
I am not sure I understand how does it know the cookie type is iopf_param
for PASID 0?

Between IOPF and IOMMUFD use of the cookie, cookie types are different,
right?

>  	if (!iopf_param)
>  		return -ENODEV;
>  
> @@ -235,7 +235,7 @@ int iopf_queue_flush_dev(struct device *dev)
>  		return -ENODEV;
>  
>  	mutex_lock(&param->lock);
> -	iopf_param = param->iopf_param;
> +	iopf_param = iommu_get_device_fault_cookie(dev, 0);
>  	if (iopf_param)
>  		flush_workqueue(iopf_param->queue->wq);
>  	else
> @@ -286,9 +286,9 @@ EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
>   */
>  int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
>  {
> -	int ret = -EBUSY;
> -	struct iopf_device_param *iopf_param;
> +	struct iopf_device_param *iopf_param, *curr;
>  	struct dev_iommu *param = dev->iommu;
> +	int ret;
>  
>  	if (!param)
>  		return -ENODEV;
> @@ -303,16 +303,27 @@ int iopf_queue_add_device(struct iopf_queue *queue,
> struct device *dev) 
>  	mutex_lock(&queue->lock);
>  	mutex_lock(&param->lock);
> -	if (!param->iopf_param) {
> -		list_add(&iopf_param->queue_list, &queue->devices);
> -		param->iopf_param = iopf_param;
> -		ret = 0;
> +	curr = iommu_set_device_fault_cookie(dev, 0, iopf_param);
> +	if (IS_ERR(curr)) {
> +		ret = PTR_ERR(curr);
> +		goto err_free;
>  	}
> +
> +	if (curr) {
> +		ret = -EBUSY;
> +		goto err_restore;
> +	}
> +	list_add(&iopf_param->queue_list, &queue->devices);
>  	mutex_unlock(&param->lock);
>  	mutex_unlock(&queue->lock);
>  
> -	if (ret)
> -		kfree(iopf_param);
> +	return 0;
> +err_restore:
> +	iommu_set_device_fault_cookie(dev, 0, curr);
> +err_free:
> +	mutex_unlock(&param->lock);
> +	mutex_unlock(&queue->lock);
> +	kfree(iopf_param);
>  
>  	return ret;
>  }
> @@ -329,7 +340,6 @@ EXPORT_SYMBOL_GPL(iopf_queue_add_device);
>   */
>  int iopf_queue_remove_device(struct iopf_queue *queue, struct device
> *dev) {
> -	int ret = -EINVAL;
>  	struct iopf_fault *iopf, *next;
>  	struct iopf_device_param *iopf_param;
>  	struct dev_iommu *param = dev->iommu;
> @@ -339,16 +349,17 @@ int iopf_queue_remove_device(struct iopf_queue
> *queue, struct device *dev) 
>  	mutex_lock(&queue->lock);
>  	mutex_lock(&param->lock);
> -	iopf_param = param->iopf_param;
> -	if (iopf_param && iopf_param->queue == queue) {
> -		list_del(&iopf_param->queue_list);
> -		param->iopf_param = NULL;
> -		ret = 0;
> +	iopf_param = iommu_get_device_fault_cookie(dev, 0);
> +	if (!iopf_param || iopf_param->queue != queue) {
> +		mutex_unlock(&param->lock);
> +		mutex_unlock(&queue->lock);
> +		return -EINVAL;
>  	}
> +
> +	list_del(&iopf_param->queue_list);
> +	iommu_set_device_fault_cookie(dev, 0, NULL);
>  	mutex_unlock(&param->lock);
>  	mutex_unlock(&queue->lock);
> -	if (ret)
> -		return ret;
>  
>  	/* Just in case some faults are still stuck */
>  	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)


Thanks,

Jacob
