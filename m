Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF914AD24
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470684; cv=none; b=dxnFj3V+83JxuDRVYbD1oODBplPV+tkOZa4SoXZj96jRzP/oQ2KuTWfnbxRg1uAFtIPdQCltyOJhlBnmKYnX7GsYNl8u1DkzJxMJSoaUPf+vwPQqEQbLJG/7cQh3xyUCkfMh4J/bWCNr6tgR0XDe0+zuWSPQOwBGQg7OmpcCYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470684; c=relaxed/simple;
	bh=/Me5wMpR/UwA1YVs+dIUucOW/F8h8aXT6I9AFyhY514=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W1Xq2d4YOOOSZRWXqj5jCrgI3HXO7ltXobTI3JP7B3cw13h9GVGhj5+tG2F/ZntSaJNF4kU3mEWIj03HQPg8ihBoI7cLIwjPU8k9qR3qyolpHEFx2SSdGXjfKVPqHd6RyEOEFqGgzj0UL4TnX0Y9M9nG1ptvli1TaW1CeN2Hx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgXuYmXq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgXuYmXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716470683; x=1748006683;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Me5wMpR/UwA1YVs+dIUucOW/F8h8aXT6I9AFyhY514=;
  b=MgXuYmXqU8zjF3Q4/NDELQzqrmzPFGiF0Po+RNNNqd81W81qjtXAI0bc
   5bKmCl3TWukOkVEZFEGvy/kaTSfhpv8ciDaoVYw2RhHJDhDkak7PVRDIO
   GZdihTYiUB+sVIbKep02q3ukW6KziU9zNNnPcSIHNkOR1BHECS32JMLry
   w/mUxVS3w6bllg95c2umRizzRSvB51fIYcoh3W614ueSUb5CNOWfn/tr9
   UfroUVldw6iZuHneLFHg5GsIc15iB6KAPGFiaZgAnNQ80kpTlYEBqA5x7
   2z8p7xQuNYIEB1JBBO72gmhCM019DOgXapILXuTmTaFdtArfwbJwkmcaj
   w==;
X-CSE-ConnectionGUID: kZMrrCT2TnWxO1ze7zZGEw==
X-CSE-MsgGUID: XbwIHgd4Q92oPyPpvjJPpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23397307"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23397307"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:24:43 -0700
X-CSE-ConnectionGUID: K1Q2J8ZtSjmfR1VKNQcxgA==
X-CSE-MsgGUID: pSlsOeNWRbq/lZqw/acuUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="56899634"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:24:39 -0700
Message-ID: <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
Date: Thu, 23 May 2024 21:24:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in
 intel_pasid_get_entry()
To: Uros Bizjak <ubizjak@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-2-ubizjak@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240522082729.971123-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/22 16:26, Uros Bizjak wrote:
> Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
> intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/pasid.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index abce19e2ad6f..9bf45bc4b967 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -146,6 +146,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>   retry:
>   	entries = get_pasid_table_from_pde(&dir[dir_index]);
>   	if (!entries) {
> +		u64 tmp;
> +
>   		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
>   		if (!entries)
>   			return NULL;
> @@ -156,8 +158,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>   		 * clear. However, this entry might be populated by others
>   		 * while we are preparing it. Use theirs with a retry.
>   		 */
> -		if (cmpxchg64(&dir[dir_index].val, 0ULL,
> -			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
> +		tmp = 0ULL;

nit: can this simply be
		tmp = 0;
?

> +		if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
> +				   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {

Above change will cause a dead loop during boot. It should be

		if (try_cmpxchg64(&dir[dir_index].val, &tmp,
				  (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {

>   			iommu_free_page(entries);
>   			goto retry;
>   		}

Best regards,
baolu
