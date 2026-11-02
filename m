Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599534;
	b=uIYi1Wwii54qcZ+F4y/rIhymhOPWQO5a0GDlUYLWVqTrCYJS+WaNX9IhSSAUoLYPe2Ls
	 K/taqxCxik+qI2xuQd83jV329DYqbamwP4k2uSQjW3196+wiuaxydb567Lm/gLnlK1zbH
	 CTvTfaw+6C4AtC/2U/rrQIyx/aG/o49/8bJ6beW7H2BKmEWGWHXQh1pYLQ1SqtO1aAa6q
	 tk+K/VMCqJ23ThPZPuSooiXkI0hFAOn8CMr/ni5sgKod8SMT+bIpu3qUdGzDYYf8TVZvH
	 mSmip/CtC5pJjsNenIUd1tMSdMZS1vpHYg7hxKhiHG7VH7d3Ctc9CLv4KRjoxlXBw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599534;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mgwDIJQ/ktrXjjgHAdGpDY1TKNJstY8opiF0EE1X4JA=;
	b=r6Vj/5iBP8YQHvUQN/DPmt2NrZhiUrthJuBT60p5FgOnN2q8oPxEllOC/x7bZW56EFs2
	 v0vnoM6TPLEu76kIgIpkrFd6a1AEAU9wBOf5ZqadYW2i8z0+/mwWmaSmdqgMhC0Jy5jUE
	 JE9NlEur04d6gTDkBoAU74CPzdtbX0m8FszfFqMydmUaOxuW/FHHl346q8VM5Bf1grY69
	 XZoG8Pt7sgM6GiLrax4sB6MSyI/5k7KaEYS1UMue5rxjCxvtNBoYcKc3SqT6pnlJnc4KT
	 gJrD7gM+zGizLPNSycY88fth+1Ypc/QooJlWuMshNTDomhLgxP03EPSPLgU2JCZyDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cC+8RBs3;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE8606A326
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 06:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AE8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cC+8RBs3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793599534; x=1825135534;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IakynqKDqunCjQwdJaPLOPZZRbiJFiyMHsV1OvcG494=;
  b=cC+8RBs3KqtnXvUyU40Gfcn92x4oXuEz6yVSn2Y8a74Zk6DGHhzVe2SE
   NPkcCsoGTNnswi51hXT4CNDIVVmsMuIgBTZBfx19Qpi4y7+pkui+1dFU0
   ENAQcjGTk/FOntvVPngDXbD/RIEP8FPWgqQ6U65Zm3QfDD4YhOoqxBj/g
   WGgOwrleD2xusY8tZYp4JIkneETQVF0sFL45OwmhkCHMMNNIOYZhxWbkm
   ST7X5Hr9Tr1h825Tb+qPQhTuHXciSe9p6WQ/hO7IavCy/9lzeSKfg/jNv
   ML6qVFf7Bh10bAEyLwmZcIRls90MyMaV01mLCGnw3MJKoZy6AVgBYs+Ps
   Q==;
X-CSE-ConnectionGUID: LE2MAHRTQNSKnzqW1UZaiQ==
X-CSE-MsgGUID: OHZ1y+JORtCFwtzjCgIFAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2286400"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2286400"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 22:05:34 -0800
X-CSE-ConnectionGUID: F1GKqG5BToaKrcApC0GGAg==
X-CSE-MsgGUID: H788A8/aQBme86noa/pRrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6124642"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 22:05:30 -0800
Message-ID: <e6624f1a-b6dd-4229-a26c-4b0501357b75@linux.intel.com>
Date: Mon, 2 Nov 2026 14:05:26 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
To: Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <5751040a-e180-4d29-851d-3ccab96878a3@linux.intel.com>
 <5512edd1-3c52-4e8a-a38f-3a5f1457cdaf@intel.com>
 <auglmP/oFZNhnja/@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <auglmP/oFZNhnja/@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/2026 1:54 PM, Nicolin Chen wrote:
> On Mon, Nov 02, 2026 at 11:30:02AM +0800, Yi Liu wrote:
>> On 11/1/26 13:53, Baolu Lu wrote:
>>> This doesn't fix the same-domain replace issue, which can still result
>>> in a use-after-free bug. I agree that this needs a separate lifetime
>>> mechanism as stated in the cover letter. But is it possible to prevent
>>> the same-domain replace case from going through this interface?
>> fwiw, iommufd already guards this at the device-replace layer
>> (iommufd_device_do_replace() short-circuits when hwpt == old_hwpt) [1],
>> so IOMMUFD callers can't currently trigger this. But that's a caller-side
>> convention, not something
>> iommu_replace_group_handle()/iommu_replace_device_pasid() enforce themselves
>> - so it's still
>> reachable if a future/other caller doesn't do the same check. Worth
>> deciding whether to push the guard down into the core API, or document
>> it as a caller contract.
> I can add a fifth patch. Please see if it looks good to you.
> 
> Subject: [PATCH] iommu: Reject a same-domain replace in the attach handle APIs
> 
> Both iommu_replace_group_handle() and iommu_replace_device_pasid() skip the
> driver callback when the new domain is the one currently attached. In that
> case, nothing flushes the pending faults that may still be holding the old
> handle. Then, the caller frees the old handle once the replace returns, so
> such a fault would hit a use-after-free.
> 
> No caller does this today, since iommufd_device_do_replace() returns early
> when the new hwpt is the old one. However, it is only a caller convention,
> which neither API enforces.
> 
> Reject a same-domain replace in both APIs with a WARN_ON, and document it
> in their kernel-docs.
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3fea48d3538ad..a9bc4ca5dbb4e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3716,6 +3716,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>    * Caller should always provide a new handle to avoid race with the paths
>    * that have lockless reference to handle if it intends to pass a valid handle.
>    *
> + * The @domain must not be the domain currently attached to the @pasid. Such a
> + * same-domain replace would skip the driver callback flushing pending faults.
> + * Then, those faults could use the old handle after the caller frees it.
> + *
>    * Return 0 on success, or an error.
>    */
>   int iommu_replace_device_pasid(struct iommu_domain *domain,
> @@ -3785,15 +3789,17 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>   	}
>   
>   	curr_domain = pasid_array_entry_to_domain(curr);
> -	ret = 0;
> -
> -	if (curr_domain != domain) {
> -		ret = __iommu_set_group_pasid(domain, group,
> -					      pasid, curr_domain);
> -		if (ret)
> -			entry = curr; /* restore the old handle */
> +	/* Same as iommu_replace_group_handle(), reject a same-domain replace */
> +	if (WARN_ON(curr_domain == domain)) {
> +		entry = curr; /* restore the old handle */
> +		ret = -EINVAL;
> +		goto out_store;
>   	}
>   
> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
> +	if (ret)
> +		entry = curr; /* restore the old handle */
> +
>   out_store:
>   	/*
>   	 * The xa_store() above reserved the memory, and the group->mutex
> @@ -3985,6 +3991,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
>    *
>    * Caller should always provide a new handle to avoid race with the paths
>    * that have lockless reference to handle.
> + *
> + * The @new_domain must not be the domain currently attached to the group. Such
> + * a same-domain replace would skip the driver callback flushing pending faults.
> + * Then, those faults could use the old handle after the caller frees it.
>    */
>   int iommu_replace_group_handle(struct iommu_group *group,
>   			       struct iommu_domain *new_domain,
> @@ -3997,6 +4007,16 @@ int iommu_replace_group_handle(struct iommu_group *group,
>   		return -EINVAL;
>   
>   	mutex_lock(&group->mutex);
> +	/*
> +	 * A same-domain replace would skip the driver callback flushing pending
> +	 * faults. Then, those faults could use the old handle after the caller
> +	 * frees it.
> +	 */
> +	if (WARN_ON(group->domain == new_domain)) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
>   	entry = iommu_make_pasid_array_entry(new_domain, handle);
>   	/*
>   	 * iommu_attach_handle_get() runs without the group mutex, so unpublish

I am fine with this change.

Thanks,
baolu
