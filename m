Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468B1FA2
	for <iommu@lists.linux.dev>; Fri, 30 Sep 2022 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664525086; x=1696061086;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oFjiQiA1mW1s4pr3Dw779NT4rP7m0ZzZZ2KjXZ98jn4=;
  b=W9mQ4QgWAaqJNh/ZdjgkTJZFJHXfWZSod1+HoQXXwizyI37SBk9rOROG
   Z4KwEmwUyc3V7Hdfi+a9uSkII05iJTF6GyEUVxuj0o2VN4wnvOeCIsgEv
   AlHzL2GyY9x8qsLTe9Zla+EBbp60fI+hPsjXWaYv8TayGOvl/rMMVg1aa
   tjoQjqHEWd3tmEOx1Q85hemgePpby8xI8HxRhz2qKFBsHNaSZC6TKVWxv
   6bDZnqJ6xsMhRe4Nxi/sOkQtxvFMekSXhuwAc62rfteRbTBwmF05Qe6N0
   50oY4K9t/PMCCqCFPX/ApF0nlCmA6A0ERgn4rl7/7KyFp6r/2uwNgAQUj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328514745"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="328514745"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:04:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655876135"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="655876135"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.178]) ([10.254.215.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:04:43 -0700
Message-ID: <badfd899-aab1-9f47-9053-e05c6bedd668@linux.intel.com>
Date: Fri, 30 Sep 2022 16:04:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove useless parameter in iommu_bus_init().
Content-Language: en-US
To: Yu Zhang <yu.c.zhang@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
References: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/30 15:02, Yu Zhang wrote:
> Parameter 'ops' is no longer used by iommu_bus_init(), after
> commit 8cec63e52966 ("iommu: Remove iommu_callback_data").
> 
> So just remove it.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3a808146b50f..bedda1e0f016 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1775,7 +1775,7 @@ int bus_iommu_probe(struct bus_type *bus)
>   	return ret;
>   }
>   
> -static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> +static int iommu_bus_init(struct bus_type *bus)
>   {
>   	struct notifier_block *nb;
>   	int err;
> @@ -1836,7 +1836,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>   	bus->iommu_ops = ops;
>   
>   	/* Do IOMMU specific setup for this bus-type */
> -	err = iommu_bus_init(bus, ops);
> +	err = iommu_bus_init(bus);
>   	if (err)
>   		bus->iommu_ops = NULL;
>   

bus_set_iommu() has been retired. All patches are just queued in
linux-next and will show up in v6.1-rc1.

Best regards,
baolu
