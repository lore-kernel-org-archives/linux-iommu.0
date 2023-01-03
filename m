Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A377F
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 01:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672709646; x=1704245646;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6guush2vfOoBc9v6cMZa7A/f9x+xz+VSebDHnSj7k/k=;
  b=e24/Y9hKGtfo01N7fjlJb9q+ERetUJH/rbQ8HcXzEhIklLQILu6GfrZp
   rwjqR5WmJYRMKk/Yi7hX8VaFDU/K1g/Cxunk2oD56OjPOgRgdMPVzyr0T
   qUaO6XbNhjiR6BronoVRW7jXtE3h1hGWvWpuax3qCghv0n/kK3KaBPtIV
   pXSgNUH7Z+iHHgklbBzZnW3OhJnCXP03+iPbwut8I/SSFVygkkMBUWkSs
   37jun/WHM2G0vI62QETknH8HIzefvxCEpybL9M1dzynjpLtOb9R5tgDOG
   FJyI22kVaN4vpqCwJM/6WYbvsdKKcNIprfu3lF6roScOFh8RV0cQ+X14O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301247135"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="301247135"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 17:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="983417229"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="983417229"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jan 2023 17:34:03 -0800
Message-ID: <ffe919f3-f4f2-b378-947f-4cf704ad8950@linux.intel.com>
Date: Tue, 3 Jan 2023 09:26:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
To: Miaoqian Lin <linmq006@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221230083100.1489569-1-linmq006@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221230083100.1489569-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/22 4:31 PM, Miaoqian Lin wrote:
> iommu_group_get() returns the group with the reference incremented.
> Move iommu_group_get() after owner check to fix the refcount leak.

An empty @owner is a more serious problem than refcount leak. It should
not happen, so a WARN_ON() was added there.

Anyway, your change makes the code better.

> 
> Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/iommu/iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..3a7dd8b61fab 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3185,14 +3185,16 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
>    */
>   int iommu_device_claim_dma_owner(struct device *dev, void *owner)
>   {
> -	struct iommu_group *group = iommu_group_get(dev);
> +	struct iommu_group *group = NULL;

No need to set NULL to group.

>   	int ret = 0;
>   
> -	if (!group)
> -		return -ENODEV;
>   	if (WARN_ON(!owner))
>   		return -EINVAL;
>   
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return -ENODEV;
> +
>   	mutex_lock(&group->mutex);
>   	if (group->owner_cnt) {
>   		if (group->owner != owner) {

Others look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

--
Best regards,
baolu
