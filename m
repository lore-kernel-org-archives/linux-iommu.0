Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12AEA3
	for <iommu@lists.linux.dev>; Sun, 21 May 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684657220; x=1716193220;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tC0SwKYETAOpGInrpsKtb0LbHOZuupDkjqNb8uXDAs=;
  b=RSU6AzCUNlUOl2UOfXlaDMXcWrCOtOj0BNKcSCQk8+w0Qj3b47Zol4el
   H/viM31ZvtabPiZ5VWv/sjvRMADFdP+X5LKI/Qqfu32QxO5lR08zQeTq+
   tpax3sZSfymgUthQfbRSwD76wxY8qIEjIUSdch1PKhAjNKlgRc/MJ0ndX
   zUs4C7e8BbGUWP72Sntvj893SO9kzM8oGG2vVXGIkdm8MAhxNosk74Zvy
   t4Xb36mEZRJP2iDYHe7xdjSVf8i5UOkOKWmvkT6OdRMjgPMJhnNUNqNdW
   AuCi15fdmFrRTkcZoo2gzO8DruCzE4/w+clLOQBsIORtufd3+Wgd7dvN1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="350189312"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="350189312"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 01:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="792903662"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="792903662"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2023 01:20:16 -0700
Message-ID: <6676d850-f633-bacd-445b-44cf045a699c@linux.intel.com>
Date: Sun, 21 May 2023 16:19:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 03/10] iommu: Inline iommu_group_get_for_dev() into
 __iommu_probe_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> This is the only caller, and it doesn't need the generality of the
> function. We already know there is no iommu_group, so it is simply two
> function calls.
> 
> Moving it here allows the following patches to split the logic in these
> functions.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 50 ++++++++-----------------------------------
>   1 file changed, 9 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35dadcc9999f8b..6177e01ced67ab 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -127,7 +127,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   				      int target_type);
>   static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>   					       struct device *dev);
> -static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>   				      const char *buf, size_t count);
>   
> @@ -379,12 +378,18 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	if (ops->is_attach_deferred)
>   		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
>   
> -	group = iommu_group_get_for_dev(dev);
> +	group = ops->device_group(dev);
> +	if (WARN_ON_ONCE(group == NULL))
> +		group = ERR_PTR(-EINVAL);
>   	if (IS_ERR(group)) {
>   		ret = PTR_ERR(group);
>   		goto out_release;
>   	}
>   
> +	ret = iommu_group_add_device(group, dev);
> +	if (ret)
> +		goto err_put_group;
> +
>   	mutex_lock(&group->mutex);
>   	if (group_list && !group->default_domain && list_empty(&group->entry))
>   		list_add_tail(&group->entry, group_list);
> @@ -396,6 +401,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   	return 0;
>   
> +err_put_group:

nit: perhaps out_put_group?

> +	iommu_group_put(group);
>   out_release:
>   	if (ops->release_device)
>   		ops->release_device(dev);
> @@ -1670,45 +1677,6 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>   	return dom;
>   }

Others look good to me:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
