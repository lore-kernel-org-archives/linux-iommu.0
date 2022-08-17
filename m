Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5A1C17
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660732498; x=1692268498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WDCWwFNC4pSlrtLv+pJZJTESXKf8+WkfSayMR/BUY90=;
  b=UOF0AJLY8nKVPWwGTa4lqcn7In75T5+ois0MvvvB78fcMH7BY8D4JgqH
   FvAHG2xpJHlgIIQ/vamo03wDHb/157Y90skInzujQyeFRFrrMEeBwsKgQ
   dm1FNHgIYrSKWqDoxb86aaS5ATkEqZbBwLcUhcr2TAU+CtIXEgxMt4BQN
   aZO6GxoTi6tazOg4E0DuLrcbRgEjZUQFobnTAPaKq5O7v3dG0kWbT4Gez
   9o6Lq51BN6Ens+PiCx5CrRnWYoiyI8ub5mL7hLnZzU91do6Vv2aYqrKKc
   UCBDInsC9DkJ5Uu1i28+Yvuz9V3FQIheat9CUXQxMTTbhOQWxFD69DH4c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272228771"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272228771"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:34:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667559585"
Received: from jzhan60-mobl1.ccr.corp.intel.com (HELO [10.254.209.228]) ([10.254.209.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:34:56 -0700
Message-ID: <50b8489c-bd93-c8ae-cd92-af429ae762b0@linux.intel.com>
Date: Wed, 17 Aug 2022 18:34:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: return early when devices in a group require
 different domain type
Content-Language: en-US
To: Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev
References: <20220816020701.90533-1-yuancan@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220816020701.90533-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/16 10:07, Yuan Can wrote:
> When alloc default domain for an iommu_group in
> probe_alloc_default_domain, the expected domain
> type of each device in the iommu_group is checked
> in a loop, if two devices require different types,
> the loop can be breaked since the default domain
> will be set to iommu_def_domain_type.
> Return 1 when this happened to break the loop in
> __iommu_group_for_each_dev.
> 
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Nit:
Try to use up the allowed number of characters per line before wrapping
and use "./scripts/checkpatch.pl --strict --codespell _your_patch_file"
to check the patch.

For the change:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 74bc9111c7be..0d4d78946d31 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
>   				 dev_name(gtype->dev),
>   				 iommu_domain_type_str(gtype->type));
>   			gtype->type = 0;
> +			return 1; /* end the outer loop */
>   		}
>   
>   		if (!gtype->dev) {

