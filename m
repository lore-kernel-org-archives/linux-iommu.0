Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8F370
	for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 01:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665712370; x=1697248370;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tvf1KEUmmFWCZG5Vqpb9xVTMOaAK+dTPvxZXl2xkreQ=;
  b=cOlsBXb5a0pk52uwBV+TeKgUo6B3rb8qqCQVGup+8SSVP4mKD7FTPiV2
   sXjWTiNjJBz298ID5Pvm2hoILWl2PNxRmgZS5rSjoFwI10OfHszuVREa4
   gHZHpK2VG7WJN/PaMnf+H/scCEbKY2dPgoD4jn/y5xqHObCNKpZAMqKqj
   SjPhVEHJU3gS2jqjeEznbKqIJyCZFPYM0vQa0qNrXrM86XPa/B9iZW2UL
   NNPgjil6rNhlRd3E5XHM7lEpGKmL9WTdXxWEOq2/iubccD+v0bD6izwXh
   Wgx5ANv0yO+ZdzBqG5lkwj0nAdaHxEaryd5jLk4QCPQHGlDGxSzDydiAe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302868484"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302868484"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:52:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627401441"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627401441"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.33]) ([10.254.210.33])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:52:46 -0700
Message-ID: <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
Date: Fri, 14 Oct 2022 09:52:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221013153355.2365865-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/13 23:33, Jerry Snitselaar wrote:
> iommu_sva_bind_device() should only be called if
> iommu_dev_enable_feature() succeeded. There has been one case already
> where that hasn't been the case, which resulted in a null pointer
> deref in dev_iommu_ops(). To avoid that happening in the future if
> another driver makes that mistake, sanity check dev->iommu and
> dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> drivers/iommu/iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..20ec75667529 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>   {
>   	struct iommu_group *group;
>   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> +			__func__);
> +		return ERR_PTR(-ENODEV);
> +	}

If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
This kind of error will be discovered at the first place.

Best regards,
baolu

> +
> +	ops = dev_iommu_ops(dev);
>   
>   	if (!ops->sva_bind)
>   		return ERR_PTR(-ENODEV);
