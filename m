Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C402346FB0
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009923; cv=none; b=Bv31AIiREt/1GBnmRpe8O9cZBT5shaW/ypuTdCQ/eI2efSyEWmGiYVozC/fhdnmIRpQ0HI9+1zOU0Hv51ML4yLe6vPVs5Q3IJRk347pE+j8nuddhS2AjtaQx/c/BEY1Qt3sWUZAZvmlfNJ0JlwtxskJE/2JeuAVJ1PwsTvueprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009923; c=relaxed/simple;
	bh=wwr3NnsqcF99mraKL+t0X61UHp2wswKgEvFithKH1zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ox93o/uSGfip4C6rDEdodEKqUXd+W49YcU3xI9H6dTGFU+hzGKGfiXBM30deGn3WVI0axjUdad35XSmH7aVuyN8p6jYhyYJP+TXnFtXVc6ld6duDbE5SxKBfJzb91iPyBKsTvaTatbSWTh2pqZSa9lw6qlz+SXkVD9oOf5RvUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtdTl9Xn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtdTl9Xn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777009922; x=1808545922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wwr3NnsqcF99mraKL+t0X61UHp2wswKgEvFithKH1zc=;
  b=dtdTl9XnBgQmTWKeW/rTPMwBonWrLH49v52KjYFmnHjrhzE0AGyblwtI
   2JVaw6WTmEfL4oRapuSQL8gCptvF3ygpqrHDD5WE5wnraLVQd5VnSElEQ
   fdukzsCyBn4gVmU+nBiVlyU/aivgNn3hidTZcBScOs1y5ddD58fI2IfF5
   YNrUOAB3Ogp4S3+sS4AV2WwwmqpbCTXbo9ruJEpu38jOJ3a+/EHwRIPkk
   IaWk0tTpDw4m6I3WDmAznURm/ZJy76hzRuJyMEOtGtVPsU/+6cGym1pMv
   jyZ0tbe9A8fr7X8kmDs8qF/i0tHO9D2MWQPDrb8IyR5uGZ4AIlzOdmyk9
   Q==;
X-CSE-ConnectionGUID: Ct92eu0cQhuXWUHfSHwkRw==
X-CSE-MsgGUID: gGyVwQslTgeWtM/eQq+Dfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="100638445"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100638445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:52:01 -0700
X-CSE-ConnectionGUID: JIMvgPVyQoqRARaJ3p1Kyw==
X-CSE-MsgGUID: aRY5rTLpRXOvN8nIS9ZpzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="226329568"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:51:58 -0700
Message-ID: <9752ce24-a5f2-491d-b6fb-9e6d81f0cb67@linux.intel.com>
Date: Fri, 24 Apr 2026 13:49:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 3/6] iommu: Fix pasid attach in
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <3f1b73fa5162e55ffbe497508aeea1fc7cee6e2c.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3f1b73fa5162e55ffbe497508aeea1fc7cee6e2c.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/19/26 07:41, Nicolin Chen wrote:
> Now the helpers handle per-gdev resets. So use the per-device API properly
> to attach/detach PASIDs. Also add max_pasids check as other callers.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Reported-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Closes:https://lore.kernel.org/all/ad858513-09fc-455e-bbc5- 
> fe38a225cc78@linux.alibaba.com/
> Reviewed-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d5d9102b9d750..e9ffa562b614f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -4026,9 +4026,14 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   	 * The pasid_array is mostly fenced by group->mutex, except one reader
>   	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
>   	 */
> -	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> -		iommu_remove_dev_pasid(&pdev->dev, pasid,
> -				       pasid_array_entry_to_domain(entry));
> +	if (pdev->dev.iommu->max_pasids > 0) {
> +		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
> +			struct iommu_domain *pasid_dom =
> +				pasid_array_entry_to_domain(entry);
> +
> +			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
> +		}
> +	}
>   
>   	group->recovery_cnt++;
>   	return ret;
> @@ -4090,10 +4095,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   	 * The pasid_array is mostly fenced by group->mutex, except one reader
>   	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
>   	 */
> -	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> -		WARN_ON(__iommu_set_group_pasid(
> -			pasid_array_entry_to_domain(entry), group, pasid,
> -			group->blocking_domain));
> +	if (pdev->dev.iommu->max_pasids > 0) {
> +		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
> +			struct iommu_domain *pasid_dom =
> +				pasid_array_entry_to_domain(entry);
> +
> +			WARN_ON(pasid_dom->ops->set_dev_pasid(
> +				pasid_dom, &pdev->dev, pasid,
> +				group->blocking_domain));
> +		}
> +	}
>   
>   	if (!WARN_ON(group->recovery_cnt == 0))
>   		group->recovery_cnt--;

I don’t think this patch fixes a real-world issue though it has the
"Fixes:" tag. Logically, if pdev->dev.iommu->max_pasids == 0, there
should be no domains attached to any pasid. Consequently,
group->pasid_array should be empty, and the xa_for_each loop is just a
no-op.

I understand this was a result of Sashko's review comments, but I don't
think it worth a formal fix. I admit I might be overlooking something,
so please correct me if I am wrong.

Thanks,
baolu
